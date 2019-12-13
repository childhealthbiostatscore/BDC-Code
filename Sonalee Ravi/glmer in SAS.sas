proc import datafile = '\\Mac\Home\Desktop\cgm_medicaid.csv'
 out = work.cgm
 dbms = CSV;
run;

ods output ParameterEstimates = Results Tests3 = Type3;

proc glimmix data = cgm;
class EPICMRN cgm_binary PumpUse(ref="No") Race_Ethnicity mod_race(ref="Non-Hispanic White") cgm_ever_pump(ref="CGM+|Pump-");
model cgm_binary(event='1') = days_since_last Age_AtEncounterDate DiabetesDuration cgm_ever_pump mod_race / solution distribution=binary;
random intercept / subject = EPICMRN;
run;

ods excel file="\\Mac\Home\Desktop\predict_cgm.xlsx";
proc print data = Results;
run;
ods excel close;

ods excel file="\\Mac\Home\Desktop\type3.xlsx";
proc print data = Type3;
run;
ods excel close;

proc freq data = cgm;
run;
