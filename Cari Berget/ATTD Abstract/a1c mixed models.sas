*libname data '\\ucdenver.pvt\som\peds\RI Biostatistics Core\Laura Tim projects\Cari Berget\ATTD Abstract\Data_Cleaned';
libname data 'S:\Laura Tim projects\Cari Berget\ATTD Abstract\Data_Cleaned';


/**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.4
 *   CREATOR:   External File Interface
 *   DATE:      04OCT18
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data WORK.alldata    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'S:\Laura Tim projects\Cari Berget\ATTD Abstract\Data_Cleaned\670GChild.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat record_id best32. ;
       informat demographics_dob mmddyy10. ;
       informat demographics_age best32. ;
       informat demographics_ethnicity best32. ;
       informat demographics_race best32. ;
       informat demographics_sex best32. ;
       informat demographics_insurance best32. ;
       informat demographics_pumphx best32. ;
       informat demographics_cgmhx best32. ;
       informat demographics_diabetesdx mmddyy10. ;
       informat demographics_t1d_duration best32. ;
       informat automode_start mmddyy10. ;
       informat demographics_complete best32. ;
       informat hba1c_baseline best32. ;
       informat hba1c_date_b mmddyy10. ;
       informat hba1c_t1 best32. ;
       informat hba1c_date_t1 mmddyy10. ;
       informat t1_date mmddyy10. ;
       informat t1_am_time best32. ;
       informat t1_mm_time best32. ;
       informat t1_sensor_wear best32. ;
       informat t1_sensor_u54 best32. ;
       informat t1_sensor_55_69 best32. ;
       informat t1_sensor_70_180 best32. ;
       informat t1_sensor_181_250 best32. ;
       informat t1_sensor_g250 best32. ;
       informat t1_mean_sg best32. ;
       informat t1_sd best32. ;
       informat t1_bg_checks best32. ;
       informat t1_calibrations best32. ;
       informat t1_tdd best32. ;
       informat t1_basal best32. ;
       informat t1_bolus best32. ;
       informat t1_amexits best32. ;
       informat t1_amexit_day best32. ;
       informat t1_amexit_hyper best32. ;
       informat t1_amexit_hypo best32. ;
       informat t1_amexit_manual best32. ;
       informat t1_amexit_other best32. ;
       informat time_1_glycemic_data_complete best32. ;
       informat hba1c_t2 best32. ;
       informat hba1c_date_t2 mmddyy10. ;
       informat t2_date mmddyy10. ;
       informat t2_am_time best32. ;
       informat t2_mm_time best32. ;
       informat t2_sensor_wear best32. ;
       informat t2_sensor_u54 best32. ;
       informat t2_sensor_55_69 best32. ;
       informat t2_sensor_70_180 best32. ;
       informat t2_sensor_181_250 best32. ;
       informat t2_sensor_g250 best32. ;
       informat t2_mean_sg best32. ;
       informat t2_sd best32. ;
       informat t2_bg_checks best32. ;
       informat t2_calibrations best32. ;
       informat t2_tdd best32. ;
       informat t2_basal best32. ;
       informat t2_bolus best32. ;
       informat t2_amexits best32. ;
       informat t2_amexit_day best32. ;
       informat t2_amexit_hyper best32. ;
       informat t2_amexit_hypo best32. ;
       informat t2_amexit_manual best32. ;
       informat t2_amexit_other best32. ;
       informat time_2_glycemic_data_complete best32. ;
       informat hba1c_t3 best32. ;
       informat hba1c_date_t3 mmddyy10. ;
       informat t3_date mmddyy10. ;
       informat t3_am_time best32. ;
       informat t3_mm_time best32. ;
       informat t3_sensor_wear best32. ;
       informat t3_sensor_u54 best32. ;
       informat t3_sensor_54_69 best32. ;
       informat t3_sensor_70_180 best32. ;
       informat t3_sensor_g250 best32. ;
       informat t3_sensor_181_250 best32. ;
       informat t3_mean_sg best32. ;
       informat t3_sd best32. ;
       informat t3_bg_checks best32. ;
       informat t3_calibrations best32. ;
       informat t3_tdd best32. ;
       informat t3_basal best32. ;
       informat t3_bolus best32. ;
       informat t3_amexits best32. ;
       informat t3_amexit_day best32. ;
       informat t3_amexit_hyper best32. ;
       informat t3_amexit_hypo best32. ;
       informat t3_amexit_manual best32. ;
       informat t3_amexit_other best32. ;
       informat time_3_glycemic_data_complete best32. ;
       informat c_hba1c_t4 best32. ;
       informat c_hba1c_date_t4 mmddyy10. ;
       informat c_t4_date mmddyy10. ;
       informat c_t4_am_time best32. ;
       informat c_t4_mm_time best32. ;
       informat c_t4_sensor_wear best32. ;
       informat c_t4_sensor_u54 best32. ;
       informat c_t4_sensor_55_69 best32. ;
       informat c_t4_sensor_71_180 best32. ;
       informat c_t4_sensor_181_250 best32. ;
       informat c_t4_sensor_g250 best32. ;
       informat c_t4_mean_sg best32. ;
       informat c_t4_sd best32. ;
       informat c_t4_bg_checks best32. ;
       informat c_t4_calibrations best32. ;
       informat c_t4_tdd best32. ;
       informat c_t4_basal best32. ;
       informat c_t4_bolus best32. ;
       informat c_t4_amexits best32. ;
       informat c_t4_amexit_day best32. ;
       informat c_t4_amexit_hyper best32. ;
       informat c_t4_amexit_hypo best32. ;
       informat c_t4_amexit_manual best32. ;
       informat c_t4_amexit_other best32. ;
       informat time_4_glycemic_data_complete best32. ;
       format record_id best12. ;
       format demographics_dob mmddyy10. ;
       format demographics_age best12. ;
       format demographics_ethnicity best12. ;
       format demographics_race best12. ;
       format demographics_sex best12. ;
       format demographics_insurance best12. ;
       format demographics_pumphx best12. ;
       format demographics_cgmhx best12. ;
       format demographics_diabetesdx mmddyy10. ;
       format demographics_t1d_duration best12. ;
       format automode_start mmddyy10. ;
       format demographics_complete best12. ;
       format hba1c_baseline best12. ;
       format hba1c_date_b mmddyy10. ;
       format hba1c_t1 best12. ;
       format hba1c_date_t1 mmddyy10. ;
       format t1_date mmddyy10. ;
       format t1_am_time best12. ;
       format t1_mm_time best12. ;
       format t1_sensor_wear best12. ;
       format t1_sensor_u54 best12. ;
       format t1_sensor_55_69 best12. ;
       format t1_sensor_70_180 best12. ;
       format t1_sensor_181_250 best12. ;
       format t1_sensor_g250 best12. ;
       format t1_mean_sg best12. ;
       format t1_sd best12. ;
       format t1_bg_checks best12. ;
       format t1_calibrations best12. ;
       format t1_tdd best12. ;
       format t1_basal best12. ;
       format t1_bolus best12. ;
       format t1_amexits best12. ;
       format t1_amexit_day best12. ;
       format t1_amexit_hyper best12. ;
       format t1_amexit_hypo best12. ;
       format t1_amexit_manual best12. ;
       format t1_amexit_other best12. ;
       format time_1_glycemic_data_complete best12. ;
       format hba1c_t2 best12. ;
       format hba1c_date_t2 mmddyy10. ;
       format t2_date mmddyy10. ;
       format t2_am_time best12. ;
       format t2_mm_time best12. ;
       format t2_sensor_wear best12. ;
       format t2_sensor_u54 best12. ;
       format t2_sensor_55_69 best12. ;
       format t2_sensor_70_180 best12. ;
       format t2_sensor_181_250 best12. ;
       format t2_sensor_g250 best12. ;
       format t2_mean_sg best12. ;
       format t2_sd best12. ;
       format t2_bg_checks best12. ;
       format t2_calibrations best12. ;
       format t2_tdd best12. ;
       format t2_basal best12. ;
       format t2_bolus best12. ;
       format t2_amexits best12. ;
       format t2_amexit_day best12. ;
       format t2_amexit_hyper best12. ;
       format t2_amexit_hypo best12. ;
       format t2_amexit_manual best12. ;
       format t2_amexit_other best12. ;
       format time_2_glycemic_data_complete best12. ;
       format hba1c_t3 best12. ;
       format hba1c_date_t3 mmddyy10. ;
       format t3_date mmddyy10. ;
       format t3_am_time best12. ;
       format t3_mm_time best12. ;
       format t3_sensor_wear best12. ;
       format t3_sensor_u54 best12. ;
       format t3_sensor_54_69 best12. ;
       format t3_sensor_70_180 best12. ;
       format t3_sensor_g250 best12. ;
       format t3_sensor_181_250 best12. ;
       format t3_mean_sg best12. ;
       format t3_sd best12. ;
       format t3_bg_checks best12. ;
       format t3_calibrations best12. ;
       format t3_tdd best12. ;
       format t3_basal best12. ;
       format t3_bolus best12. ;
       format t3_amexits best12. ;
       format t3_amexit_day best12. ;
       format t3_amexit_hyper best12. ;
       format t3_amexit_hypo best12. ;
       format t3_amexit_manual best12. ;
       format t3_amexit_other best12. ;
       format time_3_glycemic_data_complete best12. ;
       format c_hba1c_t4 best12. ;
       format c_hba1c_date_t4 mmddyy10. ;
       format c_t4_date mmddyy10. ;
       format c_t4_am_time best12. ;
       format c_t4_mm_time best12. ;
       format c_t4_sensor_wear best12. ;
       format c_t4_sensor_u54 best12. ;
       format c_t4_sensor_55_69 best12. ;
       format c_t4_sensor_71_180 best12. ;
       format c_t4_sensor_181_250 best12. ;
       format c_t4_sensor_g250 best12. ;
       format c_t4_mean_sg best12. ;
       format c_t4_sd best12. ;
       format c_t4_bg_checks best12. ;
       format c_t4_calibrations best12. ;
       format c_t4_tdd best12. ;
       format c_t4_basal best12. ;
       format c_t4_bolus best12. ;
       format c_t4_amexits best12. ;
       format c_t4_amexit_day best12. ;
       format c_t4_amexit_hyper best12. ;
       format c_t4_amexit_hypo best12. ;
       format c_t4_amexit_manual best12. ;
       format c_t4_amexit_other best12. ;
       format time_4_glycemic_data_complete best12. ;
    input
                record_id
                demographics_dob
                demographics_age
                demographics_ethnicity
                demographics_race
                demographics_sex
                demographics_insurance
                demographics_pumphx
                demographics_cgmhx
                demographics_diabetesdx
                demographics_t1d_duration
                automode_start
                demographics_complete
                hba1c_baseline
                hba1c_date_b
                hba1c_t1
                hba1c_date_t1
                t1_date
                t1_am_time
                t1_mm_time
                t1_sensor_wear
                t1_sensor_u54
                t1_sensor_55_69
                t1_sensor_70_180
                t1_sensor_181_250
                t1_sensor_g250
                t1_mean_sg
                t1_sd
                t1_bg_checks
                t1_calibrations
                t1_tdd
                t1_basal
                t1_bolus
                t1_amexits
                t1_amexit_day
                t1_amexit_hyper
                t1_amexit_hypo
                t1_amexit_manual
                t1_amexit_other
                time_1_glycemic_data_complete
                hba1c_t2
                hba1c_date_t2
                t2_date
                t2_am_time
                t2_mm_time
                t2_sensor_wear
                t2_sensor_u54
                t2_sensor_55_69
                t2_sensor_70_180
                t2_sensor_181_250
                t2_sensor_g250
                t2_mean_sg
                t2_sd
                t2_bg_checks
                t2_calibrations
                t2_tdd
                t2_basal
                t2_bolus
                t2_amexits
                t2_amexit_day
                t2_amexit_hyper
                t2_amexit_hypo
                t2_amexit_manual
                t2_amexit_other
                time_2_glycemic_data_complete
                hba1c_t3
                hba1c_date_t3
                t3_date
                t3_am_time
                t3_mm_time
                t3_sensor_wear
                t3_sensor_u54
                t3_sensor_54_69
                t3_sensor_70_180
                t3_sensor_g250
                t3_sensor_181_250
                t3_mean_sg
                t3_sd
                t3_bg_checks
                t3_calibrations
                t3_tdd
                t3_basal
                t3_bolus
                t3_amexits
                t3_amexit_day
                t3_amexit_hyper
                t3_amexit_hypo
                t3_amexit_manual
                t3_amexit_other
                time_3_glycemic_data_complete
                c_hba1c_t4
                c_hba1c_date_t4
                c_t4_date
                c_t4_am_time
                c_t4_mm_time
                c_t4_sensor_wear
                c_t4_sensor_u54
                c_t4_sensor_55_69
                c_t4_sensor_71_180
                c_t4_sensor_181_250
                c_t4_sensor_g250
                c_t4_mean_sg
                c_t4_sd
                c_t4_bg_checks
                c_t4_calibrations
                c_t4_tdd
                c_t4_basal
                c_t4_bolus
                c_t4_amexits
                c_t4_amexit_day
                c_t4_amexit_hyper
                c_t4_amexit_hypo
                c_t4_amexit_manual
                c_t4_amexit_other
                time_4_glycemic_data_complete
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;

/* need to have at least one hba1c after baseline */
data keep;
set alldata;
keep record_id automode_start hba1c_baseline  hba1c_date_b hba1c_t1 hba1c_date_t1 t1_am_time hba1c_t2 hba1c_date_t2 t2_am_time;
if hba1c_t1=. and hba1c_t2=. then delete;
run;
proc print data=keep; run;
data long;
format hba1c_date mmddyy10.;
length visit $2;
set keep;
by record_id;
if first.record_id then do;
  hba1c=.; hba1c_date=.;
