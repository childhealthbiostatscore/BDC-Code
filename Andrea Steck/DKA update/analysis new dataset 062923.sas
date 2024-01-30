
*libname data 'S:\Shared Projects\Laura\BDC\Projects\Todd Alonso\DKA\Data';
*libname data 'W:\Shared Projects\Laura\BDC\Todd Alonso\DKA\Data';
libname data 'W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw';
*libname data "C:\temp\Morgan Sooy DKA update\Data_raw";
libname save 'W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\';

proc format;
  value $ age_cat "1"="<6 years"
                "2"="6- <13 years"
				"3"="13+ years";
  value $ gender "Female"="Female"
				 "Male"="Male";
  value $ new_ins "Military Plans"="Military Plans"
				  "None"="None"
				  "Private"="Private"
				  "Public"="Public";
  value $ race_eth "Hispanic"="Hispanic"
				"Non-Hispanic Black"="Non-Hispanic Black"
				"Non-Hispanic White"="Non-Hispanic White"
				"Other/Unknown"="Other/Unknown";
  value $ dka "Yes"="Yes"
              "No"="No";
  value $ rural "Non-rural"="Non-rural"
                "Rural"="Rural";
  value yn 0="No"
  		   1="Yes";
  value $ dka_sev "Mild DKA"="Mild DKA"
                "Severe DKA"="Severe DKA"
				"No DKA"="No DKA";
run;

data alldata;
set data.alldata;
run;
proc freq data=alldata; table Rural_or_non_rural Insurance InsuranceGroup / missing; run;
proc print data=alldata; var ZipCode_DateOfDiagnosis; where Rural_or_non_rural in (""," "); run;
proc contents; run;
/* start out with 148 missing Rural_or_non_rural */
proc print data=alldata;
var MRN source instudy dka DKA pH bicarb;
where dka in (""," ");
run;
proc print data=alldata;
where mrn=1516406;
var mrn source instudy Rural_or_non_rural ZipCode_DateOfDiagnosis;
run;

/* create new variable for active/inactive study participants */
data alldata;
set alldata;
if instudy=0 then instudy_active=.;
else if instudy=1 and ge6moprior=1 and seen_12mo_prior=1 then instudy_active=1;
else if instudy=1 and (ge6moprior=0 or seen_12mo_prior=0) then instudy_active=0;
run;
proc freq data=alldata;
table instudy_active*ge6moprior*seen_12mo_prior;
run;
data alldata;
set alldata;
length active_inactive_clinic $ 25;
if instudy=0 then active_inactive_clinic=0;
else if instudy=1 and ge6moprior=1 and seen_12mo_prior=1 then active_inactive_clinic=1;
else if instudy=1 and (ge6moprior=0 or seen_12mo_prior=0) then active_inactive_clinic=2;
run;
proc freq data=alldata;
table active_inactive_clinic*instudy;
run;
proc print data=alldata;
where mrn=1034232;
var mrn source instudy new_ins;
run;

data x;
set alldata;
where (dka="No" and dka_sev="Mild DKA") or (dka="Yes" and dka_sev="No DKA") or
  dka in (""," ") or dka_sev in ("", " ");
keep mrn pp3 source ph bicarb dka dka_sev;
run;
proc sort data=x; by source; run;
proc print data=x; run;
proc freq data=alldata;
table ph;
run;

/* create variable for categorical age */
data alldata;
set alldata;
if Age_AtOnset=. then age_cat=.;
else if Age_AtOnset<6 then age_cat=1;
else if Age_AtOnset>=6 and Age_AtOnset<13 then age_cat=2;
else age_cat=3;
format age_cat age_cat.;
run;
proc print data=alldata; var Age_AtOnset age_cat; run;
proc freq data=alldata; table age_cat; run;

proc freq data=alldata; table new_ins*insurancegroup / missing; run;
data alldata;
set alldata;
if new_ins in (""," ") then new_ins=insurancegroup;
run;
proc print data=alldata;
where mrn=1516406;
var mrn source instudy Rural_or_non_rural;
run;


/* recode English cap and noncap */
proc freq data=alldata; table PrimaryLanguage; run;
data alldata;
set alldata;
if PrimaryLanguage='ENGLISH' then PrimaryLanguage='English';
run;

/* create variable for non-English speaking */
data alldata;
set alldata;
if PrimaryLanguage in (' ','.') then English=.;
else if PrimaryLanguage='English' then English=1;
else English=0;
run;

