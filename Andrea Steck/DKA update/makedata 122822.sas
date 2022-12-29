*libname data 'S:\Shared Projects\Laura\BDC\Projects\Todd Alonso\DKA\Data';
libname data 'T:\Todd Alonso\DKA\Data';

/**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      02AUG18
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data WORK.alldata    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'T:\Todd Alonso\DKA\Data\DKA-ACA_all patients in study_08052019.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat SubjectID best32. ;
       informat OnsetDate mmddyy10. ;
       informat AgeAtOnset best32. ;
       informat Gender $1. ;
       informat RaceEthnicity $50. ;
       informat InsuranceType $50. ;
       informat PrimarySpokenLanguage $50. ;
       informat OnsetYear best32. ;
       informat Rural_Non_Rural $8. ;
       informat DKAAtDx $10. ;
       informat pH best32. ;
       informat HCO3 best32. ;
       informat BG best32. ;
       informat A1cAtDiagnosis best32. ;
       format SubjectID best12. ;
       format OnsetDate mmddyy10. ;
       format AgeAtOnset best12. ;
       format Gender $1. ;
       format RaceEthnicity $50. ;
       format InsuranceType $50. ;
       format PrimarySpokenLanguage $50. ;
       format OnsetYear best12. ;
       format Rural_Non_Rural $8. ;
       format DKAAtDx $8. ;
       format pH best12. ;
       format HCO3 best12. ;
       format BG best12. ;
       format A1cAtDiagnosis best12. ;
    input
                SubjectID
                OnsetDate
                AgeAtOnset
                Gender $
                RaceEthnicity $
                InsuranceType $
                PrimarySpokenLanguage $
                OnsetYear
                Rural_Non_Rural $
                DKAAtDx $
                pH
                HCO3
                BG
                A1cAtDiagnosis
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;


data data.alldata;
set alldata;
run;

proc freq data=alldata;
table dkaatdx;
run;
