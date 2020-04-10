######## Kimber Simmons #########
library(Hmisc)

#pt level data:
dat<-read.csv('S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Data/CAID_PatientLevelRport_V1_07091029_Cleaned.csv',na.strings="NULL")
#remove celiac disease data from this original dataset:
dat<-dat[,-c(which(colnames(dat)=="CeliacDisease"):
               which(colnames(dat)=="CeliacDisease_.CGMLow_VisitDate_2ndBeforeDxDate"))]

#updated celiac data with multiple definitions of celiac's disease:
dat.cel<-read.csv('S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Data/CeliacPatientLevelReport_1sheet_07172019.csv',na.strings="NULL")
dat.cel<-dat.cel[,c(1,which(colnames(dat.cel)=="CeliacDisease"):
                   which(colnames(dat.cel)=="CeliacDisease_.CGMLow_VisitDate_2ndBeforeDxDate"))]
#merge celiac data in with original:
dat<-merge(dat,dat.cel,by="EPICMRN",all=T)

#where celiac data is missing, it is a "no":
dat$CeliacDisease[is.na(dat$CeliacDisease)]<-"N"
dat$AbnormalPanel<-factor(dat$AbnormalPanel,levels=c("Y","N"))
dat$AbnormalPanel[is.na(dat$AbnormalPanel)]<-"N"
dat$GlutenFreeDiet[is.na(dat$GlutenFreeDiet)]<-"N"


#format variables:

#demographics:
dat$DOB<-as.POSIXct(dat$DOB,format="%m/%d/%Y")
dat$OnsetDate<-as.POSIXct(dat$OnsetDate,format="%m/%d/%Y")
dat$Age_At_diabetes_DX<-as.numeric(difftime(dat$OnsetDate,dat$DOB,units='days')/365)
label(dat$Age_AtDX)<-"Age at Diabetes Dx, years"
dat$Gender<-as.factor(dat$Gender)
label(dat$Gender)<-"Gender"
dat$BMI_AtDX<-as.numeric(as.character(dat$BMI_AtDX))
label(dat$BMI_AtDX)<-"BMI at Dx"

dat$RaceEthinicity<-as.factor(dat$RaceEthinicity)
label(dat$RaceEthinicity)<-"Race/Ethnicity"
dat$RaceEthinicity_cat<-NA
dat$RaceEthinicity_cat[dat$RaceEthinicity=="Non-Hispanic White"]<-"Non-Hispanic White"
dat$RaceEthinicity_cat[dat$RaceEthinicity=="Non-Hispanic Black"]<-"Non-Hispanic Black"
dat$RaceEthinicity_cat[dat$RaceEthinicity=="Hispanic"]<-"Hispanic"
dat$RaceEthinicity_cat[dat$RaceEthinicity=="Unknown"]<-NA
dat$RaceEthinicity_cat[dat$RaceEthinicity %in% c("American Indian/Alaska Native",
                                                 "Asian",
                                                 "More than one Race",
                                                 "Native Hawaiian/Other Pacific Islander",
                                                 "Other")]<-"Other"
dat$RaceEthinicity_cat<-as.factor(dat$RaceEthinicity_cat)
label(dat$RaceEthinicity_cat)<-"Race/Ethnicity"

dat$hispanic_yn<-NA
dat$hispanic_yn[dat$RaceEthinicity_cat=="Hispanic"]<-"Hispanic"
dat$hispanic_yn[dat$RaceEthinicity_cat!="Hispanic"]<-"Non-Hispanic"
dat$hispanic_yn[dat$RaceEthinicity_cat=="Unknown"]<-NA
label(dat$hispanic_yn)<-"Hispanic"

# dat$Height_AtDX<-as.numeric(as.character(dat$Height_AtDX))
# dat$Weight_AtDX<-as.numeric(as.character(dat$Weight_AtDX))
# 
# label(dat$Height_AtDX)<-"Height at Diabetes Dx"
# label(dat$Weight_AtDX)<-"Weight at Diabetes Dx"

#time to event:
dat$LastVisitDate<-as.POSIXct(dat$LastVisitDate,format="%m/%d/%Y")