end;
visit='B';
hba1c=hba1c_baseline;
hba1c_date=hba1c_date_b;
output;
visit='T1';
hba1c=hba1c_t1;
hba1c_date=hba1c_date_t1;
output;
visit='T2';
hba1c=hba1c_t2;
hba1c_date=hba1c_date_t2;
output;
drop hba1c_t1 hba1c_date_t1 hba1c_t2 hba1c_date_t2 hba1c_date_b;
run;

/* delete a1c 3 months prior to AM start */
data long;
set long;
a1c_am_diff=intck('days',automode_start,hba1c_date);
if a1c_am_diff<-90 then delete;
run;
proc print data=long; 
run;
/* profile plot */
proc sgplot data=long;
series x=a1c_am_diff y=hba1c/ group=record_id;
run;

/* create a dataset excluding anyone who has T1 and T2 but has <10% AM at both visits */
data cont;
set long;
where (t1_am_time=. and t2_am_time>=10) or (t1_am_time>=10 and t2_am_time=.) or (t1_am_time>=10 and t2_am_time>=10);
run;
proc print data=cont; run;

/* MIXED MODELS */

/* all participants */
proc sort data=long; by record_id; run;
/* visit is unit of time */
proc mixed data=long;
class visit record_id;
model hba1c = visit / s;
repeated visit / subject=record_id type=un;
lsmeans visit;
run;
/* AIC 578.2 */
/* BEST MODEL - adjusted for baseline */
proc mixed data=long;
class visit record_id;
model hba1c = visit hba1c_baseline / s;
repeated visit / subject=record_id type=ar(1);
lsmeans visit;
where visit ne 'B';
run;
/* AIC 299.1 */
/* continuous time */
proc mixed data=long;
class record_id;
model hba1c = a1c_am_diff / s;
repeated  / subject=record_id type=un;
run;
/* AIC 590.2 */
/* adjusted for baseline */
proc mixed data=long;
class record_id;
model hba1c = a1c_am_diff hba1c_baseline / s;
repeated  / subject=record_id type=un;
where visit ne 'B';
run;
/* AIC 307.2 */

