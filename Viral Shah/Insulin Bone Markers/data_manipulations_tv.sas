
*dataset for table 1 baseline values;
proc import
	datafile = 'S:\PEDS\RI Biostatistics Core\Shared\Shared Projects\Laura Tim projects\Viral Shah\Insulin bone marker\Data_Cleaned\KPhysExamRecHealth.csv'
	out = descriptives
	dbms = 'csv'
	replace;
run;

data bmi;
set descriptives;
where Visit = "Visit 0";
bmi = weight/((height/100)**2);
keep ptid bmi;
run;

proc sort data = bmi;
by ptid;
run;

proc import
	datafile = 'S:\PEDS\RI Biostatistics Core\Shared\Shared Projects\Laura Tim projects\Viral Shah\Insulin bone marker\Data_Cleaned\KVisit0Screening.csv'
	out = visit0
	dbms = 'csv'
	replace;
run;

proc import
	datafile = 'S:\PEDS\RI Biostatistics Core\Shared\Shared Projects\Laura Tim projects\Viral Shah\Insulin bone marker\Data_Cleaned\age at consent.csv'
	out = consent_age
	dbms = 'csv'
	replace;
run;
proc sort data = visit0;
by ptid;
run;
proc sort data = consent_age;
by ptid;
run;
data baseline;
merge visit0(in=invisit0) consent_age(in = inconsent_age) bmi(in = inbmi);
by ptid;
if invisit0 = 1 & inconsent_age= 1 & inbmi = 1 then output;
run; 
data baseline;
set baseline;
t1dduration = AgeAtConsent - DiagT1DAge;
if hba1c = 'NULL' then hba1c = '';
hba1c_num = input(hba1c, 8.);
drop hba1c;
rename hba1c_num = hba1c;
run;
proc means data = baseline;
var AgeAtConsent t1dduration UnitsInsTotal HbA1c bmi;
run;

proc freq data = baseline;
tables gender InsDeliveryMethod CurrUseCGM/ chisq;
run;


*data manipulations for "for_analysis_Bone Injury 1 and 2 Analysis with Updated Sample Names 03_29_2018.csv";
proc import
	datafile = 'S:\PEDS\RI Biostatistics Core\Shared\Shared Projects\Laura Tim projects\Viral Shah\Insulin bone marker\Data_Cleaned\for_analysis_Bone Injury 1 and 2 Analysis with Updated Sample Names 03_29_2018.csv'
	out = bone_injury
	dbms = 'csv'
	replace;
run;
data bone_injury1;
retain PtID TimePoint OPG OPN Osteocalcin_1;
set bone_injury;
PtID = substr(row_labels, 1, 9);
TimePoint = substr(row_labels,11, 3);
keep PtID TimePoint OPG OPN Osteocalcin_1;
run;

*exported the file for later analysis;
*Proc Export data = bone_injury1 outfile = 'S:\BDC\SHARED\Pickett\Barbara Davis Center\Bone studies\insulin and bone\markers_opg_opn_osteoc.csv';
*run;
proc contents data = bone_injury1;
run;
*separating bone_injury variables into 0 and 120 timepoints;
data bone_injury0;
set bone_injury1;
where Timepoint in('0');
rename OPG = OPG0; 
rename OPN = OPN0;
rename Osteocalcin_1 = osteocalcin0;
keep ptid opg0 opn0 osteocalcin0;
run; 

data bone_injury120;
set bone_injury1;
where Timepoint in('120');
rename OPG = OPG120; 
rename OPN = OPN120;
rename Osteocalcin_1 = osteocalcin120;
keep ptid opg120 opn120 osteocalcin120;
run; 

proc sort data = bone_injury0;
by ptid;
run;

proc sort data = bone_injury120;
by ptid;
run;
****************************************************************************************************************************************************;
****************************************************************************************************************************************************;
*data manipulations for "for_analysis_Beta Cell INS Combined IGF1 CTX1 P1NP VitD.csv";
proc import
	datafile = 'S:\PEDS\RI Biostatistics Core\Shared\Shared Projects\Laura Tim projects\Viral Shah\Insulin bone marker\Data_Cleaned\for_analysis_Beta Cell INS Combined IGF1 CTX1 P1NP VitD.csv'
	out = bone_markers1
	dbms = 'csv'
	replace;
run;

data bone_markers2;
set bone_markers1;
where row_labels in('0','120');
rename row_labels = TimePoint; 
run; 
*Proc Export data = bone_markers2 outfile = 'S:\BDC\SHARED\Pickett\Barbara Davis Center\Bone studies\insulin and bone\markers_igf_ctx_p1np_vitd.csv';
*run;

proc contents data = bone_markers2;
run;

*separating bone markers into 0 and 120 timepoints;
data bone_markers0;
set bone_markers2;
where Timepoint in('0');
rename Average_of_CTX_1_Average__ng_ml_ = CTX0; 
rename Average_of_Vitamin_D_Average = VitD0;
rename Average_of_x21_IGF_Dilution_fact = IGF0;
rename Average_of_xP1NP_Dilution_factor = P1NP0;
run; 
data bone_markers120;
set bone_markers2;
where Timepoint in('120');
rename Average_of_CTX_1_Average__ng_ml_ = CTX120; 
rename Average_of_Vitamin_D_Average = VitD120;
rename Average_of_x21_IGF_Dilution_fact = IGF120;
rename Average_of_xP1NP_Dilution_factor = P1NP120;
run; 

