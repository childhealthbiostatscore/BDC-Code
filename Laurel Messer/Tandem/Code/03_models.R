######MODELS FOR PRO TANDEM STUDY
###AUTHOR: KRISTEN CAMPBELL
###DATE: 8/15/2019
# library(nlme)
# library(lme4)

require(lsmeans)

source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/00_data.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/01_survey_factors.R')

dat.model<-dat[,c(1,6,30,116:117,142:144,213,227:232)]
#might have to do this:
dat.model$change1_benefit<-dat.model$mid_factor1-dat.model$baseline_factor1
dat.model$change2_benefit<-dat.model$post6m_factor1-dat.model$mid_factor1

dat.model$change1_burden<-dat.model$mid_factor2-dat.model$baseline_factor2
dat.model$change2_burden<-dat.model$post6m_factor2-dat.model$mid_factor2

hist(dat.model$change1_benefit)
hist(dat.model$change2_benefit)
hist(dat.model$change1_burden)
hist(dat.model$change2_burden)


#how many went up vs down:
dat.model$change1_benefit_up<-1
dat.model$change1_benefit_up[dat.model$change1_benefit<=0]<-0

dat.model$change2_benefit_up<-1
dat.model$change2_benefit_up[dat.model$change2_benefit<=0]<-0

change1.benefit<-lm(dat.model$change1_benefit~1)
change1.benefit<-lm(dat.model$change1_benefit~dat.model$method_cat)
#model selection:
change1.benefit.respon<-lm(dat.model$change1_benefit~dat.model$B_RESPONDENT)
summary(change1.benefit.respon)
change1.benefit.cgm<-lm(dat.model$change1_benefit~dat.model$cgm_yn)
summary(change1.benefit.cgm)
change1.benefit.age<-lm(dat.model$change1_benefit~dat.model$Age) #dont include
summary(change1.benefit.age)
change1.benefit.gen<-lm(dat.model$change1_benefit~dat.model$Gender) #dont include
summary(change1.benefit.gen)

change1.benefit<-lm(dat.model$change1_benefit~dat.model$method_cat+dat.model$cgm_yn+dat.model$Baseline_A1C+
                      dat.model$Age+dat.model$mid_point)

summary(change1.benefit)
#plot(change1.benefit)
ch1.fac1.means <- lsmeans(change1.benefit, c("method_cat"))


change2.benefit<-lm(dat.model$change2_benefit~1)
change2.benefit<-lm(dat.model$change2_benefit~dat.model$method_cat+dat.model$cgm_yn)
#model selection:
change2.benefit.respon<-lm(dat.model$change2_benefit~dat.model$B_RESPONDENT)
summary(change2.benefit.respon)
change2.benefit.cgm<-lm(dat.model$change2_benefit~dat.model$cgm_yn)
summary(change2.benefit.cgm)
change2.benefit.age<-lm(dat.model$change2_benefit~dat.model$Age) 
summary(change2.benefit.age)
change2.benefit.gen<-lm(dat.model$change2_benefit~dat.model$Gender) #dont include
summary(change2.benefit.gen)

change2.benefit<-lm(dat.model$change2_benefit~dat.model$method_cat+dat.model$cgm_yn+dat.model$Age
                    +dat.model$Baseline_A1C+dat.model$mid_point)

summary(change2.benefit)
#plot(change2.benefit)
ch2.fac1.means <- lsmeans(change2.benefit, c("method_cat"))

####FACTOR 2 MODELS
change1.burden<-lm(dat.model$change1_burden~1)
change1.burden<-lm(dat.model$change1_burden~dat.model$method_cat)
change1.burden<-lm(dat.model$change1_burden~dat.model$method_cat+dat.model$cgm_yn+dat.model$Age
                    +dat.model$Baseline_A1C+dat.model$mid_point)

summary(change1.burden)
#plot(change1.burden)
ch1.fac2.means <- lsmeans(change1.burden, c("method_cat"))


change2.burden<-lm(dat.model$change2_burden~1)
change2.burden<-lm(dat.model$change2_burden~dat.model$method_cat+dat.model$cgm_yn)
change2.burden<-lm(dat.model$change2_burden~dat.model$method_cat+dat.model$cgm_yn+dat.model$Age
                    +dat.model$Gender+dat.model$Baseline_A1C+dat.model$mid_point)

summary(change2.burden)
#plot(change2.burden)
ch2.fac2.means <- lsmeans(change2.burden, c("method_cat"))


###Mixed modeling: 
# 
# dat.long<-reshape(dat.model,
#                   varying=c("baseline_benefit","baseline_burden",
#                             "mid_benefit","mid_burden",
#                             "post6m_benefit","post6m_burden"),
#                   v.names = c("benefit","burden"),
#                   timevar = "time",
#                   times = c("baseline", "mid", "post6m"),
#         idvar="ExternalReference",direction="long")
# dat.long<-dat.long[order(dat.long$ExternalReference,dat.long$time),]
# 
# dat.long$time<-factor(dat.long$time)
# 
# #####FACTOR 1 - not normal
# 
# dat.long$benefit_2<-dat.long$benefit^3
# hist(dat.long$benefit_2)
# 
# 
# 
# #LMM: can't do this
# benefit_uni<-lme(benefit~time+time*method_cat
#                  ,random=~1|ExternalReference,data=dat.long)
# #plot(benefit_uni)
# summary(benefit_uni)
# 
# 
# #####FACTOR 2 - pretty normal
# burden_uni<-lme(burden~time+time*method_cat
#                      ,random=~1|ExternalReference,data=dat.long)
# #plot(burden_uni)
# summary(burden_uni)
