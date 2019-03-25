library(Hmisc)
library(robustbase)
source("S:/Shared Material/Shared Code/R/temp_table1.R")
setwd("S:/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data")
dat_cgm<-read.csv("./Final CGM/cgm_final.csv")
dat_demo<-read.csv("Mastersheet Template 2_22_19.csv")

###data processing:
dat_demo$subject_id<-paste0(dat_demo$Group,dat_demo$ID)
dat<-merge(dat_demo,dat_cgm,by="subject_id")

#variables for table 1
levels(dat$Group)<-c("Control","Gastroparesis")
dat$Group<-factor(dat$Group,levels=c("Gastroparesis","Control"))
label(dat$Age)<-"Age (years)"
dat$Gender[dat$Gender=="Male"]<-"MALE"
dat$Gender<-factor(dat$Gender)

dat$Gender<-as.factor(dat$Gender)
label(dat$Gender)<-"Gender"
label(dat$Years.w.Diabetes)<-"Years with Diabetes"

dat$date_cgm_placement_2<-as.Date(dat$date_cgm_placement_2)
dat$Diagnosis.of.Gastroparesis<-as.Date(dat$Diagnosis.of.Gastroparesis,format="%m/%d/%Y")

dat$duration_of_gastro<-as.numeric((dat$date_cgm_placement_2-dat$Diagnosis.of.Gastroparesis)/365)
label(dat$duration_of_gastro)<-"Years from Dx of Gastroparesis to 670G"
dat$duration_of_gastro<-as.numeric(dat$duration_of_gastro)

#GCI score -???
#dat$gci_pre<-rowMeans(as.matrix(dat[,c(28:36)]),na.rm=T)
dat$gci_pre<-rowMedians(as.matrix(dat[,c(which(colnames(dat)=="GCI_Q1_pre"):which(colnames(dat)=="GCSI_Q9_pre"))]),na.rm=T)
label(dat$gci_pre)<-"Median GCI Score: Pre"
dat$gci_post<-rowMedians(as.matrix(dat[,c(which(colnames(dat)=="GCSI_Q1_post"):which(colnames(dat)=="GCSI_Q9_post"))]),na.rm=T)
label(dat$gci_post)<-"Median GCI Score: Post2"

label(dat$A1C_3mo_pre)<-"A1C, Pre"
label(dat$A1C_6mo_post)<-"A1C, Post2"

dat$a1c_mean<-rowMeans(dat[,c("A1C_3mo_pre","A1C_6mo_post")])
label(dat$a1c_mean)<-"Mean A1C over Pre and Post2"

dat$a1c_change<-dat$A1C_3mo_pre-dat$A1C_6mo_post
label(dat$a1c_change)<-"Change in A1c (pre-post2)"

label(dat$Weight_3mo_pre)<-"Weight, pre"

dat$weight_change<-dat$Weight_3mo_pre-dat$Weight_6mo_post
label(dat$weight_change)<-"Change in Weight (Pre-Post-2)"

label(dat$Avg.daily.Basal_3mo_pre)<-"Average Daily Basal, pre"

dat$basal_change<-dat$Avg.daily.Basal_3mo_pre-dat$Avg.daily.Basal_6mo_post
label(dat$basal_change)<-"Change in Daily Basal (pre minus post)"

label(dat$Avg.daily.Bolus_3mo_pre)<-"Average Daily Bolus, Pre"

dat$bolus_change<-dat$Avg.daily.Bolus_3mo_pre-dat$Avg.daily.Bolus_6mo_post
label(dat$bolus_change)<-"Change in Daily Bolus (pre minus post)"

label(dat$Carb.Ratio_3mo_pre)<-"Carb Ratio, pre"

dat$carb_ratio_change<-dat$Carb.Ratio_3mo_pre-dat$Carb.Ratio_6mo_post
label(dat$carb_ratio_change)<-"Change in Carb Ratio"

dat$Active.Time_3mo_pre_hours<-as.numeric(substr(dat$Active.Time_3mo_pre,1,1))*60
dat$Active.Time_3mo_pre_mins<-as.numeric(substr(dat$Active.Time_3mo_pre,3,4))
dat$active.time_3mo_use<-(dat$Active.Time_3mo_pre_hours+dat$Active.Time_3mo_pre_mins)/60

dat$Active.Time_6mo_post_hours<-as.numeric(substr(dat$Active.Time_6mo_post,1,1))*60
dat$Active.Time_6mo_post_mins<-as.numeric(substr(dat$Active.Time_6mo_post,3,4))
dat$active.time_6mo_use<-(dat$Active.Time_6mo_post_hours+dat$Active.Time_6mo_post_mins)/60

label(dat$active.time_3mo_use)<-"Mean Active Insulin Hours Pre"

dat$active_mean_change<-dat$active.time_3mo_use-dat$active.time_6mo_use
label(dat$active_mean_change)<-"Change in Active Insulin Time"

