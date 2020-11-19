#Clear existing data and graphics
rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
smod1=read.csv('S:/Shared Projects/Laura/BDC/Projects/Sonalee Ravi/ASKED-IT/Data/ASKEDIT_DATA_2018-12-06_1058.csv')
#Setting Labels

label(smod1$pid)="Participant ID"
label(smod1$redcap_event_name)="Event Name"
label(smod1$collaboration_score)="Collaboration with Parents Subscale"
label(smod1$care_subscale)="Care Subscale"
label(smod1$problem_solve_score)="Problem Solving Subscale"
label(smod1$communication_score)="Communication Subscale"
label(smod1$goal_score)="Goals Subscale"
label(smod1$smod_score)="Total Score"
#Setting Units


#Setting Factors(will create new variable for factors)
smod1$redcap_event_name.factor = factor(smod1$redcap_event_name,levels=c("enrollment_arm_1","3_months_arm_1","6_months_arm_1","enrollment_arm_2","3_months_arm_2","6_months_arm_2"))

levels(smod1$redcap_event_name.factor)=c("Enrollment (Arm 1: Control)","3 Months (Arm 1: Control)","6 Months (Arm 1: Control)","Enrollment (Arm 2: Texting)","3 Months (Arm 2: Texting)","6 Months (Arm 2: Texting)")
