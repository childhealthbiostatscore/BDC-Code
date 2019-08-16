######MODELS FOR PRO TANDEM STUDY
###AUTHOR: KRISTEN CAMPBELL
###DATE: 8/15/2019

library(nlme)
library(lme4)
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/00_data.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/01_survey_factors.R')

dat.temp<-dat[,c(1,6,30,116:117,142:144,227:232)]
#might have to do this:
# dat.temp$change1_factor1<-dat.temp$baseline_factor1-dat.temp$mid_factor1
# dat.temp$change2_factor1<-dat.temp$mid_factor2-dat.temp$mid_factor1

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

#####FACTOR 1 - not normal
require(MASS)
qqp(dat.long$factor1, "norm")
qqp(dat.long$factor1, "lnorm")
gam <- fitdistr(dat.long$factor1, "Gamma")
qqp(dat.long$factor1, "gamma", shape = gam$estimate[[1]], rate = gam$estimate[[2]])


dat.long$factor1_2<-dat.long$factor1^3
hist(dat.long$factor1_2)



#LMM: can't do this
factor1_uni<-lme(factor1~time+time*method_cat
                 ,random=~1|ExternalReference,data=dat.long)
plot(factor1_uni)
summary(factor1_uni)


#####FACTOR 2 - pretty normal
factor2_uni<-lme(factor2~time+time*method_cat
                     ,random=~1|ExternalReference,data=dat.long)
plot(factor2_uni)
summary(factor2_uni)
