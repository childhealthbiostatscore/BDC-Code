/* import data */
proc import datafile = "Desktop/a1cs.csv"
out = a1cs
replace;
run;

/* trajectory */
proc traj data=a1cs;
id id; 
var OrderValue_1-OrderValue_17;
indep time_1-time_17;
model cnorm;
min 0;
max 15;
ngroups 3;
order 1 1 1;
run;
