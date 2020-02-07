####### Mixed Models #######
#source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/00_data.R')
library(nlme)
library(afex)
require(lsmeans)
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/Year4 Code/00_data_yr4.R')
length(unique(dat$MRN))

dat$yeargrouping<-factor(dat$yeargrouping,levels=c("Year4","Base1","Year1","Year2","Year3"))

####A1c: overall cohort####
a1c_mod_toyear4<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+group+factor(trt_grp)+
                       factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
                     ,random=~1|MRN/yeargrouping,data=dat)
year4_sum<-summary(a1c_mod_toyear4)
year4_sum<-year4_sum$tTable[,c(1,2,5)]
year4_sum<-as.data.frame(year4_sum)
year4_sum$Value<-round(year4_sum$Value,3)
year4_sum$Std.Error<-round(year4_sum$Std.Error,3)
year4_sum$`p-value`<-round(year4_sum$`p-value`,3)

anova_a1c_mod_toyear4<-anova(a1c_mod_toyear4)

#test for differences between groups at each time point:
ref_test <- lsmeans(a1c_mod_toyear4, c("technology_type_inyear", "yeargrouping","trt_grp"))

ref_4 <- lsmeans(a1c_mod_toyear4, c("trt_grp", "yeargrouping"))

c_within_year <- list(c_base1 = c(0, 0, -1, 1, 0, 0, 0, 0, 0, 0),
                 c_year1 = c(0, 0, 0, 0, -1, 1, 0, 0, 0, 0),
                 c_year2 = c(0, 0, 0, 0, 0, 0, -1, 1, 0, 0),
                 c_year3 = c(0, 0, 0, 0, 0, 0, 0, 0, -1, 1),
                 c_year4 = c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0))
con_within_yr<-summary(contrast(ref_4, c_within_year))
con_within_yr<-con_within_yr[,c(1,2,3,6)]
con_within_yr$estimate<-round(con_within_yr$estimate,3)
con_within_yr$SE<-round(con_within_yr$SE,3)
con_within_yr$p.value<-round(con_within_yr$p.value,3)

c_across_year <- list(lp_base_1 = c(0, 0, 0, 1, 0, -1, 0, 0, 0, 0),
                      c_base_1 = c(0, 0, 1, 0, -1, 0, 0, 0, 0, 0),
                      lp_1_2 = c(0, 0, 0, 0, 0, 1, 0, -1, 0, 0),
                      c_1_2 = c(0, 0, 0, 0, 1, 0, -1, 0, 0, 0),
                      lp_2_3 = c(0, 0, 0, 0, 0, 0, 0, 1, 0, -1),
                      c_2_3 = c(0, 0, 0, 0, 0, 0, 1, 0, -1, 0),
                      lp_3_4 = c(0, -1, 0, 0, 0, 0, 0, 0, 0, 1),
                      c_3_4 = c(-1, 0, 0, 0, 0, 0, 0, 0, 1, 0),
                      lp_base_4 = c(0, -1, 0, 1, 0, 0, 0, 0, 0, 0),
                      c_base_4 = c(-1, 0, 1, 0, 0, 0, 0, 0, 0, 0)
)
c_across_year<-summary(contrast(ref_4, c_across_year))
c_across_year<-c_across_year[,c(1,2,3,6)]
c_across_year$estimate<-round(c_across_year$estimate,3)
c_across_year$SE<-round(c_across_year$SE,3)
c_across_year$p.value<-round(c_across_year$p.value,3)

c_across_year_grp <- list(grp_base_1 = c(0, 0, -1, 1, 1, -1, 0, 0, 0, 0),
                          grp_1_2 = c(0, 0, 0, 0, -1, 1, 1, -1, 0, 0),
                          grp_2_3 = c(0, 0, 0, 0, 0, 0, -1, 1, 1, -1),
                          grp_3_4 = c(-1, 1, 0, 0, 0, 0, 0, 0, 1, -1))
