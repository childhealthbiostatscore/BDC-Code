####### Mixed Models #######
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/00_data.R')
library(nlme)

library(multcomp)


dat<-subset(dat,dat$yeargrouping!="Year3")
dat<-subset(dat,dat$yeargrouping!="Year4")

dat$yeargrouping<-factor(dat$yeargrouping,levels=c("Year2","Base1","Year1"))
dat$group<-factor(dat$group,levels=c("Less than 12","greater than or equal to 12"))

dat$trt_grp<-as.factor(dat$trt_grp)
a1c_mod1<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+group+factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
                  ,random=~1|MRN,data=dat)
summary(a1c_mod1)

coef(a1c_mod1)
K <- matrix(c(0, 0, 0, -1, 0, 0, 0, 0, 1), 1) # Year 1 between control and LP
summary(glht(a1c_mod1, linfct = K))

K <- matrix(c(0, 0, -1, 0, 0, 0, 0, -1, 0), 1) # Base 1 between control and LP
summary(glht(a1c_mod1, linfct = K))

K <- matrix(c(0, 0, -1, 0, 0, 0, 0, -1, 0), 1) # Year 2 between control and LP
summary(glht(a1c_mod1, linfct = K))

write.csv(dat,'mixed_forsas.csv')
