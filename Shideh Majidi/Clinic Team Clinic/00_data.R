###Shideh Majidi: 
#Clinic Team Clinic
library(lubridate)
dat<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Shideh Majidi/Clinic team clinic/Data/RetrospectiveReview_062220_highlighted_coded_RDV.csv",
              na.strings=c("NULL",""))
dat<-subset(dat,!is.na(dat$MRN)) #remove empty rows between patients

#fix visit type for this MRN (shideh to send a new dataset)
dat$Visit.Type[dat$MRN==1269330 & dat$VisitDate=="3/22/2016"]<-0
dat$Visit.Type[dat$MRN==1269330 & dat$VisitDate=="7/12/2016"]<-0
dat$Visit.Type[dat$MRN==1269330 & dat$VisitDate=="10/11/2016"]<-0

#data dictionary:
dat$Gender<-as.factor(dat$Gender)
levels(dat$Gender)<-c("Male","Female")

dat$Race.Ethnicity<-as.factor(dat$Race.Ethnicity)
levels(dat$Race.Ethnicity)<-c("White",
                      "Hispanic",
                      "Black",
                      "Other",
                      "More than One",
                      "Unknown",
                      "Asian",
                      "American Indian/Alaskan Native")

dat$InsuranceType_VisitDate<-as.factor(dat$InsuranceType_VisitDate)
levels(dat$InsuranceType_VisitDate)<-c("Private","Public","Military","TBD")

dat$Visit.Type<-as.factor(dat$Visit.Type)
levels(dat$Visit.Type)<-c("RTC","CTC","Routine")

dat$CGM_Use<-as.factor(dat$CGM_Use)
levels(dat$CGM_Use)<-c("No","Yes")

dat$InsulinPump_Use<-as.factor(dat$InsulinPump_Use)
levels(dat$InsulinPump_Use)<-c("No","Yes")

dat$VisitDate<-as.POSIXct(dat$VisitDate,format="%m/%d/%Y")
####LONGITUDINAL DATASET PREPARATION:

#1. REDUCE DATASET TO ONLY PATIENTS WITH >2 RTC VISITS & DELETE VISITS PRE-RTC:
number_each<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$MRN==1484180)
    dat.temp<-dat.temp[order(dat.temp$VisitDate),]
    dat.temp$row_num<-rep(1:nrow(dat.temp))
    #total of each visit type:
    dat.temp$total_RTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="RTC"))
    dat.temp$total_CTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="CTC"))
    dat.temp$total_routine<-nrow(subset(dat.temp,dat.temp$Visit.Type=="Routine"))
    
    #time periods:
    dat.temp$row_num_first_RTC<-NA
    if (dat.temp$total_RTC[1]>0){dat.temp$row_num_first_RTC<-min(dat.temp$row_num[dat.temp$Visit.Type=="RTC"])}
        # dat.temp$time_period<-NA
    # if (dat.temp$total_RTC[1]>0){
    #   dat.temp$time_period[dat.temp$row_num>=dat.temp$row_num_first_RTC[1] & dat.temp$row_num<=dat.temp$row_num_last_RTC[1]]<-"During RTC"
    #   dat.temp$time_period[dat.temp$row_num>=dat.temp$row_num_last_RTC[1]]<-"Post-RTC"
    # }
    #total of each visit type post-RTC:
    
    dat.temp})
  
  dat<-do.call(rbind,temp)
}
dat<-number_each(dat$MRN,dat)
dat<-subset(dat,dat$total_RTC>=2)
dat<-subset(dat,dat$row_num>=dat$row_num_first_RTC)

#2. CALCULATE 1 YEAR POST-RESEARCH TEAM CLINIC (CHANGE THIS??):
one_year<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$MRN==1341549)
    dat.temp<-dat.temp[order(dat.temp$VisitDate),]
    
    dat.temp$row_num<-rep(1:nrow(dat.temp))
    dat.temp$row_num_last_RTC<-NA
    dat.temp$row_num_last_RTC<-max(dat.temp$row_num[dat.temp$Visit.Type=="RTC"])
    dat.temp$date_last_RTC<-dat.temp$VisitDate[dat.temp$row_num_last_RTC==dat.temp$row_num]
    dat.temp$date_max<-dat.temp$date_last_RTC+years(1)
    dat.temp})
  #print(dat.temp$MRN)
  dat<-do.call(rbind,temp)
}
dat<-one_year(dat$MRN,dat)

dat$after_1year<-0
dat$after_1year[dat$VisitDate>dat$date_max]<-1

