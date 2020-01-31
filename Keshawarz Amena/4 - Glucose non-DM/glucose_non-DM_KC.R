#################
## Glucose, non-DM
#################

## Data 
glu_ndm_survival <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/4 - Glucose non-DM/glusurv_ndm.sas7bdat")
glu_ndm_long <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/4 - Glucose non-DM/glulong_ndm.sas7bdat")

## Regression model
glu_ndm_LME <- lme (glu ~ v_time_months + sex , random = ~ 1|StudyID, data=glu_ndm_long, control=ctrl)
plot(glu_ndm_LME)
# Fit the survival model
glu_ndm_cox <- coxph(Surv(fup_months, Death) ~ sex, data=glu_ndm_survival, x=T, control=coxph.control(timefix=F))

#Fit the joint model [can't do this until the regression converges]
glu_ndm_joint <- jointModel(glu_ndm_LME, glu_ndm_cox, time="v_time_months", method="weibull-PH-GH")
# gives the error Error in solve.default(D) : 
# system is computationally singular: reciprocal condition number = 1.56386e-99
#summary(glu_ndm_joint)