label(dat$total_sensor_readings_1)<-"Total Sensor Readings, Pre"
label(dat$total_sensor_readings_2)<-"Total Sensor Readings, Post-1"
label(dat$total_sensor_readings_3)<-"Total Sensor Readings, Post-2"
dat$total_sensor_readings_overall<-dat$total_sensor_readings_1+dat$total_sensor_readings_2+dat$total_sensor_readings_3
label(dat$total_sensor_readings_overall)<-"Total Sensor Readings, overall"

label(dat$average_sensor_1)<-"24-Hour Mean Glucose, Pre"
label(dat$average_sensor_2)<-"24-Hour Mean Glucose, Post-1"
label(dat$average_sensor_3)<-"24-Hour Mean Glucose, Post-2"

dat$average_sensor_change_13<-dat$average_sensor_1-dat$average_sensor_3
label(dat$average_sensor_change_13)<-"24-Hour Mean Glucose Change (Pre-Post2)"

dat$average_sensor_change_12<-dat$average_sensor_1-dat$average_sensor_2
label(dat$average_sensor_change_12)<-"24-Hour Mean Glucose Change (Pre-Post1)"

dat$average_sensor_change_23<-dat$average_sensor_2-dat$average_sensor_3
label(dat$average_sensor_change_23)<-"24-Hour Mean Glucose Change (Post1-Post2)"

label(dat$daytime_avg_sensor_glucose_1)<-"Daytime Mean Glucose, Pre"
label(dat$daytime_avg_sensor_glucose_2)<-"Daytime Mean Glucose, Post-1"
label(dat$daytime_avg_sensor_glucose_3)<-"Daytime Mean Glucose, Post-2"

dat$daytime_avg_sensor_change_13<-dat$daytime_avg_sensor_glucose_1-dat$daytime_avg_sensor_glucose_3
label(dat$daytime_avg_sensor_change_13)<-"Daytime Mean Glucose Change (Pre-Post2)"

dat$daytime_avg_sensor_change_12<-dat$daytime_avg_sensor_glucose_1-dat$daytime_avg_sensor_glucose_2
label(dat$daytime_avg_sensor_change_12)<-"Daytime Mean Glucose Change (Pre-Post1)"

dat$daytime_avg_sensor_change_23<-dat$daytime_avg_sensor_glucose_2-dat$daytime_avg_sensor_glucose_3
label(dat$daytime_avg_sensor_change_23)<-"Daytime Mean Glucose Change (Post1-Post2)"

label(dat$nighttime_avg_sens_glucose_1)<-"Nighttime Mean Glucose, Pre"
label(dat$nighttime_avg_sens_glucose_2)<-"Nighttime Mean Glucose, Post-1"
label(dat$nighttime_avg_sens_glucose_3)<-"Nighttime Mean Glucose, Post-2"

dat$nighttime_avg_sensor_change_13<-dat$nighttime_avg_sens_glucose_1-dat$nighttime_avg_sens_glucose_3
label(dat$nighttime_avg_sensor_change_13)<-"Nighttime Mean Glucose Change (Pre-Post2)"

dat$nighttime_avg_sensor_change_12<-dat$nighttime_avg_sens_glucose_1-dat$nighttime_avg_sens_glucose_2
label(dat$nighttime_avg_sensor_change_12)<-"Nighttime Mean Glucose Change (Pre-Post1)"

dat$nighttime_avg_sensor_change_23<-dat$nighttime_avg_sens_glucose_2-dat$nighttime_avg_sens_glucose_3
label(dat$nighttime_avg_sensor_change_23)<-"Nighttime Mean Glucose Change (Post1-Post2)"

label(dat$cv_1)<-"Glucose Variability (cv), Pre"
label(dat$cv_2)<-"Glucose Variability (cv), Post-1"
label(dat$cv_3)<-"Glucose Variability (cv), Post-2"

dat$cv_change_13<-dat$cv_1-dat$cv_3
label(dat$cv_change_13)<-"CV Change (Pre-Post2)"

dat$cv_change_12<-dat$cv_1-dat$cv_2
label(dat$cv_change_12)<-"CV Change (Pre-Post1)"

dat$cv_change_23<-dat$cv_2-dat$cv_3
label(dat$cv_change_23)<-"CV Change (Post1-Post2)"

dat$date_cgm_placement_1<-as.POSIXct(dat$date_cgm_placement_1)
dat$date_cgm_placement_2<-as.POSIXct(dat$date_cgm_placement_2)
dat$date_cgm_placement_3<-as.POSIXct(dat$date_cgm_placement_3)

dat$date_cgm_end_1<-as.POSIXct(dat$date_cgm_end_1)
dat$date_cgm_end_2<-as.POSIXct(dat$date_cgm_end_2)
dat$date_cgm_end_3<-as.POSIXct(dat$date_cgm_end_3)

dat$total_days_1<-as.numeric(dat$date_cgm_end_1-dat$date_cgm_placement_1)
dat$total_days_2<-as.numeric(dat$date_cgm_end_2-dat$date_cgm_placement_2)
dat$total_days_3<-as.numeric(dat$date_cgm_end_3-dat$date_cgm_placement_3)

label(dat$total_days_1)<-"Pre period length, days"
label(dat$total_days_2)<-"Post-1 period length, days"
label(dat$total_days_3)<-"Post-2 period length, days"

