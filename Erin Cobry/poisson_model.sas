/**********************************************************************
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      02JAN20
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
***********************************************************************/
   data WORK.ALARMS    ;
   %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
   infile '\\Mac\Home\Desktop\alarms.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
      informat id $6. ;
      informat timepoint $10. ;
      informat dates $16. ;
      informat num_nights best32. ;
      informat num_alarms best32. ;
      informat num_alarms_in_AM best32. ;
      informat perc_time_in_AM best32. ;
      informat start_date $7. ;
      informat end_date $7. ;
      informat nights best32. ;
      informat numeric_time best32. ;
      format id $6. ;
      format timepoint $10. ;
      format dates $16. ;
      format num_nights best12. ;
      format num_alarms best12. ;
      format num_alarms_in_AM best12. ;
      format perc_time_in_AM best12. ;
      format start_date $7. ;
      format end_date $7. ;
      format nights best12. ;
      format numeric_time best12. ;
   input
               id  $
               timepoint  $
               dates  $
               num_nights
               num_alarms
               num_alarms_in_AM
               perc_time_in_AM
               start_date  $
               end_date  $
               nights
               numeric_time
   ;
   if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
   run;

proc glimmix data = alarms method = rspl;
class id timepoint(ref = "Baseline");
model num_alarms = timepoint perc_time_in_AM / solution distribution = poisson;
random intercept / subject=id;
run;
