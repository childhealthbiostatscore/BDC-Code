########Gerard Gonzalez Latino Program Analysis########

######### READ IN ALL DATASETS ########

#Read in Data: LP patients (will need new dataset)
setwd('S:/Shared Projects/Laura/BDC/Projects/Andrea Gerard Gonzalez/Data')
dat.lp<-read.csv('7.24.18_Cleaned_latino_clinical.csv') ###need to replace
dat.lp<-dat.lp[,-c(which(colnames(dat.lp)=="Repeat_Instrument"),
                   which(colnames(dat.lp)=="Complete_"),
                   which(colnames(dat.lp)=="Repeat_Instance"),
                   which(colnames(dat.lp)=="first_name"),
                   which(colnames(dat.lp)=="last_name"))]
dat.lp$trt_grp<-"LP"
dat.lp$record_id<-dat.lp$MRN

#check number of checks per day:
# dat.lp$checks_yn<-0
# dat.lp$checks_yn[!is.na(dat.lp$Checks_Per_Day)]<-1
# base<-subset(dat.lp,dat.lp$yeargrouping=="Base1")
# table(base$checks_yn,base$MRN)
#Read in Data: Control patients
dat.c.aic<-read.csv('05.08.19_Cleaned_controls_aic.csv')
dat.c.cgm<-read.csv('05.08.19_Cleaned_controls_cgm.csv')
dat.c.cgm$Checks_Per_Day[dat.c.cgm$MRN==804609 & dat.c.cgm$yeargrouping=="Base1"]<-2.8
dat.c.cgm$CGM[dat.c.cgm$MRN==804609 & dat.c.cgm$yeargrouping=="Base1"]<-"N"
dat.c.cgm<-dat.c.cgm[,-c(which(colnames(dat.c.cgm)=="group"):which(colnames(dat.c.cgm)=="visit"),
                                                             which(colnames(dat.c.cgm)=="Date_of_Birth"):which(colnames(dat.c.cgm)=="Diabetes_Onset_Date"),
                                                             which(colnames(dat.c.cgm)=="base_date"):which(colnames(dat.c.cgm)=="duration_of_diagnosis"))]
dat.c<-merge(dat.c.aic,dat.c.cgm,by=c("MRN","appt_date"),all=T)
dat.c<-dat.c[order(dat.c$MRN,dat.c$visit),]

dat.c.ins<-read.csv('05.08.19_Cleaned_controls_insulin.csv')
dat.c.ins<-dat.c.ins[,-c(which(colnames(dat.c.ins)=="group"):which(colnames(dat.c.ins)=="visit"),
                                                                 which(colnames(dat.c.ins)=="Date_of_Birth"):which(colnames(dat.c.ins)=="InsulinRegimen"),
                                                                 which(colnames(dat.c.ins)=="base_date"):which(colnames(dat.c.ins)=="duration_of_diagnosis"))]
dat.c<-merge(dat.c,dat.c.ins,by=c("MRN","appt_date"),all=T)
dat.c<-dat.c[order(dat.c$MRN,dat.c$visit),]

dat.c<-subset(dat.c,!is.na(dat.c$yeargrouping))
######### MERGE CONTROLS AND LP DATASETS ########

dat.c$trt_grp<-"Control"
dat.c$record_id<-dat.c$MRN
colnames(dat.c)[which(names(dat.c) == "Date_of_Birth")]<-"DOB"
colnames(dat.c)[which(names(dat.c) == "appt_date")]<-"Appt_Date"
colnames(dat.c)[which(names(dat.c) == "A1CValue")]<-"A1C"
dat.c$Appt_Type<-"R"
dat.c$Insulin_Regimen[dat.c$Insulin_Regimen==2]<-"PUMP"
dat.c$Insulin_Regimen[dat.c$Insulin_Regimen==1]<-"SS" #ask kaci about this
#these variables aren't in C, so make them NA
dat.c$BMI<-NA
dat.c$TSH<-NA
dat.c$T4_Free<-NA
dat.c$TTG<-NA
dat.c$Cholesterol<-NA
dat.c$Triglycerides<-NA
dat.c$HDL<-NA
dat.c$LDL<-NA
dat.c$Hospital<-NA
dat.c$DKA<-NA
dat.c$New_Onset<-NA
dat.c$Status<-NA
#these aren't in LP:
dat.c<-dat.c[,-c(which(colnames(dat.c)=="Enrollement_Date"),
                 which(colnames(dat.c)=="Diabetes_Onset_Date"),
                 which(colnames(dat.c)=="enroll_age"),which(colnames(dat.c.ins)=="duration_of_diagnosis"))]
#dat.c<-subset(dat.c,dat.c$MRN!=1482525) #####CHECK ON THIS MRN, IT IS IN BOTH CONTROL AND LP DATA: 1482525
#dat.c<-subset(dat.c,dat.c$MRN!=1036067) #####CHECK ON THIS MRN, IT IS IN BOTH CONTROL AND LP DATA: 1482525
##dat.c<-subset(dat.c,dat.c$MRN!=704437) #####CHECK ON THIS MRN, IT IS IN BOTH CONTROL AND LP DATA: 1482525

lp.mrns<-unique(dat.lp$MRN)
c.mrns<-unique(dat.c$MRN)

dat.c<-subset(dat.c,!(dat.c$MRN %in% lp.mrns))
#merge LP and C:
dat<-rbind(dat.lp,dat.c)

######### 1 ROW PER PATIENT, PER YEAR ########

dat$Appt_Date<-as.POSIXct(dat$Appt_Date,format="%m/%d/%Y")

dat<-by_pt_by_year(dat$MRN,dat)

dat<-subset(dat,dat$row_num_year==1)
dat<-dat[order(dat$MRN,dat$visit),]

mean(dat$a1c_last_in_year[dat$yeargrouping=="Base1" & dat$trt_grp=="LP"])
mean(dat$a1c_avg_in_year[dat$yeargrouping=="Base1" & dat$trt_grp=="LP"])

mean(dat$checks_last_in_year[dat$yeargrouping=="Base1" & dat$trt_grp=="LP"],na.rm=T)

mean(dat$a1c_last_in_year[dat$yeargrouping=="Base1" & dat$trt_grp=="Control"])
mean(dat$checks_last_in_year[dat$yeargrouping=="Base1" & dat$trt_grp=="Control"],na.rm=T)

nrow(subset(dat,dat$yeargrouping=="Base1" & dat$trt_grp=="LP" & !is.na(dat$checks_last_in_year)))
