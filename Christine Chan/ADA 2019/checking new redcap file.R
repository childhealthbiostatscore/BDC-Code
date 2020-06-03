#Load Hmisc library
library(Hmisc)
#Read Data
data <- read.csv("S:\\Shared Projects\\Laura\\Laura Tim projects\\Christine Chan\\2019 ADA Abstracts\\Data_Raw\\ADA 2019 report not excluding missing fsOGTTs.csv")
#Setting Labels

label(data$subject_id)="Subject ID"
label(data$age_at_visit_1)="Age at Visit 1"
label(data$race_ethnicity)="Race Ethnicity"
label(data$gender)="Gender"
label(data$poc_a1c)="POC A1c"
label(data$g_tube_feeds)="G-Tube Feeds"
label(data$raw_fev1)="FEV1 (L)"
label(data$raw_fvc)="FVC (L)"
label(data$cf_pancreatic)="CF Pancreatic"
label(data$tanner_stage_female_pubic___1)="Tanner Stage Female Pubic Hair (choice=1)"
label(data$tanner_stage_female_pubic___2)="Tanner Stage Female Pubic Hair (choice=2)"
label(data$tanner_stage_female_pubic___3)="Tanner Stage Female Pubic Hair (choice=3)"
label(data$tanner_stage_female_pubic___4)="Tanner Stage Female Pubic Hair (choice=4)"
label(data$tanner_stage_female_pubic___5)="Tanner Stage Female Pubic Hair (choice=5)"
label(data$tanner_stage_female_breast___1)="Tanner Stage Female Breast Development (choice=1)"
label(data$tanner_stage_female_breast___2)="Tanner Stage Female Breast Development (choice=2)"
label(data$tanner_stage_female_breast___3)="Tanner Stage Female Breast Development (choice=3)"
label(data$tanner_stage_female_breast___4)="Tanner Stage Female Breast Development (choice=4)"
label(data$tanner_stage_female_breast___5)="Tanner Stage Female Breast Development (choice=5)"
label(data$tanner_stage___1)="Tanner Stage Male Pubic Hair (choice=1)"
label(data$tanner_stage___2)="Tanner Stage Male Pubic Hair (choice=2)"
label(data$tanner_stage___3)="Tanner Stage Male Pubic Hair (choice=3)"
label(data$tanner_stage___4)="Tanner Stage Male Pubic Hair (choice=4)"
label(data$tanner_stage___5)="Tanner Stage Male Pubic Hair (choice=5)"
label(data$tanner_stage_male_testicul___1)="Tanner Stage Male Testicular Volume (choice=1)"
label(data$tanner_stage_male_testicul___2)="Tanner Stage Male Testicular Volume (choice=2)"
label(data$tanner_stage_male_testicul___3)="Tanner Stage Male Testicular Volume (choice=3)"
label(data$tanner_stage_male_testicul___4)="Tanner Stage Male Testicular Volume (choice=4)"
label(data$tanner_stage_male_testicul___5)="Tanner Stage Male Testicular Volume (choice=5)"
label(data$bmi_z_score)="BMI Z-score Visit 1"
label(data$min_minus_10_glucose)="-10 Minute Glucose"
label(data$lab_ogtt_fasting)="Lab OGTT Fasting Glucose"
label(data$min_10_glucose)="10 Minute Glucose"
label(data$min_20_glucose)="20 Minute Glucose"
label(data$min_30_glucose)="30 Minute Glucose"
label(data$lab_ogtt_1_hour_glucose)="Lab OGTT 1 hour Glucose"
label(data$min_90_glucose)="90 Minute Glucose"
label(data$lab_ogtt_2_hour_glucose)="Lab OGTT 2 hour Glucose"
label(data$min_150_glucose)="150 Minute Glucose"
label(data$min_180_glucose)="180 Minute Glucose"
label(data$min_minus_10_insulin)="-10 Minute Insulin"
label(data$min_0_insulin)="0 Minute Insulin"
label(data$min_10_insulin)="10 Minute Insulin"
label(data$min_20_insulin)="20 Minute Insulin"
label(data$min_30_insulin)="30 Minute Insulin"
label(data$min_60_insulin)="60 Minute Insulin"
label(data$min_90_insulin)="90 Minute Insulin"
label(data$min_120_insulin)="120 Minute Insulin"
label(data$min_150_insulin)="150 Minute Insulin"
label(data$min_180_insulin)="180 Minute Insulin"
label(data$min_minus_10_c_peptide)="-10 Minute C-peptide"
label(data$min_0_c_peptide)="0 Minute C-peptide"
label(data$min_10_c_peptide)="10 Minute C-peptide"
label(data$min_20_c_peptide)="20 Minute C-peptide"
label(data$min_30_c_peptide)="30 Minute C-peptide"
label(data$min_60_c_peptide)="60 Minute C-peptide"
label(data$min_90_c_peptide)="90 Minute C-peptide"
label(data$min_120_c_peptide)="120 Minute C-peptide"
label(data$min_150_c_peptide)="150 Minute C-peptide"
label(data$min_180_c_peptide)="180 Minute C-peptide"
label(data$min_sensor)="Minimum Sensor Reading"
label(data$max_sensor)="Maximum Sensor Reading"
label(data$average_sensor)="Average Sensor "
label(data$average_auc_per_day)="Average AUC per Day"
label(data$avg_excur_over_200_per_day)="Average Excursions > 200 per Day"
label(data$avg_excur_over_140_per_day)="Average Excursions > 140 per Day"
label(data$excursions_over_200)="Excursions Over 200 "
label(data$excursions_over_140)="Excursions Over 140"
label(data$percent_time_under_60)="Percent Time Spent < 60"
label(data$percent_time_under_70)="Percent Time Spent < 70"
label(data$percent_time_over_140)="Percent Time Spent > 140"
label(data$min_spent_under_60)="Time Spent < 60"
label(data$min_spent_under_70)="Time Spent < 70"
label(data$min_spent_over_200)="Time Spent > 200"
label(data$min_spent_over_140)="Time Spent > 140"
label(data$total_auc)="Total AUC"
label(data$standard_deviation)="Standard Deviation"
label(data$r_mage)="R MAGE"
label(data$mean_amp_glycemic_ex)="Mean Amplitude Glycemic Excursion (MAGE)"
label(data$min_minus_10_glucagon)="-10 Minute Glucagon"
label(data$min_0_glucagon)="0 Minute Glucagon"
label(data$min_10_glucagon)="10 Minute Glucagon"
label(data$min_20_glucagon)="20 Minute Glucagon"
label(data$min_30_glucagon)="30 Minute Glucagon"
label(data$min_60_glucagon)="60 Minute Glucagon"
label(data$min_90_glucagon)="90 Minute Glucagon"
label(data$min_120_glucagon)="120 Minute Glucagon"
label(data$min_150_glucagon)="150 Minute Glucagon"
label(data$min_180_glucagon)="180 Minute Glucagon"
label(data$group_category)="Combined Group Category"
label(data$fvc_and_fev1_date)="FVC and FEV1 Date"
label(data$average_height)="Average Height"
label(data$days_btw_cgm_and_pfts)="Days Between CGM Placement and PFTs"
#Setting Units


