#################
## Visceral fat, DM and non-DM
#################

## Data 
l45vsf_all_survival <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/7 - Visceral fat all/l45vsfsurv.sas7bdat")
l45vsf_all_long <- read.sas7bdat("C:/Users/campbkri/Documents/GitHub/BDC-Code/Keshawarz Amena/7 - Visceral fat all/l45vsflong.sas7bdat")

## Regression model
l45vsf_all_survival$fup_ten_years <- l45vsf_all_survival$fup_years/10
l45vsf_all_long$v_ten_years <- l45vsf_all_long$v_time_years/10

l45vsf_all_LME <- lme (l45vsf ~ v_ten_years + dia + sex, random = ~ 1|StudyID, data=l45vsf_all_long, control=ctrl)

# Fit the survival model
l45vsf_all_cox <- coxph(Surv(fup_ten_years, Death) ~ dia + sex, data=l45vsf_all_survival, x=T, control=coxph.control(timefix=F))

#Fit the joint model
# l45vsf_all_joint <- jointModel(l45vsf_all_LME, l45vsf_all_cox, time="v_ten_years", method="Cox-PH-GH")
# summary(l45vsf_all_joint)