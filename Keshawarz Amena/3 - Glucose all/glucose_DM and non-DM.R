#################
## Glucose, DM and non-DM
#################


## Data 
glu_all_survival <- read.sas7bdat("Y:/Analysis of Data/Amena/CACTI/JM - things associated with mortality in T1D and nonDM/Analysis/glusurv.sas7bdat")
glu_all_long <- read.sas7bdat("Y:/Analysis of Data/Amena/CACTI/JM - things associated with mortality in T1D and nonDM/Analysis/glulong.sas7bdat")

## Regression model
glu_all_LME <- lme (glu ~ v_time_months + dia + sex, random = ~ v_time_months|StudyID, data=glu_all_long, control=ctrl)

# Fit the survival model
glu_all_cox <- coxph(Surv(fup_months, Death) ~ dia + sex, data=glu_all_survival, x=T, control=coxph.control(timefix=F))

#Fit the joint model
glu_all_joint <- jointModel(glu_all_LME, glu_all_cox, time="v_time_months", method="weibull-PH-GH")
## Joint model will not converge, gives the error     "Hessian matrix at convergence is not positive definite"
# summary(glu_all_joint)