/* create variable for quarter of the year */
data alldata;
set alldata;
month=month(onsetdate);
if month=. then quarter=.;
else if month in (1,2,3) then quarter=1;
else if month in (4,5,6) then quarter=2;
else if month in (7,8,9) then quarter=3;
else quarter=4;
run;

/* year of onset */
data alldata;
set alldata;
year=year(onsetdate);
run;
proc print data=alldata;
var source onsetdate year;
run;

/* combine race ethnicity categories */
/*	Let’s do race/ethnicity as NHW, H, NHB, and all the others/unknown. */
/* not using variable new_eth anymore */
data alldata;
set alldata;
new_eth=race_eth;
run;
data alldata;
set alldata;
if new_eth="Hispanic" then hispanic=1;
else hispanic=0;
run;
/* code race_eth for Marian's data */
data alldata;
set alldata;
if source="MarianJama" and (ethnicity="Hispanic or Latino" or race="Hispanic") then race_eth="Hispanic";
else if source="MarianJama" and (ethnicity ne "Hispanic or Latino" and race ne "Hispanic") and 
		race="White" then race_eth="Non-Hispanic White";
else if source="MarianJama" and (ethnicity ne "Hispanic or Latino" and race ne "Hispanic") and race="Black or African Ame" 
		then race_eth="Non-Hispanic Black";
else if source="MarianJama" and race_eth in ("",".") then race_eth="Other";
run;
/* code race_eth for Morgan's missing people */
proc print data=alldata;
where source="MORGAN" and race_eth in (""," ") and instudy=1;
var mrn source instudy active_inactive_clinic race new_eth Ethnicity race_eth;
run;
data alldata;
set alldata;
if source="MORGAN" and race_eth in (""," ") and race="White" and Ethnicity="Not Hispanic or Latino" then race_eth="Non-Hispanic White";
if source="MORGAN" and race_eth in (""," ") and race="Black/African Americ" and Ethnicity="Hispanic or Latino" then race_eth="Other";
if source="MORGAN" and race_eth in (""," ") and race="White" and Ethnicity="Not Reported" then race_eth="Other";
if source="MORGAN" and race_eth in (""," ") and race in ("More than one Race","Unknown OR Not Repor","Other") then race_eth="Other";
run;
proc print data=alldata;
where source="MORGAN" and race_eth in (""," ") and instudy=1;
var mrn source instudy active_inactive_clinic race new_eth Ethnicity race_eth;
run;
proc freq data=alldata;
table race_eth;
run;
proc print data=alldata;
where race_eth in (""," ") ;
var mrn source instudy active_inactive_clinic race new_eth Ethnicity race_eth;
run;

/* create variable for DKA severity */
data alldata;
set alldata;
if DKA="YES" then dka="Yes";
run;
proc print data=alldata;
where mrn=1034232;
var mrn source instudy new_ins;
run;

/* read in hardcoded corrections */
 /**********************************************************************
 *   PRODUCW:\Shared Projects\Laura\BDC   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      19FEB23
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
   data WORK.CORRECTIONS    ;
    %let _EFIERR_ = 0; 
    infile 'W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\checking_DKA_07FEB2023.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat MRN best32. ;
       informat DKA $3. ;
       informat dka_sev $10. ;
       informat pH best32. ;
       informat bicarb best32. ;
       format MRN best12. ;
       format DKA $3. ;
       format dka_sev $10. ;
       format pH best12. ;
       format bicarb best12. ;
    input
                MRN
                DKA  $
                dka_sev  $
                pH
                bicarb
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  
    run;
proc sort data=corrections; by mrn; run;
proc sort data=alldata; by mrn; run;
data alldata;
merge alldata corrections;
by mrn;
run;
proc freq data=alldata; table source*dka; run;
/* Marian's dataset looks good to here */

/* merge in another set of corrections */

/**********************************************************************
 *   PRODUCW:\Shared Projects\Laura\BDC   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      03JUL23
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data WORK.NEW_corrections    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\DKA Severity Issues - fixed_07.05.23.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat MRN best32. ;
       informat PP3 best32. ;
       informat pH 8.2 ;
       informat bicarb 8. ;
       informat DKA $3. ;
       informat DKA_sev $10. ;
       informat SOURCE $6. ;
       format MRN best12. ;
       format PP3 best12. ;
       format pH best12. ;
       format bicarb best12. ;
       format DKA $3. ;
       format DKA_sev $10. ;
       format SOURCE $6. ;
    input
                MRN
                PP3  
                pH
                bicarb
                DKA  $
                DKA_sev  $
                SOURCE  $
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;
/* divide correction dataset into two datasets - one with MRN and one with PP3 to be merged separately */
data new_corrections_mrn;
set new_corrections;
where mrn ne .;
run;
data new_corrections_pp3;
set new_corrections;
where mrn=. and pp3  ne .;
run;
proc sort data=new_corrections_mrn; by MRN; run;
proc sort data=alldata; by MRN; run;
data alldata;
merge alldata new_corrections_mrn;
by MRN;
run;


