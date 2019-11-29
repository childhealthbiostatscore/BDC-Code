#######PI: LAUREL MESSER
#######PROJECT: TANDEM PROs
#
library(Hmisc)
source('S:/Shared Material/Shared Code/R/temp_table1.R')
#1st row is labels, then assign them to the actual variable names:
labels<-read.csv('S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/labels.csv')[1,]
dat<-read.csv('S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/BIQPRO_RawComplete_07.30.csv',
              na.strings=c("","I don't know"))
label(dat[,c(1:131)])<-as.list(names(labels))

#adding baseline age, 8/26:
age<-read.csv('S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/PRO Baseline Age.csv')

dat<-merge(dat,age,by="ExternalReference",all.x=T)

#look at ages:
age<-dat[,c(1,which(colnames(dat)=="Age"),
            which(colnames(dat)=="BaselineAGE"))]
#patient demographics:
#age is at 6 months:
# dat$B_StartDate<-as.POSIXct(dat$B_StartDate,format="%m/%d/%Y %H:%M")
# dat$post6m_StartDate<-as.POSIXct(dat$post6m_StartDate,format="%m/%d/%Y %H:%M")
# dat$yrs_in_study<-(dat$post6m_StartDate-dat$B_StartDate)/365
# 
# dat$age_at_baseline<-as.numeric(dat$Age-dat$yrs_in_study)
#date of diagnosis: 2 year date format, but some are 19 and some are 20:
#any dates between 00 and 19 are 2000s, any greater than 19 are 1900s
dat$date_of_dx_year<-substr(dat$DateOfDiagnosis,nchar(as.character(dat$DateOfDiagnosis))-1,
                            nchar(as.character(dat$DateOfDiagnosis)))
dat$date_of_dx_year4<-NA
dat$date_of_dx_year4[dat$date_of_dx_year<=19 &!is.na(dat$date_of_dx_year)]<-
  paste0("20",dat$date_of_dx_year[dat$date_of_dx_year<=19 &!is.na(dat$date_of_dx_year)])
dat$date_of_dx_year4[dat$date_of_dx_year>19 &!is.na(dat$date_of_dx_year)]<-
  paste0("19",dat$date_of_dx_year[dat$date_of_dx_year>19 &!is.na(dat$date_of_dx_year)])
dat$DateOfDiagnosis_4<-substr(as.character(dat$DateOfDiagnosis),0,nchar(as.character(dat$DateOfDiagnosis))-2)
dat$DateOfDiagnosis_4<-paste0(dat$DateOfDiagnosis_4,as.character(dat$date_of_dx_year4))
#temp<-dat[,c(123,141:143)]
dat$DateOfDiagnosis_4<-as.POSIXct(dat$DateOfDiagnosis_4,format="%d-%B-%Y")
dat$B_StartDate<-as.POSIXct(dat$B_StartDate,format="%m/%d/%Y %H:%M")
dat$duration_of_diabetes_at_baseline_days<-dat$B_StartDate-dat$DateOfDiagnosis_4
dat$duration_of_diabetes_at_baseline_years<-as.numeric(dat$duration_of_diabetes_at_baseline_days)/365
label(dat$duration_of_diabetes_at_baseline_years)<-"Duration of diabetes at baseline (years)"
# dist_check(dat$duration_of_diabetes_at_baseline_years) 

dat$DiabetesType<-as.factor(dat$DiabetesType) #1061 Type 1 - remove all "type 2","unknown" and "missing"??


dat$cgm_yn<-NA
dat$cgm_yn[dat$B_CGMUSE=="No, I do not currently use a CGM, but I used to in the past."]<-"Yes"
dat$cgm_yn[dat$B_CGMUSE=="Yes, I use a Dexcom CGM."]<-"Yes"
dat$cgm_yn[dat$B_CGMUSE=="Yes, I use a Medtronic CGM."]<-"Yes"
dat$cgm_yn[dat$B_CGMUSE=="Yes, I use the Abbott Freestyle Libre."]<-"Yes"
dat$cgm_yn[dat$B_CGMUSE=="No, I have never used a CGM."]<-"No"
dat$cgm_yn<-as.factor(dat$cgm_yn)
label(dat$cgm_yn)<-"Any previous CGM use?"
dat$BaselineMethod<-as.factor(dat$BaselineMethod)

dat$method_cat<-NA
dat$method_cat[dat$BaselineMethod=="Animas Insulin Pump"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod=="Insulet OmniPod Insulin Pump"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod=="Medtronic MiniMed Insulin Pump"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod=="Multiple Daily Injections (e.g., insulin pen, syringe)"]<-"Injections"
dat$method_cat[dat$BaselineMethod=="Other (Please Specify)"]<-"Other"
dat$method_cat[dat$BaselineMethod=="Roche Accu-Chek Insulin Pump"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod=="Tandem Insulin Pump"]<-"Tandem Pump"
dat$method_cat<-as.factor(dat$method_cat)
label(dat$method_cat)<-"Previous insulin method"

