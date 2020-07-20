
###Summary Stats###
source("S:/Shared Material/Shared Code/R/temp_table1.R")

table1<-final_table(dat.one,c("Gender","Age_eachvisit","Race.Ethnicity","InsuranceType_VisitDate",
                              "CGM_Use","InsulinPump_Use","DurationOfDiabetes_eachvisit"),
                        dat.one$group,margin=2,single=F,2,col.names=T, summary.stat='median')
table1

table2<-final_table(dat.one,c("A1C_Value","Meter_BGLow","Meter_BGHigh","Meter_BGOK"), 
                    dat.one$group,margin=2,single=F,2,col.names=T, summary.stat='mean')

table2

table3<-final_table(dat.one,c("total_visits","total_RTC","total_CTC","total_routine", #totals of each visit type
                              "research_period_visits","RTC_visits_cat","research_period_time",
                              "post_period_visits","post_period_time"), 
                    dat.one$group,margin=2,single=F,2,col.names=T, summary.stat='median')
table3
