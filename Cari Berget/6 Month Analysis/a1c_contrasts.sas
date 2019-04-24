/**********************************************************************
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      24APR19
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
***********************************************************************/
   data WORK.DATA_NO_M1    ;
   %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
   infile '\\Mac\Home\Desktop\cari.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2;
      informat record_id $5. ;
      informat date $10. ;
      informat days best32. ;
      informat tpoint $4. ;
      informat hba1c best32. ;
      informat am_time best32. ;
      informat mm_time best32. ;
      informat sensor_wear best32. ;
      informat sensor_u54 best32. ;
      informat sensor_55_69 best32. ;
      informat sensor_70_180 best32. ;
      informat sensor_181_250 best32. ;
      informat sensor_g250 best32. ;
      informat mean_sg best32. ;
      informat sd best32. ;
      informat bg_checks best32. ;
      informat calibrations best32. ;
      informat tdd best32. ;
      informat basal best32. ;
      informat bolus best32. ;
      informat amexit best32. ;
      informat amexit_day best32. ;
      informat amexit_hyper best32. ;
      informat amexit_hypo best32. ;
      informat amexit_manual best32. ;
      informat amexit_other best32. ;
      informat automode_start $9. ;
      informat cpaid_score best32. ;
      informat cbehavior_score best32. ;
      informat cworry_score best32. ;
      informat ctotal_score best32. ;
      informat yapaid_score best32. ;
      informat yabehavior_score best32. ;
      informat yaworry_score best32. ;
      informat yatotal_score best32. ;
      informat ppaid_score best32. ;
      informat pbehavior_score best32. ;
      informat pworry_score best32. ;
      informat ptotal_score best32. ;
      informat baseline_a1c best32. ;
      informat age_group $6. ;
      informat hba1c_clinical $9. ;
      format record_id $5. ;
      format date $10. ;
      format days best12. ;
      format tpoint $4. ;
      format hba1c best12. ;
      format am_time best12. ;
      format mm_time best12. ;
      format sensor_wear best12. ;
      format sensor_u54 best12. ;
      format sensor_55_69 best12. ;
      format sensor_70_180 best12. ;
      format sensor_181_250 best12. ;
      format sensor_g250 best12. ;
      format mean_sg best12. ;
      format sd best12. ;
      format bg_checks best12. ;
      format calibrations best12. ;
      format tdd best12. ;
      format basal best12. ;
      format bolus best12. ;
      format amexit best12. ;
      format amexit_day best12. ;
      format amexit_hyper best12. ;
      format amexit_hypo best12. ;
      format amexit_manual best12. ;
      format amexit_other best12. ;
      format automode_start $9. ;
      format cpaid_score best12. ;
      format cbehavior_score best12. ;
      format cworry_score best12. ;
      format ctotal_score best12. ;
      format yapaid_score best12. ;
      format yabehavior_score best12. ;
      format yaworry_score best12. ;
      format yatotal_score best12. ;
      format ppaid_score best12. ;
      format pbehavior_score best12. ;
      format pworry_score best12. ;
      format ptotal_score best12. ;
      format baseline_a1c best12. ;
      format age_group $6. ;
      format hba1c_clinical $9. ;
   input
               record_id  $
               date  $
               days
               tpoint  $
               hba1c
               am_time
               mm_time
               sensor_wear
               sensor_u54
               sensor_55_69
               sensor_70_180
               sensor_181_250
               sensor_g250
               mean_sg
               sd
               bg_checks
               calibrations
               tdd
               basal
               bolus
               amexit
               amexit_day
               amexit_hyper
               amexit_hypo
               amexit_manual
               amexit_other
               automode_start  $
               cpaid_score
               cbehavior_score
               cworry_score
               ctotal_score
               yapaid_score
               yabehavior_score
               yaworry_score
               yatotal_score
               ppaid_score
               pbehavior_score
               pworry_score
               ptotal_score
               baseline_a1c
               age_group  $
               hba1c_clinical  $
   ;
   if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
   run;

proc mixed data=data_no_m1;
class record_id tpoint(ref="B") hba1c_clinical(ref="(0,7.5]");
model hba1c = tpoint hba1c_clinical tpoint*hba1c_clinical / s;
random intercept / subject = record_id;
run;

ods output SolutionF = GroupMeans Estimates = Estimates;


proc mixed data=data_no_m1;
class record_id tpoint(ref="B") hba1c_clinical(ref="(0,7.5]");
model hba1c = tpoint*hba1c_clinical / s noint;
random intercept / subject = record_id;
ESTIMATE "B. vs T1, Low A1c" tpoint*hba1c_clinical 0 0 1 0 0 0 0 0 -1/E;
ESTIMATE "B. vs T1, Medium A1c" tpoint*hba1c_clinical 1 0 0 0 0 0 -1 0 0/E;
ESTIMATE "B. vs T1, High A1c" tpoint*hba1c_clinical 0 1 0 0 0 0 0 -1 0/E;
ESTIMATE "B. vs T2, Low A1c" tpoint*hba1c_clinical 0 0 0 0 0 1 0 0 -1/E;
ESTIMATE "B. vs T2, Medium A1c" tpoint*hba1c_clinical 0 0 0 1 0 0 -1 0 0/E;
ESTIMATE "B. vs T2, High A1c" tpoint*hba1c_clinical 0 0 0 0 1 0 0 -1 0/E;
run;

ods excel file="\\Mac\Home\Desktop\means.xlsx";
proc print data = GroupMeans;
run;
ods excel close;

ods excel file="\\Mac\Home\Desktop\estimates.xlsx";
proc print data = Estimates;
run;
ods excel close;
