##### Tables - Gerard Gonzalez #####
source('S:/Shared Material/Shared Code/R/temp_table1.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/Year4 Code/00_data_yr4.R')

#demographics:
dat.base<-subset(dat,dat$yeargrouping=="Base1")
label(dat.base$Gender)<-"Gender"
label(dat.base$age)<-"Age at baseline"
label(dat.base$group)<-"Age group at baseline"
label(dat.base$duration_of_diagnosis)<-"Duration of Diagnosis at Baseline"
label(dat.base$a1c_last_in_year)<-"A1C at Baseline"
label(dat.base$checks_last_in_year)<-"Checks per day at Baseline"
label(dat.base$BMI)<-"BMI at Baseline"
dat.base$trt_grp<-as.factor(dat.base$trt_grp)
tab.demo<-final_table(dat.base,c('Gender','age','group','duration_of_diagnosis',
                                 'a1c_last_in_year','checks_last_in_year'),
                      dat.base$trt_grp,margin=2,single=F,ron=2,col.names=T, summary.stat='mean')
tab.demo

#TABLE 1 (NEW WAY):
mean_sd_table_1<-function(var,year){
  
  #var<-'a1c_last_in_year'
  #year<-"Base1"
  dat.temp<-subset(dat,dat$yeargrouping==year)
  x<-dat.temp[,which(colnames(dat.temp)==var)]
  mean.1<-mean(x[dat.temp$trt_grp=="Control"],na.rm=T)
  sd.1<-sd(x[dat.temp$trt_grp=="Control"],na.rm=T)
  
  temp.1<-subset(dat.temp,dat.temp$trt_grp=="Control")
  n.1<-nrow(subset(temp.1,!is.na(var)))
  
  mean.2<-mean(x[dat.temp$trt_grp=="LP"],na.rm=T)
  sd.2<-sd(x[dat.temp$trt_grp=="LP"],na.rm=T)
  
  temp.2<-subset(dat.temp,dat.temp$trt_grp=="LP")
  n.2<-nrow(subset(temp.2,!is.na(var)))
  
  #table for x
  tab.x<-data.frame(
    variable=c(paste0(year,": ",label(x)),"mean\u00B1sd","n"),
    Control=c("",paste0(round(mean.1,2),"\u00B1",round(sd.1,2)),n.1),
    Trt=c("",paste0(round(mean.2,2),"\u00B1",round(sd.2,2)),n.2)
  )
  return(tab.x)
}
a1c_base_1<-mean_sd_table_1('a1c_last_in_year',"Base1")
a1c_year_1<-mean_sd_table_1('a1c_last_in_year',"Year1")
a1c_year_2<-mean_sd_table_1('a1c_last_in_year',"Year2")
a1c_year_3<-mean_sd_table_1('a1c_last_in_year',"Year3")
a1c_year_4<-mean_sd_table_1('a1c_last_in_year',"Year4")

checks_base_1<-mean_sd_table_1('checks_last_in_year',"Base1")
checks_year_1<-mean_sd_table_1('checks_last_in_year',"Year1")
checks_year_2<-mean_sd_table_1('checks_last_in_year',"Year2")
checks_year_3<-mean_sd_table_1('checks_last_in_year',"Year3")
checks_year_4<-mean_sd_table_1('checks_last_in_year',"Year4")

tab.1<-rbind(a1c_base_1,a1c_year_1,a1c_year_2,a1c_year_3,a1c_year_4,checks_base_1,checks_year_1,checks_year_2,checks_year_3,checks_year_4)