dat$age_cat<-NA
dat$age_cat[dat$Age<18]<-"<18"
dat$age_cat[dat$Age>=18]<-">=18"

dat$age_cat<-as.factor(dat$age_cat)
label(dat$age_cat)<-"Age, categorical"

table(dat$B_RESPONDENT)
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Both"]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="both of the above"]<-"A Parent/Guardian/Caregiver of someone with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Both person with diabetes and parent of diabetic"]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="both, my daughter and myself have diabetes"]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Diabetic"]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="I am both of the above options."]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Mom"]<-"A Parent/Guardian/Caregiver of someone with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="wife of person with diabetes"]<-"A Parent/Guardian/Caregiver of someone with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="I am a person with diabetes."]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Mother"]<-"A Parent/Guardian/Caregiver of someone with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Parent"]<-"A Parent/Guardian/Caregiver of someone with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Self"]<-"Person with Diabetes"

dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Both, patients and parent"]<-"A Parent/Guardian/Caregiver of someone with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Also grandparent of a diabetic."]<-"A Parent/Guardian/Caregiver of someone with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="I have it and my daughter does as well"]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="T1 diabetic with T1 child"]<-"Person with Diabetes"

table(dat$B_RESPONDENT_OTHER[dat$B_RESPONDENT=="Other (Please Specify)"],
      dat$Age[dat$B_RESPONDENT=="Other (Please Specify)"])

table(dat$BaselineMethod)
table(dat$BaselineMethod_other)
dat$method_cat[dat$BaselineMethod_other=="Medtronic 670G"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="Medtronic 670g"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="Parasympathetic 723"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="Pen but previously had Animas Pump"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="previously used omnipod"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="V go"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="Vgo"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="VGO 40"]<-"Non-Tandem Pump"

dat$method_cat[dat$BaselineMethod_other=="Loop DIY closed-loop system"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="deltec cozmo insulin pump"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="Both X2 and Omnipod"]<-"Non-Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="both Medtronic and Tandem pumps"]<-"Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="Animas, MDI and now tandem"]<-"Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="Tandem loaner"]<-"Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="dx mid june and used pens/syringes until started tandem mid july"]<-"Tandem Pump"
dat$method_cat[dat$BaselineMethod_other=="just switched to Tandem"]<-"Tandem Pump"

###Survey Data: BASELINE
#first remove qualitative questions:
dat<-dat[,-c(which(colnames(dat)=="Baseline_1.qualitative"),
             which(colnames(dat)=="Baseline_2.qualitative"),
             which(colnames(dat)=="post6m_1.qualitative"),
             which(colnames(dat)=="post6m_2.qualitative"))]
replace<-function(x){
  #x<-dat$post6m_2
  temp<-x
  temp<-factor(x,levels=c(levels(x),"1","10"))
  temp[temp=="Very Unsatisfied\n1"]<-1
  temp[temp=="Very\nSatisfied\n10"]<-10
  temp[temp=="Not At All\n\n1"]<-1
  temp[temp=="Not at all\n1"]<-1
  temp[temp=="A Lot\n\n10"]<-10
  temp[temp=="A lot\n10"]<-10
  temp[temp=="Strongly\nDisagree\n1"]<-1
  temp[temp=="Strongly\nAgree\n10"]<-10
  temp[temp=="Never\n1"]<-1
  temp[temp=="Always\n10"]<-10
  temp[temp=="A lot less\n1"]<-1
  temp[temp=="A lot more\n10"]<-10
  temp[temp=="All the time\n10"]<-10
  temp<-factor(temp)
  temp<-as.numeric(as.character(temp))
  label(temp)<-paste0(label(x))
  return(temp)
}

dat[,c(which(colnames(dat)=="Baseline_1"):
         which(colnames(dat)=="Baseline_12"))]<-lapply(dat[,c(which(colnames(dat)=="Baseline_1"):
                                                                which(colnames(dat)=="Baseline_12"))],replace)
dat[,c(which(colnames(dat)=="post2m_1"):
         which(colnames(dat)=="post2m_12"))]<-lapply(dat[,c(which(colnames(dat)=="post2m_1"):
                                                            which(colnames(dat)=="post2m_12"))],replace)
dat[,c(which(colnames(dat)=="post4m_1"):
         which(colnames(dat)=="post4m_12"))]<-lapply(dat[,c(which(colnames(dat)=="post4m_1"):
                                                            which(colnames(dat)=="post4m_12"))],replace)
