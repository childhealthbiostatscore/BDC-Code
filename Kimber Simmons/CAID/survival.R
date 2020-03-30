#####SurvivalAnalysis#####
library(survival)
library(RColorBrewer)
library(jskm)
library(gridExtra)
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Kimber Simmons/CAID/data_prep.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Kimber Simmons/CAID/labs.R')

options(scipen=999)
options(max.print=1000000)
#########ANY CAID TIME-TO-EVENT#############
dat.any<-subset(dat,!is.na(dat$time_to_any))

dat.any$time_to_any<-as.numeric(dat.any$time_to_any)/12
dat.any$any_caid<-as.numeric(dat.any$any_caid)
dat.any<-dat.any[order(dat.any$any_caid),]
median_age<-median(dat.any$Age_At_diabetes_DX)
dat.any$age_cat<-"<10.1"
dat.any$age_cat[dat.any$Age_At_diabetes_DX>=median_age]<-">=10.1"
dat.any$age_cat<-as.factor(dat.any$age_cat)
label(dat.any$age_cat)<-"Age, categorized by median"

any <- survfit(Surv(dat.any$time_to_any, dat.any$any_caid) ~ 1, data=dat.any)

summary( any, times=c(2,8))

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/any_overall.jpeg",
     height=6,width=6,units='in',res=300)
jskm(any,xlab="Years from Diabetes Onset",ylab="Percent CAID-Free",table=T,
     main="Time-to-Any CAID",ylim=c(0.6,1),marks=F,linecols = 'black',ci=T,
     legend=F)
dev.off()

# ANY BY BASELINE CHARS
any_gen <- survfit(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$Gender, data=dat.any)
any_gen_plot<-jskm(any_gen,xlab="Years from Diabetes Onset",ylab="Percent CAID-Free",table=T,
             main="Any CAID, by Gender",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
             ystratalabs=levels(dat.any$Gender),pval=T,
             legendposition = c(0.85,0.2))
# BY RACE/ETHNICITY
any_race <- survfit(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$RaceEthinicity_cat, data=dat.any)
any_race_plot<-jskm(any_race,xlab="Years from Diabetes Onset",ylab="Percent CAID-Free",table=T,
             main="Any CAID, by Race/Ethnicity",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
             ystratalabs=levels(dat.any$RaceEthinicity_cat),pval=T,
             legendposition = c(0.85,0.2),ystrataname = "")       
# BY MEDIAN AGE
any_age <- survfit(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$age_cat, data=dat.any)
any_age_plot<-jskm(any_age,xlab="Years from Diabetes Onset",ylab="Percent CAID-Free",table=T,
             main="Any CAID, by Median Age",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
             ystratalabs=levels(dat.any$age_cat),pval=T,
             legendposition = c(0.85,0.2),ystrataname = "") 

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/any_baseline.jpeg",
     height=6,width=12,units='in',res=300)
grid.arrange(any_gen_plot, any_race_plot, any_age_plot, ncol = 3)
dev.off()

#########THYROID TIME-TO-EVENT#############
###time to thyroid:
dat.thy<-subset(dat,!is.na(dat$time_to_thyroid))

dat.thy$time_to_thyroid<-as.numeric(dat.thy$time_to_thyroid)/12
dat.thy$thyroid_yn<-as.numeric(dat.thy$thyroid_yn)
dat.thy<-dat.thy[order(dat.thy$time_to_thyroid),]
thy <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ 1, data=dat.thy)
summary( thy, times=c(2,8))

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/thy_overall.jpeg",
     height=6,width=6,units='in',res=300)
jskm(thy,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
     main="Time-to-Thyroid Disease",ylim=c(0.6,1),marks=F,linecols = 'black',ci=T,
     legend=F)
dev.off()

#time to thyroid by baseline chars:
# ANY BY BASELINE CHARS
thy_gen <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$Gender, data=dat.thy)
thy_gen_plot<-jskm(thy_gen,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
                   main="Thyroid Disease, by Gender",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=levels(dat.thy$Gender),pval=T,
                   legendposition = c(0.85,0.2))
