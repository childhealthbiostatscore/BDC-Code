#####SurvivalAnalysis#####
library(survival)

#########THYROID TIME-TO-EVENT#############
###time to thyroid:
dat.thy<-subset(dat,!is.na(dat$time_to_thyroid))

dat.thy$time_to_thyroid<-as.numeric(dat.thy$time_to_thyroid)
dat.thy$thyroid_yn<-as.numeric(dat.thy$thyroid_yn)
dat.thy<-dat.thy[order(dat.thy$time_to_thyroid),]
km_fit <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ 1, data=dat.thy)

summary(km_fit)
plot(km_fit,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="Time-to-Thyroid Disease",lwd=2,ylim=c(0.8,1))

# BY GENDER
km_fit_2 <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$Gender, data=dat.thy)

summary(km_fit_2)
plot(km_fit_2,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="Time-to-Thyroid Disease by Gender",lwd=2,ylim=c(0.8,1),col=c(1,2))

legend("bottomleft",levels(dat$Gender),col=c(1,2),bty="n",lwd=c(2,2))

logrank<-coxph(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$Gender, data=dat.thy)
logrank_sum<-summary(logrank)
text(2,.9,paste0("Female Vs. Male p=",round(logrank_sum$coefficients[1,5],4)))

# BY RACE/ETHNICITY
km_fit_3 <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$RaceEthinicity_cat, data=dat.thy)

summary(km_fit_3)
plot(km_fit_3,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="Time-to-Thyroid Disease by Race/Ethnicity",lwd=2,ylim=c(0.8,1),col=c(1:5))

legend("bottomleft",levels(dat$RaceEthinicity_cat),col=c(1:5),bty="n",lwd=c(2,2))

logrank<-coxph(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$RaceEthinicity_cat, data=dat.thy)
logrank_sum<-summary(logrank)
text(3,.88,paste0("Hispanic vs. Non-Hispanic White p=",round(logrank_sum$coefficients[2,5],4)))

# BY MEDIAN AGE
median_age<-median(dat.thy$Age_At_diabetes_DX)
dat.thy$age_cat<-"<10.1 years at diabetes dx"
dat.thy$age_cat[dat.thy$Age_At_diabetes_DX>=median_age]<-">=10.1 years at diabetes dx"
dat.thy$age_cat<-as.factor(dat.thy$age_cat)
label(dat.thy$age_cat)<-"Age, categorized by median"
km_fit_4 <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$age_cat, data=dat.thy)

summary(km_fit_4)
plot(km_fit_4,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="Time-to-Thyroid Disease by Median Age",lwd=2,ylim=c(0.8,1),col=c(1:2))

legend("bottomleft",levels(dat.thy$age_cat),col=c(1:2),bty="n",lwd=c(2,2))

logrank<-coxph(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$age_cat, data=dat.thy)
logrank_sum<-summary(logrank)
text(3,.88,paste0("Younger vs. Older Group p=",round(logrank_sum$coefficients[1,5],4)))

#########CELIAC TIME-TO-EVENT#############
###time to celiac:
dat.cel<-subset(dat,!(dat$celiac_timing %in% c("At Diabetes Onset",
                                                "Before Diabetes Onset")))

dat.cel$time_to_celiac<-as.numeric(dat.cel$time_to_celiac)
dat.cel$celiac_yn<-as.numeric(dat.cel$celiac_yn)
dat.cel<-dat.cel[order(dat.cel$time_to_celiac),]
km_fit <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ 1, data=dat.cel)

summary(km_fit)
plot(km_fit,xlab="Years from Diabetes Onset",ylab="Percent celiac Disease-Free",
     main="Time-to-celiac Disease",lwd=2,ylim=c(0.8,1))

# BY GENDER
km_fit_2 <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$Gender, data=dat.cel)

summary(km_fit_2)
plot(km_fit_2,xlab="Years from Diabetes Onset",ylab="Percent celiac Disease-Free",
     main="Time-to-celiac Disease by Gender",lwd=2,ylim=c(0.8,1),col=c(1,2))

legend("bottomleft",levels(dat$Gender),col=c(1,2),bty="n",lwd=c(2,2))

logrank<-coxph(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$Gender, data=dat.cel)
logrank_sum<-summary(logrank)
text(2,.85,paste0("Female Vs. Male p=",round(logrank_sum$coefficients[1,5],4)))

# BY RACE/ETHNICITY
km_fit_3 <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$RaceEthinicity_cat, data=dat.cel)

summary(km_fit_3)
plot(km_fit_3,xlab="Years from Diabetes Onset",ylab="Percent celiac Disease-Free",
     main="Time-to-celiac Disease by Race/Ethnicity",lwd=2,ylim=c(0.8,1),col=c(1:5))

