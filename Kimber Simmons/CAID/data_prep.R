######## Kimber Simmons #########
library(Hmisc)
#pt level data:
dat<-read.csv('S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Data/CAID_PatientLevelRport_V1_07031029_Cleaned.csv')

#format variables:

#demographics:
dat$DOB<-as.POSIXct(dat$DOB,format="%m/%d/%Y")
dat$OnsetDate<-as.POSIXct(dat$OnsetDate,format="%m/%d/%Y")
dat$Age_AtDX<-(dat$OnsetDate-dat$DOB)/365
label(dat$Age_AtDX)<-"Age at Dx, years"
dat$Gender<-as.factor(dat$Gender)
label(dat$Gender)<-"Gender"
dat$RaceEthinicity<-as.factor(dat$RaceEthinicity)
label(dat$RaceEthinicity)<-"Race/Ethnicity"
label(dat$BMI_AtDX)<-"BMI at Dx"

#time to event:

#thyroid
dat$thyroid_yn<-NA
dat$thyroid_yn[dat$ThyroidDisease=="Y"]<-1
dat$thyroid_yn[dat$ThyroidDisease=="N"]<-0

dat$ThyroidDisease_DxDate<-as.POSIXct(dat$ThyroidDisease_DxDate,format="%m/%d/%Y")
###need censoring dates
dat$time_to_thyroid<-NA
dat$time_to_thyroid[dat$thyroid_yn==1]<-(dat$ThyroidDisease_DxDate[dat$thyroid_yn==1]-dat$OnsetDate[dat$thyroid_yn==1])/60/60/24/31
label(dat$time_to_thyroid)<-"Months from Onset to Thyroid Disease (days)"
dat$thyroid_timing<-NA
dat$thyroid_timing[dat$time_to_thyroid<0]<-"Before Diabetes Onset"
dat$thyroid_timing[dat$time_to_thyroid==0]<-"At Diabetes Onset"
dat$thyroid_timing[dat$time_to_thyroid>0]<-"After Diabetes Onset"

#celiac
dat$celiac_yn<-NA
dat$celiac_yn[dat$CeliacDisease=="Y"]<-1
dat$celiac_yn[dat$CeliacDisease=="N"]<-0

dat$CeliacDisease_DxDate<-as.POSIXct(dat$CeliacDisease_DxDate,format="%m/%d/%Y")
###need censoring dates
dat$time_to_celiac<-NA
dat$time_to_celiac[dat$celiac_yn==1]<-(dat$CeliacDisease_DxDate[dat$celiac_yn==1]-dat$OnsetDate[dat$celiac_yn==1])/60/60/24/31
label(dat$time_to_celiac)<-"Months from Onset to Celiac Disease (days)"
dat$celiac_timing<-NA
dat$celiac_timing[dat$time_to_celiac<0]<-"Before Diabetes Onset"
dat$celiac_timing[dat$time_to_celiac==0]<-"At Diabetes Onset"
dat$celiac_timing[dat$time_to_celiac>0]<-"After Diabetes Onset"

#addisons
dat$addison_yn<-NA
dat$addison_yn[dat$AddisonsDisease=="Y"]<-1
dat$addison_yn[dat$AddisonsDisease=="N"]<-0

dat$AddisonsDisease_DxDate<-as.POSIXct(dat$AddisonsDisease_DxDate,format="%m/%d/%Y")
###need censoring dates
dat$time_to_addison<-NA
dat$time_to_addison[dat$addison_yn==1]<-(dat$AddisonsDisease_DxDate[dat$addison_yn==1]-dat$OnsetDate[dat$addison_yn==1])/60/60/24/31 ##1 pt is missing addison date
label(dat$time_to_addison)<-"Months from Onset to addison Disease (days)"
dat$addison_timing<-NA
dat$addison_timing[dat$time_to_addison<0]<-"Before Diabetes Onset"
dat$addison_timing[dat$time_to_addison==0]<-"At Diabetes Onset"
dat$addison_timing[dat$time_to_addison>0]<-"After Diabetes Onset"

