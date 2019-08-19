######MODELS FOR PRO TANDEM STUDY
###AUTHOR: KRISTEN CAMPBELL
###DATE: 8/15/2019
# library(nlme)
# library(lme4)

require(lsmeans)

source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/00_data.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/01_survey_factors.R')

dat.temp<-dat[,c(1,6,30,116:117,142:144,227:232)]
#might have to do this:
dat.temp$change1_factor1<-dat.temp$mid_factor1-dat.temp$baseline_factor1
dat.temp$change2_factor1<-dat.temp$post6m_factor1-dat.temp$mid_factor1

dat.temp$change1_factor2<-dat.temp$mid_factor2-dat.temp$baseline_factor2
dat.temp$change2_factor2<-dat.temp$post6m_factor2-dat.temp$mid_factor2

hist(dat.temp$change1_factor1)
hist(dat.temp$change2_factor1)
hist(dat.temp$change1_factor2)
hist(dat.temp$change2_factor2)


#how many went up vs down:
dat.temp$change1_up<-1
dat.temp$change1_up[dat.temp$change1_factor1<0]<-0

dat.temp$change2_factor1_up<-1
dat.temp$change2_factor1_up[dat.temp$change2_factor1<0]<-0

change1.factor1<-lm(dat.temp$change1_factor1~1)
change1.factor1<-lm(dat.temp$change1_factor1~dat.temp$method_cat)
change1.factor1<-lm(dat.temp$change1_factor1~dat.temp$method_cat+dat.temp$cgm_yn+dat.temp$Age
                    +dat.temp$Gender+dat.temp$Baseline_A1C)

summary(change1.factor1)
plot(change1.factor1)
ch1.fac1.means <- lsmeans(change1.factor1, c("method_cat"))


change2.factor1<-lm(dat.temp$change2_factor1~1)
change2.factor1<-lm(dat.temp$change2_factor1~dat.temp$method_cat+dat.temp$cgm_yn)
change2.factor1<-lm(dat.temp$change2_factor1~dat.temp$method_cat+dat.temp$cgm_yn+dat.temp$Age
                    +dat.temp$Gender+dat.temp$Baseline_A1C)

summary(change2.factor1)
plot(change2.factor1)
ch2.fac1.means <- lsmeans(change2.factor1, c("method_cat"))

####FACTOR 2 MODELS
change1.factor2<-lm(dat.temp$change1_factor2~1)
change1.factor2<-lm(dat.temp$change1_factor2~dat.temp$method_cat)
change1.factor2<-lm(dat.temp$change1_factor2~dat.temp$method_cat+dat.temp$cgm_yn+dat.temp$Age
                    +dat.temp$Gender+dat.temp$Baseline_A1C)

summary(change1.factor2)
plot(change1.factor2)
ch1.fac2.means <- lsmeans(change1.factor2, c("method_cat"))


change2.factor2<-lm(dat.temp$change2_factor2~1)
change2.factor2<-lm(dat.temp$change2_factor2~dat.temp$method_cat+dat.temp$cgm_yn)
change2.factor2<-lm(dat.temp$change2_factor2~dat.temp$method_cat+dat.temp$cgm_yn+dat.temp$Age
                    +dat.temp$Gender+dat.temp$Baseline_A1C)

summary(change2.factor2)
plot(change2.factor2)
ch2.fac2.means <- lsmeans(change2.factor2, c("method_cat"))


###Mixed modeling: 

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
# 
# #####FACTOR 1 - not normal
# 
# dat.long$factor1_2<-dat.long$factor1^3
# hist(dat.long$factor1_2)
# 
# 
# 
# #LMM: can't do this
# factor1_uni<-lme(factor1~time+time*method_cat
#                  ,random=~1|ExternalReference,data=dat.long)
# plot(factor1_uni)
# summary(factor1_uni)
# 
# 
# #####FACTOR 2 - pretty normal
# factor2_uni<-lme(factor2~time+time*method_cat
#                      ,random=~1|ExternalReference,data=dat.long)
# plot(factor2_uni)
# summary(factor2_uni)
