#### MIXED MODELS 

dat.long<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data/long_dataset.csv")
library(nlme)

##repeated measures:

#random intercept only:
#time as a factor
results_int.factor<-lme(average_sensor~factor(Period)*Group,random=~1|subject_id,data=dat.long)
summary(results_int.factor)
anova(results_int.factor)

#time as continuous
results_int.num<-lme(average_sensor~as.numeric(Period)*Group,random=~1|subject_id,data=dat.long)
summary(results_int.num)

#random intercept and slope:
results_slope<-lme(average_sensor~factor(Period)*Group,random=~1|subject_id/Period,data=dat.long)
summary(results_slope)
