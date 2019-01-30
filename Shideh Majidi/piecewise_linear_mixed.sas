/*Import before vs. during data*/
data WORK.BD    ;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'S:\PEDS\RI Biostatistics Core\Shared\Laura Tim projects\Shideh Majidi\High Risk Program\Data_Cleaned\before_during.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2;
informat record_id best32. ;
informat case_control $3. ;
informat case_id $3. ;
informat visitdate yymmdd10. ;
informat program_start_date yymmdd10. ;
informat a1c best32. ;
informat lowbg best32. ;
informat targetbg best32. ;
informat highbg best32. ;
informat bgchecks best32. ;
informat days best32. ;
informat sw_factor best32. ;
informat time_to_start best32. ;
informat k best32. ;
informat timespl1 best32. ;
format record_id best12. ;
format case_control $3. ;
format case_id $3. ;
format visitdate yymmdd10. ;
format program_start_date yymmdd10. ;
format a1c best12. ;
format lowbg best12. ;
format targetbg best12. ;
format highbg best12. ;
format bgchecks best12. ;
format days best12. ;
format sw_factor best12. ;
format time_to_start best12. ;
format k best12. ;
format timespl1 best12. ;
input
	record_id
	case_control  $
	case_id  $
	visitdate
	program_start_date
	a1c
	lowbg
	targetbg
	highbg
	bgchecks
	days
	sw_factor
	time_to_start
	k
	timespl1
;
if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;


/*Macro for piecewise mixed model*/
%macro piecewise_mixed(var,data);
proc mixed data = &data;
class case_control case_id;
model &var = time_to_start timespl1 case_control case_control*time_to_start case_control*timespl1/solution;
random intercept/sub=case_id;
estimate "Intercept: control" intercept 1 case_control 0 1 ;
estimate "Intercept: case" intercept 1 case_control 1 0 ;
estimate "Intercept: case - control" intercept 0 case_control 1 -1 ;
estimate "Slope(time) before k: control"
time_to_start 1 timespl1 0 case_control*time_to_start 0 1 case_control*timespl1 0 0 ;
estimate "Slope(time) before k: case"
time_to_start 1 timespl1 0 case_control*time_to_start 1 0 case_control*timespl1 0 0 ;
estimate "Slope(time) before k: case - con"
time_to_start 0 timespl1 0 case_control*time_to_start 1 -1 case_control*timespl1 0 0 ;
estimate "Slope(time) after k: control"
time_to_start 1 timespl1 1 case_control*time_to_start 0 1 case_control*timespl1 0 1 ;
estimate "Slope(time) after k: case"
time_to_start 1 timespl1 1 case_control*time_to_start 1 0 case_control*timespl1 1 0 ;
estimate "Slope(time) after k: case - con"
time_to_start 0 timespl1 0 case_control*time_to_start 1 -1 case_control*timespl1 1 -1 ;
estimate "Slope(time) change k: control"
time_to_start 0 timespl1 1 case_control*time_to_start 0 0 case_control*timespl1 0 1 ;
estimate "Slope(time) change k: case"
time_to_start 0 timespl1 1 case_control*time_to_start 0 0 case_control*timespl1 1 0 ;
estimate "Slope(time) change k: case - con"
time_to_start 0 timespl1 0 case_control*time_to_start 0 0 case_control*timespl1 1 -1 ;
ods output Estimates=&var&data;
run;
%mend;

/*Mixed models for before vs. during for all variables*/
%piecewise_mixed(a1c,bd);
%piecewise_mixed(lowbg,bd);
%piecewise_mixed(targetbg,bd);
%piecewise_mixed(highbg,bd);
%piecewise_mixed(bgchecks,bd);
%piecewise_mixed(days,bd);
%piecewise_mixed(sw_factor,bd);

/*Import during vs. after data*/
data WORK.da    ;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'S:\PEDS\RI Biostatistics Core\Shared\Laura Tim projects\Shideh Majidi\High Risk Program\Data_Cleaned\during_after.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2;
informat record_id best32. ;
informat case_control $3. ;
informat case_id $3. ;
informat visitdate yymmdd10. ;
informat program_end_date yymmdd10. ;
informat a1c best32. ;
informat lowbg best32. ;
informat targetbg best32. ;
informat highbg best32. ;
informat bgchecks best32. ;
informat days best32. ;
informat sw_factor best32. ;
informat time_to_start best32. ;
informat k best32. ;
informat timespl1 best32. ;
format record_id best12. ;
format case_control $3. ;
format case_id $3. ;
format visitdate yymmdd10. ;
format program_end_date yymmdd10. ;
format a1c best12. ;
format lowbg best12. ;
format targetbg best12. ;
format highbg best12. ;
format bgchecks best12. ;
format days best12. ;
format sw_factor best12. ;
format time_to_start best12. ;
format k best12. ;
format timespl1 best12. ;
input
	record_id
	case_control  $
	case_id  $
	visitdate
	program_end_date
	a1c
	lowbg
	targetbg
	highbg
	bgchecks
	days
	sw_factor
	time_to_start
	k
	timespl1
;
if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;

/*Mixed models for during vs. after for all variables*/
%piecewise_mixed(a1c,da);
%piecewise_mixed(lowbg,da);
%piecewise_mixed(targetbg,da);
%piecewise_mixed(highbg,da);
%piecewise_mixed(bgchecks,da);
%piecewise_mixed(days,da);
%piecewise_mixed(sw_factor,da);

/*Import before vs. after data*/
data WORK.Ba    ;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'S:\PEDS\RI Biostatistics Core\Shared\Laura Tim projects\Shideh Majidi\High Risk Program\Data_Cleaned\before_after.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2;
informat record_id best32. ;
informat case_control best32. ;
informat case_id best32. ;
informat a1c best32. ;
informat lowbg best32. ;
informat targetbg best32. ;
informat highbg best32. ;
informat bgchecks best32. ;
informat days best32. ;
informat sw_factor best32. ;
informat visitdate mmddyy10. ;
informat program_start_date mmddyy10. ;
informat program_end_date mmddyy10. ;
informat time_to_start best32. ;
informat time_from_end best32. ;
informat k best32. ;
informat timespl1 best32. ;
format record_id best12. ;
format case_control best12. ;
format case_id best12. ;
format a1c best12. ;
format lowbg best12. ;
format targetbg best12. ;
format highbg best12. ;
format bgchecks best12. ;
format days best12. ;
format sw_factor best12. ;
format visitdate mmddyy10. ;
format program_start_date mmddyy10. ;
format program_end_date mmddyy10. ;
format time_to_start best12. ;
format time_from_end best12. ;
format k best12. ;
format timespl1 best12. ;
input
	record_id
	case_control
	case_id
	a1c
	lowbg
	targetbg
	highbg
	bgchecks
	days
	sw_factor
	visitdate
	program_start_date
	program_end_date
	time_to_start
	time_from_end
	k
	timespl1
;
if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;

/*Mixed models for before vs. after for all variables*/
%piecewise_mixed(a1c,ba);
%piecewise_mixed(lowbg,ba);
%piecewise_mixed(targetbg,ba);
%piecewise_mixed(highbg,ba);
%piecewise_mixed(bgchecks,ba);
%piecewise_mixed(days,ba);
%piecewise_mixed(sw_factor,ba);
