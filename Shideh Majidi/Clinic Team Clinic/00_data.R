###Shideh Majidi: 
#Clinic Team Clinic
library(lubridate)
library(Hmisc)
#READ IN DATA:
setwd("S:/Shared Projects/Laura/BDC/Projects/Shideh Majidi/Clinic team clinic/Data/")
dat<-read.csv("RetrospectiveReview_062220_highlighted_coded_RDV_SMupdated.csv",
              na.strings=c("NULL",""))
#remove empty rows between patients
dat<-subset(dat,!is.na(dat$MRN)) 

dat$Visit.Type<-as.factor(dat$Visit.Type)
levels(dat$Visit.Type)<-c("RTC","CTC","Routine")
dat$VisitDate<-as.POSIXct(dat$VisitDate,format="%m/%d/%Y")

####LONGITUDINAL DATASET PREPARATION####:

#1. REDUCE DATASET TO ONLY PATIENTS WITH >2 RTC VISITS & DELETE VISITS PRE-RTC:
step1<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$MRN==1484180)
    dat.temp<-dat.temp[order(dat.temp$VisitDate),]
    dat.temp$row_num<-rep(1:nrow(dat.temp))
    dat.temp$total_RTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="RTC"))
    dat.temp$row_num_first_RTC<-NA
    if (dat.temp$total_RTC[1]>0){dat.temp$row_num_first_RTC<-min(dat.temp$row_num[dat.temp$Visit.Type=="RTC"])}
    dat.temp})
  
  dat<-do.call(rbind,temp)
}
dat<-step1(dat$MRN,dat)
dat<-subset(dat,dat$total_RTC>=2)
dat<-subset(dat,dat$row_num>=dat$row_num_first_RTC)

#2. MAX FOLLOW-UP FOR THIS STUDY: 18 MONTHS POST LAST RTC:
step2<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$MRN==688048)
    dat.temp<-dat.temp[order(dat.temp$VisitDate),]
    
    dat.temp$row_num<-rep(1:nrow(dat.temp)) #recalculate now that removed rows pre-rtc
    dat.temp$row_num_last_RTC<-NA
    dat.temp$row_num_last_RTC<-max(dat.temp$row_num[dat.temp$Visit.Type=="RTC"])
    dat.temp$date_last_RTC<-dat.temp$VisitDate[dat.temp$row_num_last_RTC==dat.temp$row_num]
    dat.temp$date_last_RTC<-as.POSIXct(dat.temp$date_last_RTC,format="%Y-%m-%d")
    dat.temp$date_max<-dat.temp$date_last_RTC %m+% months(18)
    dat.temp})
  #print(dat.temp$MRN)
  dat<-do.call(rbind,temp)
}
dat<-step2(dat$MRN,dat)

dat$after_18mo<-0
dat$after_18mo[dat$VisitDate>dat$date_max]<-1

dat<-subset(dat,dat$after_18mo==0)