legend("bottomleft",levels(dat$RaceEthinicity_cat),col=c(1:5),bty="n",lwd=c(2,2))

# logrank<-coxph(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$RaceEthinicity_cat, data=dat.cel)
# logrank_sum<-summary(logrank)
# text(6,.83,paste0("Hispanic vs. Non-Hispanic White p=",round(logrank_sum$coefficients[2,5],4)))

# BY MEDIAN AGE
median_age<-median(dat.cel$Age_At_diabetes_DX)
dat.cel$age_cat<-"<10.1 years at diabetes dx"
dat.cel$age_cat[dat.cel$Age_At_diabetes_DX>=median_age]<-">=10.1 years at diabetes dx"
dat.cel$age_cat<-as.factor(dat.cel$age_cat)
label(dat.cel$age_cat)<-"Age, categorized by median"
km_fit_4 <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$age_cat, data=dat.cel)

summary(km_fit_4)
plot(km_fit_4,xlab="Years from Diabetes Onset",ylab="Percent celiac Disease-Free",
     main="Time-to-celiac Disease by Median Age",lwd=2,ylim=c(0.8,1),col=c(1:2))

legend("bottomleft",levels(dat.cel$age_cat),col=c(1:2),bty="n",lwd=c(2,2))

logrank<-coxph(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$age_cat, data=dat.cel)
logrank_sum<-summary(logrank)
text(3,.85,paste0("Younger vs. Older Group p=",round(logrank_sum$coefficients[1,5],4)))

#########ADDISON TIME-TO-EVENT#############
###time to addison:
dat.add<-subset(dat,!(dat$addison_timing %in% c("At Diabetes Onset",
                                               "Before Diabetes Onset")))

dat.add$time_to_addison<-as.numeric(dat.add$time_to_addison)
dat.add$addison_yn<-as.numeric(dat.add$addison_yn)
dat.add<-dat.add[order(dat.add$time_to_addison),]
km_fit <- survfit(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ 1, data=dat.add)

summary(km_fit)
plot(km_fit,xlab="Years from Diabetes Onset",ylab="Percent addison Disease-Free",
     main="Time-to-addison Disease",lwd=2,ylim=c(0.8,1))

# BY GENDER
km_fit_2 <- survfit(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$Gender, data=dat.add)

summary(km_fit_2)
plot(km_fit_2,xlab="Years from Diabetes Onset",ylab="Percent addison Disease-Free",
     main="Time-to-addison Disease by Gender",lwd=2,ylim=c(0.8,1),col=c(1,2))

legend("bottomleft",levels(dat$Gender),col=c(1,2),bty="n",lwd=c(2,2))

logrank<-coxph(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$Gender, data=dat.add)
logrank_sum<-summary(logrank)
text(2,.85,paste0("Female Vs. Male p=",round(logrank_sum$coefficients[1,5],4)))

# BY RACE/ETHNICITY
km_fit_3 <- survfit(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$RaceEthinicity_cat, data=dat.add)

summary(km_fit_3)
plot(km_fit_3,xlab="Years from Diabetes Onset",ylab="Percent addison Disease-Free",
     main="Time-to-addison Disease by Race/Ethnicity",lwd=2,ylim=c(0.8,1),col=c(1:5))

legend("bottomleft",levels(dat$RaceEthinicity_cat),col=c(1:5),bty="n",lwd=c(2,2))

# logrank<-coxph(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$RaceEthinicity_cat, data=dat.add)
# logrank_sum<-summary(logrank)
# text(6,.83,paste0("Hispanic vs. Non-Hispanic White p=",round(logrank_sum$coefficients[2,5],4)))

# BY MEDIAN AGE
median_age<-median(dat.add$Age_At_diabetes_DX)
dat.add$age_cat<-"<10.1 years at diabetes dx"
dat.add$age_cat[dat.add$Age_At_diabetes_DX>=median_age]<-">=10.1 years at diabetes dx"
dat.add$age_cat<-as.factor(dat.add$age_cat)
label(dat.add$age_cat)<-"Age, categorized by median"
km_fit_4 <- survfit(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$age_cat, data=dat.add)

summary(km_fit_4)
plot(km_fit_4,xlab="Years from Diabetes Onset",ylab="Percent addison Disease-Free",
     main="Time-to-addison Disease by Median Age",lwd=2,ylim=c(0.8,1),col=c(1:2))

legend("bottomleft",levels(dat.add$age_cat),col=c(1:2),bty="n",lwd=c(2,2))

logrank<-coxph(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$age_cat, data=dat.add)
logrank_sum<-summary(logrank)
text(3,.85,paste0("Younger vs. Older Group p=",round(logrank_sum$coefficients[1,5],4)))
