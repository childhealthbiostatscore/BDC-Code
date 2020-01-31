#################
## HDL cholesterol, diabetic only
#################

## Data 
hdlc_dm_survival <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/6 - HDL DM/hdlsurv_dm.sas7bdat")
hdlc_dm_long <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/6 - HDL DM/hdllong_dm.sas7bdat")

## Regression model
hdlc_dm_LME <- lme (hdlc ~ v_time_months + sex , random = ~ 1|StudyID, data=hdlc_dm_long)

# Fit the survival model
hdlc_dm_cox <- coxph(Surv(fup_months, Death) ~ sex, data=hdlc_dm_survival, x=T, control=coxph.control(timefix=F))

#Fit the joint model
hdlc_dm_joint <- jointModel(hdlc_dm_LME, hdlc_dm_cox, time="v_time_months", method="weibull-PH-GH")
# Joint model doesn't run, gives the error "Error in solve.default(D) : system is computationally singular: reciprocal     condition number = 5.2714e-19
# summary(hdlc_dm_joint)