proc print data=alldata;
where source="MORGAN" and dka in (""," ");
var MRN instudy pH bicarb dka;
run;
data alldata;
set alldata;
if source="MORGAN" and dka in (""," ") and ((ph ne . and ph<7.1) or (bicarb ne . and bicarb <5)) then dka="Yes";
else if source="MORGAN" and dka in (""," ") and ((ph>=7.1 and ph<7.3) or (bicarb>=5 and bicarb<15)) then dka="Yes";
run;
/* for Todd's and Morgan's data, if someone has pH and/or bicarb and has DKA="Yes" fill in dka severity */
data alldata;
set alldata;
if source="TODD" and dka="Yes" and ((ph ne . and ph<7.1) or (bicarb ne . and bicarb <5)) then dka_sev="Severe DKA";
else if source="TODD" and dka="Yes" and ((ph>=7.1 and ph<7.3) or (bicarb>=5 and bicarb<15)) then dka_sev="Mild DKA";
else if source="MORGAN" and dka="Yes" and ((ph ne . and ph<7.1) or (bicarb ne . and bicarb <5)) then dka_sev="Severe DKA";
else if source="MORGAN" and dka="Yes" and ((ph>=7.1 and ph<7.3) or (bicarb>=5 and bicarb<15)) then dka_sev="Mild DKA";
run;
proc freq data=alldata; table source*dka; run;


proc freq data=alldata; table source*dka; run;
proc sort data=new_corrections_pp3; by pp3; run;
proc sort data=alldata; by pp3; run;
data alldata;
merge alldata new_corrections_pp3;
by pp3;
run;
data alldata;
set alldata;
if source="Marian" then source="MarianJama";
run;
data alldata;
set alldata;
if source="MarianJama" and DKA="No" and DKA_sev in (""," ") then DKA_sev="No DKA";
run;
proc freq data=alldata; table source*dka / missing; run;proc freq data=alldata; table source*dka / missing; run;

proc freq data=alldata; table Rural_or_non_rural / missing; run;
proc print data=alldata; var ZipCode_DateOfDiagnosis; where Rural_or_non_rural in (""," "); run;
/* still 148 missing Rural_or_non_rural */

proc freq data=alldata; table source*dka; run;
ods rtf file="W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\dka_crosstab.rtf"; 
proc freq data=alldata;
where source="TODD"; 
table dka*dka_sev / missing;
title "Source=TODD";
run;
proc freq data=alldata;
where source="MORGAN"; 
table dka*dka_sev / missing;
title "source=MORGAN";
run;
proc freq data=alldata;
where source="MarianJama" ; 
table dka*dka_sev / missing;
title "source=MarianJama";
run;
proc freq data=alldata;
table instudy*dka*dka_sev;
run;
ods rtf close;
title;
data dka_prob;
set alldata;
where (dka="No" and dka_sev="Mild DKA") or (dka="Yes" and dka_sev="No DKA") or
  dka in (""," ") or dka_sev in ("", " ");
keep mrn pp3 source ph bicarb dka dka_sev;
run;
proc sort data=dka_prob; by source; run;
proc print data=dka_prob; run;
proc export data=dka_prob
  outfile="W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\dka_issues.csv" dbms=csv replace;
run;

/* Morgan says to delete ppts not living in CO in her dataset between 2017-2021 */
proc print data=alldata;
where source="MORGAN" and State_DateOfDiagnosis ne "Co";
var source year State_DateOfDiagnosis;
run;
data alldata;
set alldata;
if source="MORGAN" and State_DateOfDiagnosis ne "Co" then delete;
run; 

proc freq data=alldata; table instudy; run;

proc freq data=alldata; table Rural_or_non_rural; run;
data alldata;
set alldata;
if Rural_or_non_rural="*Zipcode:" then Rural_or_non_rural="";
*if dka in (""," ") then dka=DKA;
run;
proc freq data=alldata; table dka*DKA / missing; run;

