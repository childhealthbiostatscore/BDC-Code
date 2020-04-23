#####SurvivalAnalysis#####
library(survival)
library(RColorBrewer)
library(jskm)
library(gridExtra)
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Kimber Simmons/CAID/data_prep.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Kimber Simmons/CAID/labs.R')

options(scipen=999)
options(max.print=1000000)
dat$hispanic_yn<-as.factor(dat$hispanic_yn)
dat$Age_At_diabetes_DX<-as.numeric(dat$Age_At_diabetes_DX)
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

any_age<-coxph(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$Age_At_diabetes_DX, 
                data=dat.any)
summary(any_age)

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

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/any_hisp.jpeg",
     height=6,width=6,units='in',res=300)
any_hisp <- survfit(Surv(dat.any$time_to_any, dat.any$any_caid) ~ dat.any$hispanic_yn, data=dat.any)

any_age_plot<-jskm(any_hisp,xlab="Years from Diabetes Onset",ylab="Percent CAID-Free",table=T,
                   main="Any CAID, by Hispanic/Non-Hispanic",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=levels(dat.any$hispanic_yn),pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 
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


thy_age<-coxph(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$Age_At_diabetes_DX, 
               data=dat.thy)
summary(thy_age)
exp(confint(thy_age))
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

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/thy_hisp.jpeg",
     height=6,width=6,units='in',res=300)
thy_hisp <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$hispanic_yn, data=dat.thy)

thy_age_plot<-jskm(thy_hisp,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
                   main="Thyroid Disease, by Hispanic/Non-Hispanic",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=levels(dat.thy$hispanic_yn),pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 
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

#thyroid by GADA and age 5 years:
# dat.thy$age_5_GADA<-NA
# dat.thy$age_5_GADA[dat.thy$Age_At_diabetes_DX<=5 & dat.thy$GADA_pos_neg=="POS"]<-"GADA+ and <=5 yrs"
# dat.thy$age_5_GADA[dat.thy$Age_At_diabetes_DX>5 & dat.thy$GADA_pos_neg=="POS"]<-"GADA+ and >5 yrs"
# dat.thy$age_5_GADA[dat.thy$Age_At_diabetes_DX<=5 & dat.thy$GADA_pos_neg=="NEG"]<-"GADA- and <=5 yrs"
# dat.thy$age_5_GADA[dat.thy$Age_At_diabetes_DX>5 & dat.thy$GADA_pos_neg=="NEG"]<-"GADA- and >5 yrs"
# dat.thy$age_5_GADA<-as.factor(dat.thy$age_5_GADA)
thy_gada <- survfit(Surv(dat.thy$time_to_thyroid, dat.thy$thyroid_yn) ~ dat.thy$GADA_pos_neg,
                    data=dat.thy)
dat.thy.5<-subset(dat.thy,dat.thy$Age_At_diabetes_DX<=5)
thy_gada_age <- survfit(Surv(dat.thy.5$time_to_thyroid, dat.thy.5$thyroid_yn) ~ dat.thy.5$GADA_pos_neg,
                    data=dat.thy.5)
dat.thy.over5<-subset(dat.thy,dat.thy$Age_At_diabetes_DX>5)

thy_gada_overage <- survfit(Surv(dat.thy.over5$time_to_thyroid, dat.thy.over5$thyroid_yn) ~ dat.thy.over5$GADA_pos_neg,
                        data=dat.thy.over5)

thy_gada_plot<-jskm(thy_gada,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
                    main="Thyroid Disease, by GADA",ylim=c(0.6,1),marks=F,
                    linecols = 'Set1',ci=T,
                    ystratalabs=c("GADA - neg","GADA - pos"),pval=T,
                    legendposition = c(0.85,0.2),ystrataname = "") 
thy_gada_age_plot<-jskm(thy_gada_age,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
                    main="<=5 Years at Onset",ylim=c(0.6,1),marks=F,
                    linecols = 'Set2',ci=T,
                    ystratalabs=c("GADA - neg","GADA - pos"),pval=T,
                    legendposition = c(0.85,0.2),ystrataname = "") 
thy_gada_overage_plot<-jskm(thy_gada_overage,xlab="Years from Diabetes Onset",ylab="Percent Thyroid Disease-Free",table=T,
                        main=">5 Years at Onset",ylim=c(0.6,1),marks=F,
                        linecols = 'Set2',ci=T,
                        ystratalabs=c("GADA - neg","GADA - pos"),pval=T,
                        legendposition = c(0.85,0.2),ystrataname = "") 

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/thy_gada.jpeg",
     height=6,width=12,units='in',res=300)