#thyroid
dat$thyroid_yn<-NA
dat$thyroid_yn[dat$ThyroidDisease=="Y"]<-1
dat$thyroid_yn[dat$ThyroidDisease=="N"]<-0
dat$thyroid_yn<-as.factor(dat$thyroid_yn)
label(dat$thyroid_yn)<-"Thyroid Y/N"

dat$ThyroidDisease_DxDate<-as.POSIXct(dat$ThyroidDisease_DxDate,format="%m/%d/%Y")
dat$time_to_thyroid<-NA
dat$time_to_thyroid[dat$thyroid_yn==1]<-difftime(dat$ThyroidDisease_DxDate[dat$thyroid_yn==1],dat$OnsetDate[dat$thyroid_yn==1],units='days')
dat$time_to_thyroid[dat$thyroid_yn==0]<-difftime(dat$LastVisitDate[dat$thyroid_yn==0],dat$OnsetDate[dat$thyroid_yn==0],unit='days')
dat$time_to_thyroid<-as.numeric(dat$time_to_thyroid)*0.0328767
label(dat$time_to_thyroid)<-"Months from Onset to Thyroid Disease"

dat$thyroid_timing<-NA
dat$thyroid_timing[dat$time_to_thyroid<0 & dat$thyroid_yn==1]<-"Before Diabetes Onset"
dat$thyroid_timing[dat$time_to_thyroid==0 & dat$thyroid_yn==1]<-"At Diabetes Onset"
dat$thyroid_timing[dat$time_to_thyroid>0 & dat$thyroid_yn==1]<-"After Diabetes Onset"
dat$thyroid_timing<-as.factor(dat$thyroid_timing)
label(dat$thyroid_timing)<-"Timing of Thyroid Disease"
#treat those with thyroid disease prior at at diabets as missing for now
dat$thyroid_months_if_yes<-NA
dat$thyroid_months_if_yes[dat$thyroid_yn==1]<-dat$time_to_thyroid[dat$thyroid_yn==1]
label(dat$thyroid_months_if_yes)<-"Months from Onset to Thryoid Disease"

dat$thyroid_yn[dat$thyroid_timing=="At Diabetes Onset"]<-NA
dat$thyroid_yn[dat$thyroid_timing=="Before Diabetes Onset"]<-NA
dat$time_to_thyroid[dat$thyroid_timing=="At Diabetes Onset"]<-NA
dat$time_to_thyroid[dat$thyroid_timing=="Before Diabetes Onset"]<-NA
dat$thyroid_months_if_yes[dat$thyroid_timing=="At Diabetes Onset"]<-NA
dat$thyroid_months_if_yes[dat$thyroid_timing=="Before Diabetes Onset"]<-NA
#create dataset for only thyroid, and calculate change in quantities of interest (BMI, labs, etc.)
#dat.thyroid<-subset(dat,dat$thyroid_yn==1)

#celiac
dat$celiac_yn<-NA
dat$celiac_yn[dat$CeliacDisease=="Y"]<-1
dat$celiac_yn[dat$CeliacDisease=="N"]<-0
dat$celiac_yn<-as.factor(dat$celiac_yn)
label(dat$celiac_yn)<-"celiac Y/N"

dat$CeliacDisease_DxDate<-as.POSIXct(dat$CeliacDisease_DxDate,format="%m/%d/%Y")
dat$time_to_celiac<-NA
dat$time_to_celiac[dat$celiac_yn==1]<-difftime(dat$CeliacDisease_DxDate[dat$celiac_yn==1],dat$OnsetDate[dat$celiac_yn==1],unit="days")
dat$time_to_celiac[dat$celiac_yn==0]<-difftime(dat$LastVisitDate[dat$celiac_yn==0],dat$OnsetDate[dat$celiac_yn==0],unit="days")
dat$time_to_celiac<-as.numeric(dat$time_to_celiac)*0.0328767
label(dat$time_to_celiac)<-"Months from Onset to celiac Disease"

