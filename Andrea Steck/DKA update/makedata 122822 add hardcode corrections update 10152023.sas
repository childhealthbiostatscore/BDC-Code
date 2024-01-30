*libname data 'S:\Shared Projects\Laura\BDC\Projects\Todd Alonso\DKA\Data';
libname data 'W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw';
libname data "W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw";

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
    infile 'W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\MASTER 10.18.23 MS.csv' delimiter = ',' MISSOVER DSD lrecl=13106 firstobs=2 ;
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
       informat State_DateOfDiagnosis $2. ;
       informat PrimaryLanguage $30. ;
       informat NewOnset_DxThroughScreeningStudy $9. ;
       informat Last_research_study_visit_date mmddyy10. ;
       informat Initial_research_study_visit_dat mmddyy10. ;
       informat STATE $2. ;
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
       format State_DateOfDiagnosis $2. ;
       format PrimaryLanguage $30. ;
       format NewOnset_DxThroughScreeningStudy $9. ;
       format Last_research_study_visit_date mmddyy10. ;
       format Initial_research_study_visit_dat mmddyy10. ;
       format STATE $2. ;
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
proc freq data=alldata; table Rural_or_non_rural / missing; run;
proc print data=alldata; var ZipCode_DateOfDiagnosis; where Rural_or_non_rural in (""," "); run;
/* 150 observations missing ZipCode_DateOfDiagnosis and Rural_or_non_rural */

proc contents; run;

/* read in file with updated covariates */
  /**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      15OCT23
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data WORK.missing_covariates    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\active_study_participants_missing_covariates updated.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat MRN best32. ;
       informat PP3 best32. ;
       informat Age_AtOnset best32. ;
       informat InitalA1c best32. ;
       informat Rural_or_non_rural $15. ;
       informat race_eth $18. ;
       informat SOURCE $10. ;
       informat age_cat $12. ;
       informat new_ins $7. ;
       informat English 8. ;
       informat year best32. ;
       informat hispanic 8. ;
       informat gender $6. ;
       format MRN best12. ;
       format PP3 best12. ;
       format Age_AtOnset best12. ;
       format InitalA1c best12. ;
       format Rural_or_non_rural $15. ;
       format race_eth $18. ;
       format SOURCE $10. ;
       format age_cat $12. ;
       format new_ins $7. ;
       format English 8. ;
       format year best12. ;
       format hispanic 8. ;
       format gender $6. ;
    input
                MRN
                PP3
                Age_AtOnset
                InitalA1c
                Rural_or_non_rural  $
                race_eth  $
                SOURCE  $
                age_cat  $
                new_ins  $
                English  
                year
                hispanic  
                gender  $
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;
proc print data=missing_covariates; run;
proc contents data=missing_covariates; run;

/* divide into dataset with MRN and PP */
data missing_covariates_mrn;
set missing_covariates;
where mrn ne .;
run;
proc print; run;
data missing_covariates_pp;
set missing_covariates;
where mrn =.;
run;
proc print; run;

/* merge MRN and PP datasets individually with master dataset to update covariates */
proc sort data=alldata; by mrn; run;
proc sort data=missing_covariates_mrn; by mrn; run;
data alldata;
merge alldata missing_covariates_mrn;
by mrn;
run;
proc print data=alldata;
var mrn source instudy new_ins;
where instudy;
run;
proc print data=alldata;
where mrn=1034232;
var mrn source instudy new_ins;
run;
proc sort data=alldata; by pp3; run;
proc sort data=missing_covariates_pp; by pp3; run;
data alldata;
merge alldata missing_covariates_pp;
by pp3;
run;
proc freq data=alldata; table Rural_or_non_rural / missing; run;
proc print data=alldata; var ZipCode_DateOfDiagnosis; where Rural_or_non_rural in (""," "); run;
proc print data=alldata;
where mrn=1034232;
var mrn source instudy new_ins;
run;
/* 148 observations missing ZipCode_DateOfDiagnosis and Rural_or_non_rural */

