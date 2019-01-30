*put data in a new folder may need to change datafile name;
proc import
datafile = 'S:\PEDS\RI Biostatistics Core\Shared\Shared Projects\Laura Tim projects\Viral Shah\Insulin bone marker\Data_Cleaned\updated_full_data_bone_turnover.csv'
out = full_data_bone_turnover
dbms = 'csv'
replace;
run;

*table 1 values;
proc contents data = baseline;
run;

data full_data_bone_turnover;
set full_data_bone_turnover;
if cpep_group = 'medium' then cpep_group = 'high';
run;

proc means data = full_data_bone_turnover; *we only want baseline info on those who have the data we collected for visit 3.....***;
var AgeAtConsent t1dduration UnitsInsTotal HbA1c bmi ins0;
class cpep_group;
*Per Kaci, need to add  insulin concentration and glucose AUC. Insulin at baseline? AUC calculated already?;
run;

proc freq data = full_data_bone_turnover;
tables gender InsDeliveryMethod CurrUseCGM;
by cpep_group;
run;
***********************************************************************************************************************;
***********************************************************************************************************************;
*analysis for 3 objectives;

*************************;
*objective 1: correlations between bone turnover markers and insulin;
****timepoint 0***;
%macro correlation0(dataset);
proc corr data = &dataset;
	var ins0;
	with opg0 opn0 osteocalcin0 igf0 ctx0 p1np0 vitd0 glucagon0 calcium po4;
run;
%mend;
%correlation0(full_data_bone_turnover);

****timepoint 120***;
%macro correlation120(dataset);
proc corr data = &dataset;
	var ins120;
	with opg120 opn120 osteocalcin120 igf120 ctx120 p1np120 vitd120 glucagon120 calcium po4;
run;
%mend;

%correlation120(full_data_bone_turnover);

****difference in timepoints 120-0***;
%macro correlationdiff(dataset);
proc corr data = &dataset;
	var ins_diff;
	with opg_diff opn_diff osteocalc_diff igf_diff ctx_diff p1np_diff vitd_diff glucagon_diff calcium po4;
run;
%mend;
%correlationdiff(full_data_bone_turnover);
***********************************************************************************************************;
*objective 2: correlation between insulin levels and bone turnover markers by c-peptide group;
****first create data subsets for groups;
data cpep_negative;
set full_data_bone_turnover;
where cpep_group = 'negative';
run;

data cpep_low;
set full_data_bone_turnover;
where cpep_group = 'low';
run;

data cpep_medium;
set full_data_bone_turnover;
where cpep_group = 'medium';
run;

data cpep_high;
set full_data_bone_turnover;
where cpep_group = 'high';
run;

****correlation at time 0;
%correlation0(cpep_negative);
%correlation0(cpep_low);
%correlation0(cpep_medium); *only a single subject in this category;
%correlation0(cpep_high);

*correlation at time 120;
%correlation120(cpep_negative);
%correlation120(cpep_low);
%correlation120(cpep_medium); *only a single subject in this category;
%correlation120(cpep_high);

*correlation for difference in times 120-0;
%correlationdiff(cpep_negative);
%correlationdiff(cpep_low);
%correlationdiff(cpep_medium); *only a single subject in this category;
%correlationdiff(cpep_high);

********************************************************************************************************;
*Objective 3: is the effect of insulin on BTM(bone turnover markers) mediated by IGF-1?;
**only po4 was significanlty correlated with ins120 and insdiff;
proc corr data = full_bone_turnover;
	var igf120;
	with po4;
run;

proc corr data = full_bone_turnover;
	var igf_diff;
	with po4;
run;
