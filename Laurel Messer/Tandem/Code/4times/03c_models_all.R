######MODELS FOR PRO TANDEM STUDY
###AUTHOR: KRISTEN CAMPBELL
###DATE: 5/4/2020
library(nlme)
library(lme4)
require(lsmeans)
library(CorrMixed)
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/4times/00_data_4times.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/4times/01_survey_4times.R')

dat.model<-dat[,c(which(colnames(dat) %in% c("ExternalReference","B_RESPONDENT","Baseline_A1C",
                                                   "Age","Gender","BaselineAGE","duration_of_diabetes_at_baseline_years","cgm_yn","method_cat",
                                                   "baseline_factor1","post2m_factor1","post4m_factor1","post6m_factor1",
                                                    "baseline_factor2","post2m_factor2","post4m_factor2","post6m_factor2")))]

dat.model$factor1_baseline<-dat.model$baseline_factor1
dat.model$factor2_baseline<-dat.model$baseline_factor2

###Mixed modeling: 

dat.long<-reshape(dat.model,
                  varying=c("baseline_factor1","baseline_factor2",
                            "post2m_factor1","post2m_factor2",
                            "post4m_factor1","post4m_factor2",
                            "post6m_factor1","post6m_factor2"),
                  v.names = c("factor1","factor2"),
                  timevar = "time",
                  times = c("baseline", "post2m", "post4m","post6m"),
        idvar="ExternalReference",direction="long")
dat.long<-dat.long[order(dat.long$ExternalReference,dat.long$time),]

dat.long$time<-factor(dat.long$time)
dat.long$factor1[dat.long$factor1=="NaN"]<-NA

###spaghetti plots:
#A: full trajectories:
num_measures<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    ##dat.temp <- subset(dat.long,dat.long$ExternalReference=="BDC_0001")
    dat.temp$num_factor1<-nrow(subset(dat.temp,!is.na(dat.temp$factor1)))
    dat.temp$num_factor2<-nrow(subset(dat.temp,!is.na(dat.temp$factor2)))
    dat.temp
    dat.temp})
  
  dat<-do.call(rbind,temp)
}
dat.long<-num_measures(dat.long$ExternalReference,dat.long)



#####FACTOR 1 - not normal

dat.long.1<-subset(dat.long,!is.na(dat.long$factor1))
dat.long.1<-subset(dat.long.1,!is.na(dat.long.1$factor1_baseline))
hist(dat.long.1$factor1)

dat.long.1$factor1_beta<-(dat.long.1$factor1-1)/(10-1)
quantile(dat.long.1$factor1_beta)

dat.long.1$factor1_beta_ex<-(dat.long.1$factor1_beta*(nrow(dat.long.1)-1)+0.5)/nrow(dat.long.1)
quantile(dat.long.1$factor1_beta_ex)
hist(dat.long.1$factor1_beta_ex)

#export to SAS:
write.csv(dat.long.1,"S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/data_factor1_05122020.csv")


dat.long.2<-subset(dat.long,!is.na(dat.long$factor2))
dat.long.2<-subset(dat.long.2,!is.na(dat.long.2$factor2_baseline))
hist(dat.long.2$factor2)

dat.long.2$factor2_beta<-(dat.long.2$factor2-1)/(10-1)
quantile(dat.long.2$factor2_beta)

dat.long.2$factor2_beta_ex<-(dat.long.2$factor2_beta*(nrow(dat.long.2)-1)+0.5)/nrow(dat.long.2)
quantile(dat.long.2$factor2_beta_ex)
hist(dat.long.2$factor2_beta_ex)

write.csv(dat.long.2,"S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/data_factor2_05122020.csv")