c_across_year_grp<-summary(contrast(ref_4, c_across_year_grp))
c_across_year_grp<-c_across_year_grp[,c(1,2,3,6)]
c_across_year_grp$estimate<-round(c_across_year_grp$estimate,3)
c_across_year_grp$SE<-round(c_across_year_grp$SE,3)
c_across_year_grp$p.value<-round(c_across_year_grp$p.value,3)
# 
# #####A1c in older cohort
# dat.old<-subset(dat,dat$group=="greater than or equal to 12")
# a1c_mod_toyear4_old<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+factor(trt_grp)+
#                            factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
#                          ,random=~1|MRN/yeargrouping,data=dat.old)
# year4_sum_old<-summary(a1c_mod_toyear4_old)
# year4_sum_old<-year4_sum_old$tTable[,c(1,2,5)]
# year4_sum_old<-as.data.frame(year4_sum_old)
# year4_sum_old$Value<-round(year4_sum_old$Value,3)
# year4_sum_old$Std.Error<-round(year4_sum_old$Std.Error,3)
# year4_sum_old$`p-value`<-round(year4_sum_old$`p-value`,3)
# anova_a1c_mod_toyear4_old<-anova(a1c_mod_toyear4_old)
# 
# #test for differences between groups at each time point:
# ref_4_old <- lsmeans(a1c_mod_toyear4_old, c("trt_grp", "yeargrouping"))
# 
# c_list_4_old <- list(c_base1_old = c(0, 0, -1, 1, 0, 0, 0, 0, 0, 0),
#                      c_year1_old = c(0, 0, 0, 0, -1, 1, 0, 0, 0, 0),
#                      c_year2_old = c(0, 0, 0, 0, 0, 0, -1, 1, 0, 0),
#                      c_year3_old = c(0, 0, 0, 0, 0, 0, 0, 0, -1, 1),
#                      c_year4_old = c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
#                      lp_3_4 = c(0, 1, 0, 0, 0, 0, 0, 0, 0, -1),
#                      c_3_4 = c(1, 0, 0, 0, 0, 0, 0, 0, -1, 0)
# )
# contrasts_4_old<-summary(contrast(ref_4_old, c_list_4_old))
# contrasts_4_old<-contrasts_4_old[,c(1,2,3,6)]
# contrasts_4_old$estimate<-round(contrasts_4_old$estimate,3)
# contrasts_4_old$SE<-round(contrasts_4_old$SE,3)
# contrasts_4_old$p.value<-round(contrasts_4_old$p.value,3)
# 
# ###A1C: Younger Group
# dat.young<-subset(dat,dat$group=="Less than 12")
# a1c_mod_toyear4_young<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+factor(trt_grp)+
#                              factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
#                            ,random=~1|MRN/yeargrouping,data=dat.young)
# year4_sum_young<-summary(a1c_mod_toyear4_young)
# year4_sum_young<-year4_sum_young$tTable[,c(1,2,5)]
# year4_sum_young<-as.data.frame(year4_sum_young)
# year4_sum_young$Value<-round(year4_sum_young$Value,3)
# year4_sum_young$Std.Error<-round(year4_sum_young$Std.Error,3)
# year4_sum_young$`p-value`<-round(year4_sum_young$`p-value`,3)
# 
# anova_a1c_mod_toyear4_young<-anova(a1c_mod_toyear4_young)
# 
# #test for differences between groups at each time point:
# ref_4_young <- lsmeans(a1c_mod_toyear4_young, c("trt_grp", "yeargrouping"))
# 
# c_list_4_young <- list(c_base1_young = c(0, 0, -1, 1, 0, 0, 0, 0, 0, 0),
#                        c_year1_young = c(0, 0, 0, 0, -1, 1, 0, 0, 0, 0),
#                        c_year2_young = c(0, 0, 0, 0, 0, 0, -1, 1, 0, 0),
#                        c_year3_young = c(0, 0, 0, 0, 0, 0, 0, 0, -1, 1),
#                        c_year4_young = c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
#                        lp_3_4 = c(0, 1, 0, 0, 0, 0, 0, 0, 0, -1),
#                        c_3_4 = c(1, 0, 0, 0, 0, 0, 0, 0, -1, 0)
# )
# contrasts_4_young<-summary(contrast(ref_4_young, c_list_4_young))
# contrasts_4_young<-contrasts_4_young[,c(1,2,3,6)]
# contrasts_4_young$estimate<-round(contrasts_4_young$estimate,3)
# contrasts_4_young$SE<-round(contrasts_4_young$SE,3)
# contrasts_4_young$p.value<-round(contrasts_4_young$p.value,3)
# 
# # #A1c: pump group
# dat.pump<-subset(dat,dat$technology_type_inyear %in% c("Pump Only","CGM and Pump"))
# 
# a1c_mod_toyear4_pump<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+factor(trt_grp)+group+
#                             factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+cgm_yn_inyear
#                           ,random=~1|MRN/yeargrouping,data=dat.pump)
# year4_sum_pump<-summary(a1c_mod_toyear4_pump)
# year4_sum_pump<-year4_sum_pump$tTable[,c(1,2,5)]
# year4_sum_pump<-as.data.frame(year4_sum_pump)
# year4_sum_pump$Value<-round(year4_sum_pump$Value,3)
# year4_sum_pump$Std.Error<-round(year4_sum_pump$Std.Error,3)
# year4_sum_pump$`p-value`<-round(year4_sum_pump$`p-value`,3)
# anova_a1c_mod_toyear4_pump<-anova(a1c_mod_toyear4_pump)
# # 
# # #test for differences between groups at each time point:
# ref_4_pump <- lsmeans(a1c_mod_toyear4_pump, c("trt_grp", "yeargrouping"))
# 
# c_list_4_pump <- list(c_base1_pump = c(0, 0, -1, 1, 0, 0, 0, 0, 0, 0),
#                       c_year1_pump = c(0, 0, 0, 0, -1, 1, 0, 0, 0, 0),
#                       c_year2_pump = c(0, 0, 0, 0, 0, 0, -1, 1, 0, 0),
#                       c_year3_pump = c(0, 0, 0, 0, 0, 0, 0, 0, -1, 1),
#                       c_year4_pump = c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
#                       lp_3_4 = c(0, 1, 0, 0, 0, 0, 0, 0, 0, -1),
#                       c_3_4 = c(1, 0, 0, 0, 0, 0, 0, 0, -1, 0)
# )
# contrasts_4_pump<-summary(contrast(ref_4_pump, c_list_4_pump))
# contrasts_4_pump<-contrasts_4_pump[,c(1,2,3,6)]
# contrasts_4_pump$estimate<-round(contrasts_4_pump$estimate,3)
# contrasts_4_pump$SE<-round(contrasts_4_pump$SE,3)
# contrasts_4_pump$p.value<-round(contrasts_4_pump$p.value,3)
# # # 
# # #A1c: no technology
# dat.nopump<-subset(dat,dat$technology_type_inyear=="No CGM or Pump")
# a1c_mod_toyear4_nopump<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+factor(trt_grp)+group+
#                               factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
#                             ,random=~1|MRN/yeargrouping,data=dat.nopump)
# year4_sum_nopump<-summary(a1c_mod_toyear4_nopump)
# year4_sum_nopump<-year4_sum_nopump$tTable[,c(1,2,5)]
# year4_sum_nopump<-as.data.frame(year4_sum_nopump)
# year4_sum_nopump$Value<-round(year4_sum_nopump$Value,3)
# year4_sum_nopump$Std.Error<-round(year4_sum_nopump$Std.Error,3)
# year4_sum_nopump$`p-value`<-round(year4_sum_nopump$`p-value`,3)
# anova_a1c_mod_toyear4_nopump<-anova(a1c_mod_toyear4_nopump)
# #test for differences between groups at each time point:
# ref_4_nopump <- lsmeans(a1c_mod_toyear4_nopump, c("trt_grp", "yeargrouping"))
# 
# c_list_4_nopump <- list(c_base1_nopump = c(0, 0, -1, 1, 0, 0, 0, 0, 0, 0),
#                       c_year1_nopump = c(0, 0, 0, 0, -1, 1, 0, 0, 0, 0),
#                       c_year2_nopump = c(0, 0, 0, 0, 0, 0, -1, 1, 0, 0),
#                       c_year3_nopump = c(0, 0, 0, 0, 0, 0, 0, 0, -1, 1),
#                       c_year4_nopump = c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
#                       lp_3_4 = c(0, 1, 0, 0, 0, 0, 0, 0, 0, -1),
#                       c_3_4 = c(1, 0, 0, 0, 0, 0, 0, 0, -1, 0)
# )
# contrasts_4_nopump<-summary(contrast(ref_4_nopump, c_list_4_nopump))
# contrasts_4_nopump<-contrasts_4_nopump[,c(1,2,3,6)]
# contrasts_4_nopump$estimate<-round(contrasts_4_nopump$estimate,3)
# contrasts_4_nopump$SE<-round(contrasts_4_nopump$SE,3)
# contrasts_4_nopump$p.value<-round(contrasts_4_nopump$p.value,3)
# 
# #########Checks Per Day#########
# #OVERALL
# dat_checks<-subset(dat,!is.na(dat$checks_last_in_year))
# checks_mod_toyear4<-lme(checks_last_in_year~baseline_checks+factor(yeargrouping)+group+
#                           factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
#                         ,random=~1|MRN/yeargrouping,data=dat_checks)
# checks_year4_sum<-summary(checks_mod_toyear4)
# checks_year4_sum<-checks_year4_sum$tTable[,c(1,2,5)]
# checks_year4_sum<-as.data.frame(checks_year4_sum)
# checks_year4_sum$Value<-round(checks_year4_sum$Value,3)
# checks_year4_sum$Std.Error<-round(checks_year4_sum$Std.Error,3)
# checks_year4_sum$`p-value`<-round(checks_year4_sum$`p-value`,3)
# 
# 
# anova_checks_mod_toyear4<-anova(checks_mod_toyear4)
# #test for differences between groups at each time point:
# ref_4_checks <- lsmeans(checks_mod_toyear4, c("trt_grp", "yeargrouping"))
# 
# c_list_4_checks <- list(c_base1_checks = c(0, 0, -1, 1, 0, 0, 0, 0, 0, 0),
#                         c_year1_checks = c(0, 0, 0, 0, -1, 1, 0, 0, 0, 0),
#                         c_year2_checks = c(0, 0, 0, 0, 0, 0, -1, 1, 0, 0),
#                         c_year3_checks = c(0, 0, 0, 0, 0, 0, 0, 0, -1, 1),
#                         c_year4_checks = c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
#                         lp_3_4 = c(0, 1, 0, 0, 0, 0, 0, 0, 0, -1),
#                         c_3_4 = c(1, 0, 0, 0, 0, 0, 0, 0, -1, 0)
# )
# contrasts_4_checks<-summary(contrast(ref_4_checks, c_list_4_checks))
# contrasts_4_checks<-contrasts_4_checks[,c(1,2,3,6)]
# contrasts_4_checks$estimate<-round(contrasts_4_checks$estimate,3)
# contrasts_4_checks$SE<-round(contrasts_4_checks$SE,3)
# contrasts_4_checks$p.value<-round(contrasts_4_checks$p.value,3)
# 
# #OLDER
# dat_checks_old<-subset(dat_checks,dat_checks$group=="greater than or equal to 12")
# checks_mod_toyear4_old<-lme(checks_last_in_year~baseline_checks+factor(yeargrouping)+
#                               factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
#                             ,random=~1|MRN/yeargrouping,data=dat_checks_old)
# checks_year4_sum_old<-summary(checks_mod_toyear4_old)
# checks_year4_sum_old<-checks_year4_sum_old$tTable[,c(1,2,5)]
# checks_year4_sum_old<-as.data.frame(checks_year4_sum_old)
# checks_year4_sum_old$Value<-round(checks_year4_sum_old$Value,3)
# checks_year4_sum_old$Std.Error<-round(checks_year4_sum_old$Std.Error,3)
# checks_year4_sum_old$`p-value`<-round(checks_year4_sum_old$`p-value`,3)
# anova_checks_mod_toyear4_old<-anova(checks_mod_toyear4_old)
# #test for differences between groups at each time point:
# ref_4_checks_old <- lsmeans(checks_mod_toyear4_old, c("trt_grp", "yeargrouping"))
# 
# c_list_4_checks_old <- list(c_base1_checks_old = c(0, 0, -1, 1, 0, 0, 0, 0, 0, 0),
#                         c_year1_checks_old = c(0, 0, 0, 0, -1, 1, 0, 0, 0, 0),
#                         c_year2_checks_old = c(0, 0, 0, 0, 0, 0, -1, 1, 0, 0),
#                         c_year3_checks_old = c(0, 0, 0, 0, 0, 0, 0, 0, -1, 1),
#                         c_year4_checks_old = c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
#                         lp_3_4 = c(0, 1, 0, 0, 0, 0, 0, 0, 0, -1),
#                         c_3_4 = c(1, 0, 0, 0, 0, 0, 0, 0, -1, 0)
# )
# contrasts_4_checks_old<-summary(contrast(ref_4_checks_old, c_list_4_checks_old))
# contrasts_4_checks_old<-contrasts_4_checks_old[,c(1,2,3,6)]
# contrasts_4_checks_old$estimate<-round(contrasts_4_checks_old$estimate,3)
# contrasts_4_checks_old$SE<-round(contrasts_4_checks_old$SE,3)
# contrasts_4_checks_old$p.value<-round(contrasts_4_checks_old$p.value,3)
# 
# #YOUNGER
# dat_checks_young<-subset(dat_checks,dat_checks$group=="Less than 12")
# checks_mod_toyear4_young<-lme(checks_last_in_year~baseline_checks+factor(yeargrouping)+
#                                 factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis+technology_type_inyear
#                               ,random=~1|MRN/yeargrouping,data=dat_checks_young)
# checks_year4_sum_young<-summary(checks_mod_toyear4_young)
# checks_year4_sum_young<-checks_year4_sum_young$tTable[,c(1,2,5)]
# checks_year4_sum_young<-as.data.frame(checks_year4_sum_young)
# checks_year4_sum_young$Value<-round(checks_year4_sum_young$Value,3)
# checks_year4_sum_young$Std.Error<-round(checks_year4_sum_young$Std.Error,3)
# checks_year4_sum_young$`p-value`<-round(checks_year4_sum_young$`p-value`,3)
# anova_checks_mod_toyear4_young<-anova(checks_mod_toyear4_young)
# 
# #test for differences between groups at each time point:
# ref_4_checks_young <- lsmeans(checks_mod_toyear4_young, c("trt_grp", "yeargrouping"))
# 
# c_list_4_checks_young <- list(c_base1_checks_young = c(0, 0, -1, 1, 0, 0, 0, 0, 0, 0),
#                             c_year1_checks_young = c(0, 0, 0, 0, -1, 1, 0, 0, 0, 0),
#                             c_year2_checks_young = c(0, 0, 0, 0, 0, 0, -1, 1, 0, 0),
#                             c_year3_checks_young = c(0, 0, 0, 0, 0, 0, 0, 0, -1, 1),
#                             c_year4_checks_young = c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
#                             lp_3_4 = c(0, 1, 0, 0, 0, 0, 0, 0, 0, -1),
#                             c_3_4 = c(1, 0, 0, 0, 0, 0, 0, 0, -1, 0)
# )
# contrasts_4_checks_young<-summary(contrast(ref_4_checks_young, c_list_4_checks_young))
# contrasts_4_checks_young<-contrasts_4_checks_young[,c(1,2,3,6)]
# contrasts_4_checks_young$estimate<-round(contrasts_4_checks_young$estimate,3)
# contrasts_4_checks_young$SE<-round(contrasts_4_checks_young$SE,3)
# contrasts_4_checks_young$p.value<-round(contrasts_4_checks_young$p.value,3)
# 
# ####PUMP ONLY
# dat_checks_pump<-subset(dat_checks,dat_checks$technology_type_inyear=="Pump Only")
# checks_mod_toyear4_pump<-lme(checks_last_in_year~baseline_checks+factor(yeargrouping)+group+
#                                factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
#                              ,random=~1|MRN/yeargrouping,data=dat_checks_pump)
# checks_year4_sum_pump<-summary(checks_mod_toyear4_pump)
# checks_year4_sum_pump<-checks_year4_sum_pump$tTable[,c(1,2,5)]
# checks_year4_sum_pump<-as.data.frame(checks_year4_sum_pump)
# checks_year4_sum_pump$Value<-round(checks_year4_sum_pump$Value,3)
# checks_year4_sum_pump$Std.Error<-round(checks_year4_sum_pump$Std.Error,3)
# checks_year4_sum_pump$`p-value`<-round(checks_year4_sum_pump$`p-value`,3)
# 
# anova_checks_mod_toyear4_pump<-anova(checks_mod_toyear4_pump)
# 
# #test for differences between groups at each time point:
# ref_4_checks_pump <- lsmeans(checks_mod_toyear4_pump, c("trt_grp", "yeargrouping"))
# 
# c_list_4_checks_pump <- list(c_base1_checks_pump = c(0, 0, -1, 1, 0, 0, 0, 0, 0, 0),
#                             c_year1_checks_pump = c(0, 0, 0, 0, -1, 1, 0, 0, 0, 0),
#                             c_year2_checks_pump = c(0, 0, 0, 0, 0, 0, -1, 1, 0, 0),
#                             c_year3_checks_pump = c(0, 0, 0, 0, 0, 0, 0, 0, -1, 1),
#                             c_year4_checks_pump = c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
#                             lp_3_4 = c(0, 1, 0, 0, 0, 0, 0, 0, 0, -1),
#                             c_3_4 = c(1, 0, 0, 0, 0, 0, 0, 0, -1, 0)
# )
# contrasts_4_checks_pump<-summary(contrast(ref_4_checks_pump, c_list_4_checks_pump))
# contrasts_4_checks_pump<-contrasts_4_checks_pump[,c(1,2,3,6)]
# contrasts_4_checks_pump$estimate<-round(contrasts_4_checks_pump$estimate,3)
# contrasts_4_checks_pump$SE<-round(contrasts_4_checks_pump$SE,3)
# contrasts_4_checks_pump$p.value<-round(contrasts_4_checks_pump$p.value,3)
# # 
# # ####NO TECH
# dat_checks_nopump<-subset(dat_checks,dat_checks$technology_type_inyear=="No CGM or Pump")
# checks_mod_toyear4_nopump<-lme(checks_last_in_year~baseline_checks+factor(yeargrouping)+group+
#                                  factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
#                                ,random=~1|MRN/yeargrouping,data=dat_checks_nopump)
# checks_year4_sum_nopump<-summary(checks_mod_toyear4_nopump)
# checks_year4_sum_nopump<-checks_year4_sum_nopump$tTable[,c(1,2,5)]
# checks_year4_sum_nopump<-as.data.frame(checks_year4_sum_nopump)
# checks_year4_sum_nopump$Value<-round(checks_year4_sum_nopump$Value,3)
# checks_year4_sum_nopump$Std.Error<-round(checks_year4_sum_nopump$Std.Error,3)
# checks_year4_sum_nopump$`p-value`<-round(checks_year4_sum_nopump$`p-value`,3)
# anova_checks_mod_toyear4_nopump<-anova(checks_mod_toyear4_nopump)
# 
# #test for differences between groups at each time point:
# ref_4_checks_nopump <- lsmeans(checks_mod_toyear4_nopump, c("trt_grp", "yeargrouping"))
# 
# c_list_4_checks_nopump <- list(c_base1_checks_nopump = c(0, 0, -1, 1, 0, 0, 0, 0, 0, 0),
#                             c_year1_checks_nopump = c(0, 0, 0, 0, -1, 1, 0, 0, 0, 0),
#                             c_year2_checks_nopump = c(0, 0, 0, 0, 0, 0, -1, 1, 0, 0),
#                             c_year3_checks_nopump = c(0, 0, 0, 0, 0, 0, 0, 0, -1, 1),
#                             c_year4_checks_nopump = c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
#                             lp_3_4 = c(0, 1, 0, 0, 0, 0, 0, 0, 0, -1),
#                             c_3_4 = c(1, 0, 0, 0, 0, 0, 0, 0, -1, 0)
# )
# contrasts_4_checks_nopump<-summary(contrast(ref_4_checks_nopump, c_list_4_checks_nopump))
# contrasts_4_checks_nopump<-contrasts_4_checks_nopump[,c(1,2,3,6)]
# contrasts_4_checks_nopump$estimate<-round(contrasts_4_checks_nopump$estimate,3)
# contrasts_4_checks_nopump$SE<-round(contrasts_4_checks_nopump$SE,3)
# contrasts_4_checks_nopump$p.value<-round(contrasts_4_checks_nopump$p.value,3)