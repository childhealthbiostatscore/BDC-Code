##### Tables - Gerard Gonzalez #####
source('S:/Shared Material/Shared Code/R/temp_table1.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/00_data.R')

#Table 1A:


tab.1a<-final_table(dat.trt,c('a1c_last_in_year','checks_last_in_year'),
            dat.trt$yeargrouping,margin=2,single=F,ron=2,col.names=T, summary.stat='mean')

tab.1b<-final_table(dat.con,c('a1c_last_in_year','checks_last_in_year'),
                    dat.con$yeargrouping,margin=2,single=F,ron=2,col.names=T, summary.stat='mean')

mean_sd_table<-function(x,year){
  
  #x<-dat$a1c_last_in_year
  #year<-"Year"
  dat.temp<-subset(dat,dat$yeargrouping==year)
  mean.1<-mean(x[dat.temp$group=="Less than 12" & dat.temp$trt_grp=="Control"],na.rm=T)
  sd.1<-sd(x[dat.temp$group=="Less than 12" & dat.temp$trt_grp=="Control"],na.rm=T)
  
  n.1<-nrow(subset(dat.temp,dat.temp$group=="Less than 12" & dat.temp$trt_grp=="Control" &!is.na(x)))
  
  mean.2<-mean(x[dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="Control"],na.rm=T)
  sd.2<-sd(x[dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="Control"],na.rm=T)
  n.2<-nrow(subset(dat.temp,dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="Control" &!is.na(x)))
  
  mean.3<-mean(x[dat.temp$group=="Less than 12" & dat.temp$trt_grp=="LP"],na.rm=T)
  sd.3<-sd(x[dat.temp$group=="Less than 12" & dat.temp$trt_grp=="LP"],na.rm=T)
  n.3<-nrow(subset(dat.temp,dat.temp$group=="Less than 12" & dat.temp$trt_grp=="LP" &!is.na(x)))
    
  mean.4<-mean(x[dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="LP"],na.rm=T)
  sd.4<-sd(x[dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="LP"],na.rm=T)  
  n.4<-nrow(subset(dat.temp,dat.temp$group=="greater than or equal to 12" & dat.temp$trt_grp=="LP" &!is.na(x)))
  
  #table for x
  tab.x<-data.frame(
    variable=c(paste0(year,": ",label(x)),"n","mean (std. dev)"),
    ControlYoung=c("",n.1,paste0(round(mean.1,3)," ","(",round(sd.1,3),")")),
    ControlOld=c("",n.2,paste0(round(mean.2,3)," ","(",round(sd.1,3),")")),
    TrtYoung=c("",n.3,paste0(round(mean.3,3)," ","(",round(sd.1,3),")")),
    TrtOld=c("",n.4,paste0(round(mean.4,3)," ","(",round(sd.1,3),")"))
    )
  return(tab.x)
}

a1c_base<-mean_sd_table(dat.temp$a1c_last_in_year,"Base1")
a1c_1<-mean_sd_table(dat.temp$a1c_last_in_year,"Year1")
a1c_2<-mean_sd_table(dat.temp$a1c_last_in_year,"Year2")
a1c_3<-mean_sd_table(dat.temp$a1c_last_in_year,"Year3")

checks_base<-mean_sd_table(dat.temp$checks_last_in_year,"Base1")
checks_1<-mean_sd_table(dat.temp$checks_last_in_year,"Year1")
checks_2<-mean_sd_table(dat.temp$checks_last_in_year,"Year2")
checks_3<-mean_sd_table(dat.temp$checks_last_in_year,"Year3")
