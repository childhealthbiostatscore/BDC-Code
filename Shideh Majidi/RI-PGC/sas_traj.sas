/* import data */
proc import datafile = "Desktop/a1cs.csv"
out = a1cs
replace;
run;

/* trajectory */
proc traj data=a1cs  outplot=op outstat=os out=of outest=oe itdetail;  
ID id;
Var OrderValue_1-OrderValue_17;
Indep time_1-time_17;
model cnorm;
min 0;
max 15;
ngroups 3;
order 1 1 1;
run;
%trajplot(op,os,'Trajplot','Cnorm model','A1c','Time');