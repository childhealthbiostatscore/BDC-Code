######ARCHIVE OF PLOTS########

#Q2 overall, version 1
par(mfrow=c(1,3))
plot(c(0,24),c(0,1),type="n",xlab="Hour in ICU",ylab="Average CRI",xaxt='n'
     ,main="Average CRI during ICU Stay: mean and 95% CI")
axis(1,at=rep(0:24,by=1))
abline(v=0,lty=2)
#bypass to ICU
points(-0.5,q1.2_o[2],pch=19)
lines(c(-0.5,-0.5),c(q1.2_o[3],q1.2_o[4]))
#hours in ICU
for (i in 1:24){
  #i<-17
  points(i,mean(dat$CRI[dat$hour_num==i],na.rm=T),pch=19)
  lines(c(i,i),c(t.test(dat$CRI[dat$hour_num==i])$conf.int[1],
                 t.test(dat$CRI[dat$hour_num==i])$conf.int[2]))
}

plot(c(0,24),c(80,140),type="n",xlab="Hour in ICU",ylab="Average HR",xaxt='n'
     ,main="Average HR during ICU Stay: mean and 95% CI")
axis(1,at=rep(0:24,by=1))
abline(v=0,lty=2)
#bypass to ICU
points(-0.5,mean(dat.one$AfterCPBHR_M1,na.rm=T),pch=19)
lines(c(-0.5,-0.5),c(t.test(dat.one$AfterCPBHR_M1)$conf.int[1],
                     t.test(dat.one$AfterCPBHR_M1)$conf.int[2]))
#hours in ICU
for (i in 1:24){
  #i<-17
  points(i,mean(dat$HR_M1[dat$hour_num==i],na.rm=T),pch=19)
  lines(c(i,i),c(t.test(dat$HR_M1[dat$hour_num==i])$conf.int[1],
                 t.test(dat$HR_M1[dat$hour_num==i])$conf.int[2]))
}

plot(c(0,24),c(50,90),type="n",xlab="Hour in ICU",ylab="Average MAP",xaxt='n'
     ,main="Average MAP during ICU Stay: mean and 95% CI")
axis(1,at=rep(0:24,by=1))
abline(v=0,lty=2)
#bypass to ICU
points(-0.5,mean(dat.one$AfterCPB_MAP,na.rm=T),pch=19)
lines(c(-0.5,-0.5),c(t.test(dat.one$AfterCPB_MAP)$conf.int[1],
                     t.test(dat.one$AfterCPB_MAP)$conf.int[2]))
#hours in ICU
for (i in 1:24){
  #i<-17
  points(i,mean(dat$ART_MAP[dat$hour_num==i],na.rm=T),pch=19)
  lines(c(i,i),c(t.test(dat$ART_MAP[dat$hour_num==i])$conf.int[1],
                 t.test(dat$ART_MAP[dat$hour_num==i])$conf.int[2]))
}

#Q2 by LOS, v1
par(mfrow=c(1,3))
plot(c(0,24),c(0,1),type="n",xlab="Hour in ICU",ylab="Average CRI",xaxt='n'
     ,main="CRI")
axis(1,at=rep(0:24,by=1))
#bypass to ICU
points(-0.5,mean(dat.one$AfterCPBCRI[dat.one$icu_los_grp=="1 Day"],na.rm=T),pch=19,col="red")
lines(c(-0.5,-0.5),c(t.test(dat.one$AfterCPBCRI[dat.one$icu_los_grp=="1 Day"])$conf.int[1],
                     t.test(dat.one$AfterCPBCRI[dat.one$icu_los_grp=="1 Day"])$conf.int[2]),col="red")
points(-0.5,mean(dat.one$AfterCPBCRI[dat.one$icu_los_grp=="2+ Days"],na.rm=T),pch=17,col="deeppink")
lines(c(-0.5,-0.5),c(t.test(dat.one$AfterCPBCRI[dat.one$icu_los_grp=="2+ Days"])$conf.int[1],
                     t.test(dat.one$AfterCPBCRI[dat.one$icu_los_grp=="2+ Days"])$conf.int[2]),col="deeppink")

#hours in ICU
for (i in 1:24){
  #i<-17
  points(i,mean(dat$CRI[dat$hour_num==i & dat$icu_los_grp=="1 Day"],na.rm=T),pch=19,col="red")
  lines(c(i,i),c(t.test(dat$CRI[dat$hour_num==i & dat$icu_los_grp=="1 Day"])$conf.int[1],
                 t.test(dat$CRI[dat$hour_num==i & dat$icu_los_grp=="1 Day"])$conf.int[2]),col="red")
  points(i,mean(dat$CRI[dat$hour_num==i & dat$icu_los_grp=="2+ Days"],na.rm=T),pch=17,col="deeppink")
  lines(c(i,i),c(t.test(dat$CRI[dat$hour_num==i & dat$icu_los_grp=="2+ Days"])$conf.int[1],
                 t.test(dat$CRI[dat$hour_num==i & dat$icu_los_grp=="2+ Days"])$conf.int[2]),col="deeppink")
}

