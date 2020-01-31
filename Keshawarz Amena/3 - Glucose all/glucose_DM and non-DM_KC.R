#################
## Glucose, DM and non-DM
#################


## Data 
glu_all_survival <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/3 - Glucose all/glusurv.sas7bdat")
glu_all_long <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/3 - Glucose all/glulong.sas7bdat")

## Regression model
ctrl=lmeControl(opt='optim',optimMethod = "SANN")

glu_all_LME <- lme (glu ~ v_time_months + dia + sex, random = ~ 1|StudyID, data=glu_all_long, control=ctrl)
plot(glu_all_LME)
# Fit the survival model
glu_all_cox <- coxph(Surv(fup_months, Death) ~ dia + sex, data=glu_all_survival, x=T, control=coxph.control(timefix=F))

#Fit the joint model
glu_all_joint <- jointModel(glu_all_LME, glu_all_cox, time="v_time_months", method="weibull-PH-GH")
## Joint model will not converge, gives the error     "Hessian matrix at convergence is not positive definite"
# summary(glu_all_joint)