grid.arrange(thy_gada_plot, thy_gada_age_plot, thy_gada_overage_plot, ncol = 3)
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

cel_age<-coxph(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$Age_At_diabetes_DX, 
               data=dat.cel)
summary(cel_age)
exp(confint(cel_age))

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

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/cel_hisp.jpeg",
     height=6,width=6,units='in',res=300)
cel_hisp <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$hispanic_yn, data=dat.cel)

cel_age_plot<-jskm(cel_hisp,xlab="Years from Diabetes Onset",ylab="Percent Celiac-Free",table=T,
                   main="Celiac Disease, by Hispanic/Non-Hispanic",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=levels(dat.cel$hispanic_yn),pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 
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

dat.cel$tot_pos_ttg<-as.factor(dat.cel$tot_pos_ttg)
dat.cel$tot_neg_ttg<-as.factor(dat.cel$tot_neg_ttg)
dat.cel$length_testing_years<-dat.cel$length_testing/365
label(dat.cel$length_testing_years)<-"Years of testing"
tab.celiac.repeat<-final_table(dat.cel,c('num_ttg','length_testing_years','avg_testing',
                                     'tot_pos_ttg','tot_neg_inarow'),
                               dat.cel$EPICMRN,margin=2,single=F,2,col.names=T, summary.stat='median')
tab.celiac.repeat


cel_ttg.repeat_neg <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$tot_neg_2,
                   data=dat.cel)
summary(cel_ttg.repeat_neg)
summary(cel_ttg.repeat_neg,time=7)

# cel_ttg.repeat_neg.test<-coxph(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$tot_neg_2, 
#                 data=dat.cel)
# summary(cel_ttg.repeat_neg.test)

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/cel_repeated.jpeg",
     height=6,width=6,units='in',res=300)
cel_ttg_plot<-jskm(cel_ttg.repeat_neg,xlab="Years from Diabetes Onset",ylab="Percent Celiac Disease-Free",table=T,
                   main="Celiac Disease, by Number of Negative TTG",ylim=c(0,1),marks=F,
                   ystratalabs=c("0 Negative","1 Negative","2 Negative","3+ Negative"),
                   linecols = 'Set1',ci=T,pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 
dev.off()

#by age and total negatives in a row:
dat.cel$tot_neg_age<-NA
dat.cel$tot_neg_age[as.numeric(as.character(dat.cel$tot_neg_inarow))>=2
                    & dat.cel$age_cat=="<10.1"]<-"2+ neg & <10.1"
dat.cel$tot_neg_age[as.numeric(as.character(dat.cel$tot_neg_inarow))>=2
                    & dat.cel$age_cat==">=10.1"]<-"2+ neg & >10.1"
dat.cel$tot_neg_age[as.numeric(as.character(dat.cel$tot_neg_inarow))<2
                    & dat.cel$age_cat=="<10.1"]<-"<2 neg & <10.1"
dat.cel$tot_neg_age[as.numeric(as.character(dat.cel$tot_neg_inarow))<2
                    & dat.cel$age_cat==">=10.1"]<-"<2 neg & >10.1"
dat.cel$tot_neg_age<-as.factor(dat.cel$tot_neg_age)
cel_ttg.repeat_age <- survfit(Surv(dat.cel$time_to_celiac, dat.cel$celiac_yn) ~ dat.cel$tot_neg_age,
                              data=dat.cel)
summary(cel_ttg.repeat_neg,time=7)

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/cel_repeated_age.jpeg",
     height=6,width=6,units='in',res=300)
