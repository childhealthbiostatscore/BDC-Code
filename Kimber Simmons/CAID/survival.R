#####SurvivalAnalysis#####
library(survival)
library(RColorBrewer)
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Kimber Simmons/CAID/data_prep.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Kimber Simmons/CAID/labs.R')

options(scipen=999)
#########ANY CAID TIME-TO-EVENT#############
dat.any<-subset(dat,!is.na(dat$time_to_any))

dat.any$time_to_any<-as.numeric(dat.any$time_to_any)
dat.any$any_caid<-as.numeric(dat.any$any_caid)
dat.any<-dat.any[order(dat.any$any_caid),]
km_fit <- survfit(Surv(dat.any$time_to_any, dat.any$any_caid) ~ 1, data=dat.any)

summary(km_fit)
plot(km_fit,xlab="Years from Diabetes Onset",ylab="Percent CAID-Free",
     main="Time-to-Any CAID",lwd=2,ylim=c(0.75,1))

# BY GENDER
par(mfrow=c(1,3))
km_fit_2 <- survfit(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$Gender, data=dat.any)

summary(km_fit_2)
plot(km_fit_2,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="Any CAID by Gender",lwd=2,ylim=c(0.75,1),col=brewer.pal(3,"Set2"))

legend("bottomleft",levels(dat$Gender),col=brewer.pal(3,"Set2"),bty="n",lwd=c(2,2))

logrank<-coxph(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$Gender, data=dat.any)
logrank_sum<-summary(logrank)
text(2,.8,paste0("Female vs. Male p=",round(logrank_sum$coefficients[1,5],3)))

# BY RACE/ETHNICITY
km_fit_3 <- survfit(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$RaceEthinicity_cat, data=dat.any)

summary(km_fit_3)
plot(km_fit_3,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="Any CAID by Race/Ethnicity",lwd=2,ylim=c(0.75,1),col=brewer.pal(5,"Set2"))

legend("bottomleft",levels(dat$RaceEthinicity_cat),col=brewer.pal(5,"Set2"),bty="n",lwd=c(2,2))

logrank<-coxph(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$RaceEthinicity_cat, data=dat.any)
logrank_sum<-summary(logrank)
text(3,.8,paste0("Hispanic vs. Non-Hispanic White p=",round(logrank_sum$coefficients[2,5],3)))

# BY MEDIAN AGE
median_age<-median(dat.any$Age_At_diabetes_DX)
dat.any$age_cat<-"<10.1 years at diabetes dx"
dat.any$age_cat[dat.any$Age_At_diabetes_DX>=median_age]<-">=10.1 years at diabetes dx"
dat.any$age_cat<-as.factor(dat.any$age_cat)
label(dat.any$age_cat)<-"Age, categorized by median"
km_fit_4 <- survfit(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$age_cat, data=dat.any)

summary(km_fit_4)
plot(km_fit_4,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="Any CAID by Median Age",lwd=2,ylim=c(0.75,1),col=brewer.pal(3,"Set2"))

legend("bottomleft",levels(dat.any$age_cat),col=brewer.pal(3,"Set2"),bty="n",lwd=c(2,2))

logrank<-coxph(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$age_cat, data=dat.any)
logrank_sum<-summary(logrank)
text(3,.8,paste0("Younger vs. Older Group p=",round(logrank_sum$coefficients[1,5],3)))


#########THYROID TIME-TO-EVENT#############
###time to thyroid:
dat.thy<-subset(dat,!is.na(dat$time_to_thyroid))

dat.thy$time_to_thyroid<-as.numeric(dat.thy$time_to_thyroid)
dat.thy$thyroid_yn<-as.numeric(dat.thy$thyroid_yn)
dat.thy<-dat.thy[order(dat.thy$time_to_thyroid),]
km_fit <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ 1, data=dat.thy)

summary(km_fit)
plot(km_fit,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="Time-to-Thyroid Disease",lwd=3,ylim=c(0.8,1),cex.axis=1.5,cex.main=1.5,cex.lab=1.5)

# BY GENDER
par(mfrow=c(1,3))
km_fit_2 <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$Gender, data=dat.thy)

summary(km_fit_2)
plot(km_fit_2,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="By Gender",lwd=3,ylim=c(0.8,1),col=brewer.pal(3,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",levels(dat$Gender),col=brewer.pal(3,"Set1"),
       bty="n",lwd=c(3,3),cex=1.5)

logrank<-coxph(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$Gender, data=dat.thy)
logrank_sum<-summary(logrank)
text(2.3,.9,paste0("p=",round(logrank_sum$coefficients[1,5],4)),cex=1.5)

# BY RACE/ETHNICITY
km_fit_3 <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$RaceEthinicity_cat, data=dat.thy)

