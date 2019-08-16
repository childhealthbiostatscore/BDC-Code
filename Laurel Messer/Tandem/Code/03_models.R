######MODELS FOR PRO TANDEM STUDY
###AUTHOR: KRISTEN CAMPBELL
###DATE: 8/15/2019

library(nlme)

source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/00_data.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/01_survey_factors.R')

dat.temp<-dat[,c(1,6,30,116:117,142:144,227:232)]

dat.long<-reshape(dat.temp, 
                  varying=c("baseline_factor1","baseline_factor2",
                            "mid_factor1","mid_factor2",
                            "post6m_factor1","post6m_factor2"),
                  v.names = c("factor1","factor2"),
                  timevar = "time", 
                  times = c("baseline", "mid", "post6m"), 
        idvar="ExternalReference",direction="long")
dat.long<-dat.long[order(dat.long$ExternalReference,dat.long$time),]

dat.long$time<-factor(dat.long$time)

####A1c: overall cohort####
factor2_uni<-lme(factor2~time+time*method_cat
                     ,random=~1|ExternalReference,data=dat.long)
plot(factor2_uni)
summary(factor2_uni)
