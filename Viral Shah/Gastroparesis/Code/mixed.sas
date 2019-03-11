*For Kristen;
*proc import file="S:\Student Projects\Gist\Data\for_mixedmodels.csv" out=long_dat replace;
*run;
proc import file="S:\Shared Projects\Laura\BDC\Projects\Viral Shah\Gastroparesis\Data\long_dataset.csv" 
	out=long_dat 
	replace;
run;
PROC CONTENTS data=long_dat; 
run;
proc sort data=long_dat;
	by Subject Period;
run;

*intercept only, matches results_int.factor;
proc mixed data=long_dat;
	class Subject Period(ref="1") Group(ref="C");
	model average_sensor = Group Period Group*Period / solution;
	random intercept / subject=Subject;
run;

*intercept and slope, matches results_slope;
proc mixed data=long_dat;
	class Subject Period(ref="1") Group(ref="C");
	model average_sensor = Group Period Group*Period / solution;
	random intercept Period / subject=Subject;
run;