#3. CREATE COHORT MEMBERSHIP AND TIME PERIODS:
step3<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$MRN==1412945)
    dat.temp<-dat.temp[order(dat.temp$VisitDate),]
    #calculate again after removal of 18mo+
    dat.temp$row_num<-rep(1:nrow(dat.temp))
    #number of each visit type:
    dat.temp$total_RTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="RTC"))
    dat.temp$total_CTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="CTC"))
    dat.temp$total_routine<-nrow(subset(dat.temp,dat.temp$Visit.Type=="Routine"))
    #determine CTC rows:
    dat.temp$row_num_first_CTC<-NA
    if (dat.temp$total_CTC[1]>0){dat.temp$row_num_first_CTC<-min(dat.temp$row_num[dat.temp$Visit.Type=="CTC"])}
    dat.temp$row_num_last_CTC<-NA
    if (dat.temp$total_CTC[1]>0){dat.temp$row_num_last_CTC<-max(dat.temp$row_num[dat.temp$Visit.Type=="CTC"])}
    
    dat.temp$time_period<-NA
    dat.temp$time_period[dat.temp$row_num<=dat.temp$row_num_last_RTC[1]]<-"During RTC"
    dat.temp$time_period[dat.temp$row_num>dat.temp$row_num_last_RTC[1]]<-"Post-RTC"
    
    #define CTC study group:
    #must have at least two CTC within 18 months of RTC:
    dat.temp$days_rtc_to_ctc<-NA
    if (dat.temp$total_CTC[1]>0){
      dat.temp$days_rtc_to_ctc<-difftime(dat.temp$VisitDate[dat.temp$row_num_first_CTC==dat.temp$row_num],
                                           dat.temp$VisitDate[dat.temp$row_num_last_RTC==dat.temp$row_num],units='days')
    }
    dat.temp$num_CTC_post_RTC<-0
    if (dat.temp$total_CTC[1]>0){
      dat.temp$num_CTC_post_RTC<-nrow(subset(dat.temp,dat.temp$time_period=="Post-RTC" & dat.temp$Visit.Type=="CTC"))
    }
    dat.temp$group<-NA
    dat.temp$group[dat.temp$num_CTC_post_RTC>=2 & dat.temp$days_rtc_to_ctc<=547.501]<-"CTC"
    
    #define control group:
    #must have at least 1 routine visit after RTC, and not in the CTC group:
    dat.temp$num_routine_post_RTC<-0
    dat.temp$days_rtc_to_routine<-NA
    if (is.na(dat.temp$group[1])){
      dat.temp$num_routine_post_RTC<-nrow(subset(dat.temp,dat.temp$time_period=="Post-RTC"))
      dat.temp$days_rtc_to_routine[dat.temp$time_period=="Post-RTC"]<-difftime(dat.temp$VisitDate[dat.temp$time_period=="Post-RTC"],
                                             dat.temp$VisitDate[dat.temp$row_num_last_RTC==dat.temp$row_num],units='days')
    }
    dat.temp$group[dat.temp$num_routine_post_RTC>0 & is.na(dat.temp$group)]<-"Control"
    #if a CTC within 18 mo, remove from control group:
    dat.temp$group[dat.temp$group=="Control" & dat.temp$days_rtc_to_ctc<=547.501]<-"N/A - CTC within 18 mo but not in CTC group"
    dat.temp})
  
  dat<-do.call(rbind,temp)
}
dat<-step3(dat$MRN,dat)

#4. REMOVE PATIENTS WITHOUT A GROUP - THESE ONLY HAD RTC AND NO FOLLOWUP:
dat<-subset(dat,!is.na(dat$group))
# ####test:
# test<-dat[,which(colnames(dat) %in% c("MRN","VisitDate","Visit.Type","after_1year","date_max"))]
# #5. REMOVE DATA AFTER 1 YEAR POST-RTC for control group: WHAT ABOUT RESEARCH GROUP - need to update this
# dat<-subset(dat,!(dat$after_18mo==1 & dat$group=="Control"))
# 
# step5<-data.frame(mrn=row.names(table(dat$MRN,dat$time_period)),num_post=table(dat$MRN,dat$time_period)[,2])
# step5$num_post<-as.numeric(as.character(step5$num_post))
# num_0<-subset(step5,step5$num_post==0)
# mrns_0<-num_0$mrn
# 
# dat<-subset(dat,!(dat$MRN %in% mrns_0))

#5. REMOVE DATA AFTER CTC FOR RESEARCH GROUP:
dat$after_ctc<-0
dat$after_ctc[dat$group=="CTC" & dat$row_num>dat$row_num_last_CTC]<-1

dat<-subset(dat,dat$after_ctc==0)

