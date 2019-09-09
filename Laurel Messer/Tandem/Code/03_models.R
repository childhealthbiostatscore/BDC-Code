######MODELS FOR PRO TANDEM STUDY
###AUTHOR: KRISTEN CAMPBELL
###DATE: 8/15/2019
# library(nlme)
# library(lme4)

require(lsmeans)

source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/00_data.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/01_survey_factors.R')

dat.model<-dat[,c(1,6,30,116:117,137,142:144,214,228:233)]
#might have to do this:
dat.model$change1_satis<-dat.model$mid_factor1-dat.model$baseline_factor1
dat.model$change2_satis<-dat.model$post6m_factor1-dat.model$mid_factor1

dat.model$change1_burden<-dat.model$mid_factor2-dat.model$baseline_factor2
dat.model$change2_burden<-dat.model$post6m_factor2-dat.model$mid_factor2

hist(dat.model$change1_satis)
hist(dat.model$change2_satis)
hist(dat.model$change1_burden)
hist(dat.model$change2_burden)


##############FACTOR 1: SATISFACTION###################

#model selection:
change1.satis.respon<-lm(dat.model$change1_satis~dat.model$B_RESPONDENT)
summary(change1.satis.respon)
change1.satis.cgm<-lm(dat.model$change1_satis~dat.model$cgm_yn)
summary(change1.satis.cgm)
change1.satis.BaselineAGE<-lm(dat.model$change1_satis~dat.model$BaselineAGE) #dont include
summary(change1.satis.BaselineAGE)
change1.satis.gen<-lm(dat.model$change1_satis~dat.model$Gender) #dont include
summary(change1.satis.gen)

change1.satis<-lm(dat.model$change1_satis~dat.model$method_cat+dat.model$cgm_yn+dat.model$Baseline_A1C+
                      dat.model$BaselineAGE+dat.model$mid_point+dat.model$B_RESPONDENT)

summary(change1.satis)
anova(change1.satis)

#plot(change1.satis)
ch1.fac1.means <- lsmeans(change1.satis, c("method_cat"))

#ch1.fac1.means<-summary(ch1.fac1.means, adjust = "bon")

ch1.fac1.means<-summary(ch1.fac1.means, infer = c(TRUE,TRUE), adjust = "bon")


###prep for tables:
ch1.fac1.means<-as.data.frame(ch1.fac1.means)
#ch1.fac1.means<-ch1.fac1.means[,-c(3,4)]
ch1.fac1.means$lsmean<-round(as.numeric(ch1.fac1.means$lsmean),2)
ch1.fac1.means$lower.CL<-round(as.numeric(ch1.fac1.means$lower.CL),2)
ch1.fac1.means$upper.CL<-round(as.numeric(ch1.fac1.means$upper.CL),2)
ch1.fac1.means$pval<-round(ch1.fac1.means$p.value,3)
ch1.fac1.means$pval[ch1.fac1.means$pval==0]<-"<0.001"

ch1.fac1.means$change_est<-paste0(ch1.fac1.means$lsmean," (Adj CI: ",
                                  ch1.fac1.means$lower.CL,",",
                                  ch1.fac1.means$upper.CL,"); p=",ch1.fac1.means$pval)
ch1.fac1.means<-ch1.fac1.means[,-c(2:9)]
colnames(ch1.fac1.means)<-c("Previous Method","Change from Baseline to Mid-Point")


change2.satis<-lm(dat.model$change2_satis~1)
change2.satis<-lm(dat.model$change2_satis~dat.model$method_cat+dat.model$cgm_yn)
#model selection:
change2.satis.respon<-lm(dat.model$change2_satis~dat.model$B_RESPONDENT)
summary(change2.satis.respon)
change2.satis.cgm<-lm(dat.model$change2_satis~dat.model$cgm_yn)
summary(change2.satis.cgm)
change2.satis.BaselineAGE<-lm(dat.model$change2_satis~dat.model$BaselineAGE) 
summary(change2.satis.BaselineAGE)
change2.satis.gen<-lm(dat.model$change2_satis~dat.model$Gender) #dont include
summary(change2.satis.gen)

