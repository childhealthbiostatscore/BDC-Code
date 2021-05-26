graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('S:/Shared Projects/Laura/BDC/Projects/Sonalee Ravi/ASKED-IT/Data/ASKEDIT_DATA_2018-12-05_1420.csv')
#Setting Labels

label(data$pid)="Participant ID"
label(data$redcap_event_name)="Event Name"
label(data$age)="Age"
label(data$nih_sex)="Gender"
label(data$diab_durration)="Diabetes Duration"
label(data$nih_race)="Race  (Choose the one with which you MOST CLOSELY identify)"
label(data$ethnicity)="Ethnicity"
label(data$zipcode)="Zipcode"
label(data$insulindelivery)="How do you regularly give your insulin?"
label(data$pumpkind)="What kind of pump do you have?"
label(data$basalinsulin)="What is your long acting insulin?"
label(data$cgm)="Do you use a continuous glucose monitor?"
label(data$othercgm)="What kind of continuous glucose monitor do you use?"
label(data$grade)="Grade in School"
label(data$insurance)="What type of insurance do you have?"
label(data$homes)="Do you live in more than one household?"
label(data$income)="What is the total family income, before taxes, of all the adult members in the household where you spend most of your time?"
label(data$mwikadenroll)="Enrollment MWIKAD Score"
label(data$enrolla1c)="Enrollment A1c"
label(data$enrollbgfrequency)="Enrollment BG testing frequency"
label(data$enrollhigh)="Enrollment % high"
label(data$enrollinrange)="Enrollment % in range"
label(data$enrolllow)="Enrollment % low"
label(data$mwikad3month)="3 month MWIKAD"
label(data$a1c3month)="3 month A1C"
label(data$bgtest3month)="3 month BG testing frequency"
label(data$high3month)="3 month % high"
label(data$inrange3month)="3 month % in range"
label(data$low3month)="3 month % low"
label(data$mwikad6month)="6 month MWIKAD"
label(data$a1c6month)="6 month A1c"
label(data$testing6month)="6 month BG testing frequency"
label(data$high6month)="6 month % high"
label(data$inrange6month)="6 month % in rage"
label(data$low6month)="6 month % low"
label(data$response_rate)="3 month response rate"
label(data$response_rate_6_months)="6 month response rate"
label(data$totalenroll)="SMODA Enrollment Total Score"
label(data$totalsmod3month)="SMODA 3 month total score"
label(data$totalsmod6month)="SMODA 6 month Total Score"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("enrollment_arm_1","3_months_arm_1","6_months_arm_1","enrollment_arm_2","3_months_arm_2","6_months_arm_2"))
data$nih_sex.factor = factor(data$nih_sex,levels=c("1","2","3"))
data$nih_race.factor = factor(data$nih_race,levels=c("1","2","3","4","5","6","7"))
data$ethnicity.factor = factor(data$ethnicity,levels=c("1","2","3"))
data$insulindelivery.factor = factor(data$insulindelivery,levels=c("0","1","2"))
data$pumpkind.factor = factor(data$pumpkind,levels=c("1","2","3","4","5","6","7"))
data$basalinsulin.factor = factor(data$basalinsulin,levels=c("1","2","3","4"))
data$cgm.factor = factor(data$cgm,levels=c("Dexcom","Medtronic","Other","No"))
data$grade.factor = factor(data$grade,levels=c("1","2","3","4","5","6","7","8","9"))
data$insurance.factor = factor(data$insurance,levels=c("1","2","3","4","5","6"))
data$homes.factor = factor(data$homes,levels=c("1","2","3"))
data$income.factor = factor(data$income,levels=c("1","2","3","4","5","6","7","8","9","10"))

levels(data$redcap_event_name.factor)=c("Enrollment (Arm 1: Control)","3 Months (Arm 1: Control)","6 Months (Arm 1: Control)","Enrollment (Arm 2: Texting)","3 Months (Arm 2: Texting)","6 Months (Arm 2: Texting)")
levels(data$nih_sex.factor)=c("Female","Male","Unknown or Not Reported")
levels(data$nih_race.factor)=c("American Indian or Alaska Native","Asian","Black or African-American","Native Hawaiian or Other Pacific Islander","White","More than one race","Unknown or not reported")
levels(data$ethnicity.factor)=c("Hispanic or Latino","Not Hispanic or Latino","Unknown or not reported")
levels(data$insulindelivery.factor)=c("Insulin Pump","Insulin shots with carbohydrate counting","Insulin shots with set doses at meals based on blood sugar")
levels(data$pumpkind.factor)=c("Medtronic Revel, Paradigm or 530G","Medtronic 630G","Medtronic 670G","Animus Ping or Animus Vibe","Omnipod","Tandem T-slim or T-Flex","Other")
levels(data$basalinsulin.factor)=c("Lantus","Levemir","Tresiba","Other")
levels(data$cgm.factor)=c("Yes, Dexcom","Yes, Medtronic","Yes, Other","No")
levels(data$grade.factor)=c("7th","8th","9th","10th","11th","12th","Graduated high school, currently enrolled in college","Graduated high school, not enrolled in college","I got my GED")
levels(data$insurance.factor)=c("Private Insurance","Medicaid","Medicare","CHP+","Tricare","Currently do not have medical insurance")
levels(data$homes.factor)=c("Yes, I spend about equal time in each","Yes, but I mostly spend time at one","No")
#levels(data$income.factor)=c("$150,000","I dont know")
