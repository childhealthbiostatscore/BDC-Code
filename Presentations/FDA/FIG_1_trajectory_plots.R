#individual trajectories for defense + paper

library(caTools)


rm(list=ls())
getwd()

dirg <- "X:/Data"

#dirg <- "/Volumes/EJCgroupStudentThesesKristen/Data"

setwd(dirg)
getwd()

dat<-read.csv("for_jm_v3_new.csv",na.strings = c(".","NA"))
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
dat<-bypt(dat$Study_Id,dat)
#dat<-subset(dat,dat$visit_num==1)
quantile(dat$mean_tac)

###TAC Histogram: supplement 
jpeg(file="tac_histogram.jpeg") 
hist(dat$TAC,main="Histogram of TAC",xlab="TAC",col="lightgrey")
dev.off()

##Trajectory Plot: Figure 1
postscript(file="trajectory_fig1.ps",horiz=FALSE,onefile=TRUE,width=8.5,height=11) 

par(mfrow=c(2,4),oma=c(0,0,2,0),mar=c(3,2,2,1))

##plot 1
  patient<-subset(dat,dat$Study_Id==1096380)
  patient<-patient[order(patient$visit_num),] 
  plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),xlab="Months Post-Tx",ylab="TAC Trough Level",xaxt="n")
  axis(1,at=c(1,3,6,12,24,36,48))
  lines(patient$tac_months,patient$TAC)
  abline(v=patient$left_months[1],lty=2)
  abline(v=patient$right_months[1])
##plot 2
  patient<-subset(dat,dat$Study_Id==2034559)
  patient<-patient[order(patient$visit_num),] 
  plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),ylab="",xlab="",xaxt="n")
  axis(1,at=c(1,3,6,12,24,36,48))
  lines(patient$tac_months,patient$TAC)
  abline(v=patient$left_months[1],lty=2)
  abline(v=patient$right_months[1])
##plot 3
  patient<-subset(dat,dat$Study_Id==2190231)
  patient<-patient[order(patient$visit_num),] 
  plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),ylab="",xlab="",xaxt="n")
  axis(1,at=c(1,3,6,12,24,36,48))
  lines(patient$tac_months,patient$TAC)
  abline(v=patient$left_months[1],lty=2)
  abline(v=patient$right_months[1])
##plot 4
  patient<-subset(dat,dat$Study_Id==1112191)
  patient<-patient[order(patient$visit_num),] 
  plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),ylab="",xlab="",xaxt="n")
  axis(1,at=c(1,3,6,12,24,36,48))
  lines(patient$tac_months,patient$TAC)
  abline(v=patient$left_months[1],lty=2)
  abline(v=patient$right_months[1])
mtext('4 Random Individuals with dnDSA', side=3, line=0, outer=TRUE,cex=0.8,font=2)

##plot 5
  patient<-subset(dat,dat$Study_Id==1895216)
  patient<-patient[order(patient$visit_num),] 
  plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),xlab="Months Post-Tx",ylab="TAC Trough Level",xaxt="n")
  axis(1,at=c(1,3,6,12,24,36,48))
  lines(patient$tac_months,patient$TAC)
  abline(v=patient$left_months[1],lty=2)
  abline(v=patient$right_months[1])
##plot 6
  patient<-subset(dat,dat$Study_Id==2050808)
  patient<-patient[order(patient$visit_num),] 
  plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),ylab="",xlab="",xaxt="n")
  axis(1,at=c(1,3,6,12,24,36,48))
  lines(patient$tac_months,patient$TAC)
  abline(v=patient$left_months[1],lty=2)
  abline(v=patient$right_months[1])
##plot 7
  patient<-subset(dat,dat$Study_Id==2115528)
  patient<-patient[order(patient$visit_num),] 
  plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),ylab="",xlab="",xaxt="n")
  axis(1,at=c(1,3,6,12,24,36,48))
  lines(patient$tac_months,patient$TAC)
  abline(v=patient$left_months[1],lty=2)
  abline(v=patient$right_months[1])
##plot 8
  patient<-subset(dat,dat$Study_Id==2412699)
  patient<-patient[order(patient$visit_num),] 
  plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),ylab="",xlab="",xaxt="n")
  axis(1,at=c(1,3,6,12,24,36,48))
  lines(patient$tac_months,patient$TAC)
  abline(v=patient$left_months[1],lty=2)
  abline(v=patient$right_months[1])#mtext('4 Random Individuals without dnDSA', side=3, line=-27, outer=TRUE,cex=0.8,font=2)
mtext('4 Random Individuals without dnDSA', side=3, line=-40, outer=TRUE,cex=0.8,font=2)

dev.off()



##Trajectory Plot: 2x2 for ebio presentation
jpeg(file="trajectory_4.jpeg") 

par(mfrow=c(2,2),oma=c(2,2.5,2,0),mar=c(3,2,2,1))


##plot 2
patient<-subset(dat,dat$Study_Id==2034559)
patient<-patient[order(patient$visit_num),] 
plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),ylab="TAC Level",xlab="Months since Tx",xaxt="n",pch=16,cex=1.5,cex.axis=1.5)
axis(1,at=c(1,3,6,12,24,36,48),xlab="Months since Tx",cex.axis=1.5)
lines(patient$tac_months,patient$TAC,lwd=2)
abline(v=patient$left_months[1],lty=2,col="red",lwd=2)
abline(v=patient$right_months[1],col="red",lwd=2)


##plot 4
patient<-subset(dat,dat$Study_Id==1112191)
patient<-patient[order(patient$visit_num),] 
plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),ylab="",xlab="",xaxt="n",pch=16,cex=1.5,cex.axis=1.5)
axis(1,at=c(1,3,6,12,24,36,48),cex.axis=1.5)
lines(patient$tac_months,patient$TAC,lwd=2)
abline(v=patient$left_months[1],lty=2,col="red",lwd=2)
abline(v=patient$right_months[1],col="red",lwd=2)
mtext('2 Individuals with dnDSA', side=3, line=0, outer=TRUE,cex=1.5,font=2)

##plot 5
patient<-subset(dat,dat$Study_Id==1895216)
patient<-patient[order(patient$visit_num),] 
plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),xlab="Months Post-Tx",
     ylab="TAC Trough Level",xaxt="n",pch=16,cex=1.5,cex.axis=1.5)
axis(1,at=c(1,3,6,12,24,36,48),cex.axis=1.5)
lines(patient$tac_months,patient$TAC,lwd=2)
abline(v=patient$left_months[1],lty=2,col="red",lwd=2)
abline(v=patient$right_months[1],col="red",lwd=2)
mtext('Months since Tx', side=1, line=3, outer=FALSE,cex=1.5,font=0.5)
mtext('TAC Level', side=2, line=3, outer=FALSE,cex=1.5,font=0.5)
##plot 8
patient<-subset(dat,dat$Study_Id==2412699)
patient<-patient[order(patient$visit_num),] 
plot(patient$tac_months,patient$TAC,xlim=c(1,48),ylim=c(0,20),ylab="",xlab="",xaxt="n",pch=16,cex=1.5,cex.axis=1.5)
axis(1,at=c(1,3,6,12,24,36,48),cex.axis=1.5)
lines(patient$tac_months,patient$TAC,lwd=2)
abline(v=patient$left_months[1],lty=2,col="red",lwd=2)
abline(v=patient$right_months[1],col="red",lwd=2)#mtext('4 Random Individuals without dnDSA', side=3, line=-27, outer=TRUE,cex=0.8,font=2)
mtext('2 Individuals without dnDSA', side=3, line=-20, outer=TRUE,cex=1.5,font=2)

dev.off()

