###Shideh Majidi: 
#Clinic Team Clinic

dat<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Shideh Majidi/Clinic team clinic/Data/RetrospectiveReview_062220_highlighted_coded_RDV.csv",
              na.strings=c("NULL",""))
dat<-subset(dat,!is.na(dat$MRN)) #remove empty rows between patients

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
#by patient data prep:
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

#restrict to only patients with 2+ RTC:
dat<-subset(dat,dat$total_RTC>=2)
#remove visits before the first RTC:
dat<-subset(dat,dat$row_num>=dat$row_num_first_RTC)

#by patient:
by_pt<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$MRN==1341549)
    dat.temp<-dat.temp[order(dat.temp$VisitDate),]
  
    
    dat.temp$row_num<-rep(1:nrow(dat.temp))
    dat.temp$row_num_last_RTC<-NA
    if (dat.temp$total_RTC[1]>0){dat.temp$row_num_last_RTC<-max(dat.temp$row_num[dat.temp$Visit.Type=="RTC"])}
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
    
    #remove routine visits after a year post-RTC:
    # dat.temp$time_since_last_RTC<-NA
    # dat.temp$time_since_last_RTC[dat.temp$time_period=="Post-RTC"]<-difftime(dat.temp$VisitDate[dat.temp$time_period=="Post-RTC"],dat.temp$VisitDate[
    #   dat.temp$row_num==dat.temp$row_num_last_RTC],units='days')
    #total of each visit type post-RTC:
    
    #total of each visit type:
    # dat.temp$total_RTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="RTC"))
    # dat.temp$total_CTC<-nrow(subset(dat.temp,dat.temp$Visit.Type=="CTC"))
    # dat.temp$total_routine<-nrow(subset(dat.temp,dat.temp$Visit.Type=="Routine"))
    # 
    
    dat.temp})
  
  dat<-do.call(rbind,temp)
}
dat<-by_pt(dat$MRN,dat)

#group:
dat.one<-dat[!duplicated(dat$MRN),]

table(dat.one$group)