dat$celiac_timing<-NA
dat$celiac_timing[dat$time_to_celiac<0 & dat$celiac_yn==1]<-"Before Diabetes Onset"
dat$celiac_timing[dat$time_to_celiac==0 & dat$celiac_yn==1]<-"At Diabetes Onset"
dat$celiac_timing[dat$time_to_celiac>0 & dat$celiac_yn==1]<-"After Diabetes Onset"
dat$celiac_timing<-as.factor(dat$celiac_timing)
label(dat$celiac_timing)<-"Timing of celiac Disease"
#treat those with celiac disease prior at at diabets as missing for now
dat$celiac_months_if_yes<-NA
dat$celiac_months_if_yes[dat$celiac_yn==1]<-dat$time_to_celiac[dat$celiac_yn==1]
label(dat$celiac_months_if_yes)<-"Months from Onset to Celiac Disease"

dat$celiac_yn[dat$celiac_timing=="At Diabetes Onset"]<-NA
dat$celiac_yn[dat$celiac_timing=="Before Diabetes Onset"]<-NA
dat$time_to_celiac[dat$celiac_timing=="At Diabetes Onset"]<-NA
dat$time_to_celiac[dat$celiac_timing=="Before Diabetes Onset"]<-NA
dat$celiac_months_if_yes[dat$celiac_timing=="At Diabetes Onset"]<-NA
dat$celiac_months_if_yes[dat$celiac_timing=="Before Diabetes Onset"]<-NA

#other types of celiac:
dat$celiac_groups<-NA
dat$celiac_groups[dat$celiac_yn==1 & dat$Biopsy=="Positive"]<-"Grp1. Celiac Disease, Positive Biopsy"
dat$celiac_groups[dat$celiac_yn==1 & dat$GlutenFreeDiet=="Y"]<-"Grp2. Celiac Disease, Gluten Free Diet"
dat$celiac_groups[dat$celiac_yn==1 & dat$Biopsy=="Negative" & dat$GlutenFreeDiet=="Y"]<-"Grp3. Celiac Disease, Gluten Free Diet, Negative Biopsy"
dat$celiac_groups[dat$CeliacDisease=="N" & dat$AbnormalPanel=="Y" & is.na(dat$Biopsy)]<-"Grp4. Abnormal panel, no celiac disease, no biopsy"
dat$celiac_groups[dat$CeliacDisease=="N" & dat$AbnormalPanel=="Y" & dat$Biopsy=="Negative"]<-"Grp5. Abnormal panel, no celiac disease, negative biopsy"
dat$celiac_groups<-as.factor(dat$celiac_groups)
label(dat$celiac_groups)<-"Celiac Groups"
#addisons
dat$addison_yn<-NA
dat$addison_yn[dat$AddisonsDisease=="Y"]<-1
dat$addison_yn[dat$AddisonsDisease=="N"]<-0
dat$addison_yn[dat$AddisonsDisease=="NULL"]<-0
dat$addison_yn<-as.factor(dat$addison_yn)
label(dat$addison_yn)<-"Addison Disease Y/N"

dat$AddisonsDisease_DxDate<-as.POSIXct(dat$AddisonsDisease_DxDate,format="%m/%d/%Y")

dat$time_to_addison<-NA
dat$time_to_addison[dat$addison_yn==1 & !is.na(dat$addison_yn)]<-difftime(dat$AddisonsDisease_DxDate[dat$addison_yn==1 & !is.na(dat$addison_yn)],
                                                                    dat$OnsetDate[dat$addison_yn==1  & !is.na(dat$addison_yn)],unit='days') ##1 pt is missing addison date
dat$time_to_addison[dat$addison_yn==0  & !is.na(dat$addison_yn)]<-difftime(dat$LastVisitDate[dat$addison_yn==0  & !is.na(dat$addison_yn)],
                                                                     dat$OnsetDate[dat$addison_yn==0  & !is.na(dat$addison_yn)],unit="days")
dat$time_to_addison<-as.numeric(dat$time_to_addison)*0.0328767

label(dat$time_to_addison)<-"Months from Onset to addison Disease"

dat$addison_timing<-NA
dat$addison_timing[dat$time_to_addison<0 & dat$addison_yn==1]<-"Before Diabetes Onset"
dat$addison_timing[dat$time_to_addison==0 & dat$addison_yn==1]<-"At Diabetes Onset"
dat$addison_timing[dat$time_to_addison>0& dat$addison_yn==1 ]<-"After Diabetes Onset"
dat$addison_timing<-as.factor(dat$addison_timing)
label(dat$addison_timing)<-"Timing of Addison's Disease"

