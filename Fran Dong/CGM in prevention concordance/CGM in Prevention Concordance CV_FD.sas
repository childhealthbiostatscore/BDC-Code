/*********************************************************************************************
*  Project Name:	the concordance statistic (C-statistic)
*
*  Purpose of File:	the concordance statistic (C-statistic)
* 									   			
*  Filename:		CGM in Prevention Concordance CV_FD.sas
*
*  Created by:		Fran Dong
*  Creation Date:   September 23, 2024
*
*  Input Files:		ask4.CGM_A1C_bl_TD_4days (from A1C OGTT CGM analyses11302023.sas)
*
*  Output Files:		
*						
***********************************************************************************************
*  Instructions/History:  
Once the final three models were determined, the concordance statistic (C-statistic) was computed 
using 5-fold cross-validation. The concordance measures how well the model ranks the participants’ 
risk of type 1 diabetes diagnosis, with a C-statistic of 1 representing a perfect ranking system and 
a C-statistic of 0.5 representing an inaccurate model no better than randomly ranking participants’ 
risk of type 1 diabetes diagnosis. The 95% confidence intervals on the C-statistic were computed using 
10,000 bootstrap samples. 
*
**********************************************************************************************/
libname ASK4 "\\Mac\Home\Documents\GitHub\BDC-Code\Fran Dong\CGM in prevention concordance";

proc format; 
	value yesno 1="Yes"
                0="No";
    value abf   1="Positive"
                9="Inconclusive"
                0="Negative";
	value $racefmt "NHW"="Non-hispanic white"
				   "HISP"="Hispanic, any race"
				   "AA"="African american, not hispanic"
				   "Other"="Any other race, not hispanic";
run;


data subjects;
	set ASK4.cgm_a1c_bl_td_4days;
run;


/* erase dataset (set to 0 observations) */
%macro erase(data);
   data &data;
      set _null_;
   run;
%mEnd;


/* Sorts a specified dataset */
%macro sort(data, by);
   proc sort data=&data;
      by &by;
   run;
%mEnd;

/* Get Harrell's concordance from PHREG */
%macro phregConcordance(dat=dat,out=out,pred=pred,time=time,delta=delta);

	/* Create two copies of the same data to create cross product */
	data tmp1;
		set &dat(rename=(&pred.=&pred.1 &time.=&time.1 &delta.=&delta.1));
		id1=_N_;
	run;

	data tmp2;
		set &dat(rename=(&pred.=&pred.2 &time.=&time.2 &delta.=&delta.2));
		id2=_N_;
	run;
	
	/* Create cross product */
	proc sql;                  
	  create table cart as    
		select tmp1.*           
			  ,tmp2.*   
							   
		from tmp1,tmp2
	quit;

	/* Compute Concordance numerators and denominators */
	data cart;
		set cart;
		/* Remove self-pairs and duplicate pairs */
		if id2 <= id1 then delete;
		/* If both participants in the pair never had stage 3 T1D diagnosis, 
		then the pair is not considered in the c-statistic calculation. */
		if &delta.1=0 AND &delta.2=0 then delete;
		/* If one participant never had T1D diagnosis and stopped follow-up 
		before the other participant is diagnosed with T1D, 
		then the pair is not considered in the c-statistic calculation. */
		else if ((&delta.1=0 AND &delta.2=1) AND 
				  (&time.1<&time.2)
				 ) OR 
				 ((&delta.1=1 AND &delta.2=0) AND 
				  (&time.2<&time.1)
				 ) then delete;
		/* If one participant never had T1D diagnosis but had stopped 
		follow-up after the other participant is diagnosed with T1D, 
		then it is known which participant has a longer time to T1D diagnosis.  
		The pair is concordant if the participant with greater 
		hazards (higher risk of T1D progression) developed T1D first; 
		otherwise, the pair is discordant. */
		else if (&delta.1=0 AND &delta.2=1) AND (&time.1 >= &time.2) then do;
			if(&pred.2>&pred.1) then CH_numerator=1;
			else CH_numerator=0;
			CH_denominator=1;
		end;
		else if (&delta.1=1 AND &delta.2=0) AND (&time.2 >= &time.1) then do;
			if(&pred.1>&pred.2) then CH_numerator=1;
			else CH_numerator=0;
			CH_denominator=1;
		end;
		/* If both participants have a T1D diagnosis, then it is known 
		which participant has a longer time to T1D diagnosis. The pair is 
		concordant if the participant with greater hazards (higher risk 
		of T1D progression) developed T1D first, otherwise, the pair 
		is discordant. If their times are equal, then concordance cannot
		be determined and so delete */
		else if (&delta.1=1 AND &delta.2=1) AND (&time.1>&time.2) then do;
			if(&pred.2>&pred.1) then CH_numerator=1;
			else CH_numerator=0;
			CH_denominator=1;
		end;
		else if (&delta.1=1 AND &delta.2=1) AND (&time.2>&time.1) then do;
			if(&pred.1>&pred.2) then CH_numerator=1;
			else CH_numerator=0;
			CH_denominator=1;
		end;
		else if (&delta.1=1 AND &delta.2=1) AND (&time.2 = &time.1) then delete;
		/* sanity check */
		else put "WARNING: pair not scored " id1= id2=;
	run;

	/* Sum up numerators and denominators */
	proc means data=cart sum noprint;
		var Ch_numerator CH_denominator ;
		output out=&out sum=sum_num sum_den;
	run;
	
	/*  Divide numerator sum by denominator sum */
	data &out;
		set &out;
		concordance=sum_num/sum_den;
	run;
	
