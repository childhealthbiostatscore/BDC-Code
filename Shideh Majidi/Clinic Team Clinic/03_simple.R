####CTC Simple Analysis####
library(nlme)
library(afex)
require(lsmeans)
dat.one$RTC_visits_cat_2<-NA
dat.one$RTC_visits_cat_2[dat.one$RTC_visits_cat==2]<-2
dat.one$RTC_visits_cat_2[dat.one$RTC_visits_cat==3]<-3
dat.one$RTC_visits_cat_2[dat.one$RTC_visits_cat==4]<-"4+"
dat.one$RTC_visits_cat_2[dat.one$RTC_visits_cat=="5+"]<-"4+"

dat.one$Race.Ethnicity_2<-"White"
dat.one$Race.Ethnicity_2[dat.one$Race.Ethnicity!="White"]<-"Non-White"

dat.one$insurance_2<-"Private"
dat.one$insurance_2[dat.one$InsuranceType_VisitDate!="Private"]<-"Non-Private"

###Aim 1a: Control group only
####SIMPLE: Change from pre to post as outcome:

dat.c<-subset(dat.one,dat.one$group=="Control")


lm_1a<-lm(dat.c$avg_a1c_change~dat.c$avg_a1c_pre+dat.c$RTC_visits_cat_2+dat.c$post_period_visits)
summary(lm_1a)
plot(lm_1a)

lm_1a<-lm(dat.c$avg_a1c_post~dat.c$avg_a1c_pre+dat.c$total_RTC+dat.c$DurationOfDiabetes_eachvisit+
            dat.c$Gender+dat.c$insurance_2+dat.c$Race.Ethnicity_2)
summary(lm_1a)
plot(lm_1a)

###Aim 1b: CTC group only
####SIMPLE: Change from pre to post as outcome:

dat.ctc<-subset(dat.one,dat.one$group=="CTC")

lm_1b<-lm(dat.ctc$avg_a1c_post~dat.ctc$avg_a1c_pre+dat.ctc$total_RTC)
summary(lm_1b)
plot(lm_1b)

lm_1b<-lm(dat.ctc$avg_a1c_change~dat.ctc$avg_a1c_pre+dat.ctc$total_RTC+dat.ctc$DurationOfDiabetes_eachvisit+
            dat.ctc$Gender+dat.ctc$insurance_2+dat.ctc$Race.Ethnicity_2)
summary(lm_1b)
plot(lm_1b)


#####set up for mixed model with changepoint:
changepoint<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$MRN==1409272)
    dat.temp<-dat.temp[order(dat.temp$VisitDate),]
    ##TIME PERIODS:
    dat.temp$post_period<-1
    dat.temp$post_period[dat.temp$time_period=="During RTC"]<-0
    dat.temp$days_from_first_postvisit<-NA
    dat.temp$days_from_first_postvisit[dat.temp$post_period==1]<-difftime(dat.temp$VisitDate[dat.temp$post_period==1],
                                                 dat.temp$first_post_visit_date[1],unit="days")
    
    dat.temp})
  #print(dat.temp$MRN)
  dat<-do.call(rbind,temp)
}
dat<-changepoint(dat$MRN,dat)

dat<-subset(dat,!is.na(dat$A1C_Value))



dat.c.all<-subset(dat,dat$group=="Control")

control_cp<-lme(A1C_Value~post_period+ days_from_first_visit+post_period*days_from_first_visit+total_RTC
                     ,random=~1|MRN/days_from_first_visit,data=dat.c.all)
summary(control_cp)

# data alldata;
# set alldata;
# time_death=intck('days',Date_of_Transplant,Date_of_death); *time of IVUS measurement post-tx;
# time=intck('days',Date_of_Transplant,Date_of_IVUS_measure); *time of IVUS measurement post-tx;

# control=0;
# if Date_of_siro_initiation=. then control=1;
# time_years=time/365;

# time_to_siro_start=.;
# if control=0 then time_to_siro_start = intck('days',Date_of_Transplant,Date_of_siro_initiation);
# if control=1 then time_to_siro_start = intck('days',Date_of_Transplant,Date_of_last_f_u);

# *variables for change point model;
# after_siro=0;
# if Date_of_IVUS_measure>Date_of_siro_initiation then after_siro=1;
# if control=1 then after_siro=0;
# time_siro =.;
# time_siro = Date_of_IVUS_measure - Date_of_siro_initiation; *time of IVUS measurement post-siro;
# if Date_of_siro_initiation=. then time_siro=.;
# *new time since tx;
# time_since_tx=intck('years',Date_of_Transplant,today()); *time of IVUS measurement post-tx;
# run;
# 

# proc mixed data=before_after_NIPPV method=ml covtest;
# title "132 patients, at least 1 EF before or after NIPPV";
# class id after_siro;
# model IVUS_MIT=after_siro time_years after_siro*time_years / residual solution outpm=pred;
# random intercept time_years / type=un sub=iD;
# contrast "Difference in slopes" after_siro*time_years 1 -1 / e;
# estimate "Slopes" after_siro*time_years 1 -1;
# lsmeans after_siro;
# run;
# quit;
