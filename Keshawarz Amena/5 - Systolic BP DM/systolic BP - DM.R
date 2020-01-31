#################
## Systolic BP, DM 
#################


## Data 
avesystbp_dm_survival <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/5 - Systolic BP DM/avesystbpsurv_dm.sas7bdat")
avesystbp_dm_long <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/5 - Systolic BP DM/avesystbplong_dm.sas7bdat")

## Regression model
avesystbp_dm_LME <- lme (avesystbp ~ v_time_months + sex , random = ~ 1|StudyID, data=avesystbp_dm_long, control=ctrl)

# Fit the survival model
avesystbp_dm_cox <- coxph(Surv(fup_months, Death) ~ sex, data=avesystbp_dm_survival, x=T, control=coxph.control(timefix=F))

#Fit the joint model
# avesystbp_dm_joint <- jointModel(avesystbp_dm_LME, avesystbp_dm_cox, time="v_time_months", method="weibull-PH-GH")
# summary(avesystbp_dm_joint)