summary(km_fit_3)
plot(km_fit_3,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="By Race/Ethnicity",lwd=3,ylim=c(0.8,1),col=brewer.pal(5,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",levels(dat$RaceEthinicity_cat),
       col=brewer.pal(5,"Set1"),bty="n",lwd=c(3,3),cex=1.2)

logrank<-coxph(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$RaceEthinicity_cat, data=dat.thy)
logrank_sum<-summary(logrank)
text(3,.86,paste0("p=",
                  round(logrank_sum$coefficients[2,5],4)),cex=1.5)
text(3,.875,"Hispanic vs. White",cex=1.5)

# BY MEDIAN AGE
median_age<-median(dat.thy$Age_At_diabetes_DX)
dat.thy$age_cat<-"<10.1 years at diabetes dx"
dat.thy$age_cat[dat.thy$Age_At_diabetes_DX>=median_age]<-">=10.1 years at diabetes dx"
dat.thy$age_cat<-as.factor(dat.thy$age_cat)
label(dat.thy$age_cat)<-"Age, categorized by median"
km_fit_4 <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$age_cat, data=dat.thy)

summary(km_fit_4)
plot(km_fit_4,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="By Median Age",lwd=3,ylim=c(0.8,1),col=brewer.pal(3,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",c("<10.1 yrs",">=10.1 yrs"),
       col=brewer.pal(3,"Set1"),bty="n",lwd=c(3,3),cex=1.5)

logrank<-coxph(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$age_cat, data=dat.thy)
logrank_sum<-summary(logrank)
text(3,.88,paste0("p=",round(logrank_sum$coefficients[1,5],3)),cex=1.5)

###THRYOID BY LAB POS/NEG AT BASELINE:
par(mfrow=c(1,3))
dat.thy$baseline_tpo<-as.factor(dat.thy$baseline_tpo)
dat.thy.tpo<-subset(dat.thy,dat.thy$baseline_tpo %in% c("POS","NEG"))
km_fit_tpo <- survfit(Surv(dat.thy.tpo$time_to_thyroid, dat.thy.tpo$thyroid_yn) ~ dat.thy.tpo$baseline_tpo,
                      data=dat.thy.tpo)
summary(km_fit_tpo)
plot(km_fit_tpo,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="By TPO Ab at Baseline",lwd=3,ylim=c(0,1),col=brewer.pal(3,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",c("NEG","POS"),col=brewer.pal(3,"Set1"),
       bty="n",lwd=c(3,3),cex=1.5)

logrank<-coxph(Surv(dat.thy.tpo$time_to_thyroid, dat.thy.tpo$thyroid_yn) ~ dat.thy.tpo$baseline_tpo, 
               data=dat.thy.tpo)
logrank_sum<-summary(logrank)
text(2.3,.9,paste0("p<0.0001"),cex=1.5)

dat.thy$baseline_thy<-as.factor(dat.thy$baseline_thy)
dat.thy.thy<-subset(dat.thy,dat.thy$baseline_thy %in% c("POS","NEG"))
km_fit_thy <- survfit(Surv(dat.thy.thy$time_to_thyroid, dat.thy.thy$thyroid_yn) ~ dat.thy.thy$baseline_thy,
                      data=dat.thy.thy)
summary(km_fit_thy)
plot(km_fit_thy,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="By Thyroglobulin at Baseline",lwd=3,ylim=c(0,1),col=brewer.pal(3,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",c("NEG","POS"),col=brewer.pal(3,"Set1"),
       bty="n",lwd=c(3,3),cex=1.5)

logrank<-coxph(Surv(dat.thy.thy$time_to_thyroid, dat.thy.thy$thyroid_yn) ~ dat.thy.thy$baseline_thy, 
               data=dat.thy.thy)
logrank_sum<-summary(logrank)
text(2.3,.9,paste0("p<0.0001"),cex=1.5)

#combined:
dat.thy$baseline_tpo_thy<-NA
dat.thy$baseline_tpo_thy[dat.thy$baseline_tpo=="NEG" & dat.thy$baseline_thy=="NEG"]<-"Both NEG"
dat.thy$baseline_tpo_thy[dat.thy$baseline_tpo=="POS" & dat.thy$baseline_thy=="POS"]<-"Both POS"
dat.thy$baseline_tpo_thy[dat.thy$baseline_tpo=="NEG" & dat.thy$baseline_thy=="POS"]<-"TPO NEG, Thy POS"
dat.thy$baseline_tpo_thy[dat.thy$baseline_tpo=="POS" & dat.thy$baseline_thy=="NEG"]<-"TPO POS, Thy NEG"

dat.thy.comb<-subset(dat.thy,!is.na(dat.thy$baseline_tpo_thy))
dat.thy.comb$baseline_tpo_thy<-as.factor(dat.thy.comb$baseline_tpo_thy)

km_fit_thy.comb <- survfit(Surv(dat.thy.comb$time_to_thyroid, dat.thy.comb$thyroid_yn) ~ dat.thy.comb$baseline_tpo_thy,
                      data=dat.thy.comb)

plot(km_fit_thy.comb,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",
     main="By TPO/Thyroglobulin at Baseline",lwd=3,ylim=c(0,1),col=brewer.pal(4,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",levels(dat.thy.comb$baseline_tpo_thy),col=brewer.pal(4,"Set1"),
       bty="n",lwd=c(3,3),cex=1.5)

logrank<-coxph(Surv(dat.thy.comb$time_to_thyroid, dat.thy.comb$thyroid_yn) ~ dat.thy.comb$baseline_tpo_thy, 
               data=dat.thy.comb)
# logrank_sum<-summary(logrank)
# text(2.3,.9,paste0("p<0.0001"),cex=1.5)


#########CELIAC TIME-TO-EVENT#############
###time to celiac:
dat.cel<-subset(dat,!(dat$celiac_timing %in% c("At Diabetes Onset",
                                                "Before Diabetes Onset")))

dat.cel$time_to_celiac<-as.numeric(dat.cel$time_to_celiac)
dat.cel$celiac_yn<-as.numeric(dat.cel$celiac_yn)
dat.cel<-dat.cel[order(dat.cel$time_to_celiac),]
km_fit <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ 1, data=dat.cel)

summary(km_fit)
plot(km_fit,xlab="Years from Diabetes Onset",ylab="Percent Celiac Disease-Free",
     main="Time-to-Celiac Disease",lwd=3,ylim=c(0.8,1),cex.axis=1.5,cex.main=1.5,cex.lab=1.5)

# BY GENDER
par(mfrow=c(1,3))
km_fit_2 <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$Gender, data=dat.cel)

summary(km_fit_2)
plot(km_fit_2,xlab="Years from Diabetes Onset",ylab="Percent celiac Disease-Free",
     main="By Gender",lwd=3,ylim=c(0.8,1),col=brewer.pal(3,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",levels(dat$Gender),col=brewer.pal(3,"Set1"),
       bty="n",lwd=c(3,3),cex=1.5)

logrank<-coxph(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$Gender, data=dat.cel)
logrank_sum<-summary(logrank)
text(2,.9,paste0("p=",round(logrank_sum$coefficients[1,5],3)),cex=1.5)

# BY RACE/ETHNICITY
km_fit_3 <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$RaceEthinicity_cat, data=dat.cel)

summary(km_fit_3)
plot(km_fit_3,xlab="Years from Diabetes Onset",ylab="Percent celiac Disease-Free",
     main="By Race/Ethnicity",lwd=3,ylim=c(0.8,1),
     col=brewer.pal(5,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",levels(dat$RaceEthinicity_cat),
       col=brewer.pal(5,"Set1"),bty="n",lwd=c(3,3),cex=1.2)

logrank<-coxph(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$RaceEthinicity_cat, data=dat.cel)
logrank_sum<-summary(logrank)
text(3,.885,paste0("p=",
                  round(logrank_sum$coefficients[2,5],4)),cex=1.5)
text(3,.9,"Hispanic vs. White",cex=1.5)

# BY MEDIAN AGE
median_age<-median(dat.cel$Age_At_diabetes_DX)
dat.cel$age_cat<-"<10.1 years at diabetes dx"
dat.cel$age_cat[dat.cel$Age_At_diabetes_DX>=median_age]<-">=10.1 years at diabetes dx"
dat.cel$age_cat<-as.factor(dat.cel$age_cat)
label(dat.cel$age_cat)<-"Age, categorized by median"
km_fit_4 <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$age_cat, data=dat.cel)

summary(km_fit_4)
plot(km_fit_4,xlab="Years from Diabetes Onset",ylab="Percent celiac Disease-Free",
     main="By Median Age",lwd=3,ylim=c(0.8,1),
     col=brewer.pal(3,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",c("<10.1 yrs",">=10.1 yrs"),col=brewer.pal(3,"Set1"),
       bty="n",lwd=c(3,3),cex=1.5)

logrank<-coxph(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$age_cat, data=dat.cel)
logrank_sum<-summary(logrank)
text(2.5,.9,paste0("p=",round(logrank_sum$coefficients[1,5],4)),cex=1.5)


###CELIAC BY LAB POS/NEG AT BASELINE:
#par(mfrow=c(1,3))
dat.cel$baseline_ttg<-as.factor(dat.cel$baseline_ttg)
dat.cel.ttg<-subset(dat.cel,dat.cel$baseline_ttg %in% c("POS","NEG"))
km_fit_ttg <- survfit(Surv(dat.cel.ttg$time_to_celiac, dat.cel.ttg$celiac_yn) ~ dat.cel.ttg$baseline_ttg,
                      data=dat.cel.ttg)
summary(km_fit_ttg)
plot(km_fit_ttg,xlab="Years from Diabetes Onset",ylab="Percent Celiac Disease-Free",
     main="By TTG at Baseline",lwd=3,ylim=c(0,1),col=brewer.pal(3,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",c("NEG","POS"),col=brewer.pal(3,"Set1"),
       bty="n",lwd=c(3,3),cex=1.5)

logrank<-coxph(Surv(dat.cel.ttg$time_to_celiac, dat.cel.ttg$celiac_yn) ~ dat.cel.ttg$baseline_ttg,
               data=dat.cel.ttg)
logrank_sum<-summary(logrank)
text(2.3,.9,paste0("p<0.0001"),cex=1.5)

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

dat.add$baseline_21<-as.factor(dat.add$baseline_21)
dat.add.21<-subset(dat.add,dat.add$baseline_21 %in% c("POS","NEG"))
km_fit_21 <- survfit(Surv(dat.add.21$time_to_addison, dat.add.21$addison_yn) ~ dat.add.21$baseline_21,
                      data=dat.add.21)
summary(km_fit_21)
plot(km_fit_21,xlab="Years from Diabetes Onset",ylab="Percent Addison Disease-Free",
     main="By 21-OH at Baseline",lwd=3,ylim=c(0.5,1),col=brewer.pal(3,"Set1"),cex.main=1.5,
     cex.axis=1.5,cex.lab=1.5)

legend("bottomleft",c("NEG","POS"),col=brewer.pal(3,"Set1"),
       bty="n",lwd=c(3,3),cex=1.5)

logrank<-coxph(Surv(dat.add.21$time_to_addison, dat.add.21$addison_yn) ~ dat.add.21$baseline_21,
               data=dat.add.21)
logrank_sum<-summary(logrank)
text(2.3,.9,paste0("p<0.0001"),cex=1.5)

# # BY GENDER
# km_fit_2 <- survfit(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$Gender, data=dat.add)
# 
# summary(km_fit_2)
# plot(km_fit_2,xlab="Years from Diabetes Onset",ylab="Percent addison Disease-Free",
#      main="Time-to-addison Disease by Gender",lwd=2,ylim=c(0.8,1),col=c(1,2))
# 
# legend("bottomleft",levels(dat$Gender),col=c(1,2),bty="n",lwd=c(2,2))
# 
# logrank<-coxph(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$Gender, data=dat.add)
# logrank_sum<-summary(logrank)
# text(2,.85,paste0("Female Vs. Male p=",round(logrank_sum$coefficients[1,5],4)))
# 
# # BY RACE/ETHNICITY
# km_fit_3 <- survfit(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$RaceEthinicity_cat, data=dat.add)
# 
# summary(km_fit_3)
# plot(km_fit_3,xlab="Years from Diabetes Onset",ylab="Percent addison Disease-Free",
#      main="Time-to-addison Disease by Race/Ethnicity",lwd=2,ylim=c(0.8,1),col=c(1:5))
# 
# legend("bottomleft",levels(dat$RaceEthinicity_cat),col=c(1:5),bty="n",lwd=c(2,2))
# 
# # logrank<-coxph(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$RaceEthinicity_cat, data=dat.add)
# # logrank_sum<-summary(logrank)
# # text(6,.83,paste0("Hispanic vs. Non-Hispanic White p=",round(logrank_sum$coefficients[2,5],4)))
# 
# # BY MEDIAN AGE
# median_age<-median(dat.add$Age_At_diabetes_DX)
# dat.add$age_cat<-"<10.1 years at diabetes dx"
# dat.add$age_cat[dat.add$Age_At_diabetes_DX>=median_age]<-">=10.1 years at diabetes dx"
# dat.add$age_cat<-as.factor(dat.add$age_cat)
# label(dat.add$age_cat)<-"Age, categorized by median"
# km_fit_4 <- survfit(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$age_cat, data=dat.add)
# 
# summary(km_fit_4)
# plot(km_fit_4,xlab="Years from Diabetes Onset",ylab="Percent addison Disease-Free",
#      main="Time-to-addison Disease by Median Age",lwd=2,ylim=c(0.8,1),col=c(1:2))
# 
# legend("bottomleft",levels(dat.add$age_cat),col=c(1:2),bty="n",lwd=c(2,2))
# 
# logrank<-coxph(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ dat.add$age_cat, data=dat.add)
# logrank_sum<-summary(logrank)
# text(3,.85,paste0("Younger vs. Older Group p=",round(logrank_sum$coefficients[1,5],4)))