proc print data=alldata;
where new_ins in (""," ");
var MRN source instudy new_ins InsuranceGroup;
run;
proc freq data=alldata;
table source*instudy;
where new_ins in (""," ");
run;
proc freq data=alldata; table insurance*new_ins; run;
/* hard code a few more insurance values */
data alldata;
set alldata;
if insurance in ("CICP","RMHP Direct PPO","ROCKY MOUNTAIN HEALTH PLAN","ROCKY MOUNTAIN HEALTH PLANS","Rocky Mountain HMO","ROCKY MOUNTAIN HP",
  "ROCKY MTN HEALTH MAINTENANCE","ROCKY MTN HMO MEDICAID") then new_ins="Public";
run;
proc freq data=alldata; table insurance*new_ins; run;

/* compare DKA status known to unknown */
proc freq data=alldata; table dka; run;
data alldata;
set alldata;
if dka="YES" then dka="Yes";
gender=sex;
if strip(dka)="No" then dka="No";
run;
data alldata;
set alldata;
if dka="." or dka="" or dka=" " or dka="Unk" then dkaknown=0;
else dkaknown=1;
format gender $gender. new_ins $new_ins. dka $dka. Rural_or_non_rural $rural. 
		english yn. hispanic yn. dka_sev $dka_sev. race_eth $race_eth.;
label Age_AtOnset="Age at onset"
	  gender="Sex"
	  new_ins="Insurance"
	  InitalA1c="HbA1c"
	  dka="DKA"
	  dka_sev="DKA severity"
	  Rural_or_non_rural="Rural"
	  English="English-speaking"
      Hispanic="Hispanic"
	  race_eth="Race/ethnicity";
run;
proc freq data=alldata; table Hispanic English; run;
proc print data=alldata;
var MRN source instudy dka dkaknown;
where dka in (""," ");
run;
proc contents; run;
proc freq data=alldata; table instudy*dkaknown;run;
proc freq data=alldata;
tables dka*dkaknown / missing;
run;
proc ttest data=alldata;
var ageatonset;
class dkaknown;
run;
proc freq data=alldata;
table instudy*dkaknown / missing;
run;
proc print data=alldata;
var mrn source instudy dka dkaknown;
where dkaknown=0;
run;
proc freq data=alldata;
tables dkaknown*(gender race_eth new_ins) / chisquare exact;
run;

data foranalysis;
set alldata;
run;
%include 'V:\SAS tools\Amanda table 1\2 category macros with KW.sas';
proc datasets;
delete OutTable ;
run;
quit;
%CON(BV = Age_AtOnset, OC=dkaknown);
%CAT(BV = gender, BVF = $gender, OC= dkaknown);
%CAT(BV = race_eth, BVF = $race_eth, OC= dkaknown);
%CAT(BV = new_ins, BVF = $new_ins, OC= dkaknown);
ods rtf file='c:\temp\output.rtf' style=journal;
proc print data=outtable noobs label;
var _Label_ RowVarc C0 c1 xPC ;
label 	_Label_ = '00'x
		RowVarc = '00'x
		C0 = 'DKA status unknown'
		C1 = 'DKA status known'
		xPC = 'P-value' ;
run;
ods rtf close;
proc freq data=foranalysis; table race_eth; run;

/* now delete unknown status for rest of analysis */
data alldata;
set alldata;
if dka='' or dka=" " or dka="Unk" then delete;
run;
proc freq data=alldata; table new_ins; run;
proc print data=alldata; run;
proc freq data=alldata; table instudy; run;
data foranalysis;
set alldata;
run;



/* export csv file */
proc export data=alldata
outfile="W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\morgan cleaned final dataset no unknown all CO.csv"
replace
dbms="csv";
run;

proc freq data=alldata; table Rural_or_non_rural / missing; run;
ods rtf file="C:\temp\output.rtf";
proc print data=alldata; var MRN PP3 source instudy ZipCode_DateOfDiagnosis; where Rural_or_non_rural in (""," "); run;
/* now 118 missing Rural_or_non_rural */
ods rtf close;

