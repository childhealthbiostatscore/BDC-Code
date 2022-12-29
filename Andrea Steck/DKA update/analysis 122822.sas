*libname data 'S:\Shared Projects\Laura\BDC\Projects\Todd Alonso\DKA\Data';
*libname data 'T:\Todd Alonso\DKA\Data';
libname data 'B:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw';

proc format;
  value age_cat 1='<6 years'
                2='6- <13 years'
				3='13+ years';
  value $ gender "F"="Female"
				 "M"="Male";
  value $ new_ins "Military Plans"="Military Plans"
				  "None"="None"
				  "Private"="Private"
				  "Public"="Public";
  value $ new_eth "Hispanic"="Hispanic"
				"Non-Hispanic Black"="Non-Hispanic Black"
				"Non-Hispanic White"="Non-Hispanic White"
				"Other/Unknown"="Other/Unknown";
run;

data alldata;
set data.alldata;
run;
proc contents; run;

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



/* STOPPED HERE */

proc freq data=alldata; table insurancetype ; run;
/* recategorize some insurance types */
proc freq data=alldata; tables insurancetype; run;
data alldata;
length new_ins $30;
set alldata;
if insurancetype in ('TBD','Unknown') then new_ins='Unknown';
else if insurancetype in ('Public','Medicaid') then new_ins='Public/Medicaid';
else if insurancetype in ('Military Plans ','Private ') then new_ins='Private/military';
else new_ins=insurancetype;
run;
proc freq data=alldata;
tables insurancetype*new_ins;
run;
/*data alldata;*/
/*set alldata;*/
/*new_ins=insurancetype;*/
/*run;*/

/* recode English cap and noncap */
data alldata;
set alldata;
if PrimarySpokenLanguage='ENGLISH' then PrimarySpokenLanguage='English';
run;

/* create variable for non-English speaking */
data alldata;
set alldata;
if PrimarySpokenLanguage in (' ','.') then English=.;
else if PrimarySpokenLanguage='English' then English=1;
else English=0;
run;
proc freq data=alldata;
tables PrimarySpokenLanguage*English;
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
tables month*quarter;
run;

/* year of onset */
data alldata;
set alldata;
year=year(onsetdate);
run;

/* combine race ethnicity categories */
/*	Let’s do race/ethnicity as NHW, H, NHB, and all the others/unknown. */
data alldata;
set alldata;
if RaceEthnicity in ('Non-Hispanic White','Non-Hispanic Black','Hispanic') then new_eth=RaceEthnicity;
else new_eth='Other/Unknown';
run;
proc freq data=alldata;
tables raceEthnicity*new_eth;
run;

*ods rtf file="C:\temp\output.rtf";
proc freq data=alldata;
tables Gender RaceEthnicity InsuranceType PrimarySpokenLanguage Rural_Non_Rural DKAAtDx year month; 
run;
*ods rtf close;

/* compare DKA status known to unknown */
data alldata;
set alldata;
if dkaatdx="UNKN" then dkaknown=0;
else dkaknown=1;
format gender $gender. new_eth $new_eth. new_ins $new_ins.;
label ageatonset="Age at onset"
	  gender="Sex"
	  new_eth="Race/ethnicity"
	  new_ins="Insurance";
run;
proc freq data=alldata;
tables dkaatdx*dkaknown;
run;
proc ttest data=alldata;
var ageatonset;
class dkaknown;
run;
proc freq data=alldata;
tables dkaknown*(gender new_eth new_ins) / chisquare exact;
run;
data foranalysis;
set alldata;
run;
%include 'H:\SAS tools\Amanda table 1\2 category macros with KW.sas';
proc datasets;
delete OutTable ;
run;
quit;
%CON(BV = ageatonset, OC=dkaknown);
%CAT(BV = gender, BVF = $gender, OC= dkaknown);
%CAT(BV = new_eth, BVF = $new_eth, OC= dkaknown);
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