mean_sd_table<-function(var,year){
  
  #var<-'a1c_last_in_year'
  #year<-"Base1"
  dat.temp<-subset(dat,dat$yeargrouping==year)
  x<-dat.temp[,which(colnames(dat.temp)==var)]
  mean.1<-mean(x[dat.temp$group=="Less than 12" & dat.temp$trt_grp=="Control"],na.rm=T)
  sd.1<-sd(x[dat.temp$group=="Less than 12" & dat.temp$trt_grp=="Control"],na.rm=T)
  
  temp.1<-subset(dat.temp,dat.temp$group=="Less than 12" & dat.temp$trt_grp=="Control")
  n.1<-nrow(subset(temp.1,!is.na(var)))
  
  mean.2<-mean(x[dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="Control"],na.rm=T)
  sd.2<-sd(x[dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="Control"],na.rm=T)
  
  temp.2<-subset(dat.temp,dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="Control")
  n.2<-nrow(subset(temp.2,!is.na(var)))
  
  mean.3<-mean(x[dat.temp$group=="Less than 12" & dat.temp$trt_grp=="LP"],na.rm=T)
  sd.3<-sd(x[dat.temp$group=="Less than 12" & dat.temp$trt_grp=="LP"],na.rm=T)
  
  temp.3<-subset(dat.temp,dat.temp$group=="Less than 12" & dat.temp$trt_grp=="LP")
  n.3<-nrow(subset(temp.3,!is.na(var)))
  
  mean.4<-mean(x[dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="LP"],na.rm=T)
  sd.4<-sd(x[dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="LP"],na.rm=T)  
  temp.4<-subset(dat.temp,dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="LP")
  n.4<-nrow(subset(temp.4,!is.na(var)))
  
  #table for x
  tab.x<-data.frame(
    variable=c(paste0(year,": ",label(x)),"mean\u00B1sd","n"),
    ControlYoung=c("",paste0(round(mean.1,3),"\u00B1",round(sd.1,3)),n.1),
    ControlOld=c("",paste0(round(mean.2,3),"\u00B1",round(sd.2,3)),n.2),
    TrtYoung=c("",paste0(round(mean.3,3),"\u00B1",round(sd.3,3)),n.3),
    TrtOld=c("",paste0(round(mean.4,3),"\u00B1",round(sd.4,3)),n.4)
  )
  return(tab.x)
}

a1c_base<-mean_sd_table('a1c_last_in_year',"Base1")
a1c_1<-mean_sd_table('a1c_last_in_year',"Year1")
a1c_2<-mean_sd_table('a1c_last_in_year',"Year2")
a1c_3<-mean_sd_table('a1c_last_in_year',"Year3")
a1c_4<-mean_sd_table('a1c_last_in_year',"Year4")

checks_base<-mean_sd_table('checks_last_in_year',"Base1")
checks_1<-mean_sd_table('checks_last_in_year',"Year1")
checks_2<-mean_sd_table('checks_last_in_year',"Year2")
checks_3<-mean_sd_table('checks_last_in_year',"Year3")
checks_4<-mean_sd_table('checks_last_in_year',"Year4")

tab.2<-rbind(a1c_base,a1c_1,a1c_2,a1c_3,a1c_4,checks_base,checks_1,checks_2,checks_3,checks_4)

#Table 5: Pump Use Y/N:

tab.pump.trt<-final_table(dat.trt,c('pump_yn_inyear'),
                    dat.trt$yeargrouping,margin=2,single=F,ron=2,col.names=T, summary.stat='mean')[,c(1,3:7)]

tab.pump.con<-final_table(dat.con,c('pump_yn_inyear'),
                          dat.con$yeargrouping,margin=2,single=F,ron=2,col.names=T, summary.stat='mean')[,c(1,3:7)]

tab.cgm.trt<-final_table(dat.trt,c('cgm_yn_inyear'),
                          dat.trt$yeargrouping,margin=2,single=F,ron=2,col.names=T, summary.stat='mean')[,c(1,3:7)]

tab.cgm.con<-final_table(dat.con,c('cgm_yn_inyear'),
                          dat.con$yeargrouping,margin=2,single=F,ron=2,col.names=T, summary.stat='mean')[,c(1,3:7)]


comp<-subset(dat.trt,dat.trt$yeargrouping %in% c("Base1","Year4"))
temp.tab<-(table(comp$MRN)>1)*1
temp.comp<-data.frame(MRN=rownames(temp.tab),temp.tab)
comp<-merge(comp,temp.comp,by="MRN")
comp<-subset(comp,comp$temp.tab==1)
table(comp$pump_yn_inyear[comp$yeargrouping=="Base1"],comp$pump_yn_inyear[comp$yeargrouping=="Year4"])
test.6a<-mcnemar.test(comp$pump_yn_inyear[comp$yeargrouping=="Base1"],
                      comp$pump_yn_inyear[comp$yeargrouping=="Year4"])$p.value

comp<-subset(dat.trt,dat.trt$yeargrouping %in% c("Year3","Year4"))
temp.tab<-(table(comp$MRN)>1)*1
temp.comp<-data.frame(MRN=rownames(temp.tab),temp.tab)
comp<-merge(comp,temp.comp,by="MRN")
comp<-subset(comp,comp$temp.tab==1)
table(comp$pump_yn_inyear[comp$yeargrouping=="Year3"],comp$pump_yn_inyear[comp$yeargrouping=="Year4"])
test.6b<-mcnemar.test(comp$pump_yn_inyear[comp$yeargrouping=="Year3"],
                      comp$pump_yn_inyear[comp$yeargrouping=="Year4"])$p.value

