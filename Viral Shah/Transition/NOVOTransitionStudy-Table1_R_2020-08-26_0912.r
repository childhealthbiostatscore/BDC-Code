#Read Data
data=read.csv('/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/NOVO Transition/Data_Raw/NOVOTransitionStudy-Table1_DATA_2020-08-26_0912.csv')
#Setting Labels

label(data$record_id)="Record ID"
label(data$randomization_group)="Randomization Group"
label(data$age)="Age"
label(data$gender)="Gender:"
label(data$a1c)="HbA1C point of care value:"
label(data$diabetes_duration)="Diabetes duration:"
label(data$bmi)="BMI:"
label(data$insulin_pump)="What is your method of insulin delivery?"
label(data$cgm)="Do you currently use a continuous glucose monitor?"
label(data$education)="2. What is the highest grade or year of sch...Code GED as 12)"
label(data$insurance_private)="1. Currently have private medical insurance...insurance plan)"
label(data$insurance_medicare)="2. Currently have Medicare"
label(data$insurance_medicaid)="3. Currently have Medicaid, CHP or other government plan"
label(data$insurance_medical)="4. Currently do not have medical insurance"
label(data$insurance_no_answer)="5. No answer/ dont know/ refused"
label(data$diabetes_meds)="Do you take other diabetes medications besides insulin?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$randomization_group.factor = factor(data$randomization_group,levels=c("1","2"))
data$gender.factor = factor(data$gender,levels=c("1","2","3"))
data$insulin_pump.factor = factor(data$insulin_pump,levels=c("1","2","3","4","5"))
data$cgm.factor = factor(data$cgm,levels=c("1","0"))
data$education.factor = factor(data$education,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"))
data$insurance_private.factor = factor(data$insurance_private,levels=c("1","2"))
data$insurance_medicare.factor = factor(data$insurance_medicare,levels=c("1","2"))
data$insurance_medicaid.factor = factor(data$insurance_medicaid,levels=c("1","2"))
data$insurance_medical.factor = factor(data$insurance_medical,levels=c("1","2"))
data$insurance_no_answer.factor = factor(data$insurance_no_answer,levels=c("1","2"))
data$diabetes_meds.factor = factor(data$diabetes_meds,levels=c("1","0"))

levels(data$randomization_group.factor)=c("One to One Ratio","Delayed Transition")
levels(data$gender.factor)=c("Male","Female","Other")
levels(data$insulin_pump.factor)=c("Medtronic insulin pump","Tandem insulin pump","Omnipod","Animas insulin pump","Other insulin pump")
levels(data$cgm.factor)=c("Yes","No")
levels(data$education.factor)=c("No Schooling 01","Less than or equal to 06","07","08","09 (High school)","10","11","12","13 (College)","14","15","16","17 (Graduate school)","18","19","20+","No answer")
levels(data$insurance_private.factor)=c("Yes","No")
levels(data$insurance_medicare.factor)=c("Yes","No")
levels(data$insurance_medicaid.factor)=c("Yes","No")
levels(data$insurance_medical.factor)=c("Yes","No")
levels(data$insurance_no_answer.factor)=c("Yes","No")
levels(data$diabetes_meds.factor)=c("Yes","No")