proc sort data = bone_markers0;
by ptid;
run;

proc sort data = bone_markers120;
by ptid;
run;
**********************************************************************************************************************************************;
**********************************************************************************************************************************************;
*data maniputlations for "for_analysis_KSampleResults.csv";
proc import
	datafile = 'S:\PEDS\RI Biostatistics Core\Shared\Shared Projects\Laura Tim projects\Viral Shah\Insulin bone marker\Data_Cleaned\KSampleResults.csv'
	out = clamp_data
	dbms = 'csv'
	replace;
run;
****************************************************;
*getting the data on calcium and PO4;
data baselineCA;
set clamp_data;
where visit = 'Visit 0' and analyte in('CA'); 
calcium = value;
keep ptid calcium;
run;
data baselinePO4;
set clamp_data;
where visit = 'Visit 0' and analyte in('ALK'); 
po4 = value;
keep ptid po4;
run;

data po4_temp;
set baselinePO4;
run;
proc sort data =po4_temp nodupkey;
by ptid;
run;

proc sort data = baselineCA;
by PtID;
run;
proc sort data = baselinePO4;
by PtID;
run;
****************************************************;
*getting the data on insulin glucose and CPEP;
data analytes;
set clamp_data;
where visit = 'Visit 3' and timepoint in('0','120') and analyte in('INS_TO', 'GLUCAG','CA', 'CPEP'); *need to check the insulin variable name;
run;
proc freq data = clamp_data;
tables analyte;
run;
*separating insulin values for 0 and 120 timepoints;
data insulin0;
set analytes;
where analyte = 'INS_TO' and timepoint in('0');
ins0 = value;
keep ptid ins0;
run;
data insulin120;
set analytes;
where analyte = 'INS_TO' and timepoint in('120');
ins120 = value;
keep ptid ins120;
run;

proc sort data = insulin0;
by PtID;
run;
proc sort data = insulin120;
by PtID;
run;

*glucagon at 0 and 120 timepoints; 
data glucagon0;
set analytes;
where analyte = 'GLUCAG'and timepoint in('0');
glucagon0 = value;
keep ptid glucagon0;
run;
data glucagon120;
set analytes;
where analyte = 'GLUCAG'and timepoint in('120');
glucagon120 = value;
keep ptid glucagon120;
run;

proc sort data = glucagon0;
by PtID;
run;
proc sort data = glucagon120;
by PtID;
run;

*CPEP values;
data CPEP;
set analytes;
where analyte = 'CPEP';
run;
*making cpeptide groups;
data CPEP;
set cpep;
if value = 0.007 then cpep_group = 'negative';
	else if value >=0.017 and value<= 0.2 then cpep_group = 'low';
	else if value >0.2 and value<= 0.4 then cpep_group = 'medium';
	else cpep_group = 'high';
run;

*separating into 0 and 120 timepoints;
data CPEP0;
set CPEP;
where timepoint in('0');
cpep0 = value;
keep ptid cpep0 cpep_group;
run;

data CPEP120;
set CPEP;
where timepoint in('120');
cpep120 = value;
keep ptid cpep120 cpep_group;
run;


proc sort data = CPEP0;
by PtID;
run;
proc sort data = CPEP120;
by PtID;
run;

data bone_turnover;
merge insulin0 insulin120(in = ininsulin120) bone_injury0 bone_injury120 bone_markers0 bone_markers120 cpep0 cpep120 glucagon0 glucagon120 baselineCA baselinePO4;
by ptid;
if ininsulin120 = 1 then output; *baselineCA and baselinePO4 have values for subjects that weren't in the clamp study... keeping only those who had 120 min measures;
*this deleted subject K068-0003 due to no measurements at 120 timepoint(for any variables);
run;

proc sort data = bone_turnover nodupkey; *subject K023-0001 had to measurements for CA and PO4, deleted one;
by ptid;
run;

*Variables: insulin, P1NP, CTX, osteocalcin, OPN, OPG, glucagon, CA, PO4, VitD, IGF, cpep;
data full_bone_turnover;
set bone_turnover;
ins_diff = ins120- ins0;
p1np_diff = p1np120 - p1np0;
ctx_diff = ctx120 - ctx0;
osteocalc_diff = osteocalcin120 - osteocalcin0;
OPN_diff = OPN120 - OPN0;
OPG_diff = OPG120 - OPG0;
glucagon_diff = glucagon120 - glucagon0;
IGF_diff = IGF120-IGF0;
vitd_diff = vitd120 - vitd0;
cpep_diff = cpep120 - cpep0;
drop TimePoint;
run;



Proc Export data = full_bone_turnover outfile = 'S:\PEDS\RI Biostatistics Core\Shared\Shared Projects\Laura Tim projects\Viral Shah\Insulin bone marker\Data_Cleaned\full_data_bone_turnover.csv';
run;