#Setting Factors(will create new variable for factors)
data$race_ethnicity.factor = factor(data$race_ethnicity,levels=c("1","2","3","4","5","6"))
data$gender.factor = factor(data$gender,levels=c("1","2"))
data$g_tube_feeds.factor = factor(data$g_tube_feeds,levels=c("1","0"))
data$cf_pancreatic.factor = factor(data$cf_pancreatic,levels=c("1","2"))
data$tanner_stage_female_pubic___1.factor = factor(data$tanner_stage_female_pubic___1,levels=c("0","1"))
data$tanner_stage_female_pubic___2.factor = factor(data$tanner_stage_female_pubic___2,levels=c("0","1"))
data$tanner_stage_female_pubic___3.factor = factor(data$tanner_stage_female_pubic___3,levels=c("0","1"))
data$tanner_stage_female_pubic___4.factor = factor(data$tanner_stage_female_pubic___4,levels=c("0","1"))
data$tanner_stage_female_pubic___5.factor = factor(data$tanner_stage_female_pubic___5,levels=c("0","1"))
data$tanner_stage_female_breast___1.factor = factor(data$tanner_stage_female_breast___1,levels=c("0","1"))
data$tanner_stage_female_breast___2.factor = factor(data$tanner_stage_female_breast___2,levels=c("0","1"))
data$tanner_stage_female_breast___3.factor = factor(data$tanner_stage_female_breast___3,levels=c("0","1"))
data$tanner_stage_female_breast___4.factor = factor(data$tanner_stage_female_breast___4,levels=c("0","1"))
data$tanner_stage_female_breast___5.factor = factor(data$tanner_stage_female_breast___5,levels=c("0","1"))
data$tanner_stage___1.factor = factor(data$tanner_stage___1,levels=c("0","1"))
data$tanner_stage___2.factor = factor(data$tanner_stage___2,levels=c("0","1"))
data$tanner_stage___3.factor = factor(data$tanner_stage___3,levels=c("0","1"))
data$tanner_stage___4.factor = factor(data$tanner_stage___4,levels=c("0","1"))
data$tanner_stage___5.factor = factor(data$tanner_stage___5,levels=c("0","1"))
data$tanner_stage_male_testicul___1.factor = factor(data$tanner_stage_male_testicul___1,levels=c("0","1"))
data$tanner_stage_male_testicul___2.factor = factor(data$tanner_stage_male_testicul___2,levels=c("0","1"))
data$tanner_stage_male_testicul___3.factor = factor(data$tanner_stage_male_testicul___3,levels=c("0","1"))
data$tanner_stage_male_testicul___4.factor = factor(data$tanner_stage_male_testicul___4,levels=c("0","1"))
data$tanner_stage_male_testicul___5.factor = factor(data$tanner_stage_male_testicul___5,levels=c("0","1"))
data$group_category.factor = factor(data$group_category,levels=c("1","2","3","4"))