# BY RACE/ETHNICITY
thy_race <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$RaceEthinicity_cat, data=dat.thy)
thy_race_plot<-jskm(thy_race,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
                    main="Thyroid Disease, by Race/Ethnicity",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                    ystratalabs=levels(dat.thy$RaceEthinicity_cat),pval=T,
                    legendposition = c(0.85,0.2),ystrataname = "") 

race_thy<-coxph(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$RaceEthinicity_cat, 
               data=dat.thy)
summary(race_thy)
# logrank_sum<-summary(logrank)

# BY MEDIAN AGE
median_age<-median(dat.thy$Age_At_diabetes_DX)
dat.thy$age_cat<-"<10.1"
dat.thy$age_cat[dat.thy$Age_At_diabetes_DX>=median_age]<-">=10.1"
dat.thy$age_cat<-as.factor(dat.thy$age_cat)
label(dat.thy$age_cat)<-"Age, categorized by median"
thy_age <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$age_cat, data=dat.thy)
thy_age_plot<-jskm(thy_age,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
                   main="Thyroid Disease, by Median Age",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=levels(dat.thy$age_cat),pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/thy_baseline.jpeg",
     height=6,width=12,units='in',res=300)
grid.arrange(thy_gen_plot, thy_race_plot, thy_age_plot, ncol = 3)
dev.off()


###THRYOID BY LAB POS/NEG AT BASELINE:

dat.thy$baseline_tpo<-as.factor(dat.thy$baseline_tpo)
dat.thy.tpo<-subset(dat.thy,dat.thy$baseline_tpo %in% c("POS","NEG"))
thy_tpo <- survfit(Surv(dat.thy.tpo$time_to_thyroid, dat.thy.tpo$thyroid_yn) ~ dat.thy.tpo$baseline_tpo,
                      data=dat.thy.tpo)
thy_tpo_plot<-jskm(thy_tpo,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
                   main="Thyroid Disease, by TPO",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=c("NEG","POS"),pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 

table(dat.thy.tpo$baseline_tpo,dat.thy.tpo$thyroid_yn)
summary( thy_tpo, times=c(2,8))


dat.thy$baseline_thy<-as.factor(dat.thy$baseline_thy)
dat.thy.thy<-subset(dat.thy,dat.thy$baseline_thy %in% c("POS","NEG"))
thy_thy <- survfit(Surv(dat.thy.thy$time_to_thyroid, dat.thy.thy$thyroid_yn) ~ dat.thy.thy$baseline_thy,
                      data=dat.thy.thy)
summary(thy_thy)
thy_thy_plot<-jskm(thy_thy,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
                   main="Thyroid Disease, by Thyroglobulin",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=c("NEG","POS"),pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 
#combined:
dat.thy$baseline_tpo_thy<-NA
dat.thy$baseline_tpo_thy[dat.thy$baseline_tpo=="NEG" & dat.thy$baseline_thy=="NEG"]<-"Both NEG"
dat.thy$baseline_tpo_thy[dat.thy$baseline_tpo=="POS" & dat.thy$baseline_thy=="POS"]<-"Both POS"
dat.thy$baseline_tpo_thy[dat.thy$baseline_tpo=="NEG" & dat.thy$baseline_thy=="POS"]<-"TPO NEG, Thy POS"
dat.thy$baseline_tpo_thy[dat.thy$baseline_tpo=="POS" & dat.thy$baseline_thy=="NEG"]<-"TPO POS, Thy NEG"

dat.thy.comb<-subset(dat.thy,!is.na(dat.thy$baseline_tpo_thy))
dat.thy.comb$baseline_tpo_thy<-as.factor(dat.thy.comb$baseline_tpo_thy)

thy_comb <- survfit(Surv(dat.thy.comb$time_to_thyroid, dat.thy.comb$thyroid_yn) ~ dat.thy.comb$baseline_tpo_thy,
                      data=dat.thy.comb)
thy_comb_plot<-jskm(thy_comb,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
                   main="Thyroid Disease, by both",ylim=c(0.6,1),marks=F,
                   linecols = 'Set1',ci=T,
                   ystratalabs=c("Both NEG","Both POS","TPO NEG, Thy POS","TPO POS, Thy NEG"),pval=F,
                   legendposition = c(0.85,0.2),ystrataname = "") 

comb_thy<-coxph(Surv(dat.thy.comb$time_to_thyroid, dat.thy.comb$thyroid_yn) ~ dat.thy.comb$baseline_tpo_thy,
                data=dat.thy.comb)
summary(comb_thy)
anova(comb_thy)
table(dat.thy.comb$baseline_tpo_thy,dat.thy.comb$thyroid_yn)

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/thy_labs.jpeg",
     height=6,width=12,units='in',res=300)
grid.arrange(thy_tpo_plot, thy_thy_plot, thy_comb_plot, ncol = 3)
dev.off()

#########CELIAC TIME-TO-EVENT#############
###time to celiac:
dat.cel<-subset(dat,!(dat$celiac_timing %in% c("At Diabetes Onset",
                                                "Before Diabetes Onset")))

dat.cel$time_to_celiac<-as.numeric(dat.cel$time_to_celiac)/12
dat.cel$celiac_yn<-as.numeric(dat.cel$celiac_yn)
dat.cel<-dat.cel[order(dat.cel$time_to_celiac),]
cel <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ 1, data=dat.cel)
summary( cel, times=c(2,8))

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/cel_overall.jpeg",
     height=6,width=6,units='in',res=300)