/* predictors are age at onset, gender, race, insurance, language, onset year, rural/nonrural */
/* with and without adjustment for quarter of the year */
ods rtf file="C:\temp\output.rtf style=journal";
proc logistic data=alldata;
model dka(event='Yes') = Age_AtOnset ;
run;
%macro cat(var);
proc logistic data=alldata;
class &var;
model dka(event='Yes') = &var ;
run;
%mend;
%cat(gender);
proc logistic data=alldata;
class race_eth(ref='Non-Hispanic White');;
model dka(event='Yes') = race_eth;
run;
proc logistic data=alldata;
class new_ins(ref='Private');
model dka(event='Yes') = new_ins;
run;
proc logistic data=alldata;
class Rural_or_non_rural(ref='Non-rural');
model dka(event='Yes') = Rural_or_non_rural;
run;
proc freq data=alldata; table Rural_or_non_rural; run;
%cat(English);
%cat(year);
%cat(Rural_or_non_rural);
%cat(age_cat);
proc logistic data=alldata;
model dka(event='Yes') = year ;
run;
/* add HbA1c as a predictor */
proc logistic data=alldata;
model dka(event='Yes') = InitalA1c ;
run;
/* year of onset, by insurance category */
proc sort data=alldata; by new_ins; run;
proc logistic data=alldata;
model dka(event='Yes') = year ;
by new_ins;
where new_ins not in (' ','.','None');
run;
/* study participation */
proc logistic data=alldata;
class instudy(ref='0');
model dka(event='Yes') = instudy ;
run;
ods rtf close;
proc freq; table english; run;

proc print data=alldata;
where MRN=1516406;
run;

/* 2x2 table of study by DKA */
ods rtf file="C:\temp\output.rtf" style=journal;
proc freq data=alldata;
table instudy*dka / chisq;
run;
proc freq data=alldata;
table instudy*dka_sev / chisq;
run;
proc freq data=alldata;
table instudy_active*dka / exact;
run;
proc freq data=alldata;
table instudy*dka / exact;
where instudy_active ne 1;
run;
ods rtf close;

proc freq data=alldata;
table year;
run;
proc print data=alldata;
var source race_eth new_ins year Rural_Non_Rural instudy;
run;
proc contents; run;
proc freq data=alldata;
table Rural_or_non_rural*Rural_Non_Rural / missing; 
run;
proc freq data=alldata;
table  new_ins Insurance InsuranceGroup;
run;
proc print data=alldata;
var source new_ins Insurance InsuranceGroup;
where new_ins in (""," ");
run;
/* multivariate model with predictors that were significant on univariate */
ods rtf file="C:\temp\output.rtf" style=journal;
proc logistic data=alldata;
class race_eth new_ins(ref="Private") year Rural_or_non_rural(ref='Non-rural') instudy(ref='0');
model dka(event='Yes') = Age_AtOnset race_eth new_ins year Rural_or_non_rural InitalA1c instudy;
run;
/* model without A1c */
proc logistic data=alldata;
class race_eth new_ins year Rural_or_non_rural(ref='Non-rural') instudy(ref='0');
model dka(event='Yes') = Age_AtOnset race_eth new_ins year Rural_or_non_rural instudy;
run;
ods rtf close;

/* now with adjustment per quarter */
%macro catadj(var);
proc logistic data=alldata;
class &var quarter;
model dka(event='Yes')  = &var quarter;
run;
%mend;
%catadj(gender);
%catadj(age_cat);
proc logistic data=alldata;
class race_eth(ref='Non-Hispanic White') quarter;
model dka(event='Yes')  = race_eth quarter;
run;
proc logistic data=alldata;
class new_ins(ref='Private') quarter;
model dka(event='Yes')  = new_ins quarter;
run;
%catadj(English);
%catadj(year);
%catadj(Rural_or_non_rural);

/* examine rates of dka by age */
data alldata;
set alldata;
age_floor=floor(Age_AtOnset);
run;
proc univariate data=alldata;
var age_floor;
run;
proc freq data=alldata;
tables dka*age_floor / outpct out=out;
run;
proc print data=out; run;
proc sgplot data=out;
where dka='Yes';
vbar age_floor / response=PCT_COL;
run;

/* plot rates of dka by  year */
proc freq data=alldata;
tables dka*year / outpct out=out;
run;
proc print data=out; run;
proc sgplot data=out;
where dka='Yes';
vbar year / response=PCT_COL;
run;

/* separate analysis of HbA1c at diagnosis */
/* predictors are age at onset, gender, race, insurance, language, onset year, rural/nonrural */
/* with and without adjustment for quarter of the year */
%macro contglm(var);
proc glm data=alldata;
model InitalA1c = &var / solution;
run;
%mend;
%macro catglm(var);
proc glm data=alldata;
class &var;
model InitalA1c = &var / solution;
lsmeans &var / stderr;
run;
%mend;
%contglm(Age_AtOnset);
%catglm(age_cat);
%catglm(gender);
%catglm(race_eth);
%catglm(new_ins);
%catglm(English);
%contglm(year);
%catglm(Rural_or_non_rural);
proc glm data=alldata;
class race_eth(ref='White');
model InitalA1c = race_eth / solution;
lsmeans race_eth;
run;
proc glm data=alldata;
class new_ins(ref='Private') ;
model InitalA1c = new_ins / solution;
lsmeans new_ins / stderr;
run;
quit;

