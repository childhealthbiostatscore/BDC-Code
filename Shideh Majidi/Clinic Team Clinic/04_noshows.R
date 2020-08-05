####NO SHOW/CANCELLATION RATES:

noshows<-read.csv("noshow_cancellation.csv")

#subset no shows to only patients in the study:
noshows<-subset(noshows,noshows$MRN %in% dat.one$MRN)

dat.no<-merge(dat.one,noshows,all.x=T)

#remove missing apptdate, means the patient did not have any noshows:
dat.no<-subset(dat.no,!is.na(dat.no$ApptStatus))

#subset noshow data to only during study period:
dat.no$ApptDate<-as.POSIXct(dat.no$ApptDate,format="%m/%d/%Y %H:%M")
dat.no<-subset(dat.no,dat.no$ApptDate>=dat.no$first_visit_date)
dat.no<-subset(dat.no,dat.no$ApptDate<=dat.no$date_max)

#test<-dat.no[,which(colnames(dat.no) %in% c("MRN","ApptDate","first_visit_date","date_max"))]
noshow_total<-data.frame(table(dat.no$MRN))
colnames(noshow_total)<-c("MRN","noshow_total")

dat.no.pre<-subset(dat.no,dat.no$ApptDate<dat.no$first_post_visit_date)
noshow_pre<-data.frame(table(dat.no.pre$MRN))
colnames(noshow_pre)<-c("MRN","noshow_pre")

dat.no.post<-subset(dat.no,dat.no$ApptDate>=dat.no$first_post_visit_date)
noshow_post<-data.frame(table(dat.no.post$MRN))
colnames(noshow_post)<-c("MRN","noshow_post")

noshows<-merge(noshow_total,noshow_pre,by="MRN",all=T)
noshows<-merge(noshows,noshow_post,by="MRN",all=T)

dat.one<-merge(dat.one,noshows,by="MRN",all.x=T)
dat.one$noshow_total[is.na(dat.one$noshow_total)]<-0
dat.one$noshow_pre[is.na(dat.one$noshow_pre)]<-0
dat.one$noshow_post[is.na(dat.one$noshow_post)]<-0

dat.one$noshow_total<-as.numeric(as.character(dat.one$noshow_total))
dat.one$total_visits<-as.numeric(as.character(dat.one$total_visits))
dat.one$noshow_rate_total<-dat.one$noshow_total/(dat.one$noshow_total+dat.one$total_visits)

dat.one$noshow_pre<-as.numeric(as.character(dat.one$noshow_pre))
dat.one$research_period_visits<-as.numeric(as.character(dat.one$research_period_visits))
dat.one$noshow_rate_pre<-dat.one$noshow_pre/(dat.one$noshow_pre+dat.one$research_period_visits)

dat.one$noshow_post<-as.numeric(as.character(dat.one$noshow_post))
dat.one$research_period_visits<-as.numeric(as.character(dat.one$research_period_visits))
dat.one$noshow_rate_post<-dat.one$noshow_post/(dat.one$noshow_post+dat.one$research_period_visits)

dat.one$noshow_rate_change<-dat.one$noshow_rate_pre-dat.one$noshow_rate_post

label(dat.one$noshow_rate_pre)<-"No show rate, RTC"
label(dat.one$noshow_rate_post)<-"No show rate, post-RTC"
label(dat.one$noshow_rate_change)<-"No show rate, change (pre-post)"

# quantile(dat.one$noshow_rate_pre)
# quantile(dat.one$noshow_rate_post)

# num_noshows<-function(ID,data){
#   
#   temp<-lapply(unique(ID), function(x){
#     
#     dat.temp <- subset(data, ID == x)
#     # dat.temp <- subset(dat,dat$MRN==1409272)
#     dat.temp<-dat.temp[order(dat.temp$VisitDate),]
#     ##TIME PERIODS:
#     dat.temp$post_period<-1
#     dat.temp$post_period[dat.temp$time_period=="During RTC"]<-0
#     dat.temp$days_from_first_postvisit<-NA
#     dat.temp$days_from_first_postvisit[dat.temp$post_period==1]<-difftime(dat.temp$VisitDate[dat.temp$post_period==1],
#                                                                           dat.temp$first_post_visit_date[1],unit="days")
#     
#     dat.temp})
#   #print(dat.temp$MRN)
#   dat<-do.call(rbind,temp)
# }
# dat<-changepoint(dat$MRN,dat)