*libname data 'S:\Shared Projects\Laura\BDC\Projects\Todd Alonso\DKA\Data';
libname data 'X:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw';

/* this is the original file containing patients and participants after 2016 */
    data WORK.ALLDATA    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'X:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\10.26.22_Sooy_FinalThesis_Dataset LP imputed.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat MRN $40. ;
       informat Sample_ID $30. ;
       informat DOB mmddyy10. ;
       informat OnsetDate mmddyy10. ;
       informat Age_AtOnset best32. ;
       informat Sex $6. ;
       informat Race $23. ;
       informat Ethnicity $22. ;
       informat Insurance $22. ;
       informat InsuranceGroup $7. ;
       informat InitalA1c best32. ;
       informat pH best32. ;
       informat bicarb best32. ;
       informat DKA $3. ;
       informat Rural_or_non_rural $1. ;
       informat ZipCode_DateOfDiagnosis $5. ;
       informat State_DateOfDiagnosis $8. ;
       informat PrimaryLanguage $10. ;
       informat NewOnset_DxThroughScreeningStudy $4. ;
       informat Last_research_study_visit_date mmddyy10. ;
       informat LastA1C_Date mmddyy10. ;
       informat A1cValue best32. ;
       informat LastVisitDate mmddyy10. ;
       informat Initial_research_study_visit_dat mmddyy10. ;
       format MRN $40. ;
       format Sample_ID $30. ;
       format DOB mmddyy10. ;
       format OnsetDate mmddyy10. ;
       format Age_AtOnset best12. ;
       format Sex $6. ;
       format Race $23. ;
       format Ethnicity $22. ;
       format Insurance $22. ;
       format InsuranceGroup $7. ;
       format InitalA1c best12. ;
       format pH best12. ;
       format bicarb best12. ;
       format DKA $3. ;
       format Rural_or_non_rural $1. ;
       format ZipCode_DateOfDiagnosis $5. ;
       format State_DateOfDiagnosis $8. ;
       format PrimaryLanguage $10. ;
       format NewOnset_DxThroughScreeningStudy $4. ;
       format Last_research_study_visit_date mmddyy10. ;
       format LastA1C_Date mmddyy10. ;
       format A1cValue best12. ;
       format LastVisitDate mmddyy10. ;
       format Initial_research_study_visit_dat mmddyy10. ;
    input
                MRN $
                Sample_ID $
                DOB
                OnsetDate
                Age_AtOnset
                Sex  $
                Race  $
                Ethnicity  $
                Insurance  $
                InsuranceGroup  $
                InitalA1c
                pH
                bicarb
                DKA  $
                Rural_or_non_rural  $
                ZipCode_DateOfDiagnosis $
                State_DateOfDiagnosis  $
                PrimaryLanguage  $
                NewOnset_DxThroughScreeningStudy  $
                Last_research_study_visit_date
                LastA1C_Date
                A1cValue
                LastVisitDate
                Initial_research_study_visit_dat
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;
proc print; run;

/* add in new file of research participants 2005-2016 */
 data WORK.data0516    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'X:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\Combined_TN_TDA_2005-2016_without names.csv' delimiter = ',' MISSOVER DSD lrecl=13106 firstobs=2 ;
       informat MRN $40. ;
       informat PP3_Patnum $5. ;
       informat Sample_ID $30. ;
       informat Study $14. ;
       informat DOB mmddyy10. ;
       informat Initial_research_study_visit_dat mmddyy10. ;
       informat Last_research_study_visit_date mmddyy10. ;
       informat OnsetDate mmddyy10. ;
       informat Sex $6. ;
       informat Ethnicity $16. ;
       informat Race $18. ;
       informat DKA $3. ;
       informat Dual_ $3. ;
       format MRN $40. ;
       format PP3_Patnum $5. ;
       format Sample_ID $30. ;
       format Study $14. ;
       format DOB mmddyy10. ;
       format Initial_research_study_visit_dat mmddyy10. ;
       format Last_research_study_visit_date mmddyy10. ;
       format OnsetDate mmddyy10. ;
       format Sex $6. ;
       format Ethnicity $16. ;
       format Race $18. ;
       format DKA $3. ;
       format Dual_ $3. ;
      input
                MRN  $
                PP3_Patnum  $
                Sample_ID  $
                Study  $
                DOB
                Initial_research_study_visit_dat
                Last_research_study_visit_date
                OnsetDate
                Sex  $
                Ethnicity  $
                Race  $
                DKA  $
                Dual_  $
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;
data data0516;
set data0516;
Age_AtOnset=intck("year",DOB,OnsetDate);
run;
proc print; run;
data alldata;
set alldata data0516;
run;
proc export data=alldata
outfile=""
;
run;

