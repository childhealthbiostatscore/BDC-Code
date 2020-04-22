#Clear existing data and graphics
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv("S:/Shared Projects/Laura/Laura Tim projects/Christine Chan/2019 ADA Abstracts/Data_Raw/CGMInHealthyControls_DATA_2018-12-21_1936.csv")
#Setting Labels

label(data$subject_id)="Subject ID"
label(data$group_category)="Combined Group Category"
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
#Setting Units


#Setting Factors(will create new variable for factors)
data$group_category.factor = factor(data$group_category,levels=c("1","2","3","4"))

levels(data$group_category.factor)=c("Healthy Control","Cystic Fibrosis Normal Glucose Tolerant","Cystic Fibrosis Abnormal Glycemia","Cystic Fibrosis Related Diabetes")