/* read in file of missing ppts and add to the dataset*/
/**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      15OCT23
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data WORK.prev_excl    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\10.11.23 2017-2021 Previously excluded people to add to master.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat MRN best32. ;
       informat PP3 best32. ;
       informat Sample_ID best32. ;
       informat DOB mmddyy10. ;
       informat OnsetDate mmddyy10. ;
       informat OnsetYear best32. ;
       informat Age_AtOnset best32. ;
       informat Sex $6. ;
       informat Race $23. ;
       informat Ethnicity $22. ;
       informat Insurance $26. ;
       informat InsuranceGroup $7. ;
       informat InitalA1c best32. ;
       informat pH best32. ;
       informat bicarb best32. ;
       informat pH_MarianJama best32. ;
       informat BiCarb_MarianJama best32. ;
       informat dka $3. ;
       informat DKA_sev $6. ;
       informat Rural_or_non_rural $1. ;
       informat ZipCode_DateOfDiagnosis $5. ;
       informat State_DateOfDiagnosis $8. ;
       informat PrimaryLanguage $7. ;
       informat NewOnset_DxThroughScreeningStudy $8. ;
       informat Last_research_study_visit_date mmddyy10. ;
       informat Initial_research_study_visit_dat mmddyy10. ;
       informat STATE $2. ;
       informat race_eth $1. ;
       informat instudy best32. ;
       informat fup_prior_dx best32. ;
       informat fup_prior_dx_mo best32. ;
       informat ge6moprior best32. ;
       informat last_visit_to_dx best32. ;
       informat seen_12mo_prior $1. ;
       informat SOURCE $6. ;
       format MRN best12. ;
       format PP3 best12.;
       format Sample_ID best12. ;
       format DOB mmddyy10. ;
       format OnsetDate mmddyy10. ;
       format OnsetYear best12. ;
       format Age_AtOnset best12. ;
       format Sex $6. ;
       format Race $23. ;
       format Ethnicity $22. ;
       format Insurance $26. ;
       format InsuranceGroup $7. ;
       format InitalA1c best12. ;
       format pH best12. ;
       format bicarb best12. ;
       format pH_MarianJama best12.;
       format BiCarb_MarianJama best12. ;
       format dka $3. ;
       format DKA_sev $6. ;
       format Rural_or_non_rural $1. ;
       format ZipCode_DateOfDiagnosis $5. ;
       format State_DateOfDiagnosis $8. ;
       format PrimaryLanguage $7. ;
       format NewOnset_DxThroughScreeningStudy $8. ;
       format Last_research_study_visit_date mmddyy10. ;
       format Initial_research_study_visit_dat mmddyy10. ;
       format STATE $2. ;
       format race_eth $1. ;
       format instudy best12. ;
       format fup_prior_dx  best12.;
       format fup_prior_dx_mo best12. ;
       format ge6moprior best32. ;
       format last_visit_to_dx best32. ;
       format seen_12mo_prior $1. ;
       format SOURCE $6. ;
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
                pH_MarianJama  $
                BiCarb_MarianJama  
                dka  $
                DKA_sev  $
                Rural_or_non_rural  $
                ZipCode_DateOfDiagnosis $
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
                seen_12mo_prior  $
                SOURCE  $
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;
proc freq data=prev_excl; table instudy; run;
proc print data=prev_excl;
where MRN=1516406;
run;
data alldata;
set alldata prev_excl;
run;
proc freq data=alldata; table Rural_or_non_rural / missing; run;
proc print data=alldata; var ZipCode_DateOfDiagnosis Rural_or_non_rural; where Rural_or_non_rural in (""," "); run;
/* 179 observations missing ZipCode_DateOfDiagnosis and Rural_or_non_rural */
proc print data=alldata;
where mrn=1516406;
var mrn source instudy Rural_or_non_rural ZipCode_DateOfDiagnosis;
run;
data alldata;
set alldata;
if MRN=1189698 then ZipCode_DateOfDiagnosis=67871;
run;
data alldata;
set alldata;
if MRN=1724085 then ZipCode_DateOfDiagnosis=80111;
run;

/* need to make sure rural/nonrural and race/eth get updated */

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
    infile 'W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\DMERuralZIP.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
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
proc print data=zips; where STATE="CO"; run;
proc freq data=alldata; table ZipCode_DateOfDiagnosis; run;


data zips;
length Rural_Non_Rural $10;
set zips;
drop YEAR_QTR; 
Rural_Non_Rural="Rural";
run;
proc freq data=zips; table Rural_Non_Rural; run;
proc sort data=zips; by ZipCode_DateOfDiagnosis; run;
proc sort data=alldata; by ZipCode_DateOfDiagnosis; run;
data alldata;
merge alldata(in=ina) zips;
by ZipCode_DateOfDiagnosis; 
if ina;
run;
proc print data=alldata;
where mrn in (1189698,1724085);
var mrn source instudy Rural_or_non_rural ZipCode_DateOfDiagnosis;
run;