/* now delete unknown status for rest of analysis */
data alldata;
set alldata;
if dkaatdx='UNKN' then delete;
run;


/* predictors are age at onset, gender, race, insurance, language, onset year, rural/nonrural */
/* with and without adjustment for quarter of the year */
proc logistic data=alldata;
model dkaatdx(event='DKA') = ageatonset ;
run;
%macro cat(var);
proc logistic data=alldata;
class &var;
model dkaatdx(event='DKA') = &var ;
run;
%mend;
%cat(gender);
proc logistic data=alldata;
class new_eth(ref='Non-Hispanic White');;
model dkaatdx(event='DKA') = new_eth;
run;
proc logistic data=alldata;
class new_ins(ref='Private/milita');
model dkaatdx(event='DKA') = new_ins;
where new_ins ne 'None';
run;
proc freq data=alldata; table new_ins; run;
%cat(English);
%cat(onsetYear);
%cat(Rural_Non_Rural);
%cat(age_cat);
proc logistic data=alldata;
model dkaatdx(event='DKA') = onsetYear ;
run;
/* add HbA1c as a predictor */
proc logistic data=alldata;
model dkaatdx(event='DKA') = A1cAtDiagnosis ;
run;

/* year of onset, by insurance category */
proc sort data=alldata; by new_ins; run;
proc logistic data=alldata;
model dkaatdx(event='DKA') = onsetYear ;
by new_ins;
where new_ins not in (' ','.','None');
run;

proc freq data=alldata;
tables onsetYear*dkaatdx;
run;

/* multivariate model with predictors that were significant on univariate */
ods rtf file="C:\temp\output.rtf" style=journal;
proc logistic data=alldata;
class new_eth(ref='Non-Hispanic White')  new_ins(ref='Private/milita') Rural_Non_Rural;
model dkaatdx(event='DKA') = new_eth new_ins onsetYear Rural_Non_Rural A1cAtDiagnosis;
where new_ins ne 'None';
run;
ods rtf close;
/* multivariate model with predictors that were significant on univariate, without a1c */
ods rtf file="C:\temp\output.rtf" style=journal;
proc logistic data=alldata;
class new_eth(ref='Non-Hispanic White')  new_ins(ref='Private/milita') Rural_Non_Rural;
model dkaatdx(event='DKA') = new_eth new_ins onsetYear Rural_Non_Rural ;
where new_ins ne 'None';
run;
ods rtf close;
/* by insurance type */
ods rtf file="C:\temp\output.rtf" style=journal;
proc logistic data=alldata;
class new_eth(ref='Non-Hispanic White')  Rural_Non_Rural;
model dkaatdx(event='DKA') = new_eth  onsetYear Rural_Non_Rural A1cAtDiagnosis;
by new_ins;
where new_ins not in (' ','.','None');
run;
ods rtf close;

/* multivariate model with predictors that were significant on univariate */
/* add interaction between insurance type and year of onset */
ods rtf file="C:\temp\output.rtf" style=journal;
proc logistic data=alldata;
class new_eth(ref='Non-Hispanic White')  new_ins(ref='Private/military') Rural_Non_Rural;
model dkaatdx(event='DKA') = new_eth new_ins onsetYear Rural_Non_Rural A1cAtDiagnosis onsetYear*new_ins;
where new_ins not in (' ','.','None');
oddsratio onsetYear / at(new_ins="Private/military");
oddsratio onsetYear / at(new_ins="Public/Medicaid");
ods output OddsRatios=or;
ods output OddsRatiosWald=orw;
run;
data orwp;
         set orw;
         alpha=.05;
         stderr=abs(log(uppercl)-log(lowercl)) / (2*probit(1-alpha/2));
         wald=(log(oddsratioest)/stderr)**2;
         p=1-probchi(wald,1);
         drop alpha;
         run;
        proc print data=orwp label noobs; 
         format p pvalue6.;
         label stderr="Standard Error" wald="Wald Chi-Square" p="Pr > ChiSq";
         run;