jskm(cel,xlab="Years from Diabetes Onset",ylab="Percent Celiac Disease-Free",table=T,
     main="Time-to-Celiac Disease",ylim=c(0.6,1),marks=F,linecols = 'black',ci=T,
     legend=F)
dev.off()
#time to thyroid by baseline chars:
# ANY BY BASELINE CHARS
cel_gen <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$Gender, data=dat.cel)
cel_gen_plot<-jskm(cel_gen,xlab="Years from Diabetes Onset",ylab="Percent celroid Disease-Free",table=T,
                   main="Celiac Disease, by Gender",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=levels(dat.cel$Gender),pval=T,
                   legendposition = c(0.85,0.2))
# BY RACE/ETHNICITY
cel_race <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$RaceEthinicity_cat, data=dat.cel)
cel_race_plot<-jskm(cel_race,xlab="Years from Diabetes Onset",ylab="Percent celroid Disease-Free",table=T,
                    main="Celiac Disease, by Race/Ethnicity",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                    ystratalabs=levels(dat.cel$RaceEthinicity_cat),pval=T,
                    legendposition = c(0.85,0.2),ystrataname = "")       
# BY MEDIAN AGE
median_age<-median(dat.cel$Age_At_diabetes_DX)
dat.cel$age_cat<-"<10.1"
dat.cel$age_cat[dat.cel$Age_At_diabetes_DX>=median_age]<-">=10.1"
dat.cel$age_cat<-as.factor(dat.cel$age_cat)
label(dat.cel$age_cat)<-"Age, categorized by median"
cel_age <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$age_cat, data=dat.cel)
cel_age_plot<-jskm(cel_age,xlab="Years from Diabetes Onset",ylab="Percent celroid Disease-Free",table=T,
                   main="Celiac Disease, by Median Age",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=levels(dat.cel$age_cat),pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/cel_baseline.jpeg",
     height=6,width=12,units='in',res=300)
grid.arrange(cel_gen_plot, cel_race_plot, cel_age_plot, ncol = 3)
dev.off()

###CELIAC BY LAB POS/NEG AT BASELINE:
#par(mfrow=c(1,3))
dat.cel$baseline_ttg<-as.factor(dat.cel$baseline_ttg)
dat.cel.ttg<-subset(dat.cel,dat.cel$baseline_ttg %in% c("POS","NEG"))

