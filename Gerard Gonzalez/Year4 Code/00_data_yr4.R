########Gerard Gonzalez Latino Program Analysis########
library(Hmisc)
######### READ IN ALL DATASETS ########
source('C:/Users/pylell/Documents/GitHub/BDC-Code/Gerard Gonzalez/01_functions.R')
#Read in Data: LP patients - use old data, and merge in new year4 data
setwd('S:/Shared Projects/Laura/BDC/Projects/Andrea Gerard Gonzalez/Latino Clinic/Data')
dat.lp<-read.csv('10.11.18_Cleaned_latino_clinical.csv') 
dat.lp<-dat.lp[,-c(which(colnames(dat.lp)=="Repeat_Instrument"),
                   which(colnames(dat.lp)=="Complete_"),
                   which(colnames(dat.lp)=="record_id"),
                   which(colnames(dat.lp)=="Repeat_Instance"),
                   which(colnames(dat.lp)=="first_name"),
                   which(colnames(dat.lp)=="last_name"),
                   which(colnames(dat.lp)=="New_Onset"),
                   which(colnames(dat.lp)=="Status"),
                   which(colnames(dat.lp)=="TSH"):which(colnames(dat.lp)=="DKA"))]

# Year 4 data: sent in the control dataset format, Kaci needs base dates in order
# to create create windows.  export base dates and she merged this in with 
# year 4 to create final cleand year 4 data

# dat.forkaci<-dat.lp[!duplicated(dat.lp$MRN),]
# dat.forkaci<-dat.forkaci[,c(5,26)]
# write.csv(dat.forkaci,'basedates.csv')

#merge in years 2/3 from Year 4 dataset 
#(depending on base date, some "year4" data qualifies as earlier years for pt)

dat.4<-read.csv('05.24.19_Cleaned_lp_year4.csv')
#remove year 4 data for this analysis:
#dat.4<-subset(dat.4,dat.4$yeargrouping!="Year4")
dat.4<-dat.4[,-c(which(colnames(dat.4)=="Enrollement_Date"),
                 which(colnames(dat.4)=="enroll_age"),
                 which(colnames(dat.4)=="Diabetes_Onset_Date"))]
colnames(dat.4)[which(names(dat.4) == "insulin_regimen")]<-"Insulin_Regimen"
colnames(dat.4)[which(names(dat.4) == "appt_date")]<-"Appt_Date"
colnames(dat.4)[which(names(dat.4) == "Date_of_Birth")]<-"DOB"
dat.4$Appt_Type<-NA

dat.lp.final<-rbind(dat.lp,dat.4)
dat.lp.final$insulin_pump<-0
dat.lp.final$insulin_pump[dat.lp.final$Insulin_Regimen==2]<-1
dat.lp.final<-dat.lp.final[,-which(colnames(dat.lp.final)=="Insulin_Regimen")]

dat.lp.final$trt_grp<-"LP"
#HARD CODE 2 SUBJECTS TO BE CONTROLS:
dat.lp.final$trt_grp[dat.lp.final$MRN==986571]<-"Control"
dat.lp.final$trt_grp[dat.lp.final$MRN==1036067]<-"Control"

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
colnames(dat.c)[which(names(dat.c) == "Date_of_Birth")]<-"DOB"
colnames(dat.c)[which(names(dat.c) == "appt_date")]<-"Appt_Date"
colnames(dat.c)[which(names(dat.c) == "A1CValue")]<-"A1C"
dat.c$Appt_Type<-"R"
dat.c$insulin_pump<-0
dat.c$insulin_pump[dat.c$InsulinRegimen=="Insulin Pump"]<-1

#these variables aren't in C, so make them NA
dat.c$BMI<-NA
#these aren't in LP:
dat.c<-dat.c[,-c(which(colnames(dat.c)=="Enrollement_Date"),
                 which(colnames(dat.c)=="Diabetes_Onset_Date"),
                 which(colnames(dat.c)=="enroll_age"),
                 which(colnames(dat.c)=="InsulinRegimen"))]
#dat.c<-subset(dat.c,dat.c$MRN!=1482525) #####CHECK ON THIS MRN, IT IS IN BOTH CONTROL AND LP DATA: 1482525
#dat.c<-subset(dat.c,dat.c$MRN!=1036067) #####CHECK ON THIS MRN, IT IS IN BOTH CONTROL AND LP DATA: 1482525
##dat.c<-subset(dat.c,dat.c$MRN!=704437) #####CHECK ON THIS MRN, IT IS IN BOTH CONTROL AND LP DATA: 1482525
dat.c$trt_grp<-"Control"

