/*********************************************************************************************
*  Project Name:	ASK CGM and DAISY CGM analyses
*
*  Purpose of File:	Analyze combined ASK and DAISY CGM/A1C/OGTT data
* 									   			
*  Filename:		A1C OGTT CGM analyses11302023.sas
*
*  Created by:		Fran Dong
*  Creation Date:   September 23, 2024
*
*  Input Files:		ask4.both_OGTT_CGM_A1C_4days(A1C OGTT CGM merge11302023 with Seven plus.sas)
*					ask4.both_OGTT_CGM_A1C_7days(A1C OGTT CGM merge11302023 with Seven plus.sas)
*
*  Output Files:	ask4.CGM_A1C_bl_TD_4days	
*						
***********************************************************************************************
*  Instructions/History:  From "A1C OGTT CGM merge08242023 with Seven plus.sas"
*  Revised by:
*  Revision date:
*  Revisions:	only include ASK subjects having multiple Ab+ or SBB as max antibody 
*				status and include DAISY subjects having multiple Ab+ (RBA only) as 
*				max antibody status.
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
proc freq data=ask4.CGM_A1C_bl_TD_4days;
table case_t1d60*p1_pt_above140_bi2;
run;

*estimate HR for value>optimal cutoff vs value<=cutoff;
proc phreg data=ask4.CGM_A1C_bl_TD_4days;
	title "unadjsuted HR estimate with p1_pt_above140_bi2";
	model fup_month2a*case_t1d60(0)=p1_pt_above140_bi2;
	contrast "p1_pt_above140_bi2, above vs below" p1_pt_above140_bi2 1/estimate=exp;
run;

proc phreg data=ask4.CGM_A1C_bl_TD_4days;
	title "Full model";
	where ZnT8_pn ne 9;
	class sex(ref="Male") RBA_group(ref="singleAB+") ZnT8_pn(ref="Negative") BDC512_pn(ref="Negative")/param=ref;
	model fup_month2a*case_t1d60(0)=sex RBA_group ZnT8_pn BDC512_pn A1C_bi2 p1_pt_above140_bi2/selection=stepwise slentry=0.25 
											slstay=0.15 details;
run;
proc phreg data=ask4.CGM_A1C_bl_TD_4days;
	title "Final model";
	where ZnT8_pn ne 9;
	class ZnT8_pn(ref="Negative")/param=ref;
	model fup_month2a*case_t1d60(0)=ZnT8_pn A1C_bi2 p1_pt_above140_bi2/ties=Efron rl;
run;

proc contents data=ask4.CGM_A1C_bl_TD_4days;
run;

*calculate predicted risk for each observation;
/***Participants were classified as low, medium, or high risk of imminent stage 3 type 1 diabetes 
diagnosis using the full model. 
Low risk was defined as <10% chance of type 1 diabetes diagnosis by year five, 
medium risk was defined as 10% to <30% chance of type 1 diabetes diagnosis
high risk was defined as =30% chance of type 1 diabetes diagnosis.***/
proc phreg data=ask4.CGM_A1C_bl_TD_4days;
	title "final model";
	where ZnT8_pn ne 9;
	class ZnT8_pn(ref="Negative")/param=ref;
	model fup_month2a*case_t1d60(0)=ZnT8_pn A1C_bi2 p1_pt_above140_bi2/ties=Efron rl;
	output out=surv1 survival=p_survival;
run;

data surv1a;
	length riskgroup $20.;
	set surv1;
	p_risk=1-p_survival;

	if .<p_risk<0.10 then riskgroup="Low risk";
	else if 0.10=<p_risk<0.30 then riskgroup="Medium risk";
	else if p_risk>=0.3 then riskgroup="High risk";
run;
proc sort data=surv1a; by p_survival; run;
proc print; 
var riskgroup p_survival p_risk;
run;

proc freq data=surv1a;
	tables riskgroup*p1_pt_above140_bi2/nopercent nocol norow;
run;
proc means data=surv1a N mean min max std;
	class riskgroup;
	var p_risk;
run;
proc sort data = ask4.CGM_A1C_bl_TD_4days; by ID; run;
proc sort data=surv1a; by ID; run;
data x; 
merge ask4.CGM_A1C_bl_TD_4days surv1a;
by ID;
run;
proc means data=x;
class riskgroup;
var ZnT8_pn A1C_bi2 p1_pt_above140_bi2;
run;
proc means data=x;
class case_t1d60;
var ZnT8_pn A1C_bi2 p1_pt_above140_bi2;
run;
proc freq data = x;
table ZnT8_pn*case_t1d60 / chisq;
run;
proc freq data = x;
table A1C_bi2*case_t1d60 / chisq;
run;
proc freq data = x;
table p1_pt_above140_bi2*case_t1d60 / chisq;
run;
proc print data = x;
where case_t1d60 = 0 and znt8_pn > 8;
var znt8_pn;
run;

proc lifetest data=surv1a plots=survival(cl atrisk);
	Title "Generate KM survival curves by risk group";
	time fup_month2a*case_t1d60(0);
	strata riskgroup/ test=logrank;
run;