cel_ttg <- survfit(Surv(dat.cel.ttg$time_to_celiac, dat.cel.ttg$celiac_yn) ~ dat.cel.ttg$baseline_ttg,
                      data=dat.cel.ttg)
summary(cel_ttg,time=3)
table(dat.cel.ttg$baseline_ttg, dat.cel.ttg$celiac_yn)
jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/cel_labs.jpeg",
     height=6,width=6,units='in',res=300)

cel_ttg_plot<-jskm(cel_ttg,xlab="Years from Diabetes Onset",ylab="Percent Celiac Disease-Free",table=T,
                   main="Celiac Disease, by Baseline TTG",ylim=c(0,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=c("NEG","POS"),pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 

dev.off()

###repeated TTG testing:
dat.cel$tot_neg_2<-NA
dat.cel$tot_neg_2[as.numeric(as.character(dat.cel$tot_neg_inarow))>2]<-"3+ negative tests"
dat.cel$tot_neg_2[as.numeric(as.character(dat.cel$tot_neg_inarow))==2]<-"2 negative tests"
dat.cel$tot_neg_2[as.numeric(as.character(dat.cel$tot_neg_inarow))==1]<-"1 negative tests"
dat.cel$tot_neg_2[as.numeric(as.character(dat.cel$tot_neg_inarow))==0]<-"0 negative tests"

cel_ttg.repeat_neg <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$tot_neg_2,
                   data=dat.cel)
summary(cel_ttg.repeat_neg,time=7)

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/cel_repeated.jpeg",
     height=6,width=6,units='in',res=300)
cel_ttg_plot<-jskm(cel_ttg.repeat_neg,xlab="Years from Diabetes Onset",ylab="Percent Celiac Disease-Free",table=T,
                   main="Celiac Disease, by Number of Negative TTG",ylim=c(0,1),marks=F,
                   ystratalabs=c("0 Negative","1 Negative","2 Negative","3+ Negative"),
                   linecols = 'Set1',ci=T,pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 
dev.off()


# #########ADDISON TIME-TO-EVENT#############
# ###time to addison:
# dat.add<-subset(dat,!(dat$addison_timing %in% c("At Diabetes Onset",
#                                                "Before Diabetes Onset")))
# 
# dat.add$time_to_addison<-as.numeric(dat.add$time_to_addison)
# dat.add$addison_yn<-as.numeric(dat.add$addison_yn)
# dat.add<-dat.add[order(dat.add$time_to_addison),]
# km_fit <- survfit(Surv(dat.add$time_to_addison, dat.add$addison_yn) ~ 1, data=dat.add)
# 
# summary(km_fit)
# plot(km_fit,xlab="Years from Diabetes Onset",ylab="Percent addison Disease-Free",
#      main="Time-to-addison Disease",lwd=2,ylim=c(0.8,1))
# 
# dat.add$baseline_21<-as.factor(dat.add$baseline_21)
# dat.add.21<-subset(dat.add,dat.add$baseline_21 %in% c("POS","NEG"))
# km_fit_21 <- survfit(Surv(dat.add.21$time_to_addison, dat.add.21$addison_yn) ~ dat.add.21$baseline_21,
#                       data=dat.add.21)
# summary(km_fit_21)
# plot(km_fit_21,xlab="Years from Diabetes Onset",ylab="Percent Addison Disease-Free",
#      main="By 21-OH at Baseline",lwd=3,ylim=c(0.5,1),col=brewer.pal(3,"Set1"),cex.main=1.5,
#      cex.axis=1.5,cex.lab=1.5)
# 
# legend("bottomleft",c("NEG","POS"),col=brewer.pal(3,"Set1"),
#        bty="n",lwd=c(3,3),cex=1.5)
# 
# logrank<-coxph(Surv(dat.add.21$time_to_addison, dat.add.21$addison_yn) ~ dat.add.21$baseline_21,
#                data=dat.add.21)
# logrank_sum<-summary(logrank)
# text(2.3,.9,paste0("p<0.0001"),cex=1.5)

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