change2.satis<-lm(dat.model$change2_satis~dat.model$method_cat+dat.model$cgm_yn+dat.model$BaselineAGE
                    +dat.model$Baseline_A1C+dat.model$mid_point+dat.model$B_RESPONDENT)

summary(change2.satis)
anova(change2.satis)

#plot(change2.satis)
ch2.fac1.means <- lsmeans(change2.satis, c("method_cat"))
ch2.fac1.means<-summary(ch2.fac1.means, infer = c(TRUE,TRUE), adjust = "bon")

ch2.fac1.means<-as.data.frame(ch2.fac1.means)

ch2.fac1.means$lsmean<-round(as.numeric(ch2.fac1.means$lsmean),2)
ch2.fac1.means$lower.CL<-round(as.numeric(ch2.fac1.means$lower.CL),2)
ch2.fac1.means$upper.CL<-round(as.numeric(ch2.fac1.means$upper.CL),2)
ch2.fac1.means$pval<-round(ch2.fac1.means$p.value,3)
ch2.fac1.means$pval[ch2.fac1.means$pval==0]<-"<0.001"

ch2.fac1.means$change_est<-paste0(ch2.fac1.means$lsmean," (Adj CI: ",
                                  ch2.fac1.means$lower.CL,",",
                                  ch2.fac1.means$upper.CL,"); p=",ch2.fac1.means$pval)
ch2.fac1.means<-ch2.fac1.means[,-c(2:9)]
colnames(ch2.fac1.means)<-c("Previous Method","Change from Mid-Point to 6 Month")

fac1.changes<-merge(ch1.fac1.means,ch2.fac1.means,by="Previous Method")

#################FACTOR 2: DIABETES BURDEN#####################

change1.burden<-lm(dat.model$change1_burden~1)
change1.burden<-lm(dat.model$change1_burden~dat.model$method_cat)
change1.burden<-lm(dat.model$change1_burden~dat.model$method_cat+dat.model$cgm_yn+dat.model$BaselineAGE
                    +dat.model$Baseline_A1C+dat.model$mid_point+dat.model$B_RESPONDENT)

summary(change1.burden)
anova(change1.burden)

#plot(change1.burden)
ch1.fac2.means <- lsmeans(change1.burden, c("method_cat"))
ch1.fac2.means<-summary(ch1.fac2.means, infer = c(TRUE,TRUE), adjust = "bon")

###prep for tables:
ch1.fac2.means<-as.data.frame(ch1.fac2.means)
ch1.fac2.means$lsmean<-round(as.numeric(ch1.fac2.means$lsmean),2)
ch1.fac2.means$lower.CL<-round(as.numeric(ch1.fac2.means$lower.CL),2)
ch1.fac2.means$upper.CL<-round(as.numeric(ch1.fac2.means$upper.CL),2)
ch1.fac2.means$pval<-round(ch1.fac2.means$p.value,3)
ch1.fac2.means$pval[ch1.fac2.means$pval==0]<-"<0.001"

ch1.fac2.means$change_est<-paste0(ch1.fac2.means$lsmean," (Adj CI: ",
                                  ch1.fac2.means$lower.CL,",",
                                  ch1.fac2.means$upper.CL,"); p=",ch1.fac2.means$pval)
ch1.fac2.means<-ch1.fac2.means[,-c(2:9)]
colnames(ch1.fac2.means)<-c("Previous Method","Change from Baseline to Mid-Point")

change2.burden<-lm(dat.model$change2_burden~1)
change2.burden<-lm(dat.model$change2_burden~dat.model$method_cat+dat.model$cgm_yn)
change2.burden<-lm(dat.model$change2_burden~dat.model$method_cat+dat.model$cgm_yn+dat.model$BaselineAGE
                    +dat.model$Gender+dat.model$Baseline_A1C+dat.model$mid_point+dat.model$B_RESPONDENT)

summary(change2.burden)
anova(change2.burden)

#plot(change2.burden)
ch2.fac2.means <- lsmeans(change2.burden, c("method_cat"))
ch2.fac2.means<-summary(ch2.fac2.means, infer = c(TRUE,TRUE), adjust = "bon")

