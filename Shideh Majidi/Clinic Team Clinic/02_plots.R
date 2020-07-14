####PLOTS####
library(RColorBrewer)
#CTC group:
dat.ctc<-subset(dat,dat$group=="CTC")

jpeg("S:/Shared Projects/Laura/BDC/Projects/Shideh Majidi/Clinic team clinic/Results/A1c_CTC.jpeg",
     units="in",height=6,width=8,res=200)
par(mfrow=c(3,5),mar=c(2,2,1,1))
ctc.ids<-unique(dat.ctc$MRN)
colors<-rep(brewer.pal(5,"Set1"),3)
for (i in 1:length(ctc.ids)){
  plot(c(0,1400),c(6,14.5),type="n",xlab="Days since first RTC visit",
       ylab="A1c",main=paste0("MRN ",ctc.ids[i]))
  lines(dat.ctc$days_from_first_visit[dat.ctc$MRN==ctc.ids[i]],dat.ctc$A1C_Value[dat.ctc$MRN==ctc.ids[i]],col=colors[1],lwd=2)
  abline(v=dat.ctc$days_from_first_visit_to_first_post[dat.ctc$MRN==ctc.ids[i]],col="black",lty=2)
}
dev.off()

par(mfrow=c(3,5),mar=c(2,2,1,1))
ctc.ids<-unique(dat.ctc$MRN)
colors<-rep(brewer.pal(5,"Set1"),3)
for (i in 1:length(ctc.ids)){
  plot(c(0,1400),c(0,17),type="n",xlab="Days since first RTC visit",
       ylab="Meter_BGLow",main=paste0("MRN ",ctc.ids[i]))
  lines(dat.ctc$days_from_first_visit[dat.ctc$MRN==ctc.ids[i]],dat.ctc$Meter_BGLow[dat.ctc$MRN==ctc.ids[i]],col=colors[i],lwd=2)
  abline(v=dat.ctc$days_from_first_visit_to_first_post[dat.ctc$MRN==ctc.ids[i]],col=colors[i],lty=2)
}

par(mfrow=c(3,5),mar=c(2,2,1,1))
ctc.ids<-unique(dat.ctc$MRN)
colors<-rep(brewer.pal(5,"Set1"),3)
for (i in 1:length(ctc.ids)){
  plot(c(0,1400),c(17,93),type="n",xlab="Days since first RTC visit",
       ylab="Meter_BGHigh",main=paste0("MRN ",ctc.ids[i]))
  lines(dat.ctc$days_from_first_visit[dat.ctc$MRN==ctc.ids[i]],dat.ctc$Meter_BGHigh[dat.ctc$MRN==ctc.ids[i]],col=colors[i],lwd=2)
  abline(v=dat.ctc$days_from_first_visit_to_first_post[dat.ctc$MRN==ctc.ids[i]],col=colors[i],lty=2)
}

par(mfrow=c(3,5),mar=c(2,2,1,1))
ctc.ids<-unique(dat.ctc$MRN)
colors<-rep(brewer.pal(5,"Set1"),3)
for (i in 1:length(ctc.ids)){
  plot(c(0,1400),c(7,69),type="n",xlab="Days since first RTC visit",
       ylab="Meter_BGOK",main=paste0("MRN ",i))
  lines(dat.ctc$days_from_first_visit[dat.ctc$MRN==ctc.ids[i]],dat.ctc$Meter_BGOK[dat.ctc$MRN==ctc.ids[i]],col=colors[i],lwd=2)
  abline(v=dat.ctc$days_from_first_visit_to_first_post[dat.ctc$MRN==ctc.ids[i]],col=colors[i],lty=2)
}

#Control group:
dat.cont<-subset(dat,dat$group=="Control")

set.seed(100)
random_mrns<-sample (unique(dat.cont$MRN), size=14, replace =F)
dat.cont<-subset(dat.cont,dat.cont$MRN %in% random_mrns)
dat.cont<-subset(dat.cont,!is.na(dat.cont$A1C_Value))
jpeg("S:/Shared Projects/Laura/BDC/Projects/Shideh Majidi/Clinic team clinic/Results/A1c_Control.jpeg",
     units="in",height=6,width=8,res=200)
par(mfrow=c(3,5),mar=c(2,2,1,1))
cont.ids<-unique(dat.cont$MRN)
colors<-rep(brewer.pal(5,"Set1"),3)
for (i in 1:length(cont.ids)){
  plot(c(0,1400),c(6,14.5),type="n",xlab="Days since first RTC visit",
       ylab="A1c",main=paste0("MRN ",cont.ids[i]))
  lines(dat.cont$days_from_first_visit[dat.cont$MRN==cont.ids[i]],dat.cont$A1C_Value[dat.cont$MRN==cont.ids[i]],col=colors[1],lwd=2)
  abline(v=dat.cont$days_from_first_visit_to_first_post[dat.cont$MRN==cont.ids[i]],col="black",lty=2)
}
dev.off()

par(mfrow=c(3,5),mar=c(2,2,1,1))
ctc.ids<-unique(dat.cont$MRN)
colors<-rep(brewer.pal(5,"Set1"),3)
for (i in 1:length(ctc.ids)){
  plot(c(0,1400),c(0,17),type="n",xlab="Days since first RTC visit",
       ylab="Meter_BGLow",main=paste0("MRN ",ctc.ids[i]))
  lines(dat.cont$days_from_first_visit[dat.cont$MRN==ctc.ids[i]],dat.cont$Meter_BGLow[dat.cont$MRN==ctc.ids[i]],col=colors[i],lwd=2)
  abline(v=dat.cont$days_from_first_visit_to_first_post[dat.cont$MRN==ctc.ids[i]],col=colors[i],lty=2)
}

par(mfrow=c(3,5),mar=c(2,2,1,1))
ctc.ids<-unique(dat.cont$MRN)
colors<-rep(brewer.pal(5,"Set1"),3)
for (i in 1:length(ctc.ids)){
  plot(c(0,1400),c(17,93),type="n",xlab="Days since first RTC visit",
       ylab="Meter_BGHigh",main=paste0("MRN ",ctc.ids[i]))
  lines(dat.cont$days_from_first_visit[dat.cont$MRN==ctc.ids[i]],dat.cont$Meter_BGHigh[dat.cont$MRN==ctc.ids[i]],col=colors[i],lwd=2)
  abline(v=dat.cont$days_from_first_visit_to_first_post[dat.cont$MRN==ctc.ids[i]],col=colors[i],lty=2)
}

par(mfrow=c(3,5),mar=c(2,2,1,1))
ctc.ids<-unique(dat.cont$MRN)
colors<-rep(brewer.pal(5,"Set1"),3)
for (i in 1:length(ctc.ids)){
  plot(c(0,1400),c(7,69),type="n",xlab="Days since first RTC visit",
       ylab="Meter_BGOK",main=paste0("MRN ",ctc.ids[i]))
  lines(dat.cont$days_from_first_visit[dat.cont$MRN==ctc.ids[i]],dat.cont$Meter_BGOK[dat.cont$MRN==ctc.ids[i]],col=colors[i],lwd=2)
  abline(v=dat.cont$days_from_first_visit_to_first_post[dat.cont$MRN==ctc.ids[i]],col=colors[i],lty=2)
}
