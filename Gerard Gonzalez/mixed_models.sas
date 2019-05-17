PROC IMPORT datafile='S:\Shared Projects\Laura\BDC\Projects\Andrea Gerard Gonzalez\Data\mixed_forsas.csv'
out=formixed
dbms=csv
replace;
getnames=yes;
run;

proc contents data=formixed; run;

proc mixed data=formixed order = data;
class yeargrouping group trt_grp;
model a1c_last_in_year= baseline_a1c yeargrouping group trt_grp yeargrouping*trt_grp  duration_of_diagnosis/solution ;
repeated yeargrouping/ subject=MRN;
lsmeans yeargrouping*trt_grp / pdiff;
run;