#CALCULATE USABLE STATS FOR EACH GROUP:
summary_stats<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$MRN==1409272)
    dat.temp<-dat.temp[order(dat.temp$VisitDate),]
    ##TIME PERIODS:
    dat.temp$research_period_visits<-nrow(subset(dat.temp,dat.temp$time_period=="During RTC"))
    dat.temp$research_period_time<-difftime(max(dat.temp$VisitDate[dat.temp$time_period=="During RTC"]),
                                            min(dat.temp$VisitDate[dat.temp$time_period=="During RTC"]))

    dat.temp$post_period_visits<-nrow(subset(dat.temp,dat.temp$time_period!="During RTC"))
    dat.temp$post_period_time<-difftime(max(dat.temp$VisitDate[dat.temp$time_period!="During RTC"]),
                                        min(dat.temp$VisitDate[dat.temp$time_period!="During RTC"]))
    if (dat.temp$group[1]=="CTC"){
      dat.temp$time_period[dat.temp$row_num>=dat.temp$row_num_first_CTC & dat.temp$row_num<=dat.temp$row_num_last_CTC]<-"CTC"
    }
    #FINAL DATASET VERSION OF THESE VARIABLES:
    dat.temp$total_RTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="RTC"))
    dat.temp$total_CTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="CTC"))
    dat.temp$total_routine<-nrow(subset(dat.temp,dat.temp$Visit.Type=="Routine"))
    dat.temp$total_visits<-nrow(dat.temp)
    
   # print(dat.temp$MRN)
    dat.temp$first_visit_date<-dat.temp$VisitDate[1]
    dat.temp$first_post_visit_date<-min(dat.temp$VisitDate[dat.temp$time_period!="During RTC"],na.rm=T)
    #a1c metrics
    dat.temp$avg_a1c_pre<-mean(dat.temp$A1C_Value[dat.temp$time_period=="During RTC"])
    dat.temp$avg_a1c_post<-mean(dat.temp$A1C_Value[dat.temp$time_period!="During RTC"])
    
    dat.temp$hosp_any<-0
    dat.temp$hosp_any[nrow(subset(dat.temp,dat.temp$HospitalizationsForDKA>0))]<-1
    
    dat.temp$hypo_any<-0
    dat.temp$hypo_any[nrow(subset(dat.temp,dat.temp$SevereHypoglycemia>0))]<-1
    
    dat.temp})
  #print(dat.temp$MRN)
  dat<-do.call(rbind,temp)
}
dat<-summary_stats(dat$MRN,dat)

dat$days_from_last_RTC<-as.numeric(difftime(dat$VisitDate,dat$date_last_RTC,unit="days"))
dat$days_from_last_RTC[dat$days_from_last_RTC<=0]<-NA

dat$days_from_first_visit<-as.numeric(difftime(dat$VisitDate,dat$first_visit_date,unit="days"))
dat$days_from_first_visit_to_first_post<-as.numeric(difftime(dat$first_post_visit_date,dat$first_visit_date,unit="days"))

#REMOVE PATIENTS WITH NO POST PERIOD VISITS WITHIN 1 YEAR (ALL CONTROLS):
dat<-subset(dat,dat$post_period_visits>0)

#remove those with 1 CTC:
dat<-subset(dat,dat$group!="N/A - CTC within 18 mo but not in CTC group")

#ASSIGN data dictionary (using tab in original excel sheet):
dat$group<-as.factor(dat$group)
label(dat$group)<-"Group"

dat$Gender<-as.factor(dat$Gender)
levels(dat$Gender)<-c("Male","Female")
label(dat$Gender)<-"Gender"
dat$Race.Ethnicity<-factor(dat$Race.Ethnicity)
levels(dat$Race.Ethnicity)<-c("White",
                              "Hispanic",
                              "Black",
                              "Other",
                              "More than One",
                              "Unknown",
                              "Asian",
                              "American Indian/Alaskan Native")
label(dat$Race.Ethnicity)<-"Race/Ethnicity"

dat$InsuranceType_VisitDate<-as.factor(dat$InsuranceType_VisitDate)
levels(dat$InsuranceType_VisitDate)<-c("Private","Public","Military","TBD")
label(dat$InsuranceType_VisitDate)<-"Insurance Type (baseline)"

dat$CGM_Use<-as.factor(dat$CGM_Use)
levels(dat$CGM_Use)<-c("No","Yes")
label(dat$CGM_Use)<-"CGM Use (baseline)"

dat$InsulinPump_Use<-as.factor(dat$InsulinPump_Use)
levels(dat$InsulinPump_Use)<-c("No","Yes")
label(dat$InsulinPump_Use)<-"Insulin Pump Use (baseline)"

