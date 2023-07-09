*libname data 'S:\Shared Projects\Laura\BDC\Projects\Todd Alonso\DKA\Data';
libname data 'V:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw';

 /**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      29JUN23
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data WORK.ALLDATA    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'V:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\MASTER_06.15.23_WithMRNPP3 edited.csv' delimiter = ',' MISSOVER DSD lrecl=13106 firstobs=2 ;
       informat MRN best32. ;
       informat PP3 best32. ;
       informat Sample_ID best32. ;
       informat DOB mmddyy10. ;
       informat OnsetDate mmddyy10. ;
       informat OnsetYear best32. ;
       informat Age_AtOnset best32. ;
       informat Sex $6. ;
       informat Race $20. ;
       informat Ethnicity $22. ;
       informat Insurance $28. ;
       informat InsuranceGroup $7. ;
       informat InitalA1c best32. ;
       informat pH 8.2 ;
       informat bicarb 8. ;
       informat pH_MarianJama best32. ;
       informat BiCarb_MarianJama best32. ;
       informat DKA $3. ;
       informat DKA_sev $10. ;
       informat Rural_or_non_rural $9. ;
       informat ZipCode_DateOfDiagnosis $5. ;
       informat State_DateOfDiagnosis $1. ;
       informat PrimaryLanguage $30. ;
       informat NewOnset_DxThroughScreeningStudy $9. ;
       informat Last_research_study_visit_date mmddyy10. ;
       informat Initial_research_study_visit_dat mmddyy10. ;
       informat STATE $1. ;
       informat race_eth $20. ;
       informat instudy best32. ;
       informat fup_prior_dx 8. ;
       informat fup_prior_dx_mo 8. ;
       informat ge6moprior 8. ;
       informat last_visit_to_dx 8. ;
       informat seen_12mo_prior $1. ;
       informat SOURCE $10. ;
       format MRN best12. ;
       format PP3 best12. ;
       format Sample_ID best12. ;
       format DOB mmddyy10. ;
       format OnsetDate mmddyy10. ;
       format OnsetYear best12. ;
       format Age_AtOnset best12. ;
       format Sex $6. ;
       format Race $20. ;
       format Ethnicity $22. ;
       format Insurance $28. ;
       format InsuranceGroup $7. ;
       format InitalA1c best12. ;
       format pH 8.2 ;
       format bicarb 8. ;
       format pH_MarianJama best12. ;
       format BiCarb_MarianJama best12. ;
       format DKA $3. ;
       format DKA_sev $10. ;
       format Rural_or_non_rural $9. ;
       format ZipCode_DateOfDiagnosis $5. ;
       format State_DateOfDiagnosis $1. ;
       format PrimaryLanguage $30. ;
       format NewOnset_DxThroughScreeningStudy $9. ;
       format Last_research_study_visit_date mmddyy10. ;
       format Initial_research_study_visit_dat mmddyy10. ;
       format STATE $1. ;
       format race_eth $20. ;
       format instudy best12. ;
       format fup_prior_dx 8. ;
       format fup_prior_dx_mo 8. ;
       format ge6moprior 8. ;
       format last_visit_to_dx 8. ;
       format seen_12mo_prior 8. ;
       format SOURCE $10. ;
    input
                MRN
                PP3
                Sample_ID
                DOB
                OnsetDate
                OnsetYear
                Age_AtOnset
                Sex  $
                Race  $
                Ethnicity  $
                Insurance  $
                InsuranceGroup  $
                InitalA1c
                pH 
                bicarb  
                pH_MarianJama
                BiCarb_MarianJama
                DKA  $
                DKA_sev  $
                Rural_or_non_rural  $
                ZipCode_DateOfDiagnosis  $
                State_DateOfDiagnosis  $
                PrimaryLanguage  $
                NewOnset_DxThroughScreeningStudy  $
                Last_research_study_visit_date
                Initial_research_study_visit_dat
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
proc freq data=alldata; table instudy; run;
proc contents; run;

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
    infile 'V:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\DMERuralZIP.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
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
proc freq data=alldata; table instudy; run;

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
    infile 'V:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\checking_DKA_07FEB2023.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat MRN best32. ;
       informat DKA $3. ;
       informat dka_sev $10. ;
       informat pH 8. ;
       informat bicarb 8. ;
       format MRN best12. ;
       format DKA $3. ;
       format dka_sev $10. ;
       format pH 8. ;
       format bicarb 8. ;
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
proc contents data=alldata; run;
proc contents data=corrections; run;
proc print; var fup_prior_dx; run;
proc freq data=alldata; table instudy; run;

/* now we have the dataset which contains study participants and non-participants */
/* for study participants, need to limit to 70 subjects with at least 6 months of follow up */
/* SOMEWHERE JUST AFTER HERE THE VARIABLE fup_prior_dx='*' */
data nonstudy;
set alldata;
where instudy=0;
run; 
data study;
set alldata; 
where instudy=1;
run; 

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
var onsetdate Initial_research_study_visit_dat fup_prior_dx fup_prior_dx_mo ge6moprior;
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
var onsetdate Last_research_study_visit_date last_visit_to_dx seen_12mo_prior;
run;
proc freq data=study;
table ge6moprior*seen_12mo_prior;
run;
/*data study;
set study;
if ge6moprior=1; 
run;
data study;
set study;
if seen_12mo_prior=1; 
run; */
proc freq data=study;
table ge6moprior*seen_12mo_prior;
run;

data alldata;
set study nonstudy;
run;
proc freq data=alldata;
table ge6moprior*seen_12mo_prior;
run;

/* write final dataset */
data data.alldata;
set alldata;
run;
proc freq data=alldata; table instudy; run;

/* export csv file */
proc export data=alldata
outfile="V:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\morgan cleaned final dataset.csv"
replace
dbms="csv";
run;
