
libname kc "S:\Shared Projects\Laura\BDC\Projects\Laurel Messer\Tandem\Data";

proc import datafile="S:\Shared Projects\Laura\BDC\Projects\Laurel Messer\Tandem\Data\data_factor1_05122020.csv"
dbms=csv
out=kc.data1
REPLACE;
run;

proc import datafile="S:\Shared Projects\Laura\BDC\Projects\Laurel Messer\Tandem\Data\data_factor2_05122020.csv"
dbms=csv
out=kc.data2
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

proc univariate data=kc.data1;
var Baseline_A1C;
run;

proc freq data=kc.data1;
table cgm_yn /missing;
run;

*Mixed beta model;
*all covariates: -6623.53;
*without CGM_yn: -6625;
*without CGM_Yn and baselinea1c:;
proc glimmix data=kc.data1 method=quad plots=residualpanel(conditional marginal);
	class Exter_lReference time method_cat cgm_yn B_RESPONDENT;
	model factor1_trans = time method_cat method_cat*time cgm_yn Baseline_A1C BaselineAGE B_RESPONDENT factor1_baseline/ dist=beta link=logit s ddfm=bw;
	*model factor1_trans = time method_cat time*method_cat / dist=beta s ddfm=bw;
	random intercept / subject=Exter_lReference;
	lsmeans time*method_cat /ilink slicediff=method_cat adjust=bon cl plot=meanplot(sliceby=method_cat plotby=time clband ilink);
	*contrast statements for comparing differences in each group;
	estimate 'Injections: baseline to 2mo' time -1 1 0 0 time*method_cat -1 0 0  1 0 0   0 0 0   0 0 0 ,
			 'Injections: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  -1 0 0   1 0 0   0 0 0,
			 'Injections: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   -1 0 0   1 0 0,
	 		 'Non-Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 -1 0  0 1 0   0 0 0   0 0 0,
	 		 'Non-Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 -1 0   0 1 0   0 0 0,
	 		 'Non-Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 -1 0   0 1 0,
		 	 'Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 0 -1  0 0 1   0 0 0   0 0 0,
	  		 'Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 0 -1   0 0 1   0 0 0,
	 		 'Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 0 -1   0 0 1/cl ilink adjust=bon; 
	ods output LSmeans=LSMEANS;
	ods output Estimates=ESTIMATE;
run;

*LSMEANS: estiamte is in logit, so transform to Mean using exp(estimate)/(1+exp(estimate));
*LS-means are constructed on the linked scale—that is, the scale on which the model effects are additive. 
*For example, in a binomial model with logit link, the least squares means are predicted population margins of the logits.;

*create table of back-transformed estimates;
data LSMEANS;
	set LSMEANS;
	mu_trans=Mu*9+1;
	muLower_trans=LowerMu*9+1;
	muUpper_trans=UpperMu*9+1;
run;

data ESTIMATE;
	set ESTIMATE;
	mu_trans=Mu*9+1;
	muLower_trans=AdjLowerMu*9+1;
	muUpper_trans=AdjUpperMu*9+1;
run;

proc export data=LSMEANS outfile="S:\Shared Projects\Laura\BDC\Projects\Laurel Messer\Tandem\Data\lsmeans_factor1.csv"
replace;
run;


proc export data=ESTIMATE outfile="S:\Shared Projects\Laura\BDC\Projects\Laurel Messer\Tandem\Data\estimate_factor1.csv"
replace;
run;

*FACTOR 2;
data kc.data2;
	set kc.data2;
	factor2_trans=factor2_beta;
	if factor2_beta=1 then factor2_trans=0.995;
	if factor2_beta=0 then factor2_trans=0.005;
run;

proc univariate data=kc.data2;
var factor2_beta factor2_trans;
run;