dat$total_days_overall<-dat$total_days_1+dat$total_days_2+dat$total_days_3
label(dat$total_days_overall)<-"Total length, days"

dat$avg_total_sensor_per_day_1<-dat$total_sensor_readings_1/dat$total_days_1
dat$avg_total_sensor_per_day_2<-dat$total_sensor_readings_2/dat$total_days_2
dat$avg_total_sensor_per_day_3<-dat$total_sensor_readings_3/dat$total_days_3

label(dat$avg_total_sensor_per_day_1)<-"Pre average sensor readings per day"
label(dat$avg_total_sensor_per_day_2)<-"Post-1 average sensor readings per day"
label(dat$avg_total_sensor_per_day_3)<-"Post-2 average sensor readings per day"

dat$avg_total_sensor_per_day_overall<-rowMeans(dat[,c('avg_total_sensor_per_day_1','avg_total_sensor_per_day_2','avg_total_sensor_per_day_3')])
label(dat$avg_total_sensor_per_day_overall)<-"Overall average sensor readings per day"

label(dat$percent_time_under_70_1)<-"% of time in hypo (<70), Pre"
label(dat$percent_time_under_70_2)<-"% of time in hypo (<70), Post-1"
label(dat$percent_time_under_70_3)<-"% of time in hypo (<70), Post-2"

dat$percent_time_under_70_change_13<-dat$percent_time_under_70_1-dat$percent_time_under_70_3
label(dat$percent_time_under_70_change_13)<-"% Time in Hypo, Change (Pre-Post2)"

dat$percent_time_under_70_change_12<-dat$percent_time_under_70_1-dat$percent_time_under_70_2
label(dat$percent_time_under_70_change_12)<-"% Time in Hypo, Change (Pre-Post1)"

dat$percent_time_under_70_change_23<-dat$percent_time_under_70_2-dat$percent_time_under_70_3
label(dat$percent_time_under_70_change_23)<-"% Time in Hypo, Change (Post1-Post2)"

label(dat$percent_time_70_180_1)<-"Percent of time in normal (70-180), Pre"
label(dat$percent_time_70_180_2)<-"Percent of time in normal (70-180), Post-1"
label(dat$percent_time_70_180_3)<-"Percent of time in normal (70-180), Post-2"

dat$percent_time_70_180_change_13<-dat$percent_time_70_180_1-dat$percent_time_70_180_3
label(dat$percent_time_70_180_change_13)<-"% Time in Normal, Change (Pre-Post2)"

dat$percent_time_70_180_change_12<-dat$percent_time_70_180_1-dat$percent_time_70_180_2
label(dat$percent_time_70_180_change_12)<-"% Time in Normal, Change (Pre-Post1)"

dat$percent_time_70_180_change_23<-dat$percent_time_70_180_2-dat$percent_time_70_180_3
label(dat$percent_time_70_180_change_23)<-"% Time in Normal, Change (Post1-Post2)"

label(dat$percent_time_over_180_1)<-"Percent of time in hyper (>180), Pre"
label(dat$percent_time_over_180_2)<-"Percent of time in hyper (>180), Post-1"
label(dat$percent_time_over_180_3)<-"Percent of time in hyper (>180), Post-2"

dat$percent_time_over_180_change_13<-dat$percent_time_over_180_1-dat$percent_time_over_180_3
label(dat$percent_time_over_180_change_13)<-"% Time in Hyper, Change (Pre-Post2)"

dat$percent_time_over_180_change_12<-dat$percent_time_over_180_1-dat$percent_time_over_180_2
label(dat$percent_time_over_180_change_12)<-"% Time in Hyper, Change (Pre-Post1)"

dat$percent_time_over_180_change_23<-dat$percent_time_over_180_2-dat$percent_time_over_180_3
label(dat$percent_time_over_180_change_23)<-"% Time in Hyper, Change (Post1-Post2)"


##########long format for models:

dat.temp<-dat[,c("subject_id","ID","Group","total_sensor_readings_1","total_sensor_readings_2","total_sensor_readings_3",
                 "average_sensor_1","average_sensor_2","average_sensor_3",
                 "standard_deviation_1","standard_deviation_2","standard_deviation_3",
                 "daytime_avg_sensor_glucose_1","daytime_avg_sensor_glucose_2","daytime_avg_sensor_glucose_3",
                 "nighttime_avg_sens_glucose_1","nighttime_avg_sens_glucose_2","nighttime_avg_sens_glucose_3")]

dat.long <- reshape(data = dat.temp,varying=list(grep("average_sensor", colnames(dat.temp), value=T), grep("standard_deviation", colnames(dat.temp), value=T)
                                                            , grep("daytime", colnames(dat.temp), value=T), grep("nighttime_avg_sens_glucose", colnames(dat.temp),value=T), 
                                                                              grep("total_sensor_readings", colnames(dat.temp),value=T)),
                    v.names = c("average_sensor","standard_deviation","daytime_avg_sensor_glucose","nighttime_avg_sens_glucose","total_sensor_readings"), 
                    timevar= "Period", times=c('1', '2','3'),idvar = "Subject",direction = "long")


##write.csv(dat.long,"long_dataset.csv")