/* include only people with AM>10 at all visits */
proc sort data=cont; by record_id; run;
/* visit is unit of time */
proc mixed data=cont;
class visit record_id;
model hba1c = visit / s;
repeated visit / subject=record_id type=un;
lsmeans visit;
run;
/* AIC 308.4 */
/* adjusted for baseline */
proc mixed data=cont;
class visit record_id;
model hba1c = visit hba1c_baseline / s;
repeated visit / subject=record_id type=ar(1);
lsmeans visit;
where visit ne 'B';
run;
/* BEST MODEL AIC  154.9 */
/* continuous time */
proc mixed data=cont;
class record_id;
model hba1c = a1c_am_diff / s;
repeated  / subject=record_id type=un;
run;
/* AIC 329.9 */
/* adjusted for baseline */
proc mixed data=cont;
class record_id;
model hba1c = a1c_am_diff hba1c_baseline / s;
repeated  / subject=record_id type=un;
where visit ne 'B';
run;
/* AIC 163.3*/

/* final models */
ods rtf file="C:\temp\output.rtf";
proc mixed data=long;
class visit record_id;
model hba1c = visit hba1c_baseline / s;
repeated visit / subject=record_id type=ar(1);
lsmeans visit / pdiff;
where visit ne 'B';
run;
proc mixed data=cont;
class visit record_id;
model hba1c = visit hba1c_baseline / s;
repeated visit / subject=record_id type=ar(1);
lsmeans visit / pdiff;
where visit ne 'B';
run;
ods rtf close;
