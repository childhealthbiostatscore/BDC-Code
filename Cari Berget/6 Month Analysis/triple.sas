PROC MIXED DATA=alldata;
CLASS record_id tpoint(ref="B") age_group(ref="< 14") hba1c_clinical(ref="(0,7.5]");
MODEL hba1c = tpoint age_group hba1c_clinical tpoint*age_group tpoint*hba1c_clinical tpoint*age_group*hba1c_clinical/ SOLUTION;
RANDOM INT  /TYPE=UN SUBJECT=record_id G GCORR;
RUN;
