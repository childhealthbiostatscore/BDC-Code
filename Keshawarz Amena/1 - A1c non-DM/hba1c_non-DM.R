#################
## HbA1c, non-DM only
#################
library(sas7bdat)
library(JM)
## Data 
hba1c_ndm_survival <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/1 - A1c non-DM/hba1csurv_ndm.sas7bdat")
hba1c_ndm_long <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/1 - A1c non-DM/hba1clong_ndm.sas7bdat")

## Regression model
hba1c_ndm_LME <- lme (hba1c ~ v_time_months + as.factor(sex) , random = ~ 1 | StudyID, 
                      data=hba1c_ndm_long)
summary(hba1c_ndm_LME)
# model doesn't converge, gives the error ' nlminb problem, convergence error code = 1
#   message = iteration limit reached without convergence (10) 

# Fit the survival model
hba1c_ndm_cox <- coxph(Surv(fup_months, Death) ~ sex, data=hba1c_ndm_survival, x=T, control=coxph.control(timefix=F))

#Fit the joint model [can't do this until the regression converges]
hba1c_ndm_joint <- jointModel(hba1c_ndm_LME, hba1c_ndm_cox, time="v_time_months", method="weibull-PH-GH")
summary(hba1c_ndm_joint)