%mEnd phregConcordance;


/* Cross-validation macro (5 fold) */
%macro CoxCVwithBoot(dat=dat,numFolds=5,numBoots=50,vars=vars,
					  class=,by=by,out=out,convergence=convergence);

	%if (&vars ne "gluMean") %then %do;
		options nonotes nosource;
		%put Suppressing notes;
	%end;
	%put Fitting PHREG models over bootstraps and CV folds...;
	/* Fit model and save it for getting linear predictors (Xb) */
	proc phreg data=&dat.Train;
		&class;
		model fup_month2a*case_t1d60(0)=&vars;
		where replicate le &numBoots;
		by &by;
		store sasuser.mv_tmp;
		ods output convergenceStatus=&convergence;
	run;

	%put done!;
	%put Getting predicted values over bootstraps and CV folds...;	
	/* Get linear predictors on held out data */			
	proc plm restore=sasuser.mv_tmp;
		 score data=&dat.Test out=coxPHmv_scr(keep=case_t1d60 fup_month2a Predicted 
														replicate testFold);
	run;
	
	
	%put done!;
	%put Computing PHREG concordance...;
	
	%do boot=1 %to &numBoots;

		%if %eval(%sysfunc(mod(&boot,2500))=0) %then %put Boot: &boot;

		%erase(AllFolds);
			
		%do fold=1 %to &numFolds;

			data coxPHmv_scrTmp;
				set coxPHmv_scr(where=(replicate=&boot AND testFold=&fold));
				drop replicate testFold;
			run;

			/* Compute Harrell's concordance on held out data */
			%phregConcordance(dat=coxPHmv_scrTmp,
							  out=thisFold,
							  pred=Predicted,
							  time=fup_month2a,
							  delta=case_t1d60);
							  
			data AllFolds;
				set AllFolds thisFold;
			run;
			
		%end;

		proc means data=AllFolds mean;
			var Concordance;
			output out=&out.tmp(drop= _TYPE_ _FREQ_) mean=concordance;
		run;
			
		data &out.tmp;
			set &out.tmp;
			bootRep=&boot;
		run;
	
		data &out;
			set &out &out.tmp;
		run;

		options nomprint;
			
	%end;

	%put done;
	
	options notes source;

%mEnd CoxCVwithBoot;


/* Create bootstrap replicates */
title3 'Bootstrap and CV replication';
proc surveyselect data=subjects
	out=subjectsBoot 
	seed=155 
	method=urs 
	samprate=100 
	/* 20 extra reps in case of non-convergence */
	reps=10020;
run;

/* Create CV folds within each bootstrap replicate and case_t1d60 */
%sort(subjectsBoot,replicate case_t1d60);
proc surveyselect data=subjectsBoot out=subjectsBootCVTest groups=5 seed=32787;
	strata replicate case_t1d60;
run;

/* Create training data (stacking the bootstrap iterations and folds) */
data subjectsBootCVTrain;
	set subjectsBootCVTest(where=(groupID ne 1));
	testFold=1;
	output;
	set subjectsBootCVTest(where=(groupID ne 2));
	testFold=2;
	output;
	set subjectsBootCVTest(where=(groupID ne 3));
	testFold=3;
	output;
	set subjectsBootCVTest(where=(groupID ne 4));
	testFold=4;
	output;
	set subjectsBootCVTest(where=(groupID ne 5));
	testFold=5;
	output;
run;
%sort(subjectsBootCVTrain,replicate testFold );

/* Create training data */
data subjectsBootCVTest;
	set subjectsBootCVTest;
	rename groupID=testFold;
run;

%sort(subjectsBootCVTest,replicate testFold);


/* AutoAB >= 2 CV */

%erase(conc);
%erase(conv);