ods rtf close;

/* now with adjustment per quarter */
proc logistic data=alldata;
class quarter;
model dkaatdx(event='DKA') = ageatonset quarter;
run;
%macro catadj(var);
proc logistic data=alldata;
class &var quarter;
model dkaatdx(event='DKA') = &var quarter;
run;
%mend;
%catadj(gender);
proc logistic data=alldata;
class new_eth(ref='Non-Hispanic White') quarter;
model dkaatdx(event='DKA') = new_eth quarter;
run;
proc logistic data=alldata;
class new_ins(ref='Private/military') quarter;
model dkaatdx(event='DKA') = new_ins quarter;
run;
%catadj(English);
%catadj(onsetYear);
%catadj(Rural_Non_Rural);

/* examine rates of dka by age */
data alldata;
set alldata;
age_floor=floor(ageatonset);
run;
proc univariate data=alldata;
var age_floor;
run;
proc freq data=alldata;
tables dkaatdx*age_floor / outpct out=out;
run;
proc print data=out; run;
proc sgplot data=out;
where DKAAtDx='DKA';
vbar age_floor / response=PCT_COL;
run;

/* plot rates of dka by  year */
proc freq data=alldata;
tables dkaatdx*onsetYear / outpct out=out;
run;
proc print data=out; run;
proc sgplot data=out;
where DKAAtDx='DKA';
vbar onsetYear / response=PCT_COL;
run;

/* separate analysis of HbA1c at diagnosis */
/* predictors are age at onset, gender, race, insurance, language, onset year, rural/nonrural */
/* with and without adjustment for quarter of the year */
%macro contglm(var);
proc glm data=alldata;
model A1cAtDiagnosis = &var / solution;
run;
%mend;
%macro catglm(var);
proc glm data=alldata;
class &var;
model A1cAtDiagnosis = &var / solution;
lsmeans &var / stderr;
run;
%mend;
%contglm(ageatonset);
%catglm(age_cat);
%catglm(gender);
%catglm(new_eth);
%catglm(new_ins);
%catglm(English);
%contglm(onsetYear);
%catglm(Rural_Non_Rural);
proc glm data=alldata;
class new_eth(ref='Non-Hispanic White');
model A1cAtDiagnosis = new_eth / solution;
lsmeans new_eth;
run;
proc glm data=alldata;
class new_ins(ref='Private/military') ;
model A1cAtDiagnosis = new_ins / solution;
lsmeans new_ins / stderr;
run;

/* MULTIVARIATE FOR HBA1C */
ods rtf file="C:\temp\output.rtf" style=journal;
proc glm data=alldata;
class new_ins gender new_eth English;
model A1cAtDiagnosis = new_ins ageatonset gender new_eth English onsetYear / solution;
lsmeans new_ins / stderr;
lsmeans gender  / stderr;
lsmeans new_eth  / stderr;
lsmeans English  / stderr;
run;
ods rtf close;
proc freq data=alldata;
tables new_ins;
run;

/* plot of DKA rates by age groups */
proc freq data=alldata;
tables dkaatdx*age_cat;
run;

/* give Todd % DKA by insurance type and year with 95% CI */
proc sort data=alldata; by new_ins onsetYear; run;

proc freq data=alldata;
tables dkaatdx / binomial(wald) out=test ;
by new_ins onsetYear;
output out=test2 binomial;
run;
data test2;
set test2;
keep new_ins OnsetYear L_BIN U_BIN ;
label L_BIN='Lower bound 95% CI' U_BIN='Upper bound 95% CI';
run;
proc sort data=test; by new_ins OnsetYear ; run;
proc sort data=test2; by new_ins OnsetYear ; run;
data newtest;
merge test test2; 
by new_ins OnsetYear ; 
run;
data newtest;
set newtest;
where DKAAtDx='DKA';
run;
ods rtf file="C:\temp\output.rtf" style=journal;
proc print data=newtest label noobs; run;
ods rtf close;
