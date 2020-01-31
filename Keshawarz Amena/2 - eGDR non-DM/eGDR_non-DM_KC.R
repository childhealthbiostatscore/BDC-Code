#################
## Estimated GDR, non-DM
#################

## Data 
egdr_ndm_survival <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/2 - eGDR non-DM/egdrsurv_ndm.sas7bdat")
egdr_ndm_long <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/2 - eGDR non-DM/egdrlong_ndm.sas7bdat")

## Regression model
ctrl2=lmeControl(opt='optim',optimMethod = "SANN")
egdr_ndm_LME <- lme (egdr ~ v_time_months + sex , random = ~ 1|StudyID, data=egdr_ndm_long, control=ctrl2)

# Fit the survival model
egdr_ndm_cox <- coxph(Surv(fup_months, Death) ~ sex, data=egdr_ndm_survival, x=T, control=coxph.control(timefix=F))

#Fit the joint model 
egdr_ndm_joint <- jointModel(egdr_ndm_LME, egdr_ndm_cox, time="v_time_months", method="weibull-PH-GH")
# Error in solve.default(D) : 
# system is computationally singular: reciprocal condition number = 1.73733e-16
# summary(egdr_ndm_joint)