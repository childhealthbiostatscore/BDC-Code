125   /**********************************************************************
126   *   PRODUCT:   SAS
127   *   VERSION:   9.4
128   *   CREATOR:   External File Interface
129   *   DATE:      02JAN20
130   *   DESC:      Generated SAS Datastep Code
131   *   TEMPLATE SOURCE:  (None Specified.)
132   ***********************************************************************/
133      data WORK.ALARMS    ;
134      %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
135      infile '\\Mac\Home\Desktop\alarms.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
136         informat id $6. ;
137         informat timepoint $10. ;
138         informat dates $16. ;
139         informat num_nights best32. ;
140         informat num_alarms best32. ;
141         informat num_alarms_in_AM best32. ;
142         informat perc_time_in_AM best32. ;
143         informat start_date $7. ;
144         informat end_date $7. ;
145         informat nights best32. ;
146         informat numeric_time best32. ;
147         format id $6. ;
148         format timepoint $10. ;
149         format dates $16. ;
150         format num_nights best12. ;
151         format num_alarms best12. ;
152         format num_alarms_in_AM best12. ;
153         format perc_time_in_AM best12. ;
154         format start_date $7. ;
155         format end_date $7. ;
156         format nights best12. ;
157         format numeric_time best12. ;
158      input
159                  id  $
160                  timepoint  $
161                  dates  $
162                  num_nights
163                  num_alarms
164                  num_alarms_in_AM
165                  perc_time_in_AM
166                  start_date  $
167                  end_date  $
168                  nights
169                  numeric_time
170      ;
171      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
172      run;

proc glimmix data = alarms method = mspl;
class id timepoint;
model num_alarms = timepoint perc_time_in_AM / solution distribution = poisson;
random intercept / subject=id;
random _residual_ / subject=id type=ar(1);
run;