levels(data$race_ethnicity.factor)=c("White","Black/African American","Asian","Native American","Hispanic","Other/Multiple")
levels(data$gender.factor)=c("Male","Female")
levels(data$g_tube_feeds.factor)=c("Yes","No")
levels(data$cf_pancreatic.factor)=c("Sufficient","Insufficient")
levels(data$tanner_stage_female_pubic___1.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_female_pubic___2.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_female_pubic___3.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_female_pubic___4.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_female_pubic___5.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_female_breast___1.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_female_breast___2.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_female_breast___3.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_female_breast___4.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_female_breast___5.factor)=c("Unchecked","Checked")
levels(data$tanner_stage___1.factor)=c("Unchecked","Checked")
levels(data$tanner_stage___2.factor)=c("Unchecked","Checked")
levels(data$tanner_stage___3.factor)=c("Unchecked","Checked")
levels(data$tanner_stage___4.factor)=c("Unchecked","Checked")
levels(data$tanner_stage___5.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_male_testicul___1.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_male_testicul___2.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_male_testicul___3.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_male_testicul___4.factor)=c("Unchecked","Checked")
levels(data$tanner_stage_male_testicul___5.factor)=c("Unchecked","Checked")
levels(data$group_category.factor)=c("Healthy Control","Cystic Fibrosis Normal Glucose Tolerant","Cystic Fibrosis Abnormal Glycemia","Cystic Fibrosis Related Diabetes")


table(data$group_category.factor)