dat[,c(which(colnames(dat)=="post6m_1"):
         which(colnames(dat)=="post6m_12"))]<-lapply(dat[,c(which(colnames(dat)=="post6m_1"):
                                                              which(colnames(dat)=="post6m_12"))],replace)

dat[,c(which(colnames(dat)=="post2m_BIQuse"),
         which(colnames(dat)=="post4m_BIQuse"),
          which(colnames(dat)=="post6m_BIQuse"))]<-lapply(dat[,c(which(colnames(dat)=="post2m_BIQuse"),
                                                                 which(colnames(dat)=="post4m_BIQuse"),
                                                                 which(colnames(dat)=="post6m_BIQuse"))],replace)
dat$post2m_BIQ_YES<-as.factor(ifelse(dat$post2m_BIQuse==1,0,1))
dat$post4m_BIQ_YES<-as.factor(ifelse(dat$post4m_BIQuse==1,0,1))
dat$post6m_BIQ_YES<-as.factor(ifelse(dat$post6m_BIQuse==1,0,1))
label(dat$post2m_BIQ_YES)<-"2mo: used BIQ"
label(dat$post4m_BIQ_YES)<-"4mo: used BIQ"
label(dat$post6m_BIQ_YES)<-"6mo: used BIQ"


#SURVEY COMPLETION DATA:
y_n<-function(x){
  temp<-x
  temp.2<-NA
  temp.2<-ifelse(is.na(temp),0,1)
  return(temp.2)
}

dat<-cbind(dat, setNames(lapply(dat[,c(which(colnames(dat)=="Baseline_1"):
                                    which(colnames(dat)=="Baseline_12"),
                                    which(colnames(dat)=="post2m_1"):
                                      which(colnames(dat)=="post2m_12"),
                                    which(colnames(dat)=="post4m_1"):
                                      which(colnames(dat)=="post4m_12"),
                                    which(colnames(dat)=="post6m_1"):
                                      which(colnames(dat)=="post6m_12"))], y_n),
                   paste0(names(dat[,c(which(colnames(dat)=="Baseline_1"):
                                         which(colnames(dat)=="Baseline_12"),
                                       which(colnames(dat)=="post2m_1"):
                                         which(colnames(dat)=="post2m_12"),
                                       which(colnames(dat)=="post4m_1"):
                                         which(colnames(dat)=="post4m_12"),
                                       which(colnames(dat)=="post6m_1"):
                                         which(colnames(dat)=="post6m_12"))]), "_yn")))

dat$baseline_num_complete<-rowSums(dat[,c(which(colnames(dat)=="Baseline_1_yn"):
                                            which(colnames(dat)=="Baseline_12_yn"))])

dat$post2m_num_complete<-rowSums(dat[,c(which(colnames(dat)=="post2m_1_yn"):
                                            which(colnames(dat)=="post2m_12_yn"))])

dat$post4m_num_complete<-rowSums(dat[,c(which(colnames(dat)=="post4m_1_yn"):
                                            which(colnames(dat)=="post4m_12_yn"))])

dat$post6m_num_complete<-rowSums(dat[,c(which(colnames(dat)=="post6m_1_yn"):
                                            which(colnames(dat)=="post6m_12_yn"))])

dat[,c(which(colnames(dat)=="baseline_num_complete"):
         which(colnames(dat)=="post6m_num_complete"))]<-lapply(dat[,c(which(colnames(dat)=="baseline_num_complete"):
                                                                        which(colnames(dat)=="post6m_num_complete"))],
                                                               as.factor)
label(dat$baseline_num_complete)<-"Number of questions completed at baseline"
label(dat$post2m_num_complete)<-"Number of questions completed at 2 mo"
label(dat$post4m_num_complete)<-"Number of questions completed at 4 mo"
label(dat$post6m_num_complete)<-"Number of questions completed at 6 mo"

dat$baseline_complete_yn<-as.factor(ifelse(dat$baseline_num_complete==12,1,0))
dat$post2m_complete_yn<-as.factor(ifelse(dat$post2m_num_complete==12,1,0))
dat$post4m_complete_yn<-as.factor(ifelse(dat$post4m_num_complete==12,1,0))
dat$post6m_complete_yn<-as.factor(ifelse(dat$post6m_num_complete==12,1,0))

label(dat$baseline_complete_yn)<-"Baseline fully completed"
label(dat$post2m_complete_yn)<-"2mo fully completed"
label(dat$post4m_complete_yn)<-"4mo fully completed"
label(dat$post6m_complete_yn)<-"6mo fully completed"