/* read in Marian's file and merge to fill in data for participants diagnosed between 2005-2009 */
 /**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      04MAY23
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data WORK.MARIAN    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'X:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\JAMA 2005-2012 T1D and DKA known.txt' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat ID best32. ;
       informat PinkPanther_patnum best32. ;
       informat CHCO_MRN $9. ;
       informat lastname $17. ;
       informat firstname $11. ;
       informat BirthDate anydtdtm40. ;
       informat DxYear best32. ;
       informat onsetdate anydtdtm40. ;
       informat AgeAtOnset best32. ;
       informat Sex $3. ;
       informat Ethnicity $3. ;
       informat race $27. ;
       informat Hispanic $5. ;
       informat Research best32. ;
       informat pre_T1D_study $12. ;
       informat dm_type $3. ;
       informat DKA_at_diagnosis $3. ;
       informat DKA_severity best32. ;
       informat Insurance_Code best32. ;
       informat Insurance_Co $28. ;
       informat A1c_new best32. ;
       informat FamilyHxCode best32. ;
       informat Location_rural_vs_urban $3. ;
       informat pHx $6. ;
       informat bicarbx $5. ;
       format ID best12. ;
       format PinkPanther_patnum best12. ;
       format CHCO_MRN $9. ;
       format lastname $17. ;
       format firstname $11. ;
       format BirthDate datetime. ;
       format DxYear best12. ;
       format onsetdate datetime. ;
       format AgeAtOnset best12. ;
       format Sex $3. ;
       format Ethnicity $3. ;
       format race $27. ;
       format Hispanic $5. ;
       format Research best12. ;
       format pre_T1D_study $12. ;
       format dm_type $3. ;
       format DKA_at_diagnosis $3. ;
       format DKA_severity best12. ;
       format Insurance_Code best12. ;
       format Insurance_Co $28. ;
       format A1c_new best12. ;
       format FamilyHxCode best12. ;
       format Location_rural_vs_urban $3. ;
       format pHx $6. ;
       format bicarbx $5. ;
    input
                ID
                PinkPanther_patnum
                CHCO_MRN  $
                lastname  $
                firstname  $
                BirthDate
                DxYear
                onsetdate
                AgeAtOnset
                Sex  $
                Ethnicity  $
                race  $
                Hispanic  $
                Research
                pre_T1D_study  $
                dm_type  $
                DKA_at_diagnosis  $
                DKA_severity
                Insurance_Code
                Insurance_Co  $
                A1c_new
                FamilyHxCode
                Location_rural_vs_urban  $
                pHx  $
                bicarbx  $
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;
proc print data=marian; run;

/* link participants diagnosed 2010-2016 to Todd's dataset */

/* old stuff below */



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
    infile 'B:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\DMERuralZIP.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
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

/* create new race_eth variable as NHW, H, NHB, O */
proc freq data=alldata;
table race ethnicity;
run;
data alldata;
set alldata;
if race="White" and ethnicity="Not Hispanic or Latino" then race_eth="Non-Hispanic White";
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


data data0516;
set data0516;
instudy=1;
if race in (".","") and ethnicity in (".","") then race_eth="";
else if race="White" and ethnicity="No" then race_eth="Non-Hispanic White";
else if race="Black or African American" and ethnicity="No" then race_eth="Non-Hispanic Black";
else if ethnicity="Spanish/Hispanic" or ethnicity="Yes" then race_eth="Hispanic";
else race_eth="Other";
run;
proc freq data=data0516;
table race*race_eth ethnicity*race_eth / missing;
run;


/* write final dataset */
data data.alldata;
set alldata;
run;
