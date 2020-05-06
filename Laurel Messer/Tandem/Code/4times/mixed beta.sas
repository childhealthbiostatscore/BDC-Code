
libname kc "S:\Shared Projects\Laura\BDC\Projects\Laurel Messer\Tandem\Data";

proc import datafile="S:\Shared Projects\Laura\BDC\Projects\Laurel Messer\Tandem\Data\data_factor1.csv"
dbms=csv
out=kc.data1
REPLACE;
run;

PROC CONTENTS data=kc.data1;
run;

proc univariate data=kc.data1;
var factor1 factor1_beta;
run;
*spaghetti plot;
*complete data;
data complete;
	set kc.data1;
	where num_factor1=4;
run;
proc sgplot data=complete;
   series x=time y=factor1 / group=Exter_lReference;
run;
data missing;
	set kc.data1;
	where num_factor1<4;
run;
proc sgplot data=missing;
   series x=time y=factor1 / group=Exter_lReference;
run;

data missing1;
	set kc.data1;
	where num_factor1=3;
run;
proc sgplot data=missing1;
   series x=time y=factor1 / group=Exter_lReference;
run;
data missing2;
	set kc.data1;
	where num_factor1=2;
run;
proc sgplot data=missing2;
   series x=time y=factor1 / group=Exter_lReference;
run;
data missing3;
	set kc.data1;
	where num_factor1=1;
run;
proc sgplot data=missing3;
   series x=time y=factor1 / group=Exter_lReference;
run;


data kc.data1;
	set kc.data1;
	factor1_10=.;
	if factor1=10 then factor1_10=1;
	if factor1<10 then factor1_10=0;
run;

*this is the issue - almost 20% of the data is 10;
*do we just model whether it's 10 at each time point?;
proc freq data=kc.data1;
	table factor1_10*time;
run;

data kc.data1;
	set kc.data1;
	factor1_trans=factor1_beta;
	if factor1_beta=1 then factor1_trans=0.995;
	if factor1_beta=0 then factor1_trans=0.005;
run;

proc univariate data=kc.data1;
var factor1_beta factor1_trans;
run;

*Mixed beta model;
proc glimmix data=kc.data1 method=quad plots=residualpanel(conditional marginal);
	class Exter_lReference time(ref="baseline") method_cat cgm_yn B_RESPONDENT;
	model factor1_trans = factor1_baseline time method_cat time*method_cat cgm_yn Baseline_A1C BaselineAGE B_RESPONDENT/ dist=beta s ddfm=bw;
	*model factor1_trans = time method_cat time*method_cat / dist=beta s ddfm=bw;
	random intercept / subject=Exter_lReference;
	*lsmeans time*method_cat /ilink cl;
run;

*Mixed logistic model;
proc glimmix data=kc.data1 method=quad plots=residualpanel(conditional marginal);
	class Exter_lReference time(ref="baseline") method_cat cgm_yn B_RESPONDENT;
	model factor1_10(ref="0") = factor1_baseline time method_cat time*method_cat Baseline_A1C BaselineAGE B_RESPONDENT/ dist=binary s ddfm=bw;
	*model factor1_10(ref="0") = time method_cat time*method_cat  / dist=binary s ddfm=bw;
	random intercept / subject=Exter_lReference;
	*lsmeans time*method_cat /ilink cl;
run;



*model with only diabetics;
data kc.data1_dia;
	set kc.data1;
	where B_RESPONDENT="Person with Diabetes";
run;

proc glimmix data=kc.data1_dia method=quad plots=residualpanel(conditional marginal);
	class Exter_lReference time(ref="baseline") method_cat cgm_yn;
	model factor1_trans = factor1_baseline time method_cat time*method_cat cgm_yn Baseline_A1C BaselineAGE/ dist=beta s ddfm=bw;
	random intercept / subject=Exter_lReference;
	lsmeans time*method_cat /ilink cl;
run;

*model with only caregivers;
data kc.data1_care;
	set kc.data1;
	where B_RESPONDENT="A Parent/Guardian/Caregiver of someone with Diabetes";
run;

proc glimmix data=kc.data1_care method=quad plots=residualpanel(conditional marginal);
	class Exter_lReference time(ref="baseline") method_cat cgm_yn;
	model factor1_beta_ex = factor1_baseline time method_cat time*method_cat cgm_yn Baseline_A1C BaselineAGE/ dist=beta s ddfm=bw;
	random intercept / subject=Exter_lReference;
	lsmeans time*method_cat /ilink cl;
run;



*Linear mixed model;
proc glimmix data=kc.data1 method=quad;
class Exter_lReference time method_cat;
model factor1_trans = time method_cat time*method_cat / dist=gaussian s ddfm=bw;
random intercept / subject=Exter_lReference;
run;
*Beta GEE;
proc glimmix data=kc.data1 empirical;
class Exter_lReference time method_cat;
model factor1_beta_ex = factor1_baseline time method_cat time*method_cat / dist=beta s ddfm=none covb;
random _residual_ / subject=Exter_lReference type=cs vcorr;
*lsmeans diab*time /ilink cl;
run;

