####### Mixed Models #######
#source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/00_data.R')
library(nlme)
library(afex)
require(lsmeans)
#### Use only patients who had 3 year data ####
length(unique(dat$MRN))

dat$yeargrouping<-factor(dat$yeargrouping,levels=c("Year3","Base1","Year1","Year2"))

####A1c: overall cohort####
a1c_mod_toyear3<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+group+factor(trt_grp)+
                       factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
                     ,random=~1|MRN/yeargrouping,data=dat)
year3_sum<-summary(a1c_mod_toyear3)
year3_sum<-year3_sum$tTable[,c(1,2,5)]
year3_sum<-as.data.frame(year3_sum)
year3_sum$Value<-round(year3_sum$Value,3)
year3_sum$Std.Error<-round(year3_sum$Std.Error,3)
year3_sum$`p-value`<-round(year3_sum$`p-value`,3)

#test for differences between groups at each time point:
ref_3 <- lsmeans(a1c_mod_toyear3, c("trt_grp", "yeargrouping"))

c_list_3 <- list(c_base1 = c(0, 0, -1, 1, 0, 0, 0, 0),
               c_year1 = c(0, 0, 0, 0, -1, 1, 0, 0),
               c_year2 = c(0, 0, 0, 0, 0, 0, -1, 1),
               c_year3 = c(-1, 1, 0, 0, 0, 0, 0, 0)
)
contrasts_3<-summary(contrast(ref_3, c_list_3))
contrasts_3<-contrasts_3[,c(1,2,3,6)]
contrasts_3$estimate<-round(contrasts_3$estimate,3)
contrasts_3$SE<-round(contrasts_3$SE,3)
contrasts_3$p.value<-round(contrasts_3$p.value,3)

#####A1c in older cohort
dat.old<-subset(dat,dat$group=="greater than or equal to 12")
a1c_mod_toyear3_old<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+factor(trt_grp)+
                           factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
                     ,random=~1|MRN/yeargrouping,data=dat.old)
year3_sum_old<-summary(a1c_mod_toyear3_old)
year3_sum_old<-year3_sum_old$tTable[,c(1,2,5)]
year3_sum_old<-as.data.frame(year3_sum_old)
year3_sum_old$Value<-round(year3_sum_old$Value,3)
year3_sum_old$Std.Error<-round(year3_sum_old$Std.Error,3)
year3_sum_old$`p-value`<-round(year3_sum_old$`p-value`,3)

#test for differences between groups at each time point:
ref_3_old <- lsmeans(a1c_mod_toyear3_old, c("trt_grp", "yeargrouping"))

c_list_3_old <- list(c_base1_old = c(0, 0, -1, 1, 0, 0, 0, 0),
                 c_year1_old = c(0, 0, 0, 0, -1, 1, 0, 0),
                 c_year2_old = c(0, 0, 0, 0, 0, 0, -1, 1),
                 c_year3_old = c(-1, 1, 0, 0, 0, 0, 0, 0)
)
contrasts_3_old<-summary(contrast(ref_3_old, c_list_3_old))
contrasts_3_old<-contrasts_3_old[,c(1,2,3,6)]
contrasts_3_old$estimate<-round(contrasts_3_old$estimate,3)
contrasts_3_old$SE<-round(contrasts_3_old$SE,3)
contrasts_3_old$p.value<-round(contrasts_3_old$p.value,3)

###A1C: Younger Group
dat.young<-subset(dat,dat$group=="Less than 12")
a1c_mod_toyear3_young<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+factor(trt_grp)+
                             factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
                         ,random=~1|MRN/yeargrouping,data=dat.young)
year3_sum_young<-summary(a1c_mod_toyear3_young)
year3_sum_young<-year3_sum_young$tTable[,c(1,2,5)]
year3_sum_young<-as.data.frame(year3_sum_young)
year3_sum_young$Value<-round(year3_sum_young$Value,3)
year3_sum_young$Std.Error<-round(year3_sum_young$Std.Error,3)
year3_sum_young$`p-value`<-round(year3_sum_young$`p-value`,3)

#test for differences between groups at each time point:
ref_3_young <- lsmeans(a1c_mod_toyear3_young, c("trt_grp", "yeargrouping"))

