by_pt_by_year<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(dat,dat$record_id==851479)
    
    dat.temp<-dat.temp[order(dat.temp$Appt_Date),]
    dat.temp$row_tot<-nrow(dat.temp) #count of repeat visits per patient
    three_yn<-nrow(subset(dat.temp,dat.temp$yeargrouping=="Year3"))>0
    dat.temp$year_3<-0
    dat.temp$year_3[three_yn]<-1
    four_yn<-nrow(subset(dat.temp,dat.temp$yeargrouping=="Year4"))>0
    dat.temp$year_4<-0
    dat.temp$year_4[four_yn]<-1
    
    by_year<-function(ID,data){
      
      temp2<-lapply(unique(ID), function(x){
        
        dat.temp2 <- subset(data, ID == x)
        # dat.temp2<-subset(dat.temp,dat.temp$yeargrouping=="Year3")
        
        dat.temp2$row_num_year<-rep(1:nrow(dat.temp2)) #count of repeat visits per year per patient
        
        #last a1c value in each year (no missing A1c values):
        last_a1c<-dat.temp2$A1C[dat.temp2$row_num_year==max(dat.temp2$row_num_year)]
        dat.temp2$a1c_last_in_year<-last_a1c
        #last checks value in each year (missing checks values, so first remove those):
        checks.temp<-subset(dat.temp2,!is.na(dat.temp2$Checks_Per_Day))
        if (nrow(checks.temp)==0){
          last_checks<-NA
        }
        if (nrow(checks.temp)>0){
          last_checks<-checks.temp$Checks_Per_Day[checks.temp$Appt_Date==max(checks.temp$Appt_Date)]
        }

        dat.temp2$checks_last_in_year<-last_checks        
        
        #avg value in each year:
        dat.temp2$checks_avg_in_year<-mean(dat.temp2$Checks_Per_Day,na.rm=T)        
        dat.temp2$a1c_avg_in_year<-mean(dat.temp2$A1C,na.rm=T)        
        
        #any pump usage:
        dat.temp2$pump_yn_inyear<-0
        dat.temp2$pump_yn_inyear[nrow(subset(dat.temp2,dat.temp2$insulin_pump==1))>0]<-1
        
        #any CGM use:
        dat.temp2$cgm_yn_inyear<-0
        dat.temp2$cgm_yn_inyear[nrow(subset(dat.temp2,dat.temp2$CGM=="Y"))>0]<-1
        
        dat.temp2
        #print(dat.temp2$MRN)
        #print(dat.temp2$yeargrouping)
        
        dat.temp2})
      
      dat<-do.call(rbind,temp2)
    }
    
    dat.temp<-by_year(dat.temp$yeargrouping,dat.temp)
    dat.temp<-dat.temp[order(dat.temp$yeargrouping),]
    dat.temp$baseline_a1c<-dat.temp$a1c_last_in_year[1]
    
    dat.temp})
  
  dat<-do.call(rbind,temp)
}