/* MULTIVARIATE FOR HBA1C */
ods rtf file="C:\temp\output.rtf" style=journal;
proc glm data=alldata;
class new_ins(ref="Private") race_eth English;
model InitalA1c = new_ins Age_AtOnset race_eth English year / solution;
lsmeans new_ins / stderr;
lsmeans race_eth  / stderr;
lsmeans English  / stderr;
run;
ods rtf close;
proc freq data=alldata;
table new_ins;
run;

/* give Todd % DKA by insurance type and year with 95% CI */
proc sort data=alldata; by new_ins year; run;
proc freq data=alldata;
tables dka / binomial(wald) out=test ;
by new_ins year;
output out=test2 binomial;
run;
data test2;
set test2;
keep new_ins year L_BIN U_BIN ;
label L_BIN='Lower bound 95% CI' U_BIN='Upper bound 95% CI';
run;
proc sort data=test; by new_ins year ; run;
proc sort data=test2; by new_ins year ; run;
data newtest;
merge test test2; 
by new_ins year ; 
run;
data newtest;
set newtest;
where dka='Yes';
run;
ods rtf file="C:\temp\output.rtf" style=journal;
proc print data=newtest label noobs; run;
ods rtf close;

/* comparison of study and clinic patients */
proc contents data=foranalysis; run;
%include 'W:\Shared Projects\Laura\BDC\SAS tools\Amanda table 1\3 or more category Macros with KW.sas';
proc datasets;
delete OutTable ;
run;
quit;
options verbose;
%MultiCAT(BV = gender, BVF = $gender, OC= active_inactive_clinic);
%MultiCAT(BV = race_eth, BVF = $race_eth, OC= active_inactive_clinic);
%MultiCAT(BV = hispanic, BVF = yn, OC= active_inactive_clinic);
%MultiCAT(BV = new_ins, BVF = $new_ins, OC= active_inactive_clinic);
%MultiCAT(BV = dka, BVF = $new_ins, OC= active_inactive_clinic);
%MultiCAT(BV = dka_sev, BVF = $new_ins, OC= active_inactive_clinic);
%MultiCAT(BV = Rural_or_non_rural, BVF = $rural, OC= active_inactive_clinic);
%MultiCAT(BV = english, BVF = yn, OC= active_inactive_clinic);
%CON3ormore(BV = Age_AtOnset, OC=active_inactive_clinic);
%CON3ormore(BV = InitalA1c, OC=active_inactive_clinic);
ods rtf file='c:\temp\output.rtf' style=journal;
proc print data=outtable noobs label;
var _Label_ RowVarc C0 c1 xPC ;
label 	_Label_ = '00'x
		RowVarc = '00'x
		C0 = 'Clinic patient'
		C1 = 'Study patient'
		xPC = 'P-value' ;
run;
ods rtf close;

proc logistic data=alldata;
class gender active_inactive_clinic;
model gender(ref="Female") = active_inactive_clinic ;
run;
proc freq data=alldata;
table gender*active_inactive_clinic;
run;

proc sort data=foranalysis; by active_inactive_clinic; run;
proc means data=foranalysis;
var InitalA1c Age_AtOnset;
class active_inactive_clinic;
run;
proc glm data=foranalysis;
class active_inactive_clinic;
model InitalA1c = active_inactive_clinic;
run;
proc glm data=foranalysis;
class active_inactive_clinic;
model Age_AtOnset = active_inactive_clinic;
run;
proc freq data=alldata; tables gender*active_inactive_clinic / chisq; run;
proc freq data=alldata; tables race_eth*active_inactive_clinic / chisq; run;
proc freq data=alldata; tables hispanic*active_inactive_clinic / chisq; run;
proc freq data=alldata; tables new_ins*active_inactive_clinic / chisq; run;
proc freq data=alldata; tables dka*active_inactive_clinic / chisq; run;
proc freq data=alldata; tables dka_sev*active_inactive_clinic / chisq; run;
proc freq data=alldata; tables english*active_inactive_clinic / chisq; run;

data alldata;
set alldata;
if Age_AtOnset ne . and Age_AtOnset<2 then age_new_cat="<2 years old     ";
else if Age_AtOnset>=2 and Age_AtOnset<6 then age_new_cat="2 - <6 years old";
else if Age_AtOnset>=6 and Age_AtOnset<=12 then age_new_cat="6 - <12 years old";
else if Age_AtOnset>=12 and Age_AtOnset<=18 then age_new_cat="12 - 18 years old";
run;
proc freq data=alldata; table age_new_cat; run;

