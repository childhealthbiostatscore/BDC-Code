libname data 'X:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw';

/**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      21MAY23
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data WORK.alldata    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'X:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\MASTER_05.16.23_WithoutMRNPP3.csv' delimiter = ',' MISSOVER DSD lrecl=13106 firstobs=2 ;
       informat Sample_ID best32. ;
       informat DOB mmddyy10. ;
       informat OnsetDate mmddyy10. ;
       informat OnsetYear best32. ;
       informat Age_AtOnset best32. ;
       informat Sex $6. ;
       informat Race $23. ;
       informat Ethnicity $22. ;
       informat CombinedEthnicityRace_TODD $1. ;
       informat Insurance $22. ;
       informat InsuranceGroup $7. ;
       informat InitalA1c best32. ;
       informat pH best32. ;
       informat bicarb best32. ;
       informat pH_MarianJama $1. ;
       informat BiCarb_MarianJama $1. ;
       informat DKA $3. ;
       informat Rural_or_non_rural $1. ;
       informat ZipCode_DateOfDiagnosis $5. ;
       informat State_DateOfDiagnosis $8. ;
       informat PrimaryLanguage $10. ;
       informat NewOnset_DxThroughScreeningStudy $4. ;
       informat Last_research_study_visit_date mmddyy10. ;
       informat Initial_research_study_visit_dat mmddyy10. ;
       informat Rural_Non_Rural $9. ;
       informat STATE $2. ;
       informat race_eth $18. ;
       informat instudy best32. ;
       informat fup_prior_dx best32. ;
       informat fup_prior_dx_mo best32. ;
       informat ge6moprior best32. ;
       informat last_visit_to_dx best32. ;
       informat seen_12mo_prior best32. ;
       informat SOURCE $6. ;
       format Sample_ID best12. ;
       format DOB mmddyy10. ;
       format OnsetDate mmddyy10. ;
       format OnsetYear best12. ;
       format Age_AtOnset best12. ;
       format Sex $6. ;
       format Race $23. ;
       format Ethnicity $22. ;
       format CombinedEthnicityRace_TODD $1. ;
       format Insurance $22. ;
       format InsuranceGroup $7. ;
       format InitalA1c best12. ;
       format pH best12. ;
       format bicarb best12. ;
       format pH_MarianJama $1. ;
       format BiCarb_MarianJama $1. ;
       format DKA $3. ;
       format Rural_or_non_rural $1. ;
       format ZipCode_DateOfDiagnosis $5. ;
       format State_DateOfDiagnosis $8. ;
       format PrimaryLanguage $10. ;
       format NewOnset_DxThroughScreeningStudy $4. ;
       format Last_research_study_visit_date mmddyy10. ;
       format Initial_research_study_visit_dat mmddyy10. ;
       format Rural_Non_Rural $9. ;
       format STATE $2. ;
       format race_eth $18. ;
       format instudy best12. ;
       format fup_prior_dx best12. ;
       format fup_prior_dx_mo best12. ;
       format ge6moprior best12. ;
       format last_visit_to_dx best12. ;
       format seen_12mo_prior best12. ;
       format SOURCE $6. ;
    input
                Sample_ID
                DOB
                OnsetDate
                OnsetYear
                Age_AtOnset
                Sex  $
                Race  $
                Ethnicity  $
                CombinedEthnicityRace_TODD  $
                Insurance  $
                InsuranceGroup  $
                InitalA1c
                pH
                bicarb
                pH_MarianJama  $
                BiCarb_MarianJama  $
                DKA  $
                Rural_or_non_rural  $
                ZipCode_DateOfDiagnosis $
                State_DateOfDiagnosis  $
                PrimaryLanguage  $
                NewOnset_DxThroughScreeningStudy  $
                Last_research_study_visit_date
                Initial_research_study_visit_dat
                Rural_Non_Rural  $
                STATE  $
                race_eth  $
                instudy
                fup_prior_dx
                fup_prior_dx_mo
                ge6moprior
                last_visit_to_dx
                seen_12mo_prior
                SOURCE  $
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;

	data data.alldata;
	set alldata;
	run;

proc print; 
where ZipCode_DateOfDiagnosis in (""," ");
run;


/* read in zip code data */
 /**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      29DEC22
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data WORK.zips    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'X:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\DMERuralZIP.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat STATE $2. ;
       informat ZipCode_DateOfDiagnosis $5. ;
       informat YEAR_QTR best32. ;
       format STATE $2. ;
       format ZipCode_DateOfDiagnosis $5. ;
       format YEAR_QTR best12. ;
    input
                STATE  $
                ZipCode_DateOfDiagnosis $
                YEAR_QTR
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;
proc print; run;

data zips;
length Rural_Non_Rural $10;
set zips;
drop YEAR_QTR; 
Rural_Non_Rural="Rural";
run;
proc freq data=zips; table rural_non_rural; run;
proc sort data=zips; by ZipCode_DateOfDiagnosis; run;
proc sort data=alldata; by ZipCode_DateOfDiagnosis; run;

data alldata;
merge alldata(in=ina) zips;
by ZipCode_DateOfDiagnosis; 
if ina;
run;
proc freq data=alldata; table Rural_Non_Rural / missing; run;
data alldata;
set alldata;
if ZipCode_DateOfDiagnosis="" or ZipCode_DateOfDiagnosis=" " then Rural_Non_Rural="";
else if  Rural_Non_Rural="" or Rural_Non_Rural=" " then Rural_Non_Rural="Non-rural";
run;
proc print; run;
proc freq data=alldata; table Rural_Non_Rural; run;
proc print data=alldata; var ZipCode_DateOfDiagnosis Rural_Non_Rural; run;

/* create new race_eth variable as NHW, H, NHB, O */
proc freq data=alldata;
table race ethnicity race_eth;
run;
data alldata;
set alldata;
if race="White" and ethnicity="Not Hispanic or Latino" then  ="Non-Hispanic White";
else if race="Black/African American" and ethnicity="Not Hispanic or Latino" then race_eth="Non-Hispanic Black";
else if race="Hispanic/Latino" or ethnicity="Hispanic or Latino" then race_eth="Hispanic";
else race_eth="Other";
run;
proc freq data=alldata;
tables race_eth*race*ethnicity;
run;

