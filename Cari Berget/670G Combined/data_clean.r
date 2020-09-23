#Read Data
data=read.csv('./Data_Cleaned/data.csv',na.strings = "")
#Setting Labels

label(data$record_id)="Record ID"
label(data$redcap_event_name)="Event Name"
label(data$demographics_hcl)="Hybrid Closed Loop System"
label(data$demographics_dob)="Date of Birth"
label(data$demographics_sex)="Gender"
label(data$demographics_t1d_duration)="Duration of diabetes at enrollment"
label(data$demographics_race)="Race"
label(data$demographics_ethnicity)="Ethnicity"
label(data$demographics_insurance)="Insurance"
label(data$gyl_timepoint)="Time Point"
label(data$date_visit)="Date of Clinic Visit "
label(data$hba1c)="HbA1c "
label(data$time_am)="Time in Closed Loop (CL) (%)"
label(data$time_mm)="Time in Manual Mode (%)"
label(data$sensor_wear)="Sensor wear (%)"
label(data$sensor_u54)="% time under 54 mg/dL"
label(data$sensor_54_69)="% time sensor values 54-69 mg/dL"
label(data$sensor_70_180)="% time sensor values 70-180 mg/dL"
label(data$sensor_181_250)="% time sensor values 181-250 mg/dL"
label(data$sensor_g250)="% time sensor values > 250 mg/dL"
label(data$sensor_mean)="Average sensor glucose value  "
label(data$sensor_sd)="Standard deviation of sensor glucose values "
label(data$amexits)="Total # of auto mode exits "
label(data$amexit_hyper)="# of auto mode exits related to hyperglycemia  "
label(data$amexit_manual)="# of exits due to patient manually disabling auto mode"
label(data$amexits_day)="Average # of auto mode exits per day "
label(data$amexits_other)="All auto mode exits other than hyper, hypo and manual"
label(data$automode_start)="Date of Closed Loop (CL) Start"
label(data$bg_checks)="Average BG checks per day"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("baseline_arm_1","1_arm_1","2_arm_1","3_arm_1","4_arm_1","5_arm_1","6_arm_1","baseline_arm_2","1_arm_2","2_arm_2","3_arm_2","4_arm_2","5_arm_2","6_arm_2","baseline_arm_3","1_arm_3","2_arm_3","3_arm_3","4_arm_3","5_arm_3"))
data$demographics_hcl.factor = factor(data$demographics_hcl,levels=c("0","1"))
data$demographics_sex.factor = factor(data$demographics_sex,levels=c("0","1"))
data$demographics_race.factor = factor(data$demographics_race,levels=c("0","1","2","3","4","5","6"))
data$demographics_ethnicity.factor = factor(data$demographics_ethnicity,levels=c("0","1","2"))
data$demographics_insurance.factor = factor(data$demographics_insurance,levels=c("1","2","3"))
data$gyl_timepoint.factor = factor(data$gyl_timepoint,levels=c("0","1","2","3","4","5"))

levels(data$redcap_event_name.factor)=c("Baseline (Arm 1: Child)","1 (Arm 1: Child)","2 (Arm 1: Child)","3 (Arm 1: Child)","4 (Arm 1: Child)","5 (Arm 1: Child)","6 (Arm 1: Child)","Baseline (Arm 2: Young Adult )","1 (Arm 2: Young Adult )","2 (Arm 2: Young Adult )","3 (Arm 2: Young Adult )","4 (Arm 2: Young Adult )","5 (Arm 2: Young Adult )","6 (Arm 2: Young Adult )","Baseline (Arm 3: Adult)","1 (Arm 3: Adult)","2 (Arm 3: Adult)","3 (Arm 3: Adult)","4 (Arm 3: Adult)","5 (Arm 3: Adult)")
levels(data$demographics_hcl.factor)=c("670G","Control IQ")
levels(data$demographics_sex.factor)=c("Female","Male")
#levels(data$demographics_race.factor)=c("American Indian/Alaska Native","Asian","Native Hawaiian or Other Pacific Islander","Black or African American","White","More Than One Race","Unknown / Not Reported")
levels(data$demographics_race.factor)=c("Non-white","Non-white","Non-white","Non-white","White","More Than One Race","Unknown / Not Reported")
levels(data$demographics_ethnicity.factor)=c("Hispanic or Latino","NOT Hispanic or Latino","Unknown / Not Reported")
levels(data$demographics_insurance.factor)=c("Public","Private","Other")
levels(data$gyl_timepoint.factor)=c("Baseline","Month 1/ Training F/U","3 Months","6 Months","9 Months","12 Months")
