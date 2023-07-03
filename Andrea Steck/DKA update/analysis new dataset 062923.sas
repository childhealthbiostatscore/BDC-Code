
*libname data 'S:\Shared Projects\Laura\BDC\Projects\Todd Alonso\DKA\Data';
*libname data 'T:\Todd Alonso\DKA\Data';
libname data 'W:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw';

proc format;
  value age_cat 1='<6 years'
                2='6- <13 years'
				3='13+ years';
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
proc freq data=alldata; table race_eth*source ; run;
proc freq data=alldata;
where source="MarianJama"; 
table race ethnicity;
run;
proc freq data=alldata;
where source="MarianJama"; 
table dka*dka_sev;
run;


data x;
set alldata;
where dka="Yes" and dka_sev="No DKA";
run;
proc export data=x dbms=csv replace outfile="V:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\dka_yes_sev_none.csv";
run;

proc print; 
var BiCarb_MarianJama pH_MarianJama;
where BiCarb_MarianJama ne "" and pH_MarianJama ne "";
run;

/* exclude one participant over 21 years old */
data alldata;
set alldata;
if Age_AtOnset>=21 then delete;
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
proc freq data=alldata;
tables age_cat;
run;

proc freq data=alldata; table insurance insurancegroup ; run;
/* recategorize some insurance types */
/*proc freq data=alldata; tables insurancetype; run;
data alldata;
length new_ins $30;
set alldata;
if insurancegroup in ('TBD','Unknown') then new_ins='Unknown';
else if insurancegroup in ('Public','Medicaid') then new_ins='Public/Medicaid';
else if insurancegroup in ('Military Plans ','Private ') then new_ins='Private/military';
else new_ins=insurancegroup;
run;
proc freq data=alldata;
tables insurancegroup*new_ins;
run;*/
data alldata;
set alldata;
new_ins=insurancegroup;
run;

/* recode English cap and noncap */
proc freq data=alldata; table PrimaryLanguage; run;
data alldata;
set alldata;
if PrimaryLanguage='ENGLISH' then PrimaryLanguage='English';
run;
proc freq data=alldata; table PrimaryLanguage; run;

/* create variable for non-English speaking */
data alldata;
set alldata;
if PrimaryLanguage in (' ','.') then English=.;
else if PrimaryLanguage='English' then English=1;
else English=0;
run;
proc freq data=alldata;
tables PrimaryLanguage*English;
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
proc freq data=alldata;
tables month*quarter / missing;
run;

/* year of onset */
data alldata;
set alldata;
year=year(onsetdate);
run;
proc freq data=alldata; table year / missing; run;

/* combine race ethnicity categories */
/*	Let’s do race/ethnicity as NHW, H, NHB, and all the others/unknown. */
proc freq data=alldata; table race; run;
data alldata;
set alldata;
new_eth=race_eth;
run;
data alldata;
set alldata;
if new_eth="Hispanic" then hispanic=1;
else hispanic=0;
run;
proc freq data=alldata; table new_eth*hispanic; run;
proc freq data=alldata; table race_eth; run;

/* correct DKA status */
/*data alldata;
set alldata;
if mrn="1644153" then dka="No";
else if mrn="1213967" then dka="No";
else if mrn="1361724" then dka="No";
else if mrn="1593479" then dka="No";
run;*/
proc freq data=alldata; table dka ; run;

/* create variable for DKA severity */
data alldata;
set alldata;
if (ph ne . and ph<7.1) or (bicarb ne . and bicarb <5) then dka_sev="Severe DKA";
else if (ph>=7.1 and ph<7.3) or (bicarb>=5 and bicarb<15) then dka_sev="Mild DKA";
else dka_sev="No DKA";
run;
proc freq data=alldata;
tables dka_sev;
run;