/******************************************************************************/
ods rtf file="\\Mac\Home\Documents\GitHub\BDC-Code\Fran Dong\CGM in prevention concordance\output_model1.rtf";
ods rtf exclude all;
title3 "CV and bootstrap";
%coxCVwithBoot(dat=subjectsBootCV,numFolds=5,numBoots=12,
				vars=sex RBA_group ZnT8_pn BDC512_pn A1C_bi2 p1_pt_above140_bi2,
			   class=class sex RBA_group ZnT8_pn BDC512_pn A1C_bi2 p1_pt_above140_bi2,
			   by=replicate testFold,out=conc,convergence=conv);
ods rtf exclude none;

/* Check convergence:
mark bootstrap iterations as non-convergent if any 
one fold fails to converge within the iteration */
proc sql;
	create table convByBoot as
		select *, max(Status ne 0) as bootNotConverged
		from conv
		group by replicate;
quit;
%sort(convByBoot nodupkey,replicate);
		
proc format;
	value conver 1="Did not converge" 0="Converged";
run;

title3 "Bootstrap iterations converged";
proc freq data=ConvByBoot;
	table bootNotConverged;
	format bootNotConverged conver.;
run;

%sort(conc,bootRep);
%sort(ConvByBoot,replicate);

/* Merge convergence status to concordance results and 
sort with nodupkey to get one row*/
data conc_m1;
	merge conc ConvByBoot(rename=(replicate=bootRep));
	by bootRep;
run;
%sort(Conc_m1,bootRep);

title3 "Concordance";
proc univariate data=conc_m1;
	var concordance;
	where bootNotConverged=0;
	output out=concResults_m1 mean=concMean
		pctlpts=2.5 97.5 pctlpre=conc pctlname=Lower Upper;
run;

proc print data=concResults_m1;
	format conc: 5.2;
run;
ods rtf close;

%erase(conc);
%erase(conv);


/******************************************************************************/
ods rtf file="H:\DAISYSTUDY\Results\ASK\Dysglycemia project\output_model2.rtf";
ods rtf exclude all;
title3 "CV and bootstrap";
%coxCVwithBoot(dat=subjectsBootCV,numFolds=5,numBoots=12,
				vars=ZnT8_pn A1C_bi2 p1_pt_above140_bi2,
			   class=class ZnT8_pn A1C_bi2 p1_pt_above140_bi2,
			   by=replicate testFold,out=conc,convergence=conv);
ods rtf exclude none;

proc sql;
	create table convByBoot as
		select *, max(Status ne 0) as bootNotConverged
		from conv
		group by replicate;
quit;
%sort(convByBoot nodupkey,replicate);
		
proc format;
	value conver 1="Did not converge" 0="Converged";
run;

title3 "Bootstrap iterations converged";
proc freq data=ConvByBoot;
	table bootNotConverged;
	format bootNotConverged conver.;
run;

%sort(conc,bootRep);
%sort(ConvByBoot,replicate);

data conc2b;
	merge conc ConvByBoot(rename=(replicate=bootRep));
	by bootRep;
run;
%sort(Conc2b,bootRep);

title3 "Concordance";
proc univariate data=conc2b;
	var concordance;
	where bootNotConverged=0;
	output out=concResults2b mean=concMean
		pctlpts=2.5 97.5 pctlpre=conc pctlname=Lower Upper;
run;

proc print data=concResults2b;
	format conc: 5.2;
run;
ods rtf close;

%erase(conc);
%erase(conv);


/******************************************************************************/
ods rtf file="H:\DAISYSTUDY\Results\ASK\Dysglycemia project\output_model3.rtf";
ods rtf exclude all;
title3 "CV and bootstrap";
%coxCVwithBoot(dat=subjectsBootCV,numFolds=5,numBoots=12,
				vars=p1_pt_above140_bi2,
			   class=class p1_pt_above140_bi2,
			   by=replicate testFold,out=conc,convergence=conv);
ods rtf exclude none;

proc sql;
	create table convByBoot as
		select *, max(Status ne 0) as bootNotConverged
		from conv
		group by replicate;
quit;
%sort(convByBoot nodupkey,replicate);
		
proc format;
	value conver 1="Did not converge" 0="Converged";
run;

title3 "Bootstrap iterations converged";
proc freq data=ConvByBoot;
	table bootNotConverged;
	format bootNotConverged conver.;
run;

%sort(conc,bootRep);
%sort(ConvByBoot,replicate);

/* Merge convergence status to concordance results and 
sort with nodupkey to get one row*/
data conc_m3b;
	merge conc ConvByBoot(rename=(replicate=bootRep));
	by bootRep;
run;
%sort(Conc_m3b,bootRep);

title3 "Concordance";
proc univariate data=conc_m3b;
	var concordance;
	where bootNotConverged=0;
	output out=concResults_m3 mean=concMean
		pctlpts=2.5 97.5 pctlpre=conc pctlname=Lower Upper
run;

proc print data=concResults_m3;
	format conc: 5.2;
run;
ods rtf close;
