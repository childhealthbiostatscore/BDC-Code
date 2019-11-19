proc glimmix data = cgm pconv = 0.1;
class EPICMRN cgm_binary PumpUse Race_Ethnicity;
model cgm_binary = Age_AtEncounterDate DiabetesDuration PumpUse Race_Ethnicity / solution distribution=binary;
random intercept / subject = EPICMRN;
run;
