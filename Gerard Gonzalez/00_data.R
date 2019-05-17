########Gerard Gonzalez Latino Program Analysis########
library(Hmisc)
######### READ IN ALL DATASETS ########
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/01_functions.R')
#Read in Data: LP patients (will need new dataset)
setwd('S:/Shared Projects/Laura/BDC/Projects/Andrea Gerard Gonzalez/Data')
dat.lp<-read.csv('10.11.18_Cleaned_latino_clinical.csv') ###need to replace
dat.lp<-dat.lp[,-c(which(colnames(dat.lp)=="Repeat_Instrument"),
                   which(colnames(dat.lp)=="Complete_"),
                   which(colnames(dat.lp)=="Repeat_Instance"),
                   which(colnames(dat.lp)=="first_name"),
                   which(colnames(dat.lp)=="last_name"))]
dat.lp$trt_grp<-"LP"
dat.lp$record_id<-dat.lp$MRN

dat.lp$insulin_pump<-0
dat.lp$insulin_pump[dat.lp$Insulin_Regimen==2]<-1

dat.lp<-dat.lp[,-which(colnames(dat.lp)=="Insulin_Regimen")]
#check number of checks per day:
# dat.lp$checks_yn<-0
# dat.lp$checks_yn[!is.na(dat.lp$Checks_Per_Day)]<-1
# base<-subset(dat.lp,dat.lp$yeargrouping=="Base1")
# table(base$checks_yn,base$MRN)
#Read in Data: Control patients
dat.c.aic<-read.csv('05.08.19_Cleaned_controls_aic.csv')
dat.c.aic$appt_date<-as.POSIXct(dat.c.aic$appt_date,format="%m/%d/%Y")
dat.c.cgm<-read.csv('05.08.19_Cleaned_controls_cgm.csv')
dat.c.cgm$appt_date<-as.POSIXct(dat.c.cgm$appt_date,format="%m/%d/%Y")

dat.c.cgm<-dat.c.cgm[,-c(which(colnames(dat.c.cgm)=="group"):which(colnames(dat.c.cgm)=="visit"),
                                                             which(colnames(dat.c.cgm)=="Date_of_Birth"):which(colnames(dat.c.cgm)=="Diabetes_Onset_Date"),
                                                             which(colnames(dat.c.cgm)=="base_date"):which(colnames(dat.c.cgm)=="duration_of_diagnosis"))]
dat.c<-merge(dat.c.aic,dat.c.cgm,by=c("MRN","appt_date"),all=T)
dat.c<-dat.c[order(dat.c$MRN,dat.c$visit),]

dat.c.ins<-read.csv('05.08.19_Cleaned_controls_insulin.csv')
dat.c.ins$appt_date<-as.POSIXct(dat.c.ins$appt_date,format="%m/%d/%Y")

dat.c.ins<-dat.c.ins[,-c(which(colnames(dat.c.ins)=="group"):which(colnames(dat.c.ins)=="visit"),
                                                                 which(colnames(dat.c.ins)=="Date_of_Birth"):which(colnames(dat.c.ins)=="Diabetes_Onset_Date"),
                                                                 which(colnames(dat.c.ins)=="Insulin_Regimen"):which(colnames(dat.c.ins)=="duration_of_diagnosis"))]
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
dat.c$insulin_pump<-0
dat.c$insulin_pump[dat.c$InsulinRegimen=="Insulin Pump"]<-1

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
                 which(colnames(dat.c)=="enroll_age"),
                 which(colnames(dat.c)=="InsulinRegimen"))]
#dat.c<-subset(dat.c,dat.c$MRN!=1482525) #####CHECK ON THIS MRN, IT IS IN BOTH CONTROL AND LP DATA: 1482525
#dat.c<-subset(dat.c,dat.c$MRN!=1036067) #####CHECK ON THIS MRN, IT IS IN BOTH CONTROL AND LP DATA: 1482525
##dat.c<-subset(dat.c,dat.c$MRN!=704437) #####CHECK ON THIS MRN, IT IS IN BOTH CONTROL AND LP DATA: 1482525

lp.mrns<-unique(dat.lp$MRN)
c.mrns<-unique(dat.c$MRN)

dat.c<-subset(dat.c,!(dat.c$MRN %in% lp.mrns))
dat.lp$Appt_Date<-as.POSIXct(dat.lp$Appt_Date,format="%m/%d/%Y")
#merge LP and C:
dat<-rbind(dat.lp,dat.c)

######### 1 ROW PER PATIENT, PER YEAR ########

dat<-by_pt_by_year(dat$MRN,dat)

#subset to only 1 row per patient per year, since already have summary stats:
dat<-subset(dat,dat$row_num_year==1)
dat<-dat[order(dat$MRN,dat$visit),]


##prep all variables:
dat$yeargrouping<-as.factor(dat$yeargrouping)
label(dat$yeargrouping)<-"Year"

label(dat$a1c_last_in_year)<-"A1C - Last Measure in Year"
label(dat$checks_last_in_year)<-"Checks per Day - Last Measure in Year"

label(dat$a1c_avg_in_year)<-"A1C - Average in Year"
label(dat$checks_avg_in_year)<-"Checks per Day - Average in Year"

dat.trt<-subset(dat,dat$trt_grp=="LP")
dat.con<-subset(dat,dat$trt_grp=="Control")

dat.trt.young<-subset(dat.trt,dat.trt$group=="Less than 12")
dat.trt.old<-subset(dat.trt,dat.trt$group=="greater than or equal to 12")
dat.con.young<-subset(dat.con,dat.con$group=="Less than 12")
dat.con.old<-subset(dat.con,dat.con$group=="greater than or equal to 12")