#combinations of survey missingness:
dat$baseline_2mo_complete<-as.factor(ifelse(dat$baseline_complete_yn==1 & dat$post2m_complete_yn==1,1,0))
dat$baseline_4mo_complete<-as.factor(ifelse(dat$baseline_complete_yn==1 & dat$post4m_complete_yn==1,1,0))
dat$baseline_2mo_or_4mo_complete<-as.factor(ifelse(dat$post2m_complete_yn==1 | dat$post4m_complete_yn==1,1,0))
dat$baseline_6mo_complete<-as.factor(ifelse(dat$baseline_complete_yn==1 & dat$post6m_complete_yn==1,1,0))
dat$post2mo_6mo_complete<-as.factor(ifelse(dat$post2m_complete_yn==1 & dat$post6m_complete_yn==1,1,0))
dat$post4mo_6mo_complete<-as.factor(ifelse(dat$post4m_complete_yn==1 & dat$post6m_complete_yn==1,1,0))
dat$post2mo_or_4mo_6mo_complete<-as.factor(ifelse(dat$post2mo_6mo_complete==1 | dat$post4mo_6mo_complete==1,1,0))
dat$cohort_complete<-as.factor(ifelse(dat$baseline_6mo_complete==1 & dat$baseline_complete_yn==1 &
                                        (dat$baseline_2mo_complete==1 | dat$baseline_4mo_complete==1),1,0))
dat$allcomplete<-as.factor(ifelse(dat$baseline_complete_yn==1 & dat$post2m_complete_yn==1 & dat$post6m_complete_yn==1,1,0))
label(dat$baseline_2mo_complete)<-"Baseline and 2mo Complete"
label(dat$baseline_4mo_complete)<-"Baseline and 4mo Complete"
label(dat$baseline_2mo_or_4mo_complete)<-"Baseline and 2mo OR 4mo Complete"
label(dat$baseline_6mo_complete)<-"Baseline and 6mo Complete"
label(dat$post2mo_6mo_complete)<-"2mo and 6mo Complete"
label(dat$post4mo_6mo_complete)<-"4mo and 6mo Complete"
label(dat$post2mo_or_4mo_6mo_complete)<-"2mo OR 4mo, and 6mo Complete"
label(dat$allcomplete)<-"All time points Complete"
label(dat$cohort_complete)<-"In Cohort - baseline, mid-point, and 6 month complete"
###determine which midpoint survey to use:
dat$mid_point<-NA
dat$mid_point[dat$baseline_2mo_complete==1]<-"2 mo"
dat$mid_point[dat$baseline_4mo_complete==1 & dat$baseline_2mo_complete==0]<-"4 mo"
dat$mid_point<-as.factor(dat$mid_point)
label(dat$mid_point)<-"First mid-point survey"

dat$midpoint_num_complete<-NA
dat$midpoint_num_complete[dat$mid_point=="2 mo" & !is.na(dat$mid_point)]<-as.character(dat$post2m_num_complete[dat$mid_point=="2 mo" & 
                                                                                                                 !is.na(dat$mid_point)])
dat$midpoint_num_complete[dat$mid_point=="4 mo" & !is.na(dat$mid_point)]<-as.character(dat$post4m_num_complete[dat$mid_point=="4 mo" & 
                                                                                                                 !is.na(dat$mid_point)])
dat$midpoint_num_complete<-as.factor(dat$midpoint_num_complete)
label(dat$midpoint_num_complete)<-"Number of questions completed at midpoint"


dat.all<-subset(dat,dat$DiabetesType=="Type 1")

#COHORT FOR SURVEY ANALYSIS:
dat<-subset(dat.all,dat.all$cohort_complete==1)


dat$method_cat<-factor(dat$method_cat)
table(dat$method_cat,useNA="always")


table(dat$B_RESPONDENT)
table(dat$B_RESPONDENT_OTHER)
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Both"]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="both of the above"]<-"A Parent/Guardian/Caregiver of someone with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Both person with diabetes and parent of diabetic"]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="both, my daughter and myself have diabetes"]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Diabetic"]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="I am both of the above options."]<-"Person with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="Mom"]<-"A Parent/Guardian/Caregiver of someone with Diabetes"
dat$B_RESPONDENT[dat$B_RESPONDENT_OTHER=="wife of person with diabetes"]<-"A Parent/Guardian/Caregiver of someone with Diabetes"

dat$B_RESPONDENT<-factor(dat$B_RESPONDENT)
label(dat$B_RESPONDENT)<-"Respondent Type"
label(dat$Age)<-"Age at 6 mo Survey, years"
label(dat$Baseline_A1C)<-"HbA1c at baseline"
label(dat$Gender)<-"Gender"
