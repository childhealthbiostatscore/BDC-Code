173   /**********************************************************************
174   *   PRODUCT:   SAS
175   *   VERSION:   9.4
176   *   CREATOR:   External File Interface
177   *   DATE:      26APR19
178   *   DESC:      Generated SAS Datastep Code
179   *   TEMPLATE SOURCE:  (None Specified.)
180   ***********************************************************************/
181      data WORK.DATA_NO_M1    ;
182      %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
183      infile '\\Mac\Home\Desktop\cari.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2;
184         informat record_id $3. ;
185         informat date $10. ;
186         informat days best32. ;
187         informat tpoint $4. ;
188         informat hba1c best32. ;
189         informat am_time best32. ;
190         informat mm_time best32. ;
191         informat sensor_wear best32. ;
192         informat sensor_u54 best32. ;
193         informat sensor_55_69 best32. ;
194         informat sensor_70_180 best32. ;
195         informat sensor_181_250 best32. ;
196         informat sensor_g250 best32. ;
197         informat mean_sg best32. ;
198         informat sd best32. ;
199         informat bg_checks best32. ;
200         informat calibrations best32. ;
201         informat tdd best32. ;
202         informat basal best32. ;
203         informat bolus best32. ;
204         informat amexit best32. ;
205         informat amexit_day best32. ;
206         informat amexit_hyper best32. ;
207         informat amexit_hypo best32. ;
208         informat amexit_manual best32. ;
209         informat amexit_other best32. ;
210         informat automode_start $9. ;
211         informat age_group $9. ;
212         informat hba1c_baseline best32. ;
213         informat hba1c_clinical $9. ;
214         format record_id $3. ;
215         format date $10. ;
216         format days best12. ;
217         format tpoint $4. ;
218         format hba1c best12. ;
219         format am_time best12. ;
220         format mm_time best12. ;
221         format sensor_wear best12. ;
222         format sensor_u54 best12. ;
223         format sensor_55_69 best12. ;
224         format sensor_70_180 best12. ;
225         format sensor_181_250 best12. ;
226         format sensor_g250 best12. ;
227         format mean_sg best12. ;
228         format sd best12. ;
229         format bg_checks best12. ;
230         format calibrations best12. ;
231         format tdd best12. ;
232         format basal best12. ;
233         format bolus best12. ;
234         format amexit best12. ;
235         format amexit_day best12. ;
236         format amexit_hyper best12. ;
237         format amexit_hypo best12. ;
238         format amexit_manual best12. ;
239         format amexit_other best12. ;
240         format automode_start $9. ;
241         format age_group $9. ;
242         format hba1c_baseline best12. ;
243         format hba1c_clinical $9. ;
244      input
245                  record_id  $
246                  date  $
247                  days
248                  tpoint  $
249                  hba1c
250                  am_time
251                  mm_time
252                  sensor_wear
253                  sensor_u54
254                  sensor_55_69
255                  sensor_70_180
256                  sensor_181_250
257                  sensor_g250
258                  mean_sg
259                  sd
260                  bg_checks
261                  calibrations
262                  tdd
263                  basal
264                  bolus
265                  amexit
266                  amexit_day
267                  amexit_hyper
268                  amexit_hypo
269                  amexit_manual
270                  amexit_other
271                  automode_start  $
272                  age_group  $
273                  hba1c_baseline
274                  hba1c_clinical  $
275      ;
276      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
277      run;

proc mixed data=data_no_m1;
class record_id timepoint(ref="B") hba1c_clinical(ref="Low Baseline HbA1c");
model hba1c = timepoint hba1c_clinical timepoint*hba1c_clinical / s;
random intercept / subject = record_id;
run;

ods output SolutionF = GroupMeans Estimates = Estimates;


proc mixed data=data_no_m1;
class record_id timepoint(ref="B") hba1c_clinical(ref="Low Baseline HbA1c");
model hba1c = timepoint*hba1c_clinical / s noint;
random intercept / subject = record_id;
ESTIMATE "B. vs T1, Low A1c" timepoint*hba1c_clinical 0 0 1 0 0 0 0 0 -1/E;
ESTIMATE "B. vs T1, Medium A1c" timepoint*hba1c_clinical 0 1 0 0 0 0 0 -1 0/E;
ESTIMATE "B. vs T1, High A1c" timepoint*hba1c_clinical 1 0 0 0 0 0 -1 0 0/E;
ESTIMATE "B. vs T2, Low A1c" timepoint*hba1c_clinical 0 0 0 0 0 1 0 0 -1/E;
ESTIMATE "B. vs T2, Medium A1c" timepoint*hba1c_clinical 0 0 0 0 1 0 0 -1 0/E;
ESTIMATE "B. vs T2, High A1c" timepoint*hba1c_clinical 0 0 0 1 0 0 -1 0 0/E;
run;

ods excel file="\\Mac\Home\Desktop\means.xlsx";
proc print data = GroupMeans;
run;
ods excel close;

ods excel file="\\Mac\Home\Desktop\estimates.xlsx";
proc print data = Estimates;
run;
ods excel close;