c_list_3_young <- list(c_base1_young = c(0, 0, -1, 1, 0, 0, 0, 0),
                     c_year1_young = c(0, 0, 0, 0, -1, 1, 0, 0),
                     c_year2_young = c(0, 0, 0, 0, 0, 0, -1, 1),
                     c_year3_young = c(-1, 1, 0, 0, 0, 0, 0, 0)
)
contrasts_3_young<-summary(contrast(ref_3_young, c_list_3_young))
contrasts_3_young<-contrasts_3_young[,c(1,2,3,6)]
contrasts_3_young$estimate<-round(contrasts_3_young$estimate,3)
contrasts_3_young$SE<-round(contrasts_3_young$SE,3)
contrasts_3_young$p.value<-round(contrasts_3_young$p.value,3)

# #A1c: pump group
# dat.pump<-subset(dat,dat$technology_type_inyear=="Pump Only")
# a1c_mod_toyear3_pump<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+factor(trt_grp)+group+
#                              factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
#                            ,random=~1|MRN/yeargrouping,data=dat.pump)
# year3_sum_pump<-summary(a1c_mod_toyear3_pump)
# year3_sum_pump<-year3_sum_pump$tTable[,c(1,2,5)]
# year3_sum_pump<-as.data.frame(year3_sum_pump)
# year3_sum_pump$Value<-round(year3_sum_pump$Value,3)
# year3_sum_pump$Std.Error<-round(year3_sum_pump$Std.Error,3)
# year3_sum_pump$`p-value`<-round(year3_sum_pump$`p-value`,3)
# 
# #test for differences between groups at each time point:
# ref_3_pump <- lsmeans(a1c_mod_toyear3_pump, c("trt_grp", "yeargrouping"))
# 
# c_list_3_pump <- list(c_base1_pump = c(0, 0, -1, 1, 0, 0, 0, 0),
#                        c_year1_pump = c(0, 0, 0, 0, -1, 1, 0, 0),
#                        c_year2_pump = c(0, 0, 0, 0, 0, 0, -1, 1),
#                        c_year3_pump = c(-1, 1, 0, 0, 0, 0, 0, 0)
# )
# contrasts_3_pump<-summary(contrast(ref_3_pump, c_list_3_pump))
# contrasts_3_pump<-contrasts_3_pump[,c(1,2,3,6)]
# contrasts_3_pump$estimate<-round(contrasts_3_pump$estimate,3)
# contrasts_3_pump$SE<-round(contrasts_3_pump$SE,3)
# contrasts_3_pump$p.value<-round(contrasts_3_pump$p.value,3)
# 
# #A1c: no technology
# dat.nopump<-subset(dat,dat$technology_type_inyear=="No CGM or Pump")
# a1c_mod_toyear3_nopump<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+factor(trt_grp)+group+
#                               factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
#                             ,random=~1|MRN/yeargrouping,data=dat.nopump)
# year3_sum_nopump<-summary(a1c_mod_toyear3_nopump)
# year3_sum_nopump<-year3_sum_nopump$tTable[,c(1,2,5)]
# year3_sum_nopump<-as.data.frame(year3_sum_nopump)
# year3_sum_nopump$Value<-round(year3_sum_nopump$Value,3)
# year3_sum_nopump$Std.Error<-round(year3_sum_nopump$Std.Error,3)
# year3_sum_nopump$`p-value`<-round(year3_sum_nopump$`p-value`,3)
# 
# #test for differences between groups at each time point:
# ref_3_nopump <- lsmeans(a1c_mod_toyear3_nopump, c("trt_grp", "yeargrouping"))
# 
# c_list_3_nopump <- list(c_base1_nopump = c(0, 0, -1, 1, 0, 0, 0, 0),
#                         c_year1_nopump = c(0, 0, 0, 0, -1, 1, 0, 0),
#                         c_year2_nopump = c(0, 0, 0, 0, 0, 0, -1, 1),
#                         c_year3_nopump = c(-1, 1, 0, 0, 0, 0, 0, 0)
# )
# contrasts_3_nopump<-summary(contrast(ref_3_nopump, c_list_3_nopump))
# contrasts_3_nopump<-contrasts_3_nopump[,c(1,2,3,6)]
# contrasts_3_nopump$estimate<-round(contrasts_3_nopump$estimate,3)
# contrasts_3_nopump$SE<-round(contrasts_3_nopump$SE,3)
# contrasts_3_nopump$p.value<-round(contrasts_3_nopump$p.value,3)

#########Checks Per Day#########
#OVERALL
dat_checks<-subset(dat,!is.na(dat$checks_last_in_year))
checks_mod_toyear3<-lme(checks_last_in_year~baseline_checks+factor(yeargrouping)+group+
                          factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
                     ,random=~1|MRN/yeargrouping,data=dat_checks)