legend("topleft",c("LOS 1 Day","LOS 2+ Days"),col=c("red","deeppink"),lty=c(1,1),pch=c(19,17),
       ncol=1,bty="n")

plot(c(0,24),c(60,130),type="n",xlab="Hour in ICU",ylab="Average HR",xaxt='n'
     ,main="HR")
axis(1,at=rep(0:24,by=1))
#bypass to ICU
points(-0.5,mean(dat.one$AfterCPBHR_M1[dat.one$icu_los_grp=="1 Day"],na.rm=T),pch=19,col="blue")
lines(c(-0.5,-0.5),c(t.test(dat.one$AfterCPBHR_M1[dat.one$icu_los_grp=="1 Day"])$conf.int[1],
                     t.test(dat.one$AfterCPBHR_M1[dat.one$icu_los_grp=="1 Day"])$conf.int[2]),col="blue")
points(-0.5,mean(dat.one$AfterCPBHR_M1[dat.one$icu_los_grp=="2+ Days"],na.rm=T),pch=17,col="cyan")
lines(c(-0.5,-0.5),c(t.test(dat.one$AfterCPBHR_M1[dat.one$icu_los_grp=="2+ Days"])$conf.int[1],
                     t.test(dat.one$AfterCPBHR_M1[dat.one$icu_los_grp=="2+ Days"])$conf.int[2]),col="cyan")

#hours in ICU
for (i in 1:24){
  #i<-17
  points(i,mean(dat$HR_M1[dat$hour_num==i & dat$icu_los_grp=="1 Day"],na.rm=T),pch=19,col="blue")
  lines(c(i,i),c(t.test(dat$HR_M1[dat$hour_num==i & dat$icu_los_grp=="1 Day"])$conf.int[1],
                 t.test(dat$HR_M1[dat$hour_num==i & dat$icu_los_grp=="1 Day"])$conf.int[2]),col="blue")
  points(i,mean(dat$HR_M1[dat$hour_num==i & dat$icu_los_grp=="2+ Days"],na.rm=T),pch=17,col="cyan")
  lines(c(i,i),c(t.test(dat$HR_M1[dat$hour_num==i & dat$icu_los_grp=="2+ Days"])$conf.int[1],
                 t.test(dat$HR_M1[dat$hour_num==i & dat$icu_los_grp=="2+ Days"])$conf.int[2]),col="cyan")
}  
legend("topleft",c("LOS 1 Day","LOS 2+ Days"),col=c("blue","cyan"),lty=c(1,1),pch=c(19,17),
       ncol=1,bty="n")


plot(c(0,24),c(50,96),type="n",xlab="Hour in ICU",ylab="Average MAP",xaxt='n'
     ,main="MAP")
axis(1,at=rep(0:24,by=1))
#bypass to ICU
points(-0.5,mean(dat.one$AfterCPB_MAP[dat.one$icu_los_grp=="1 Day"],na.rm=T),pch=19,col="darkgreen")
lines(c(-0.5,-0.5),c(t.test(dat.one$AfterCPB_MAP[dat.one$icu_los_grp=="1 Day"])$conf.int[1],
                     t.test(dat.one$AfterCPB_MAP[dat.one$icu_los_grp=="1 Day"])$conf.int[2]),col="darkgreen")
points(-0.5,mean(dat.one$AfterCPB_MAP[dat.one$icu_los_grp=="2+ Days"],na.rm=T),pch=17,col="green")
lines(c(-0.5,-0.5),c(t.test(dat.one$AfterCPB_MAP[dat.one$icu_los_grp=="2+ Days"])$conf.int[1],
                     t.test(dat.one$AfterCPB_MAP[dat.one$icu_los_grp=="2+ Days"])$conf.int[2]),col="green")

