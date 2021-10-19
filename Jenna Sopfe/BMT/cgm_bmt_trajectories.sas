proc import datafile="Z:\PEDS\RI Biostatistics Core\Shared\Shared Projects\Laura\BDC\Projects\Jenna Sopfe\CGM and BMT FDA\Data_Cleaned\cleaned_for_traj.csv"
out=cgm
dbms=csv
replace;
run;

proc traj data=cgm out=out outstat=os outplot=op;
var Historic_Glucose_1-Historic_Glucose_75;
indep time_from_engraft_1-time_from_engraft_75;
model cnorm; max 400;
ngroups 2;
id SubjectID;
run;
%trajplot (OP, OS, “Title of graph”, “Subtitle”, “Y-axis label”, “X-axis label”);