comp<-subset(dat.con,dat.con$yeargrouping %in% c("Base1","Year4"))
temp.tab<-(table(comp$MRN)>1)*1
temp.comp<-data.frame(MRN=rownames(temp.tab),temp.tab)
comp<-merge(comp,temp.comp,by="MRN")
comp<-subset(comp,comp$temp.tab==1)
table(comp$pump_yn_inyear[comp$yeargrouping=="Base1"],comp$pump_yn_inyear[comp$yeargrouping=="Year4"])
test.6c<-mcnemar.test(comp$pump_yn_inyear[comp$yeargrouping=="Base1"],
                      comp$pump_yn_inyear[comp$yeargrouping=="Year4"])$p.value

comp<-subset(dat.con,dat.con$yeargrouping %in% c("Year3","Year4"))
temp.tab<-(table(comp$MRN)>1)*1
temp.comp<-data.frame(MRN=rownames(temp.tab),temp.tab)
comp<-merge(comp,temp.comp,by="MRN")
comp<-subset(comp,comp$temp.tab==1)
table(comp$pump_yn_inyear[comp$yeargrouping=="Year3"],comp$pump_yn_inyear[comp$yeargrouping=="Year4"])
test.6d<-mcnemar.test(comp$pump_yn_inyear[comp$yeargrouping=="Year3"],
                      comp$pump_yn_inyear[comp$yeargrouping=="Year4"])$p.value

#######CGM
comp<-subset(dat.trt,dat.trt$yeargrouping %in% c("Base1","Year4"))
temp.tab<-(table(comp$MRN)>1)*1
temp.comp<-data.frame(MRN=rownames(temp.tab),temp.tab)
comp<-merge(comp,temp.comp,by="MRN")
comp<-subset(comp,comp$temp.tab==1)
table(comp$cgm_yn_inyear[comp$yeargrouping=="Base1"],comp$cgm_yn_inyear[comp$yeargrouping=="Year4"])

test.7a<-mcnemar.test(comp$cgm_yn_inyear[comp$yeargrouping=="Base1"],
                      comp$cgm_yn_inyear[comp$yeargrouping=="Year4"])$p.value

comp<-subset(dat.trt,dat.trt$yeargrouping %in% c("Year3","Year4"))
temp.tab<-(table(comp$MRN)>1)*1
temp.comp<-data.frame(MRN=rownames(temp.tab),temp.tab)
comp<-merge(comp,temp.comp,by="MRN")
comp<-subset(comp,comp$temp.tab==1)
table(comp$cgm_yn_inyear[comp$yeargrouping=="Year3"],comp$cgm_yn_inyear[comp$yeargrouping=="Year4"])

test.7b<-mcnemar.test(comp$cgm_yn_inyear[comp$yeargrouping=="Year3"],
                      comp$cgm_yn_inyear[comp$yeargrouping=="Year4"])$p.value


comp<-subset(dat.con,dat.con$yeargrouping %in% c("Base1","Year4"))
temp.tab<-(table(comp$MRN)>1)*1
temp.comp<-data.frame(MRN=rownames(temp.tab),temp.tab)
comp<-merge(comp,temp.comp,by="MRN")
comp<-subset(comp,comp$temp.tab==1)
table(comp$cgm_yn_inyear[comp$yeargrouping=="Base1"],comp$cgm_yn_inyear[comp$yeargrouping=="Year4"])

test.7c<-mcnemar.test(comp$cgm_yn_inyear[comp$yeargrouping=="Base1"],
                      comp$cgm_yn_inyear[comp$yeargrouping=="Year4"])$p.value

comp<-subset(dat.con,dat.con$yeargrouping %in% c("Year3","Year4"))
temp.tab<-(table(comp$MRN)>1)*1
temp.comp<-data.frame(MRN=rownames(temp.tab),temp.tab)
comp<-merge(comp,temp.comp,by="MRN")
comp<-subset(comp,comp$temp.tab==1)
table(comp$cgm_yn_inyear[comp$yeargrouping=="Year3"],comp$cgm_yn_inyear[comp$yeargrouping=="Year4"])

test.7d<-mcnemar.test(comp$cgm_yn_inyear[comp$yeargrouping=="Year3"],
                      comp$cgm_yn_inyear[comp$yeargrouping=="Year4"])$p.value
