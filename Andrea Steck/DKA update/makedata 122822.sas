*libname data 'S:\Shared Projects\Laura\BDC\Projects\Todd Alonso\DKA\Data';
libname data 'B:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw';

 /**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      28DEC22
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data WORK.alldata    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'B:\Projects\Andrea Steck\Morgan Sooy DKA update\Data_raw\10.26.22_Sooy_FinalThesis_Dataset LP imputed.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat MRN best32. ;
       informat Sample_ID best32. ;
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
       informat bicarb $3. ;
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
       informat VAR24 $1. ;
       format MRN best12. ;
       format Sample_ID best12. ;
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
       format bicarb $3. ;
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
       format VAR24 $1. ;
    input
                MRN
                Sample_ID
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
                bicarb  $
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
                VAR24  $
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;
proc print; run;

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

proc sort data=zips; by ZipCode_DateOfDiagnosis; run;
proc sort data=alldata; by ZipCode_DateOfDiagnosis; run;

data alldata;
merge alldata(in=ina) zips;
by ZipCode_DateOfDiagnosis; 
if ina;
run;
data alldata;
set alldata;
if ZipCode_DateOfDiagnosis="" or ZipCode_DateOfDiagnosis=" " then Rural_Non_Rural="";
else if  Rural_Non_Rural="" or Rural_Non_Rural=" " then Rural_Non_Rural="Non-rural";
run;
proc print; run;

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
run; 
proc freq data=nonstudy; table NewOnset_DxThroughScreeningStudy; run;

data study;
set alldata; 
where NewOnset_DxThroughScreeningStudy ne "NULL" and NewOnset_DxThroughScreeningStudy ne "";
run; 
proc freq data=study; table NewOnset_DxThroughScreeningStudy; run;




/* write final dataset */
data data.alldata;
set alldata;
run;