#3. CREATE COHORT MEMBERSHIP AND TIME PERIODS:
by_pt<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$MRN==1412945)
    dat.temp<-dat.temp[order(dat.temp$VisitDate),]
    dat.temp$total_RTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="RTC"))
    dat.temp$total_CTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="CTC"))
    dat.temp$total_routine<-nrow(subset(dat.temp,dat.temp$Visit.Type=="Routine"))
    dat.temp$row_num<-rep(1:nrow(dat.temp))
    dat.temp$row_num_first_CTC<-NA
    if (dat.temp$total_CTC[1]>0){dat.temp$row_num_first_CTC<-min(dat.temp$row_num[dat.temp$Visit.Type=="CTC"])}
    dat.temp$row_num_last_CTC<-NA
    if (dat.temp$total_CTC[1]>0){dat.temp$row_num_last_CTC<-max(dat.temp$row_num[dat.temp$Visit.Type=="CTC"])}
    
    dat.temp$time_period<-NA
    dat.temp$time_period[dat.temp$row_num<=dat.temp$row_num_last_RTC[1]]<-"During RTC"
    dat.temp$time_period[dat.temp$row_num>dat.temp$row_num_last_RTC[1]]<-"Post-RTC"
    
    ####DEFINE CTC GROUP####:
    #time between RTC and CTC:
    dat.temp$days_rtc_to_ctc<-NA
    if (dat.temp$total_CTC[1]>0){
      dat.temp$days_rtc_to_ctc<-difftime(dat.temp$VisitDate[dat.temp$row_num_first_CTC==dat.temp$row_num],
                                           dat.temp$VisitDate[dat.temp$row_num_last_RTC==dat.temp$row_num],units='days')
    }
    
    #number of CTC after RTC:
    dat.temp$num_CTC_post_RTC<-0
    if (dat.temp$total_CTC[1]>0){
      dat.temp$num_CTC_post_RTC<-nrow(subset(dat.temp,dat.temp$time_period=="Post-RTC" & dat.temp$Visit.Type=="CTC"))
    }
    
    dat.temp$group<-NA
    dat.temp$group[dat.temp$num_CTC_post_RTC>=2 & dat.temp$days_rtc_to_ctc<365]<-"CTC"
    
    ####DEFINE CONTROL GROUP####
    dat.temp$num_routine_post_RTC<-0
    dat.temp$days_rtc_to_routine<-NA
    
    #number of regular after RTC:
    if (is.na(dat.temp$group[1])){
      dat.temp$num_routine_post_RTC<-nrow(subset(dat.temp,dat.temp$time_period=="Post-RTC"))
      dat.temp$days_rtc_to_routine[dat.temp$time_period=="Post-RTC"]<-difftime(dat.temp$VisitDate[dat.temp$time_period=="Post-RTC"],
                                             dat.temp$VisitDate[dat.temp$row_num_last_RTC==dat.temp$row_num],units='days')
    }
    dat.temp$group[dat.temp$num_routine_post_RTC>0 & is.na(dat.temp$group)]<-"Control"
    #if a CTC within 1st year, remove from control group:
    dat.temp$group[dat.temp$group=="Control" & dat.temp$days_rtc_to_ctc<=365]<-"N/A - CTC within 1st year but not in CTC group"
    dat.temp})
  
  dat<-do.call(rbind,temp)
}
dat<-by_pt(dat$MRN,dat)

#4. REMOVE PATIENTS WITHOUT A GROUP - THESE ONLY HAD RTC AND NO FOLLOWUP:
dat<-subset(dat,!is.na(dat$group))

####test:
test<-dat[,which(colnames(dat) %in% c("MRN","VisitDate","Visit.Type","after_1year","date_max"))]
#5. REMOVE DATA AFTER 1 YEAR POST-RTC for control group: WHAT ABOUT RESEARCH GROUP - need to update this
dat<-subset(dat,!(dat$after_1year==1 & dat$group=="Control"))

step5<-data.frame(mrn=row.names(table(dat$MRN,dat$time_period)),num_post=table(dat$MRN,dat$time_period)[,2])
step5$num_post<-as.numeric(as.character(step5$num_post))
num_0<-subset(step5,step5$num_post==0)
mrns_0<-num_0$mrn

dat<-subset(dat,!(dat$MRN %in% mrns_0))
#6. REMOVE DATA AFTER CTC FOR RESEARCH GROUP:
dat$after_ctc<-0
dat$after_ctc[dat$group=="CTC" & dat$row_num>dat$row_num_last_CTC]<-1

dat<-subset(dat,dat$after_ctc==0)
#5. CALCULATE USABLE STATS FOR EACH GROUP:
# dat<-dat[,-c(which(colnames(dat)=="row_num"):which(colnames(dat)=="num_CTC_post_RTC"),
#              which(colnames(dat)=="num_routine_post_RTC"):which(colnames(dat)=="days_rtc_to_routine"))]

summary_stats<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$MRN==1066579)
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
    print(dat.temp$MRN)
    dat.temp})
  #print(dat.temp$MRN)
  dat<-do.call(rbind,temp)
}
dat<-summary_stats(dat$MRN,dat)

#REMOVE PATIENTS WITH NO POST PERIOD VISITS WITHIN 1 YEAR (ALL CONTROLS):
dat<-subset(dat,dat$post_period_visits>0)
dat.one<-dat[!duplicated(dat$MRN),]

table(dat.one$group,useNA="always")

#remove those with 1 CTC:
dat<-subset(dat,dat$group!="N/A - CTC within 1st year but not in CTC group")

table(dat.one$research_period_visits[dat.one$group=="Control"])
quantile(dat.one$research_period_visits[dat.one$group=="Control"],useNA="always")
quantile(dat.one$research_period_time[dat.one$group=="Control"],useNA="always")
quantile(dat.one$post_period_visits[dat.one$group=="Control"],useNA="always")
quantile(dat.one$post_period_time[dat.one$group=="Control"],useNA="always")

table(dat.one$research_period_visits[dat.one$group=="CTC"])
quantile(dat.one$research_period_visits[dat.one$group=="CTC"],useNA="always")
quantile(dat.one$research_period_time[dat.one$group=="CTC"],useNA="always")
quantile(dat.one$post_period_visits[dat.one$group=="CTC"],useNA="always")
quantile(dat.one$post_period_time[dat.one$group=="CTC"],useNA="always")