###prep for tables:
ch2.fac2.means<-as.data.frame(ch2.fac2.means)
ch2.fac2.means$lsmean<-round(as.numeric(ch2.fac2.means$lsmean),2)
ch2.fac2.means$lower.CL<-round(as.numeric(ch2.fac2.means$lower.CL),2)
ch2.fac2.means$upper.CL<-round(as.numeric(ch2.fac2.means$upper.CL),2)
ch2.fac2.means$pval<-round(ch2.fac2.means$p.value,3)
ch2.fac2.means$pval[ch2.fac2.means$pval==0]<-"<0.001"

ch2.fac2.means$change_est<-paste0(ch2.fac2.means$lsmean," (Adj CI: ",
                                  ch2.fac2.means$lower.CL,",",
                                  ch2.fac2.means$upper.CL,"); p=",ch2.fac2.means$pval)
ch2.fac2.means<-ch2.fac2.means[,-c(2:9)]
colnames(ch2.fac2.means)<-c("Previous Method","Change from Mid-Point to 6 Month")
fac2.changes<-merge(ch1.fac2.means,ch2.fac2.means,by="Previous Method")

################ SENSITIVITY ANALYSIS exclude caregivers ################
dat.diab<-subset(dat.model,dat.model$B_RESPONDENT=="Person with Diabetes")

diab.change1.satis<-lm(dat.diab$change1_satis~dat.diab$method_cat+dat.diab$cgm_yn+dat.diab$Baseline_A1C+
                      dat.diab$BaselineAGE+dat.diab$mid_point)

summary(diab.change1.satis)
anova(diab.change1.satis)

#plot(change1.satis)
diab.ch1.fac1.means <- lsmeans(diab.change1.satis, c("method_cat"))
diab.ch1.fac1.means<-summary(diab.ch1.fac1.means, infer = c(TRUE,TRUE), adjust = "bon")

###prep for tables:
diab.ch1.fac1.means<-as.data.frame(diab.ch1.fac1.means)
diab.ch1.fac1.means$lsmean<-round(as.numeric(diab.ch1.fac1.means$lsmean),2)
diab.ch1.fac1.means$lower.CL<-round(as.numeric(diab.ch1.fac1.means$lower.CL),2)
diab.ch1.fac1.means$upper.CL<-round(as.numeric(diab.ch1.fac1.means$upper.CL),2)
diab.ch1.fac1.means$pval<-round(diab.ch1.fac1.means$p.value,3)
diab.ch1.fac1.means$pval[diab.ch1.fac1.means$pval==0]<-"<0.001"

diab.ch1.fac1.means$change_est<-paste0(diab.ch1.fac1.means$lsmean," (Adj CI: ",
                                  diab.ch1.fac1.means$lower.CL,",",
                                  diab.ch1.fac1.means$upper.CL,"); p=",diab.ch1.fac1.means$pval)
diab.ch1.fac1.means<-diab.ch1.fac1.means[,-c(2:9)]
colnames(diab.ch1.fac1.means)<-c("Previous Method","Change from Baseline to Midpoint")

diab.change2.satis<-lm(dat.diab$change2_satis~dat.diab$method_cat+dat.diab$cgm_yn+dat.diab$Baseline_A1C+
                           dat.diab$BaselineAGE+dat.diab$mid_point)

summary(diab.change2.satis)
anova(diab.change2.satis)

#plot(change2.satis)
diab.ch2.fac1.means <- lsmeans(diab.change2.satis, c("method_cat"))
diab.ch2.fac1.means<-summary(diab.ch2.fac1.means, infer = c(TRUE,TRUE), adjust = "bon")

###prep for tables:
diab.ch2.fac1.means<-as.data.frame(diab.ch2.fac1.means)
diab.ch2.fac1.means$lsmean<-round(as.numeric(diab.ch2.fac1.means$lsmean),2)
diab.ch2.fac1.means$lower.CL<-round(as.numeric(diab.ch2.fac1.means$lower.CL),2)
diab.ch2.fac1.means$upper.CL<-round(as.numeric(diab.ch2.fac1.means$upper.CL),2)
diab.ch2.fac1.means$pval<-round(diab.ch2.fac1.means$p.value,3)
diab.ch2.fac1.means$pval[diab.ch2.fac1.means$pval==0]<-"<0.001"