ods rtf file='V:\Projects\Andrea Steck\Morgan Sooy DKA update\numbers_for_figures.rtf' style=journal;
proc freq data=alldata;
table active_inactive_clinic*year*dka;
title "Numbers for figures: 0 = clinic, 1 = active, 2 = inactive";
run;
proc freq data=alldata;
table active_inactive_clinic*age_new_cat*dka;
run;
ods rtf close;
title;

proc freq data=foranalysis; tables Rural_or_non_rural*active_inactive_clinic / chisq; run;
proc freq data=alldata; tables Rural_or_non_rural*active_inactive_clinic / chisq; run;
* for some reason this code isn't working....will export to R;
proc export data=alldata
  outfile="W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\table1.csv" dbms=csv replace;
run;
proc export data=alldata
  outfile="W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\table1.csv" dbms=csv replace;
run;
data save.table1;
set alldata;
run;

/* rates of DKA by study participation and year */
ods rtf file="W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Report\DKA rates for figures.rtf";
proc freq data=alldata;
table year / binomial(level="2017") alpha=0.05;
where instudy=0;
title "Rate of DKA in clinic patients by year";
run;
proc freq data=alldata;
table year / binomial(level="2018") alpha=0.05;
where instudy=0;
run;
proc freq data=alldata;
table year / binomial(level="2019") alpha=0.05;
where instudy=0;
run;
proc freq data=alldata;
table year / binomial(level="2020") alpha=0.05;
where instudy=0;
run;
proc freq data=alldata;
table year / binomial(level="2021") alpha=0.05;
where instudy=0;
run;
proc freq data=alldata;
table year / binomial(level="2017") alpha=0.05;
where instudy=1;
title "Rate of DKA in study patients by year";
run;
proc freq data=alldata;
table year / binomial(level="2018") alpha=0.05;
where instudy=1;
run;
proc freq data=alldata;
table year / binomial(level="2019") alpha=0.05;
where instudy=1;
run;
proc freq data=alldata;
table year / binomial(level="2020") alpha=0.05;
where instudy=1;
run;
proc freq data=alldata;
table year / binomial(level="2021") alpha=0.05;
where instudy=1;
run;


/* DKA rates by age category and study participation */
proc freq data=alldata;
table instudy*age_cat*dka;
title "Rate of DKA by study participation and age category";
run;
ods rtf close;
title;

/******************/
/* STUDY PATIENTS */
/******************/
/* this is where I stopped - this descriptive table is not working */
/* get desc stats Morgan asked for, and then clarify why Andrea wants */
proc contents data=alldata; run;
data foranalysis;
set alldata;
where instudy;
run;
proc datasets;
delete OutTable ;
run;
quit;
%CON(BV = fup_prior_dx_mo, OC=instudy_active);
%CON(BV = fup_first_to_last_visit_mo, OC=instudy_active);
ods rtf file='c:\temp\output.rtf' style=journal;
proc print data=outtable noobs label;
var _Label_ RowVarc C0 c1 xPC ;
label 	_Label_ = '00'x
		RowVarc = '00'x
		C0 = 'DKA status unknown'
		C1 = 'DKA status known'
		xPC = 'P-value' ;
run;
ods rtf close;

data activestudy;
set alldata;
where instudy_active;
run;
ods rtf file="C:\temp\output.rtf" style=journal;
/* predictors are age at onset, gender, race, insurance, language, onset year, rural/nonrural */
proc logistic data=activestudy;
model dka(event='Yes') = Age_AtOnset ;
run;
%macro cat(var);
proc logistic data=activestudy;
class &var;
model dka(event='Yes') = &var ;
run;
%mend;
%cat(gender);
proc logistic data=activestudy;
class race_eth(ref='Non-Hispanic White');;
model dka(event='Yes') = race_eth;
run;
proc logistic data=activestudy;
class hispanic(ref='No');;
model dka(event='Yes') = hispanic;
run;
proc logistic data=activestudy;
class new_ins(ref='Private');
model dka(event='Yes') = new_ins;
run;
proc logistic data=activestudy;
class Rural_or_non_rural(ref='Non-rural');
model dka(event='Yes') = Rural_or_non_rural;
run;
%cat(English);
%cat(year);
%cat(Rural_or_non_rural);
%cat(age_cat);
proc logistic data=activestudy;
model dka(event='Yes') = year ;
run;
/* add HbA1c as a predictor */
proc logistic data=activestudy;
model dka(event='Yes') = InitalA1c ;
run;
proc freq data=activestudy; table hispanic; run;
ods rtf close;