/* read in hardcoded corrections */
 /**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      19FEB23
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
   data WORK.CORRECTIONS    ;
    %let _EFIERR_ = 0; 
    infile 'W:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\checking_DKA_07FEB2023.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
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
proc print data=alldata;
var mrn dka dka_sev ph bicarb;
run; 


proc print data=alldata;
where Age_AtOnset>=18; 
run;


/* compare DKA status known to unknown */
proc freq data=alldata; table dka; run;
data alldata;
set alldata;
if dka="YES" then dka="Yes";
gender=sex;
if strip(dka)="No" then dka="No";
run;
proc freq data=alldata;
table dka dka_sev;
run;
data alldata;
set alldata;
if dka="." or dka="" or dka=" " then dkaknown=0;
else dkaknown=1;
format gender $gender. new_eth $new_eth. new_ins $new_ins. dka $dka. Rural_Non_Rural $rural. 
		english yn. hispanic yn. dka_sev $dka_sev. race_eth $race_eth.;
label Age_AtOnset="Age at onset"
	  gender="Sex"
	  new_eth="Race/ethnicity"
	  new_ins="Insurance"
	  InitalA1c="HbA1c"
	  dka="DKA"
	  dka_sev="DKA severity"
	  Rural_Non_Rural="Rural"
	  English="English-speaking"
      Hispanic="Hispanic"
	  race_eth="Race/ethnicity";
run;
proc print data=alldata;
var  instudy dka dkaknown;
where instudy=1;
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
table instudy*dkaknown;
run;
proc freq data=alldata;
tables dkaknown*(gender new_eth new_ins) / chisquare exact;
run;

data foranalysis;
set alldata;
run;
%include 'W:\SAS tools\Amanda table 1\2 category macros with KW.sas';
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
if dka='' or dka=" " then delete;
run;
proc freq data=alldata; table new_ins; run;
proc print data=alldata; run;
data foranalysis;
set alldata;
run;
proc contents data=foranalysis; run;

proc freq data=alldata;
table dka*dka_sev;
run;
ods rtf file='c:\temp\output.rtf' style=journal;
/* people without DKA who have mild or severe */
*proc print data=alldata;
*var Sample_ID dka dka_sev ph bicarb;
*where dka="No" and (dka_sev="Mild DKA" or dka_sev="Severe DKA");
*title "No DKA but mild or severe DKA severity"; 
*run;
/* people with DKA that are marked as none */
proc print data=alldata;
var source mrn dka dka_sev ph bicarb;
where dka="Yes" and dka_sev="No DKA";
title "With DKA but DKA severity=none"; 
run;
title;
ods rtf close;

/* predictors are age at onset, gender, race, insurance, language, onset year, rural/nonrural */
/* with and without adjustment for quarter of the year */
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
class new_eth(ref='Non-Hispanic White');;
model dka(event='Yes') = new_eth;
run;
proc logistic data=alldata;
class new_ins(ref='Private');
model dka(event='Yes') = new_ins;
run;
proc freq data=alldata; table new_ins; run;
%cat(English);
%cat(year);
%cat(Rural_non_rural);
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

/* 2x2 table of study by DKA */
ods rtf file="C:\temp\output.rtf" style=journal;
proc freq data=alldata;
table instudy*dka / chisq;
run;
ods rtf close;