diab.ch2.fac1.means$change_est<-paste0(diab.ch2.fac1.means$lsmean," (Adj CI: ",
                                       diab.ch2.fac1.means$lower.CL,",",
                                       diab.ch2.fac1.means$upper.CL,"); p=",diab.ch2.fac1.means$pval)
diab.ch2.fac1.means<-diab.ch2.fac1.means[,-c(2:9)]
colnames(diab.ch2.fac1.means)<-c("Previous Method","Change from Midpoint to 6 Months")

diab.fac1.changes<-merge(diab.ch1.fac1.means,diab.ch2.fac1.means,by="Previous Method")


diab.change1.burden<-lm(dat.diab$change1_burden~dat.diab$method_cat+dat.diab$cgm_yn+dat.diab$Baseline_A1C+
                           dat.diab$BaselineAGE+dat.diab$mid_point)

summary(diab.change1.burden)
anova(diab.change1.burden)

#plot(change1.burden)
diab.ch1.fac2.means <- lsmeans(diab.change1.burden, c("method_cat"))
diab.ch1.fac2.means<-summary(diab.ch1.fac2.means, infer = c(TRUE,TRUE), adjust = "bon")

###prep for tables:
diab.ch1.fac2.means<-as.data.frame(diab.ch1.fac2.means)
diab.ch1.fac2.means$lsmean<-round(as.numeric(diab.ch1.fac2.means$lsmean),2)
diab.ch1.fac2.means$lower.CL<-round(as.numeric(diab.ch1.fac2.means$lower.CL),2)
diab.ch1.fac2.means$upper.CL<-round(as.numeric(diab.ch1.fac2.means$upper.CL),2)
diab.ch1.fac2.means$pval<-round(diab.ch1.fac2.means$p.value,3)
diab.ch1.fac2.means$pval[diab.ch1.fac2.means$pval==0]<-"<0.001"

diab.ch1.fac2.means$change_est<-paste0(diab.ch1.fac2.means$lsmean," (Adj CI: ",
                                       diab.ch1.fac2.means$lower.CL,",",
                                       diab.ch1.fac2.means$upper.CL,"); p=",diab.ch1.fac2.means$pval)
diab.ch1.fac2.means<-diab.ch1.fac2.means[,-c(2:9)]
colnames(diab.ch1.fac2.means)<-c("Previous Method","Change from Baseline to Mid-Point")

diab.change2.burden<-lm(dat.diab$change2_burden~dat.diab$method_cat+dat.diab$cgm_yn+dat.diab$Baseline_A1C+
                           dat.diab$BaselineAGE+dat.diab$mid_point)

summary(diab.change2.burden)
anova(diab.change2.burden)

#plot(change2.burden)
diab.ch2.fac2.means <- lsmeans(diab.change2.burden, c("method_cat"))
diab.ch2.fac2.means<-summary(diab.ch2.fac2.means, infer = c(TRUE,TRUE), adjust = "bon")

###prep for tables:
diab.ch2.fac2.means<-as.data.frame(diab.ch2.fac2.means)
diab.ch2.fac2.means$lsmean<-round(as.numeric(diab.ch2.fac2.means$lsmean),2)
diab.ch2.fac2.means$lower.CL<-round(as.numeric(diab.ch2.fac2.means$lower.CL),2)
diab.ch2.fac2.means$upper.CL<-round(as.numeric(diab.ch2.fac2.means$upper.CL),2)
diab.ch2.fac2.means$pval<-round(diab.ch2.fac2.means$p.value,3)
diab.ch2.fac2.means$pval[diab.ch2.fac2.means$pval==0]<-"<0.001"

diab.ch2.fac2.means$change_est<-paste0(diab.ch2.fac2.means$lsmean," (Adj CI: ",
                                       diab.ch2.fac2.means$lower.CL,",",
                                       diab.ch2.fac2.means$upper.CL,"); p=",diab.ch2.fac2.means$pval)
diab.ch2.fac2.means<-diab.ch2.fac2.means[,-c(2:9)]
colnames(diab.ch2.fac2.means)<-c("Previous Method","Change from Midpoint to 6 months")

diab.fac2.changes<-merge(diab.ch1.fac2.means,diab.ch2.fac2.means,by="Previous Method")



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