/* multivariate model with predictors that were significant on univariate */
ods rtf file="C:\temp\output.rtf" style=journal;
proc logistic data=activestudy;
class Hispanic ;
model dka(event='Yes') = Hispanic  InitalA1c;
run;
ods rtf close;

/******************/
/* CLINIC PATIENTS */
/******************/
data clinic;
set alldata;
where instudy=0;
run;
ods rtf file="C:\temp\output.rtf";
/* predictors are age at onset, gender, race, insurance, language, onset year, rural/nonrural */
proc logistic data=clinic;
model dka(event='Yes') = Age_AtOnset ;
run;
%macro cat(var);
proc logistic data=clinic;
class &var;
model dka(event='Yes') = &var ;
run;
%mend;
%cat(gender);
proc logistic data=clinic;
class race_eth(ref='Non-Hispanic White');;
model dka(event='Yes') = race_eth;
run;
proc logistic data=clinic;
class hispanic(ref='No');;
model dka(event='Yes') = hispanic;
run;
proc logistic data=clinic;
class new_ins(ref='Private');
model dka(event='Yes') = new_ins;
run;
%cat(English);
%cat(year);
proc logistic data=clinic;
class Rural_or_non_rural(ref='Non-rural');
model dka(event='Yes') = Rural_or_non_rural;
run;
%cat(age_cat);
proc logistic data=clinic;
model dka(event='Yes') = year ;
run;
/* add HbA1c as a predictor */
proc logistic data=clinic;
model dka(event='Yes') = InitalA1c ;
run;
ods rtf close;
proc print data=clinic; var age_cat; run;

/* multivariate model with predictors that were significant on univariate */
ods rtf file="C:\temp\output.rtf" style=journal;
proc logistic data=clinic;
class  new_ins(ref="Private") year Rural_or_non_rural(ref='Non-rural') race_eth(ref='Non-Hispanic White');
model dka(event='Yes') = Age_AtOnset  new_ins year Rural_or_non_rural InitalA1c race_eth;
where new_ins ne 'None';
run;
/* model without A1c */
proc logistic data=clinic;
class  new_ins year Rural_or_non_rural(ref='Non-rural') race_eth(ref='Non-Hispanic White');
model dka(event='Yes') = Age_AtOnset  new_ins year Rural_or_non_rural race_eth;
where new_ins ne 'None';
run;
ods rtf close;

/* checking for missing covariates in active study patients */
proc contents data=activestudy; run;
data active_missing;
set activestudy;
where Age_AtOnset=. or age_cat=. or gender in ("","."," ") or race_eth in ("","."," ") or hispanic=. or new_ins in ("","."," ") or English=. 
  or year=. or Rural_or_non_rural in ("","."," ") or InitalA1c=.;
run;
data active_missing;
set active_missing;
keep MRN PP3 source Age_AtOnset age_cat gender race_eth hispanic new_ins English year Rural_or_non_rural InitalA1c;
run;
proc print data=active_missing; 
run;
proc export data=active_missing
  outfile="W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\active_study_participants_missing_covariates.csv" dbms=csv replace;
run;

/* checking all participants with DKA=yes and DKA severity=unknown */
data dka_severity_unknown;
set alldata;
where dka='Yes' and dka_sev="Unknown";
run;
proc export data=dka_severity_unknown
  outfile="W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\dka_severity_unknown.csv" dbms=csv replace;
run;

proc print data=alldata;
where mrn=1516406;
var mrn source instudy Rural_or_non_rural ZipCode_DateOfDiagnosis;
run;
proc print data=alldata;
where Rural_or_non_rural in (""," ");
var mrn source instudy Rural_or_non_rural ZipCode_DateOfDiagnosis;
run;
proc print data=alldata;
where new_ins in (""," ") and instudy=1;
var mrn source instudy active_inactive_clinic insurancegroup new_ins;
run;
proc print data=alldata;
where race_eth in (""," ") ;
var mrn source instudy active_inactive_clinic race new_eth Ethnicity race_eth;
run;
proc contents; run;

/* model testing interaction of clinic/active/inactive with age group */

proc logistic data=alldata;
class instudy age_cat dka;
model dka = instudy age_cat instudy*age_cat;
run;

/* write final dataset */
proc export data=alldata
  outfile="W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\final_data_export.csv" dbms=csv replace;
run;

