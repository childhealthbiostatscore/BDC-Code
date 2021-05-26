151   /**********************************************************************
152   *   PRODUCT:   SAS
153   *   VERSION:   9.4
154   *   CREATOR:   External File Interface
155   *   DATE:      09JAN20
156   *   DESC:      Generated SAS Datastep Code
157   *   TEMPLATE SOURCE:  (None Specified.)
158   ***********************************************************************/
159      data WORK.ALARMS    ;
160      %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
161      infile 'X:\PEDS\RI Biostatistics Core\Shared\Shared Projects\Laura\BDC\Projects\Erin Cobry\670g obs sleep\Data_Cleaned\alarms.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
162         informat id $5. ;
163         informat timepoint $8. ;
164         informat start_date mmddyy10. ;
165         informat end_date mmddyy10. ;
166         informat num_nights best32. ;
167         informat num_alarms best32. ;
168         informat num_alarms_in_AM $1. ;
169         informat perc_time_in_AM best32. ;
170         informat numeric_time best32. ;
171         informat nighttime_avg_sens_glucose best32. ;
172         informat percent_time_70_180_night best32. ;
173         informat percent_time_under_70_night best32. ;
174         format id $5. ;
175         format timepoint $8. ;
176         format start_date mmddyy10. ;
177         format end_date mmddyy10. ;
178         format num_nights best12. ;
179         format num_alarms best12. ;
180         format num_alarms_in_AM $1. ;
181         format perc_time_in_AM best12. ;
182         format numeric_time best12. ;
183         format nighttime_avg_sens_glucose best12. ;
184         format percent_time_70_180_night best12. ;
185         format percent_time_under_70_night best12. ;
186      input
187                  id  $
188                  timepoint  $
189                  start_date
190                  end_date
191                  num_nights
192                  num_alarms
193                  num_alarms_in_AM  $
194                  perc_time_in_AM
195                  numeric_time
196                  nighttime_avg_sens_glucose
197                  percent_time_70_180_night
198                  percent_time_under_70_night
199      ;
200      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
201      run;

proc sort data = alarms;
by id numeric_time;
run;

proc glimmix data = alarms;
class id timepoint(ref = "Baseline");
model num_alarms = timepoint perc_time_in_AM / solution distribution = poisson offset = log_num_nights;
random intercept / subject=id;
random _residual_ / type = sp(pow)(numeric_time) subject=id;
run;
