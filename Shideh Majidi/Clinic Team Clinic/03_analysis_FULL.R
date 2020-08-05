####CTC Simple Analysis####
library(nlme)
library(afex)
require(lsmeans)

###Aim 1a: Control group only
####SIMPLE: Change from pre to post as outcome:

dat.c<-subset(dat.one,dat.one$group=="Control")

lm_1a<-lm(dat.c$avg_a1c_change~dat.c$avg_a1c_pre+dat.c$RTC_visits_cat_2+dat.c$DurationOfDiabetes_eachvisit+
            dat.c$Gender+dat.c$insurance_2+dat.c$Race.Ethnicity_2)
summary(lm_1a)
##plot(lm_1a)
lm_1a_tab<-fx_model_linear('avg_a1c_change',c('avg_a1c_pre','RTC_visits_cat_2','DurationOfDiabetes_eachvisit',
                                              'Gender','insurance_2','Race.Ethnicity_2'),data=dat.c)
lm_1a_tab$Variable<-c("Average A1c in RTC Period","4+ RTC Visits","Duration of Diabetes at First RTC","Female","Insurance - Public (vs. Private/Military)",
                      "Race/Ethnicity - White (vs. others)")

####LMM APPROACH:
dat.c.all<-subset(dat,dat$group=="Control" & !is.na(dat$A1C_Value))

lmm_1a<-lme(A1C_Value~days_from_first_visit+RTC_visits_cat_2+Gender+insurance_2+Race.Ethnicity_2+time_period
            ,random=~1|MRN/days_from_first_visit,data=dat.c.all)
lmm_1a_sum<-summary(lmm_1a)
lmm_1a_sum<-lmm_1a_sum$tTable[,c(1,2,5)]
lmm_1a_sum<-as.data.frame(lmm_1a_sum)
lmm_1a_sum$Value<-round(lmm_1a_sum$Value,3)
lmm_1a_sum$Std.Error<-round(lmm_1a_sum$Std.Error,3)
lmm_1a_sum$`p-value`<-round(lmm_1a_sum$`p-value`,3)

###Aim 1b: CTC group only
####SIMPLE: Change from pre to post as outcome:

dat.ctc<-subset(dat.one,dat.one$group=="CTC")
lm_1b<-lm(dat.ctc$avg_a1c_change~dat.ctc$avg_a1c_pre+dat.ctc$RTC_visits_cat_2)
lm_1b_tab<-fx_model_linear('avg_a1c_change',c('avg_a1c_pre','RTC_visits_cat_2'),data=dat.ctc)
lm_1b_tab$Variable<-c("Average A1c in RTC Period","4+ RTC Visits")

####LMM APPROACH:
dat.ctc.all<-subset(dat,dat$group=="CTC"  & !is.na(dat$A1C_Value))

lmm_1b<-lme(A1C_Value~days_from_first_visit+RTC_visits_cat_2+time_period
            ,random=~1|MRN/days_from_first_visit,data=dat.c.all)
lmm_1b_sum<-summary(lmm_1b)
lmm_1b_sum<-lmm_1b_sum$tTable[,c(1,2,5)]
lmm_1b_sum<-as.data.frame(lmm_1b_sum)
lmm_1b_sum$Value<-round(lmm_1b_sum$Value,3)
lmm_1b_sum$Std.Error<-round(lmm_1b_sum$Std.Error,3)
lmm_1b_sum$`p-value`<-round(lmm_1b_sum$`p-value`,3)

####Aim 2: CTC versus Control group: 
lm_2<-lm(dat.one$avg_a1c_change~dat.one$avg_a1c_pre+dat.one$RTC_visits_cat_2+dat.one$group
         #+dat.one$DurationOfDiabetes_eachvisit+dat.one$Gender+dat.one$insurance_2+dat.one$Race.Ethnicity_2+dat.one$group
)
summary(lm_2)

lm_2_tab<-fx_model_linear('avg_a1c_change',c('avg_a1c_pre','RTC_visits_cat_2','group'),data=dat.one)
lm_2_tab$Variable<-c("Average A1c in RTC Period","4+ RTC Visits","CTC Group")

#Linear mixed model of slope of A1c in post period, by group:
dat.post<-subset(dat,dat$time_period!="During RTC")

dat.post<-subset(dat.post,!is.na(dat.post$A1C_Value))

lmm_2<-lme(A1C_Value~days_from_first_visit+RTC_visits_cat_2+group
           ,random=~1|MRN/days_from_first_visit,data=dat.post)
lmm_2_sum<-summary(lmm_2)
lmm_2_sum<-lmm_2_sum$tTable[,c(1,2,5)]
lmm_2_sum<-as.data.frame(lmm_2_sum)
lmm_2_sum$Value<-round(lmm_2_sum$Value,3)
lmm_2_sum$Std.Error<-round(lmm_2_sum$Std.Error,3)
lmm_2_sum$`p-value`<-round(lmm_2_sum$`p-value`,3)


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