checks_year3_sum<-summary(checks_mod_toyear3)
checks_year3_sum<-checks_year3_sum$tTable[,c(1,2,5)]
checks_year3_sum<-as.data.frame(checks_year3_sum)
checks_year3_sum$Value<-round(checks_year3_sum$Value,3)
checks_year3_sum$Std.Error<-round(checks_year3_sum$Std.Error,3)
checks_year3_sum$`p-value`<-round(checks_year3_sum$`p-value`,3)

#test for differences between groups at each time point:
ref_3_checks <- lsmeans(checks_mod_toyear3, c("trt_grp", "yeargrouping"))

c_list_3_checks <- list(c_base1 = c(0, 0, -1, 1, 0, 0, 0, 0),
                 c_year1 = c(0, 0, 0, 0, -1, 1, 0, 0),
                 c_year2 = c(0, 0, 0, 0, 0, 0, -1, 1),
                 c_year3 = c(-1, 1, 0, 0, 0, 0, 0, 0)
)
contrasts_3_checks<-summary(contrast(ref_3_checks, c_list_3_checks))
contrasts_3_checks<-contrasts_3_checks[,c(1,2,3,6)]
contrasts_3_checks$estimate<-round(contrasts_3_checks$estimate,3)
contrasts_3_checks$SE<-round(contrasts_3_checks$SE,3)
contrasts_3_checks$p.value<-round(contrasts_3_checks$p.value,3)

#OLDER
dat_checks_old<-subset(dat_checks,dat_checks$group=="greater than or equal to 12")
checks_mod_toyear3_old<-lme(checks_last_in_year~baseline_checks+factor(yeargrouping)+
                          factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
                        ,random=~1|MRN/yeargrouping,data=dat_checks_old)
checks_year3_sum_old<-summary(checks_mod_toyear3_old)
checks_year3_sum_old<-checks_year3_sum_old$tTable[,c(1,2,5)]
checks_year3_sum_old<-as.data.frame(checks_year3_sum_old)
checks_year3_sum_old$Value<-round(checks_year3_sum_old$Value,3)
checks_year3_sum_old$Std.Error<-round(checks_year3_sum_old$Std.Error,3)
checks_year3_sum_old$`p-value`<-round(checks_year3_sum_old$`p-value`,3)

#test for differences between groups at each time point:
ref_3_checks_old <- lsmeans(checks_mod_toyear3_old, c("trt_grp", "yeargrouping"))

c_list_3_checks_old <- list(c_base1_old = c(0, 0, -1, 1, 0, 0, 0, 0),
                        c_year1_old = c(0, 0, 0, 0, -1, 1, 0, 0),
                        c_year2_old = c(0, 0, 0, 0, 0, 0, -1, 1),
                        c_year3_old = c(-1, 1, 0, 0, 0, 0, 0, 0)
)
contrasts_3_checks_old<-summary(contrast(ref_3_checks_old, c_list_3_checks_old))
contrasts_3_checks_old<-contrasts_3_checks_old[,c(1,2,3,6)]
contrasts_3_checks_old$estimate<-round(contrasts_3_checks_old$estimate,3)
contrasts_3_checks_old$SE<-round(contrasts_3_checks_old$SE,3)
contrasts_3_checks_old$p.value<-round(contrasts_3_checks_old$p.value,3)

#YOUNGER
dat_checks_young<-subset(dat_checks,dat_checks$group=="Less than 12")
checks_mod_toyear3_young<-lme(checks_last_in_year~baseline_checks+factor(yeargrouping)+
                              factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
                            ,random=~1|MRN/yeargrouping,data=dat_checks_young)
checks_year3_sum_young<-summary(checks_mod_toyear3_young)
checks_year3_sum_young<-checks_year3_sum_young$tTable[,c(1,2,5)]
checks_year3_sum_young<-as.data.frame(checks_year3_sum_young)
checks_year3_sum_young$Value<-round(checks_year3_sum_young$Value,3)
checks_year3_sum_young$Std.Error<-round(checks_year3_sum_young$Std.Error,3)
checks_year3_sum_young$`p-value`<-round(checks_year3_sum_young$`p-value`,3)

#test for differences between groups at each time point:
ref_3_checks_young <- lsmeans(checks_mod_toyear3_young, c("trt_grp", "yeargrouping"))

c_list_3_checks_young <- list(c_base1_young = c(0, 0, -1, 1, 0, 0, 0, 0),
                            c_year1_young = c(0, 0, 0, 0, -1, 1, 0, 0),
                            c_year2_young = c(0, 0, 0, 0, 0, 0, -1, 1),
                            c_year3_young = c(-1, 1, 0, 0, 0, 0, 0, 0)
)
contrasts_3_checks_young<-summary(contrast(ref_3_checks_young, c_list_3_checks_young))
contrasts_3_checks_young<-contrasts_3_checks_young[,c(1,2,3,6)]
contrasts_3_checks_young$estimate<-round(contrasts_3_checks_young$estimate,3)
contrasts_3_checks_young$SE<-round(contrasts_3_checks_young$SE,3)
contrasts_3_checks_young$p.value<-round(contrasts_3_checks_young$p.value,3)

