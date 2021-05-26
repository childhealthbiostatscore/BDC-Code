####MODELING OPTIONS####

dat<-read.csv("S:/Shared Projects/Kristen/BDC presentation/Data/for_jm_v3_kaci.csv")

nrow(dat)
names(dat)

bypt<-function(x1,data){
  
  temp<-lapply(unique(x1), function(x){
    
    dat.temp <- subset(data, x1 == x)
    ##dat.temp <- subset(dat.tvc.copy,dat.tvc.copy$study_id== 43)
    dat.temp$mean_tac<-mean(dat.temp$TAC,na.rm=T)
    dat.temp$sd_tac<-sd(dat.temp$TAC,na.rm=T)
    
    
    dat.temp
    dat.temp})
  
  dat<-do.call(rbind,temp)
}
dat<-bypt(dat$idn,dat)
dat.one<-dat[!duplicated(dat$idn),]

#LOGISTIC OUTCOME
#covariates to match the joint model (HLA mismatches, race (categorical), age (categorical))
logistic_mean<-glm(dsa_yn~mean_tac+hlamis+,data=dat.one)
