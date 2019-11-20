/**********************************************************************
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      20NOV19
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
***********************************************************************/
   data WORK.cgm    ;
   %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
   infile '\\Mac\Home\Desktop\cgm_medicaid.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
      informat Code best32. ;
      informat EPICMRN $8. ;
      informat First_Name $11. ;
      informat Last_Name $10. ;
      informat EncounterDate yymmdd10. ;
      informat HbA1c best32. ;
      informat cgm_ever_pump $12. ;
      informat PumpUse $5. ;
      informat InsuranceCategory $10. ;
      informat Age_AtEncounterDate best32. ;
      informat CGM_Type $11. ;
      informat X30_day_CGM_use best32. ;
      informat CGMMeanGlucose best32. ;
      informat CGMLowPercent best32. ;
      informat CGMOKPercent best32. ;
      informat CGMHighPercent best32. ;
      informat CGMUse $5. ;
      informat CGM_Perc best32. ;
      informat CGMUseSomeNever $6. ;
      informat DateOfDiabetesDiagnosis yymmdd10. ;
      informat T1D_Duration best32. ;
      informat Gender $3. ;
      informat DOB yymmdd10. ;
      informat Race_Ethnicity $20. ;
      informat ZipAtFirstVisit $7. ;
      informat FirstVisitDate yymmdd10. ;
      informat AgeFirstVisit best32. ;
      informat DiabetesDuration best32. ;
      informat Days best32. ;
      informat Age_Group_at_First_Visit $5. ;
      informat days_since_last best32. ;
      informat cgm_binary best32. ;
      format Code best12. ;
      format EPICMRN $8. ;
      format First_Name $11. ;
      format Last_Name $10. ;
      format EncounterDate yymmdd10. ;
      format HbA1c best12. ;
      format cgm_ever_pump $12. ;
      format PumpUse $5. ;
      format InsuranceCategory $10. ;
      format Age_AtEncounterDate best12. ;
      format CGM_Type $11. ;
      format X30_day_CGM_use best12. ;
      format CGMMeanGlucose best12. ;
      format CGMLowPercent best12. ;
      format CGMOKPercent best12. ;
      format CGMHighPercent best12. ;
      format CGMUse $5. ;
      format CGM_Perc best12. ;
      format CGMUseSomeNever $6. ;
      format DateOfDiabetesDiagnosis yymmdd10. ;
      format T1D_Duration best12. ;
      format Gender $3. ;
      format DOB yymmdd10. ;
      format Race_Ethnicity $20. ;
      format ZipAtFirstVisit $7. ;
      format FirstVisitDate yymmdd10. ;
      format AgeFirstVisit best12. ;
      format DiabetesDuration best12. ;
      format Days best12. ;
      format Age_Group_at_First_Visit $5. ;
      format days_since_last best12. ;
      format cgm_binary best12. ;
   input
               Code
               EPICMRN  $
               First_Name  $
               Last_Name  $
               EncounterDate
               HbA1c
               cgm_ever_pump  $
               PumpUse  $
               InsuranceCategory  $
               Age_AtEncounterDate
               CGM_Type  $
               X30_day_CGM_use
               CGMMeanGlucose
               CGMLowPercent
               CGMOKPercent
               CGMHighPercent
               CGMUse  $
               CGM_Perc
               CGMUseSomeNever  $
               DateOfDiabetesDiagnosis
               T1D_Duration
               Gender  $
               DOB
               Race_Ethnicity  $
               ZipAtFirstVisit  $
               FirstVisitDate
               AgeFirstVisit
               DiabetesDuration
               Days
               Age_Group_at_First_Visit  $
               days_since_last
               cgm_binary
   ;
   if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
   run;

proc glimmix data = cgm method=mspl;
class EPICMRN cgm_binary PumpUse(ref="No") Race_Ethnicity mod_race(ref="Hispanic");
model cgm_binary(event='1') = Age_AtEncounterDate DiabetesDuration PumpUse mod_race / solution distribution=binary;
random intercept / subject = EPICMRN;
run;