dat$OnsetDate<-as.POSIXct(dat$OnsetDate,format="%m/%d/%Y")
dat$DOB<-as.POSIXct(dat$DOB,format="%m/%d/%Y")
dat$DurationOfDiabetes_eachvisit<-as.numeric(difftime(dat$VisitDate,dat$OnsetDate,units="days"))/365.25
label(dat$DurationOfDiabetes_eachvisit)<-'Duration of diabetes at baseline'

dat$Age_eachvisit<-as.numeric(difftime(dat$VisitDate,dat$DOB,units="days"))/365.25
label(dat$Age_eachvisit)<-'Age at baseline'

label(dat$A1C_Value)<-"A1c - baseline"
label(dat$avg_a1c_pre)<-"A1c - average in pre-period"
label(dat$avg_a1c_post)<-"A1c - average in post-period"
dat$avg_a1c_change<-dat$avg_a1c_pre-dat$avg_a1c_post
label(dat$avg_a1c_change)<-"A1c -  change (pre minus post)"

label(dat$Meter_BGHigh)<-"Meter BG High"
label(dat$Meter_BGLow)<-"Meter BG Low"
label(dat$Meter_BGOK)<-"Meter BG OK"

label(dat$total_visits)<-"Total Visits in Study"
label(dat$total_CTC)<-"Total CTC Visits"
label(dat$total_RTC)<-"Total RTC Visits"
label(dat$total_routine)<-"Total Routine Care Visits"

dat$research_period_visits_cat<-NA
dat$research_period_visits_cat[dat$research_period_visits==2]<-2
dat$research_period_visits_cat[dat$research_period_visits==3]<-3
dat$research_period_visits_cat[dat$research_period_visits==4]<-4
dat$research_period_visits_cat[dat$research_period_visits>=5]<-"5+"
dat$research_period_visits_cat<-as.factor(dat$research_period_visits_cat)

dat$RTC_visits_cat<-NA
dat$RTC_visits_cat[dat$total_RTC==2]<-2
dat$RTC_visits_cat[dat$total_RTC==3]<-3
dat$RTC_visits_cat[dat$total_RTC==4]<-4
dat$RTC_visits_cat[dat$total_RTC>=5]<-"5+"
dat$RTC_visits_cat<-as.factor(dat$RTC_visits_cat)

label(dat$research_period_visits)<-"Research Period Visits"
label(dat$research_period_visits_cat)<-"Research Period Visits (total)"
label(dat$RTC_visits_cat)<-"Research Period Visits (RTC)"
label(dat$research_period_time)<-"Research Period Time"
label(dat$post_period_visits)<-"Post Period Visits"
label(dat$post_period_time)<-"Post Period Time"

dat$Meter_BGOK_yn_baseline<-as.factor(ifelse(is.na(dat$Meter_BGOK),"No","Yes"))
dat$CGM_OK_yn_baseline<-as.factor(ifelse(is.na(dat$CGM_OK),"No","Yes"))
label(dat$Meter_BGOK_yn_baseline)<-"Meter in range % (yes/no), baseline"
label(dat$CGM_OK_yn_baseline)<-"CGM in range % (yes/no), baseline"

dat$hosp_any<-as.factor(dat$hosp_any)
label(dat$hosp_any)<-"Any Hospitalizations For DKA during Study"

dat$hypo_any<-as.factor(dat$hypo_any)
label(dat$hypo_any)<-"Any Severe Hypoglycemia during Study"

#table(dat$HospitalizationsForDKA)
dat$RTC_visits_cat_2<-NA
dat$RTC_visits_cat_2[dat$RTC_visits_cat==2]<-"2-3"
dat$RTC_visits_cat_2[dat$RTC_visits_cat==3]<-"2-3"
dat$RTC_visits_cat_2[dat$RTC_visits_cat==4]<-"4+"
dat$RTC_visits_cat_2[dat$RTC_visits_cat=="5+"]<-"4+"