cel_ttg_plot<-jskm(cel_ttg.repeat_age,xlab="Years from Diabetes Onset",ylab="Percent Celiac Disease-Free",table=T,
                   main="Celiac Disease, by Number of Negative TTG",ylim=c(0,1),marks=F,
                   ystratalabs=c("<2 neg & <10.1 yr","<2 neg & >10.1 yr",
                                 "2+ neg & <10.1 yr","2+ neg & >10.1 yr"),
                   linecols = 'Set1',ci=T,pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 
dev.off()

#look only at TTG- and Celiac+:
cel.sub<-subset(dat.cel,dat.cel$celiac_yn==2 & dat.cel$baseline_ttg=="NEG")
quantile(cel.sub$time_to_celiac)

###TTG and age:
dat.cel.4<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=4)
cel_ttg.4 <- survfit(Surv(dat.cel.4$time_to_celiac, dat.cel.4$celiac_yn) ~ dat.cel.4$baseline_ttg,
                     data=dat.cel.4)
dat.cel.5<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=5)
cel_ttg.5 <- survfit(Surv(dat.cel.5$time_to_celiac, dat.cel.5$celiac_yn) ~ dat.cel.5$baseline_ttg,
                     data=dat.cel.5)
dat.cel.6<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=6)
cel_ttg.6 <- survfit(Surv(dat.cel.6$time_to_celiac, dat.cel.6$celiac_yn) ~ dat.cel.6$baseline_ttg,
                     data=dat.cel.6)
dat.cel.7<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=7)
cel_ttg.7 <- survfit(Surv(dat.cel.7$time_to_celiac, dat.cel.7$celiac_yn) ~ dat.cel.7$baseline_ttg,
                     data=dat.cel.7)
dat.cel.8<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=8)
cel_ttg.8 <- survfit(Surv(dat.cel.8$time_to_celiac, dat.cel.8$celiac_yn) ~ dat.cel.8$baseline_ttg,
                     data=dat.cel.8)
dat.cel.9<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=9)
cel_ttg.9 <- survfit(Surv(dat.cel.9$time_to_celiac, dat.cel.9$celiac_yn) ~ dat.cel.9$baseline_ttg,
                     data=dat.cel.9)
dat.cel.10<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=10)
cel_ttg.10 <- survfit(Surv(dat.cel.10$time_to_celiac, dat.cel.10$celiac_yn) ~ dat.cel.10$baseline_ttg,
                     data=dat.cel.10)
dat.cel.11<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=11)
cel_ttg.11 <- survfit(Surv(dat.cel.11$time_to_celiac, dat.cel.11$celiac_yn) ~ dat.cel.11$baseline_ttg,
                      data=dat.cel.11)
dat.cel.12<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=12)
cel_ttg.12 <- survfit(Surv(dat.cel.12$time_to_celiac, dat.cel.12$celiac_yn) ~ dat.cel.12$baseline_ttg,
                      data=dat.cel.12)
dat.cel.13<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=13)
cel_ttg.13 <- survfit(Surv(dat.cel.13$time_to_celiac, dat.cel.13$celiac_yn) ~ dat.cel.13$baseline_ttg,
                      data=dat.cel.13)
dat.cel.14<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=14)
cel_ttg.14 <- survfit(Surv(dat.cel.14$time_to_celiac, dat.cel.14$celiac_yn) ~ dat.cel.14$baseline_ttg,
                      data=dat.cel.14)
dat.cel.15<-subset(dat.cel.ttg,dat.cel.ttg$Age_At_diabetes_DX>=15)
cel_ttg.15 <- survfit(Surv(dat.cel.15$time_to_celiac, dat.cel.15$celiac_yn) ~ dat.cel.15$baseline_ttg,
                      data=dat.cel.15)
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