data alldata;
set alldata;
if ZipCode_DateOfDiagnosis="" or ZipCode_DateOfDiagnosis=" " then Rural_Non_Rural="";
else if  Rural_Non_Rural="" or Rural_Non_Rural=" " then Rural_Non_Rural="Non-rural";
run;
data alldata;
set alldata;
if ZipCode_DateOfDiagnosis not in (""," ") and Rural_or_non_rural in (""," ") then Rural_or_non_rural="Non-rural";
run;
proc print data=alldata;
where mrn=1045809;
var mrn source instudy Rural_or_non_rural ZipCode_DateOfDiagnosis;
run;
data alldata;
set alldata;
if Rural_or_non_rural in (""," ") then Rural_or_non_rural=Rural_or_non_rural;
run;
data alldata;
set alldata;
if MRN=1189698 then Rural_or_non_rural='Non-rural';
run;
data alldata;
set alldata;
if MRN=1724085 then Rural_or_non_rural='Non-rural';
run;
proc print data=alldata;
where mrn in (1189698,1724085);
var mrn source instudy Rural_or_non_rural ZipCode_DateOfDiagnosis;
run;
proc freq data=alldata; table Rural_or_non_rural / missing; run;
proc print data=alldata; var ZipCode_DateOfDiagnosis Rural_or_non_rural; where Rural_or_non_rural in (""," "); run;
/* still 179 observations missing ZipCode_DateOfDiagnosis and Rural_or_non_rural */
proc print data=alldata;
where mrn=1034232;
var mrn source instudy new_ins;
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
 /*  data WORK.CORRECTIONS    ;
    %let _EFIERR_ = 0; 
    infile 'W:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\checking_DKA_07FEB2023.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
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
proc freq data=alldata; table instudy; run;*/

/* now we have the dataset which contains study participants and non-participants */
/* MAKE SURE THE N IS RIGHT */
/* for study participants, need to limit to 70 subjects with at least 6 months of follow up */
proc freq data=alldata; table instudy; run;
data nonstudy;
set alldata;
where instudy=0;
run; 
data study;
set alldata; 
where instudy=1;
run; 
proc print data=study;
where MRN=1516406;
run;

/* create variable ge6moprior */
/* calculate length of followup: initial research visit to diagnosis date, and initial research visit to last research visit */
data study;
set study;
fup_prior_dx = onsetdate - Initial_research_study_visit_dat;
fup_prior_dx_mo = fup_prior_dx/30.44;
fup_first_to_last_visit = Last_research_study_visit_date - Initial_research_study_visit_dat;
fup_first_to_last_visit_mo = fup_first_to_last_visit/30.44;
run;
proc print data=study;
where MRN=1516406;
run;
data study;
set study;
if fup_prior_dx_mo>=6 then ge6moprior=1;
else ge6moprior=0;
run;
proc print data=study;
where MRN=1516406;
run;
proc print data=study;
var onsetdate Initial_research_study_visit_dat fup_prior_dx fup_prior_dx_mo ge6moprior;
run;
proc print data=study;
where MRN=1516406;
run;
proc print data= study;
var onsetdate Initial_research_study_visit_dat Last_research_study_visit_date fup_prior_dx_mo fup_first_to_last_visit_mo;
run;
proc contents; run;

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
proc print data=alldata;
where MRN=1516406;
run;

/* per Morgan, delete PP3 ID 41815 */
data alldata;
set alldata;
if PP3="41815" then delete;
run;

proc freq data=alldata;
table instudy*dka;
run;
proc freq data=alldata;
table Rural_Non_Rural rural_non_rural / missing;
run;

/* write final dataset */
data data.alldata;
set alldata;
run;
proc freq data=alldata; table instudy source; run;

/* export csv file */
proc export data=alldata
outfile="W:\Shared Projects\Laura\BDC\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\morgan cleaned final dataset.csv"
replace
dbms="csv";
run;

proc freq data=alldata; table Rural_or_non_rural / missing; run;
proc print data=alldata; var ZipCode_DateOfDiagnosis Rural_or_non_rural; where Rural_or_non_rural in (""," "); run;
/* 148 observations missing ZipCode_DateOfDiagnosis and Rural_or_non_rural */

proc freq data=alldata;
table state State_DateOfDiagnosis;
run;
proc print data=alldata;
where mrn=1034232;
var mrn source instudy new_ins;
run;