#hours in ICU
for (i in 1:24){
  #i<-17
  points(i,mean(dat$ART_MAP[dat$hour_num==i & dat$icu_los_grp=="1 Day"],na.rm=T),pch=19,col="darkgreen")
  lines(c(i,i),c(t.test(dat$ART_MAP[dat$hour_num==i & dat$icu_los_grp=="1 Day"])$conf.int[1],
                 t.test(dat$ART_MAP[dat$hour_num==i & dat$icu_los_grp=="1 Day"])$conf.int[2]),col="darkgreen")
  points(i,mean(dat$ART_MAP[dat$hour_num==i & dat$icu_los_grp=="2+ Days"],na.rm=T),pch=17,col="green")
  lines(c(i,i),c(t.test(dat$ART_MAP[dat$hour_num==i & dat$icu_los_grp=="2+ Days"])$conf.int[1],
                 t.test(dat$ART_MAP[dat$hour_num==i & dat$icu_los_grp=="2+ Days"])$conf.int[2]),col="green")
}  
legend("topleft",c("LOS 1 Day","LOS 2+ Days"),col=c("darkgreen","green"),lty=c(1,1),pch=c(19,17),
       ncol=1,bty="n")


###By VIS Escalation:
par(mfrow=c(1,3))

plot(c(0.7,2.3),c(0,1),type="n",xlab="Phase",ylab="Average CRI",xaxt="n",main="CRI")

points(c(1:2),c(q2_twogroup.vis$NoMean[4],q2_twogroup.vis$NoMean[1]),pch=19,col="red")
lines(c(1,1),c(q2_twogroup.vis$NoLowCI[4],q2_twogroup.vis$NoHighCI[4]),col="red")
lines(c(2,2),c(q2_twogroup.vis$NoLowCI[1],q2_twogroup.vis$NoHighCI[1]),col="red")
points(c(1.2,2.2),c(q2_twogroup.vis$YesMean[4],q2_twogroup.vis$YesMean[1]),pch=17,col="deeppink")
lines(c(1.2,1.2),c(q2_twogroup.vis$YesLowCI[4],q2_twogroup.vis$YesHighCI[4]),col="deeppink")
lines(c(2.2,2.2),c(q2_twogroup.vis$YesLowCI[1],q2_twogroup.vis$YesHighCI[1]),col="deeppink")

axis(1,at=c(1,2),labels = c("Bypass to ICU","1st Hour of ICU"))

legend("topleft",c("No VIS Escalation","VIS Escalation"),col=c("red","deeppink"),lty=c(1,1),pch=c(19,17),
       ncol=1,bty="n")

plot(c(0.7,2.3),c(60,130),type="n",xlab="Phase",ylab="Average HR",xaxt="n",main="HR")

points(c(1:2),c(q2_twogroup.vis$NoMean[5],q2_twogroup.vis$NoMean[2]),pch=19,col="blue")
lines(c(1,1),c(q2_twogroup.vis$NoLowCI[5],q2_twogroup.vis$NoHighCI[5]),col="blue")
lines(c(2,2),c(q2_twogroup.vis$NoLowCI[2],q2_twogroup.vis$NoHighCI[2]),col="blue")
points(c(1.2,2.2),c(q2_twogroup.vis$YesMean[5],q2_twogroup.vis$YesMean[2]),pch=17,col="cyan")
lines(c(1.2,1.2),c(q2_twogroup.vis$YesLowCI[5],q2_twogroup.vis$YesHighCI[5]),col="cyan")
lines(c(2.2,2.2),c(q2_twogroup.vis$YesLowCI[2],q2_twogroup.vis$YesHighCI[2]),col="cyan")

axis(1,at=c(1,2),labels = c("Bypass to ICU","1st Hour of ICU"))

legend("topleft",c("No VIS Escalation","VIS Escalation"),col=c("blue","cyan"),lty=c(1,1),pch=c(19,17),
       ncol=1,bty="n")

plot(c(0.7,2.3),c(50,90),type="n",xlab="Phase",ylab="Average MAP",xaxt="n",main="MAP")

points(c(1:2),c(q2_twogroup.vis$NoMean[6],q2_twogroup.vis$NoMean[3]),pch=19,col="darkgreen")
lines(c(1,1),c(q2_twogroup.vis$NoLowCI[6],q2_twogroup.vis$NoHighCI[6]),col="darkgreen")
lines(c(2,2),c(q2_twogroup.vis$NoLowCI[3],q2_twogroup.vis$NoHighCI[3]),col="darkgreen")
points(c(1.2,2.2),c(q2_twogroup.vis$YesMean[6],q2_twogroup.vis$YesMean[3]),pch=17,col="green")
lines(c(1.2,1.2),c(q2_twogroup.vis$YesLowCI[6],q2_twogroup.vis$YesHighCI[6]),col="green")
lines(c(2.2,2.2),c(q2_twogroup.vis$YesLowCI[3],q2_twogroup.vis$YesHighCI[3]),col="green")

axis(1,at=c(1,2),labels = c("Bypass to ICU","1st Hour of ICU"))

legend("topleft",c("No VIS Escalation","VIS Escalation"),col=c("darkgreen","green"),lty=c(1,1),pch=c(19,17),
       ncol=1,bty="n")