dat$Race.Ethnicity_2<-"White"
dat$Race.Ethnicity_2[dat$Race.Ethnicity!="White"]<-"Non-White"

dat$Race.Ethnicity_3<-"Other"
dat$Race.Ethnicity_3[dat$Race.Ethnicity=="Hispanic"]<-"Hispanic"
dat$Race.Ethnicity_3[dat$Race.Ethnicity=="White"]<-"White"

dat$insurance_2<-"Private/Military"
dat$insurance_2[dat$InsuranceType_VisitDate=="Public"]<-"Public"

dat.one<-dat[!duplicated(dat$MRN),]
table(dat.one$group,useNA="always")
#summary stats (included in Analysis Plan):


table(dat.one$research_period_visits_cat[dat.one$group=="Control"])
quantile(dat.one$research_period_visits[dat.one$group=="Control"],useNA="always")
quantile(dat.one$research_period_time[dat.one$group=="Control"],useNA="always")

quantile(dat.one$post_period_visits[dat.one$group=="Control"],useNA="always")
quantile(dat.one$post_period_time[dat.one$group=="Control"],useNA="always")

table(dat.one$research_period_visits_cat[dat.one$group=="CTC"])
quantile(dat.one$research_period_visits[dat.one$group=="CTC"],useNA="always")
quantile(dat.one$research_period_time[dat.one$group=="CTC"],useNA="always")
quantile(dat.one$post_period_visits[dat.one$group=="CTC"],useNA="always")
quantile(dat.one$post_period_time[dat.one$group=="CTC"],useNA="always")

#missing data:
dat.missing.a1c<-subset(dat,(is.na(dat$A1C_Value)))
dat.missing.a1c<-dat.missing.a1c[,which(colnames(dat.missing.a1c) %in% c("MRN","VisitDate","Visit.Type","A1C_Value"))]
write.csv(dat.missing.a1c,"missing_a1c.csv",row.names = F)

dat.missing.cgm.pump<-subset(dat.one,(is.na(dat.one$CGM_Use)| is.na(dat.one$InsulinPump_Use)))
dat.missing.cgm.pump<-dat.missing.cgm.pump[,which(colnames(dat.missing.cgm.pump) %in% c("MRN","VisitDate","Visit.Type","CGM_Use","InsulinPump_Use"))]
write.csv(dat.missing.cgm.pump,"missing_cgm_pump.csv",row.names = F)


#defining a threshold for time after research TC for CTC group:
# ctc<-subset(dat,dat$group=="CTC")
# table(ctc$days_from_last_RTC)
# 
# ctc$after_12<-0
# ctc$after_12[ctc$days_from_last_RTC<=365.25 & ctc$time_period!="During RTC"]<-0
# ctc$after_12[ctc$days_from_last_RTC>365.25 & ctc$time_period!="During RTC"]<-1
# 
# ctc$after_18<-0
# ctc$after_18[ctc$days_from_last_RTC<=547.50 & ctc$time_period!="During RTC"]<-0
# ctc$after_18[ctc$days_from_last_RTC>547.50 & ctc$time_period!="During RTC"]<-1
# 
# ctc$after_24<-0
# ctc$after_24[ctc$days_from_last_RTC<=730.5 & ctc$time_period!="During RTC"]<-0
# ctc$after_24[ctc$days_from_last_RTC>730.5 & ctc$time_period!="During RTC"]<-1
# 
# ctc_12<-subset(ctc,ctc$after_12!=1)
# table(ctc_12$Visit.Type)
# table(ctc_12$Visit.Type,ctc_12$MRN)
# 
# ctc_18<-subset(ctc,ctc$after_18!=1)
# table(ctc_18$Visit.Type)
# table(ctc_18$Visit.Type,ctc_18$MRN)
# 
# ctc_24<-subset(ctc,ctc$after_24!=1)
# table(ctc_24$Visit.Type)
# table(ctc_24$Visit.Type,ctc_24$MRN)
# 
# ctc_sub<-ctc[,which(colnames(ctc) %in% c("MRN","VisitDate","Visit.Type","after_1year","time_period"))]