/* now we have the dataset which contains study participants and non-participants */
/* for study participants, need to limit to 70 subjects with at least 6 months of follow up */
proc contents data=alldata; run;
proc freq data=alldata; table NewOnset_DxThroughScreeningStudy; run;
data nonstudy;
set alldata;
where NewOnset_DxThroughScreeningStudy="NULL" or NewOnset_DxThroughScreeningStudy="";
instudy=0;
run; 
proc freq data=nonstudy; table NewOnset_DxThroughScreeningStudy; run;
data study;
set alldata; 
where NewOnset_DxThroughScreeningStudy ne "NULL" and NewOnset_DxThroughScreeningStudy ne "";
instudy=1;
run; 
proc freq data=study; table NewOnset_DxThroughScreeningStudy; run;

/* create variable ge6moprior */
data study;
set study;
fup_prior_dx = onsetdate - Initial_research_study_visit_dat;
fup_prior_dx_mo = fup_prior_dx/30.44;
run;
data study;
set study;
if fup_prior_dx_mo>=6 then ge6moprior=1;
else ge6moprior=0;
run;
proc print data=study;
var Sample_ID NewOnset_DxThroughScreeningStudy onsetdate Initial_research_study_visit_dat fup_prior_dx fup_prior_dx_mo ge6moprior;
run;

/* create variable seen_12mo_prior */
data study;
set study;
last_visit_to_dx = floor((onsetdate - Last_research_study_visit_date)/30.44);
run;
data study;
set study;
if last_visit_to_dx<12 then seen_12mo_prior = 1;
else seen_12mo_prior=0;
run;
proc print data=study;
var Sample_ID NewOnset_DxThroughScreeningStudy onsetdate Last_research_study_visit_date last_visit_to_dx seen_12mo_prior;
run;
proc freq data=study;
table ge6moprior*seen_12mo_prior;
run;
data study;
set study;
where ge6moprior and seen_12mo_prior;
run;
proc freq data=study;
table ge6moprior*seen_12mo_prior;
run;

data alldata;
set study nonstudy;
run;

/* write final dataset */
data data.alldata;
set alldata;
run;

/* export csv file */
proc export data=alldata
outfile="X:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\morgan cleaned final dataset.csv"
replace
dbms="csv";
run;