proc freq data=alldata;
table year;
run;
/* multivariate model with predictors that were significant on univariate */
ods rtf file="C:\temp\output.rtf" style=journal;
proc logistic data=alldata;
class Rural_Non_Rural age_cat instudy(ref='0');
model dka(event='Yes') =  age_cat Rural_Non_Rural InitalA1c instudy;
run;
/* model without A1c */
proc logistic data=alldata;
class Rural_Non_Rural age_cat instudy(ref='0');
model dka(event='Yes') =  age_cat Rural_Non_Rural instudy;
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
class new_eth(ref='Non-Hispanic White') quarter;
model dka(event='Yes')  = new_eth quarter;
run;
proc logistic data=alldata;
class new_ins(ref='Private') quarter;
model dka(event='Yes')  = new_ins quarter;
run;
%catadj(English);
%catadj(year);
%catadj(Rural_Non_Rural);

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
%catglm(new_eth);
%catglm(new_ins);
%catglm(English);
%contglm(year);
%catglm(Rural_Non_Rural);
proc glm data=alldata;
class new_eth(ref='White');
model InitalA1c = new_eth / solution;
lsmeans new_eth;
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
class new_ins new_eth English;
model InitalA1c = new_ins Age_AtOnset new_eth English year / solution;
lsmeans new_ins / stderr;
lsmeans new_eth  / stderr;
lsmeans English  / stderr;
run;
ods rtf close;

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
proc datasets;
delete OutTable ;
run;
quit;
%CON(BV = Age_AtOnset, OC=instudy);
%CON(BV = InitalA1c, OC=instudy);
%CAT(BV = gender, BVF = $gender, OC= instudy);
%CAT(BV = new_eth, BVF = $new_eth, OC= instudy);
%CAT(BV = hispanic, BVF = yn, OC= instudy);
%CAT(BV = new_ins, BVF = $new_ins, OC= instudy);
%CAT(BV = dka, BVF = $new_ins, OC= instudy);
%CAT(BV = dka_sev, BVF = $new_ins, OC= instudy);
%CAT(BV = Rural_Non_Rural, BVF = $rural, OC= instudy);
%CAT(BV = english, BVF = yn, OC= instudy);
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
proc sort data=foranalysis; by instudy; run;
proc means data=foranalysis;
var InitalA1c;
by instudy;
run;
proc print; run;

proc print data=alldata;
where dka="Yes" and dka_sev="No DKA";
run;

/* rates of DKA by study participation and year */
ods rtf file="B:\Projects\Andrea Steck\Morgan Sooy DKA update\Report\DKA rates for figures.rtf";
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
data study;
set alldata;
where instudy=1;
run;
/* predictors are age at onset, gender, race, insurance, language, onset year, rural/nonrural */
proc logistic data=study;
model dka(event='Yes') = Age_AtOnset ;
run;
%macro cat(var);
proc logistic data=study;
class &var;
model dka(event='Yes') = &var ;
run;
%mend;
%cat(gender);
proc logistic data=study;
class new_eth(ref='Non-Hispanic White');;
model dka(event='Yes') = new_eth;
run;
proc logistic data=study;
class hispanic(ref='No');;
model dka(event='Yes') = hispanic;
run;
proc logistic data=study;
class new_ins(ref='Private');
model dka(event='Yes') = new_ins;
run;
%cat(English);
%cat(year);
%cat(Rural_non_rural);
%cat(age_cat);
proc logistic data=study;
model dka(event='Yes') = year ;
run;
/* add HbA1c as a predictor */
proc logistic data=study;
model dka(event='Yes') = InitalA1c ;
run;
proc freq data=study; table hispanic; run;

/* multivariate model with predictors that were significant on univariate */
ods rtf file="C:\temp\output.rtf" style=journal;
proc logistic data=study;
class  ;
model dka(event='Yes') =   InitalA1c;
run;
ods rtf close;

/******************/
/* CLINIC PATIENTS */
/******************/
data clinic;
set alldata;
where instudy=0;
run;
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
class new_eth(ref='Non-Hispanic White');;
model dka(event='Yes') = new_eth;
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
%cat(Rural_non_rural);
%cat(age_cat);
proc logistic data=clinic;
model dka(event='Yes') = year ;
run;
/* add HbA1c as a predictor */
proc logistic data=clinic;
model dka(event='Yes') = InitalA1c ;
run;

/* multivariate model with predictors that were significant on univariate */
ods rtf file="C:\temp\output.rtf" style=journal;
proc logistic data=clinic;
class age_cat;
model dka(event='Yes') =  age_cat InitalA1c;
where new_ins ne 'None';
run;
/* model without A1c */
proc logistic data=alldata;
class Rural_Non_Rural age_cat;
model dka(event='Yes') =  age_cat Rural_Non_Rural ;
where new_ins ne 'None';
run;
ods rtf close;
