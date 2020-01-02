158   /**********************************************************************
159   *   PRODUCT:   SAS
160   *   VERSION:   9.4
161   *   CREATOR:   External File Interface
162   *   DATE:      02JAN20
163   *   DESC:      Generated SAS Datastep Code
164   *   TEMPLATE SOURCE:  (None Specified.)
165   ***********************************************************************/
166      data WORK.ALARMS    ;
167      %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
168      infile '\\Mac\Home\Desktop\alarms.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
169         informat id $4. ;
170         informat timepoint $8. ;
171         informat dates $14. ;
172         informat num_nights best32. ;
173         informat num_alarms best32. ;
174         informat num_alarms_in_AM best32. ;
175         informat perc_time_in_AM best32. ;
176         informat start_date $6. ;
177         informat end_date $6. ;
178         informat nights best32. ;
179         informat numeric_time best32. ;
180         format id $4. ;
181         format timepoint $8. ;
182         format dates $14. ;
183         format num_nights best12. ;
184         format num_alarms best12. ;
185         format num_alarms_in_AM best12. ;
186         format perc_time_in_AM best12. ;
187         format start_date $6. ;
188         format end_date $6. ;
189         format nights best12. ;
190         format numeric_time best12. ;
191      input
192                  id  $
193                  timepoint  $
194                  dates  $
195                  num_nights
196                  num_alarms
197                  num_alarms_in_AM
198                  perc_time_in_AM
199                  start_date  $
200                  end_date  $
201                  nights
202                  numeric_time
203      ;
204      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
205      run;

proc sort data = alarms;
by id numeric_time;
run;

proc glimmix data = alarms method = mspl pconv = 0.000001;
class id timepoint(ref = "Baseline");
model num_alarms = timepoint perc_time_in_AM / solution distribution = poisson;
random intercept / subject=id;
random _residual_ / type = sp(pow)(numeric_time) subject=id;
run;