####PUMP ONLY
# dat_checks_pump<-subset(dat_checks,dat_checks$technology_type_inyear=="Pump Only")
# checks_mod_toyear3_pump<-lme(checks_last_in_year~baseline_checks+factor(yeargrouping)+group+
#                                 factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
#                               ,random=~1|MRN/yeargrouping,data=dat_checks_pump)
# checks_year3_sum_pump<-summary(checks_mod_toyear3_pump)
# checks_year3_sum_pump<-checks_year3_sum_pump$tTable[,c(1,2,5)]
# checks_year3_sum_pump<-as.data.frame(checks_year3_sum_pump)
# checks_year3_sum_pump$Value<-round(checks_year3_sum_pump$Value,3)
# checks_year3_sum_pump$Std.Error<-round(checks_year3_sum_pump$Std.Error,3)
# checks_year3_sum_pump$`p-value`<-round(checks_year3_sum_pump$`p-value`,3)
# 
# #test for differences between groups at each time point:
# ref_3_checks_pump <- lsmeans(checks_mod_toyear3_pump, c("trt_grp", "yeargrouping"))
# 
# c_list_3_checks_pump <- list(c_base1_pump = c(0, 0, -1, 1, 0, 0, 0, 0),
#                               c_year1_pump = c(0, 0, 0, 0, -1, 1, 0, 0),
#                               c_year2_pump = c(0, 0, 0, 0, 0, 0, -1, 1),
#                               c_year3_pump = c(-1, 1, 0, 0, 0, 0, 0, 0)
# )
# contrasts_3_checks_pump<-summary(contrast(ref_3_checks_pump, c_list_3_checks_pump))
# contrasts_3_checks_pump<-contrasts_3_checks_pump[,c(1,2,3,6)]
# contrasts_3_checks_pump$estimate<-round(contrasts_3_checks_pump$estimate,3)
# contrasts_3_checks_pump$SE<-round(contrasts_3_checks_pump$SE,3)
# contrasts_3_checks_pump$p.value<-round(contrasts_3_checks_pump$p.value,3)
# 
# ####NO TECH
# dat_checks_nopump<-subset(dat_checks,dat_checks$technology_type_inyear=="No CGM or Pump")
# checks_mod_toyear3_nopump<-lme(checks_last_in_year~baseline_checks+factor(yeargrouping)+group+
#                                factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
#                              ,random=~1|MRN/yeargrouping,data=dat_checks_nopump)
# checks_year3_sum_nopump<-summary(checks_mod_toyear3_nopump)
# checks_year3_sum_nopump<-checks_year3_sum_nopump$tTable[,c(1,2,5)]
# checks_year3_sum_nopump<-as.data.frame(checks_year3_sum_nopump)
# checks_year3_sum_nopump$Value<-round(checks_year3_sum_nopump$Value,3)
# checks_year3_sum_nopump$Std.Error<-round(checks_year3_sum_nopump$Std.Error,3)
# checks_year3_sum_nopump$`p-value`<-round(checks_year3_sum_nopump$`p-value`,3)
# 
# #test for differences between groups at each time point:
# ref_3_checks_nopump <- lsmeans(checks_mod_toyear3_nopump, c("trt_grp", "yeargrouping"))
# 
# c_list_3_checks_nopump <- list(c_base1_nopump = c(0, 0, -1, 1, 0, 0, 0, 0),
#                              c_year1_nopump = c(0, 0, 0, 0, -1, 1, 0, 0),
#                              c_year2_nopump = c(0, 0, 0, 0, 0, 0, -1, 1),
#                              c_year3_nopump = c(-1, 1, 0, 0, 0, 0, 0, 0)
# )
# contrasts_3_checks_nopump<-summary(contrast(ref_3_checks_nopump, c_list_3_checks_nopump))
# contrasts_3_checks_nopump<-contrasts_3_checks_nopump[,c(1,2,3,6)]
# contrasts_3_checks_nopump$estimate<-round(contrasts_3_checks_nopump$estimate,3)
# contrasts_3_checks_nopump$SE<-round(contrasts_3_checks_nopump$SE,3)
# contrasts_3_checks_nopump$p.value<-round(contrasts_3_checks_nopump$p.value,3)