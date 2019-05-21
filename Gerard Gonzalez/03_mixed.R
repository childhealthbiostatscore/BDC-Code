####### Mixed Models #######
#source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/00_data.R')
library(nlme)
library(afex)
require(lsmeans)

dat_2<-subset(dat,dat$yeargrouping!="Year3")
dat_2<-subset(dat_2,dat_2$yeargrouping!="Year4")

dat_2$yeargrouping<-factor(dat_2$yeargrouping,levels=c("Year2","Base1","Year1"))
dat_2$group<-factor(dat_2$group,levels=c("greater than or equal to 12","Less than 12"))

dat_2$trt_grp<-as.factor(dat_2$trt_grp)

# a1c_mod1<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+group+factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
#                   ,random=~1|MRN,data=dat)
# summary(a1c_mod1)

a1c_mod_toyear2<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+group+factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
              ,random=~1|MRN/yeargrouping,data=dat_2)
year2_sum<-summary(a1c_mod_toyear2)
year2_sum<-year2_sum$tTable[,c(1,2,5)]
year2_sum<-as.data.frame(year2_sum)
year2_sum$Value<-round(year2_sum$Value,3)
year2_sum$Std.Error<-round(year2_sum$Std.Error,3)
year2_sum$`p-value`<-round(year2_sum$`p-value`,3)

#test for differences between groups at each time point:
ref_2 <- lsmeans(a1c_mod_toyear2, c("trt_grp", "yeargrouping"))

c_list_2 <- list(c_base1 = c(0, 0, -1, 1, 0, 0),
               c_year1 = c(0, 0, 0, 0, -1, 1),
               c_year2 = c(-1, 1, 0, 0, 0, 0)
               )
contrasts_2<-summary(contrast(ref_2, c_list_2))
contrasts_2<-contrasts_2[,c(1,2,3,6)]
contrasts_2$estimate<-round(contrasts_2$estimate,3)
contrasts_2$SE<-round(contrasts_2$SE,3)
contrasts_2$p.value<-round(contrasts_2$p.value,3)

#### Subset to only patients who had 3 year data ####
dat_3<-subset(dat,dat$yeargrouping!="Year4")

# moved this into general function 01_functions.R
# yr_3<-function(ID,data){
#   
#   temp<-lapply(unique(ID), function(x){
#     
#     dat.temp <- subset(data, ID == x)
#     ##dat.temp <- subset(dat_3,dat_3$MRN==733537)
#     three_yn<-nrow(subset(dat.temp,dat.temp$yeargrouping=="Year3"))>0
#     dat.temp$year_3<-0
#     dat.temp$year_3[three_yn]<-1
#     dat.temp
#     dat.temp})
#   
#   dat<-do.call(rbind,temp)
# }

dat_3<-yr_3(dat_3$MRN,dat_3)

dat_3<-subset(dat_3,dat_3$year_3==1)
length(unique(dat_3$MRN))

#have to remove 1188018 because no a1c at year 3:
dat_3<-subset(dat_3,dat_3$MRN!=1188018)


dat_3$yeargrouping<-factor(dat_3$yeargrouping,levels=c("Year3","Base1","Year1","Year2"))

a1c_mod_toyear3<-lme(a1c_last_in_year~baseline_a1c+factor(yeargrouping)+group+factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
                     ,random=~1|MRN/yeargrouping,data=dat_3)
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

checks_mod_toyear3<-lme(checks_last_in_year~baseline_a1c+factor(yeargrouping)+group+factor(trt_grp)+factor(yeargrouping)*factor(trt_grp)+duration_of_diagnosis
                     ,random=~1|MRN/yeargrouping,data=dat_3)
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
contrasts_3<-contrasts_3_checks[,c(1,2,3,6)]
contrasts_3_checks$estimate<-round(contrasts_3_checks$estimate,3)
contrasts_3_checks$SE<-round(contrasts_3_checks$SE,3)
contrasts_3_checks$p.value<-round(contrasts_3_checks$p.value,3)