# lp.mrns<-unique(dat.lp$MRN)
# c.mrns<-unique(dat.c$MRN)
# dat.c<-subset(dat.c,!(dat.c$MRN %in% lp.mrns))
dat.c<-subset(dat.c,dat.c$MRN!=1482525)
dat.c<-subset(dat.c,dat.c$MRN!=744276)
dat.c$Appt_Date<-as.POSIXct(dat.c$Appt_Date,format="%Y-%m-%d")
dat.lp.final$Appt_Date<-as.POSIXct(dat.lp.final$Appt_Date,format="%m/%d/%Y")
#merge LP and C:
dat<-rbind(dat.lp.final,dat.c)

#delete duplicate rows for 1036067, since was in LP and control datasets
#also duplciates between Year4 data and original LP data
dat$duplicate<-0
dat$duplicate[duplicated(dat[,c(4,8)])]<-1
dat<-subset(dat,dat$duplicate==0)

#NEW FOR THIS ANALYSIS: 
#remove checks per day when on CGM
dat$Checks_Per_Day[dat$CGM=="Y"]<-NA

######### 1 ROW PER PATIENT, PER YEAR ########

dat<-by_pt_by_year(dat$MRN,dat)
dat<-dat[order(dat$MRN,dat$yeargrouping),]

#View(dat[,c(5,2,1,30,31,38)])
#subset to only 1 row per patient per year, since already have summary stats:
dat<-subset(dat,dat$row_num_year==1)
dat<-dat[order(dat$MRN,dat$visit),]

#NEW in this analysis:
#adjust for technology type:
dat$technology_type_inyear<-NA
dat$technology_type_inyear[dat$cgm_yn_inyear==0 & dat$pump_yn_inyear==0]<-"No CGM or Pump"
dat$technology_type_inyear[dat$cgm_yn_inyear==1 & dat$pump_yn_inyear==0]<-"CGM Only"
dat$technology_type_inyear[dat$cgm_yn_inyear==0 & dat$pump_yn_inyear==1]<-"Pump Only"
dat$technology_type_inyear[dat$cgm_yn_inyear==1 & dat$pump_yn_inyear==1]<-"CGM and Pump"
dat$technology_type_inyear<-factor(dat$technology_type_inyear,levels=c("No CGM or Pump","CGM and Pump",
                                                                       "CGM Only","Pump Only"))
dat$technology_type_inyear<-as.factor(dat$technology_type_inyear)
label(dat$technology_type_inyear)<-"Technology Type in Year"

#remove Checks per day when CGM is used:
dat$checks_last_in_year[dat$cgm_yn_inyear==1]<-NA


##future dataset: only patients followed through year 4:
dat<-subset(dat,dat$year_4==1)


##prep all variables:
dat$yeargrouping<-as.factor(dat$yeargrouping)
label(dat$yeargrouping)<-"Year"

label(dat$a1c_last_in_year)<-"A1C - Last Measure in Year"
label(dat$checks_last_in_year)<-"Checks per Day - Last Measure in Year (CGM=No)"

label(dat$a1c_avg_in_year)<-"A1C - Average in Year"
label(dat$checks_avg_in_year)<-"Checks per Day - Average in Year"

dat$pump_yn_inyear<-as.factor(dat$pump_yn_inyear)
levels(dat$pump_yn_inyear)<-c("No","Yes")
dat$pump_yn_inyear<-factor(dat$pump_yn_inyear,levels=c("Yes","No"))
label(dat$pump_yn_inyear)<-"Any Pump Use in Given Year"

dat$cgm_yn_inyear<-as.factor(dat$cgm_yn_inyear)
levels(dat$cgm_yn_inyear)<-c("No","Yes")
dat$cgm_yn_inyear<-factor(dat$cgm_yn_inyear,levels=c("Yes","No"))
label(dat$cgm_yn_inyear)<-"Any CGM Use in Given Year"

dat.trt<-subset(dat,dat$trt_grp=="LP")
dat.con<-subset(dat,dat$trt_grp=="Control")

dat.trt.young<-subset(dat.trt,dat.trt$group=="Less than 12")
dat.trt.old<-subset(dat.trt,dat.trt$group=="greater than or equal to 12")
dat.con.young<-subset(dat.con,dat.con$group=="Less than 12")
dat.con.old<-subset(dat.con,dat.con$group=="greater than or equal to 12")

#compare year 3 and year 4 patients:
dat.3<-read.csv("year3_data.csv")
dat.3<-dat.3[!duplicated(dat.3$MRN),]
dat.3$year3<-1
dat.3<-dat.3[,c(5,20,35)]

dat.4<-dat[!duplicated(dat$MRN),]
dat.4$year4<-1
dat.4<-dat.4[,c(4,19,35)]

dat.pts<-merge(dat.3,dat.4,by=c("MRN","trt_grp"),all=T)

dat.pts$year3[is.na(dat.pts$year3)]<-0
dat.pts$year4[is.na(dat.pts$year4)]<-0
table(dat.pts$year3)