*Mixed beta model;
proc glimmix data=kc.data2 method=quad plots=residualpanel(conditional marginal);
	class Exter_lReference time method_cat cgm_yn B_RESPONDENT;
	model factor2_trans = time method_cat method_cat*time cgm_yn Baseline_A1C BaselineAGE B_RESPONDENT factor2_baseline/ dist=beta s ddfm=bw;
	*model factor2_trans = time method_cat time*method_cat / dist=beta s ddfm=bw;
	random intercept / subject=Exter_lReference;
	lsmeans time*method_cat /ilink slicediff=method_cat adjust=bon cl plot=meanplot(sliceby=method_cat plotby=time clband ilink);
	*contrast statements for comparing differences in each group;
	estimate 'Injections: baseline to 2mo' time -1 1 0 0 time*method_cat -1 0 0  1 0 0   0 0 0   0 0 0 ,
			 'Injections: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  -1 0 0   1 0 0   0 0 0,
			 'Injections: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   -1 0 0   1 0 0,
	 		 'Non-Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 -1 0  0 1 0   0 0 0   0 0 0,
	 		 'Non-Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 -1 0   0 1 0   0 0 0,
	 		 'Non-Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 -1 0   0 1 0,
		 	 'Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 0 -1  0 0 1   0 0 0   0 0 0,
	  		 'Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 0 -1   0 0 1   0 0 0,
	 		 'Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 0 -1   0 0 1/cl ilink adjust=bon; 
	ods output LSmeans=LSMEANS2;
	ods output Estimates=ESTIMATE2;
run;

*create table of back-transformed estimates;
data LSMEANS2;
	set LSMEANS2;
	mu_trans=Mu*9+1;
	muLower_trans=LowerMu*9+1;
	muUpper_trans=UpperMu*9+1;
run;

data ESTIMATE2;
	set ESTIMATE2;
	mu_trans=Mu*9+1;
	muLower_trans=AdjLowerMu*9+1;
	muUpper_trans=AdjUpperMu*9+1;
run;

proc export data=LSMEANS2 outfile="S:\Shared Projects\Laura\BDC\Projects\Laurel Messer\Tandem\Data\lsmeans_factor2.csv"
replace;
run;


proc export data=ESTIMATE2 outfile="S:\Shared Projects\Laura\BDC\Projects\Laurel Messer\Tandem\Data\estimate_factor2.csv"
replace;
run;



*model with only diabetics;
data kc.data1_dia;
	set kc.data1;
	where B_RESPONDENT="Person with Diabetes";
run;
proc glimmix data=kc.data1_dia method=quad plots=residualpanel(conditional marginal);
	class Exter_lReference time method_cat cgm_yn;
	model factor1_trans = time method_cat method_cat*time cgm_yn Baseline_A1C BaselineAGE factor1_baseline/ dist=beta link=logit s ddfm=bw;
	*model factor1_trans = time method_cat time*method_cat / dist=beta s ddfm=bw;
	random intercept / subject=Exter_lReference;
	lsmeans time*method_cat /ilink slicediff=method_cat adjust=bon cl plot=meanplot(sliceby=method_cat plotby=time clband ilink);
	*contrast statements for comparing differences in each group;
	estimate 'Injections: baseline to 2mo' time -1 1 0 0 time*method_cat -1 0 0  1 0 0   0 0 0   0 0 0 ,
			 'Injections: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  -1 0 0   1 0 0   0 0 0,
			 'Injections: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   -1 0 0   1 0 0,
	 		 'Non-Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 -1 0  0 1 0   0 0 0   0 0 0,
	 		 'Non-Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 -1 0   0 1 0   0 0 0,
	 		 'Non-Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 -1 0   0 1 0,
		 	 'Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 0 -1  0 0 1   0 0 0   0 0 0,
	  		 'Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 0 -1   0 0 1   0 0 0,
	 		 'Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 0 -1   0 0 1/cl ilink adjust=bon; 
	ods output LSmeans=LSMEANS;
	ods output Estimates=ESTIMATE;
run;

data kc.data2_dia;
	set kc.data2;
	where B_RESPONDENT="Person with Diabetes";
run;
proc glimmix data=kc.data2_dia method=quad plots=residualpanel(conditional marginal);
	class Exter_lReference time method_cat cgm_yn;
	model factor2_trans = time method_cat method_cat*time cgm_yn Baseline_A1C BaselineAGE factor2_baseline/ dist=beta s ddfm=bw;
	*model factor2_trans = time method_cat time*method_cat / dist=beta s ddfm=bw;
	random intercept / subject=Exter_lReference;
	lsmeans time*method_cat /ilink slicediff=method_cat adjust=bon cl plot=meanplot(sliceby=method_cat plotby=time clband ilink);
	*contrast statements for comparing differences in each group;
	estimate 'Injections: baseline to 2mo' time -1 1 0 0 time*method_cat -1 0 0  1 0 0   0 0 0   0 0 0 ,
			 'Injections: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  -1 0 0   1 0 0   0 0 0,
			 'Injections: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   -1 0 0   1 0 0,
	 		 'Non-Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 -1 0  0 1 0   0 0 0   0 0 0,
	 		 'Non-Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 -1 0   0 1 0   0 0 0,
	 		 'Non-Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 -1 0   0 1 0,
		 	 'Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 0 -1  0 0 1   0 0 0   0 0 0,
	  		 'Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 0 -1   0 0 1   0 0 0,
	 		 'Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 0 -1   0 0 1/cl ilink adjust=bon; 
	ods output LSmeans=LSMEANS2;
	ods output Estimates=ESTIMATE2;