dat$addison_months_if_yes<-NA
dat$addison_months_if_yes[dat$addison_yn==1& !is.na(dat$addison_yn)]<-dat$time_to_addison[dat$addison_yn==1& !is.na(dat$addison_yn)]
label(dat$addison_months_if_yes)<-"Months from Onset to Addison Disease"

#######DISEASE SPECIFIC DATASETS WITH ONLY EVENTS AFTER DIABETES:
# dat.thy<-subset(dat,!(dat$thyroid_timing %in% c('At Diabetes Onset','Before Diabetes Onset')))
# dat.cel<-subset(dat,!(dat$celiac_timing %in% c('At Diabetes Onset','Before Diabetes Onset')))

##ANY CAID?

#first, if event happened before diabetes onset, treat as missing in full dataset
#for survival analysis, will subset to get rid of these pts

dat$any_caid<-NA
dat$any_caid[dat$thyroid_yn==0 & dat$celiac_yn==0 & dat$addison_yn==0]<-0
dat$any_caid[dat$thyroid_yn==1]<-1
dat$any_caid[dat$celiac_yn==1]<-1
dat$any_caid[dat$addison_yn==1]<-1
dat$any_caid<-as.factor(dat$any_caid)
label(dat$any_caid)<-"Thyroid, Celiac, or Addison's Y/N"

dat$time_to_any<-NA
dat$time_to_any<-pmin(dat$thyroid_months_if_yes,dat$celiac_months_if_yes,
                                       dat$addison_months_if_yes,na.rm=T) #pmin results in months
dat$time_to_any[dat$any_caid==0 & !is.na(dat$any_caid)]<-
  difftime(dat$LastVisitDate[dat$any_caid==0 & !is.na(dat$any_caid)],
           dat$OnsetDate[dat$any_caid==0 & !is.na(dat$any_caid)],unit='days')*0.0328767
dat$time_to_any<-as.numeric(dat$time_to_any)
label(dat$time_to_any)<-"Months from Onset to First CAID"

dat$caid_months_if_yes<-NA
dat$caid_months_if_yes[dat$any_caid==1 & !is.na(dat$any_caid)]<-dat$time_to_any[dat$any_caid==1 & !is.na(dat$any_caid)]
label(dat$caid_months_if_yes)<-"Months from Onset to first CAID"

dat$caid_months_if_no<-NA
dat$caid_months_if_no[dat$any_caid==0 & !is.na(dat$any_caid)]<-dat$time_to_any[dat$any_caid==0 & !is.na(dat$any_caid)]
label(dat$caid_months_if_no)<-"Months of follow-up for no CAIDs"

dat$which_caid<-NA
dat$which_caid[dat$time_to_any==dat$thyroid_months_if_yes & dat$thyroid_yn==1]<-"Thyroid"
dat$which_caid[dat$time_to_any==dat$celiac_months_if_yes & dat$celiac_yn==1]<-"Celiac"
dat$which_caid[dat$time_to_any==dat$addison_months_if_yes & dat$addison_yn==1]<-"Addison's"
dat$which_caid<-as.factor(dat$which_caid)
label(dat$which_caid)<-"Which CAID was first"

dat$followup<-NA
dat$followup[dat$any_caid==0 & !is.na(dat$any_caid)]<-dat$time_to_any[dat$any_caid==0 & !is.na(dat$any_caid)]
label(dat$followup)<-"Years of Follow-up for no CAIDs"

#age at each caid:
dat$age_at_thyroid<-as.numeric(difftime(dat$ThyroidDisease_DxDate,dat$DOB,units="days"))/365
label(dat$age_at_thyroid)<-"Age at Thyroid Diagnosis"

dat$age_at_celiac<-as.numeric(difftime(dat$CeliacDisease_DxDate,dat$DOB,units="days"))/365
label(dat$age_at_celiac)<-"Age at Celiac Diagnosis"

dat$age_at_add<-as.numeric(difftime(dat$AddisonsDisease_DxDate,dat$DOB,units="days"))/365
label(dat$age_at_add)<-"Age at Addison Diagnosis"