run;




*model with only caregivers;
data kc.data1_care;
	set kc.data1;
	where B_RESPONDENT="A Parent/Guardian/Caregiver of someone with Diabetes";
run;

proc glimmix data=kc.data1_care method=quad plots=residualpanel(conditional marginal);
	class Exter_lReference time method_cat cgm_yn;
	model factor1_trans = time method_cat method_cat*time cgm_yn Baseline_A1C BaselineAGE factor1_baseline/ dist=beta link=logit s ddfm=bw;
	*model factor1_trans = time method_cat time*method_cat / dist=beta s ddfm=bw;
	random intercept / subject=Exter_lReference;
	lsmeans time*method_cat /ilink slicediff=method_cat adjust=bon cl plot=meanplot(sliceby=method_cat plotby=time clband ilink);
	*contrast statements for comparing differences in each group;
	estimate 'Injections: baseline to 2mo' time -1 1 0 0 time*method_cat -1 0 0  1 0 0   0 0 0   0 0 0 ,
			 'Injections: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  -1 0 0   1 0 0   0 0 0,
			 'Injections: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   -1 0 0   1 0 0,
	 		 'Non-Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 -1 0  0 1 0   0 0 0   0 0 0,
	 		 'Non-Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 -1 0   0 1 0   0 0 0,
	 		 'Non-Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 -1 0   0 1 0,
		 	 'Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 0 -1  0 0 1   0 0 0   0 0 0,
	  		 'Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 0 -1   0 0 1   0 0 0,
	 		 'Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 0 -1   0 0 1/cl ilink adjust=bon; 
	ods output LSmeans=LSMEANS;
	ods output Estimates=ESTIMATE;
run;

data kc.data2_care;
	set kc.data2;
	where B_RESPONDENT="A Parent/Guardian/Caregiver of someone with Diabetes";
run;

proc glimmix data=kc.data2_care method=quad plots=residualpanel(conditional marginal);
	class Exter_lReference time method_cat cgm_yn;
	model factor2_trans = time method_cat method_cat*time cgm_yn Baseline_A1C BaselineAGE factor2_baseline/ dist=beta s ddfm=bw;
	*model factor2_trans = time method_cat time*method_cat / dist=beta s ddfm=bw;
	random intercept / subject=Exter_lReference;
	lsmeans time*method_cat /ilink slicediff=method_cat adjust=bon cl plot=meanplot(sliceby=method_cat plotby=time clband ilink);
	*contrast statements for comparing differences in each group;
	estimate 'Injections: baseline to 2mo' time -1 1 0 0 time*method_cat -1 0 0  1 0 0   0 0 0   0 0 0 ,
			 'Injections: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  -1 0 0   1 0 0   0 0 0,
			 'Injections: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   -1 0 0   1 0 0,
	 		 'Non-Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 -1 0  0 1 0   0 0 0   0 0 0,
	 		 'Non-Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 -1 0   0 1 0   0 0 0,
	 		 'Non-Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 -1 0   0 1 0,
		 	 'Tandem: baseline to 2mo' time -1 1 0 0 time*method_cat 0 0 -1  0 0 1   0 0 0   0 0 0,
	  		 'Tandem: 2mo to 4mo' time 0 -1 1 0 time*method_cat 0 0 0  0 0 -1   0 0 1   0 0 0,
	 		 'Tandem: 4mo to 6mo' time 0 0 -1 1 time*method_cat 0 0 0  0 0 0   0 0 -1   0 0 1/cl ilink adjust=bon; 
	ods output LSmeans=LSMEANS2;
	ods output Estimates=ESTIMATE2;
run;

