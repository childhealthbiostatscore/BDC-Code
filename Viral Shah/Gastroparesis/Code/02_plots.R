setwd("C:/Users/campbkri/Documents/GitHub/BDC-Code/Viral Shah/Gastroparesis/Code")
source('01_data.R')

####plots:
controls<-dat$subject_id[dat$Group=="Control"]
gas<-dat$subject_id[dat$Group=="Gastroparesis"]

###A1c, by patient
par(mfrow=c(1,1))
plot(c(0,2),c(6.4,8.5),type="n",main="Figure 1: Change in A1C",ylab="A1C",
     xaxt="n",xlab="Period")
axis(1,at=c(0,1,2),labels=c("Pre","Post-1", "Post-2"))
for (i in controls){
  points(0,dat$A1C_3mo_pre[dat$subject_id==i],col="black",pch=19)
  points(1,dat$A1C_3mo_after[dat$subject_id==i],col="black",pch=19)
  points(2,dat$A1C_6mo_post[dat$subject_id==i],col="black",pch=19)
  lines(c(0,1),c(dat$A1C_3mo_pre[dat$subject_id==i],
                 dat$A1C_3mo_after[dat$subject_id==i]),col="black")
  lines(c(1,2),c(dat$A1C_3mo_after[dat$subject_id==i],
                 dat$A1C_6mo_post[dat$subject_id==i]),col="black")
  }
for (i in gas){
  points(0,dat$A1C_3mo_pre[dat$subject_id==i],col="darkgrey",pch=17)
  points(1,dat$A1C_3mo_after[dat$subject_id==i],col="darkgrey",pch=17)
     points(2,dat$A1C_6mo_post[dat$subject_id==i],col="darkgrey",pch=17)
   
  lines(c(0,1),c(dat$A1C_3mo_pre[dat$subject_id==i],
                 dat$A1C_3mo_after[dat$subject_id==i]),col="darkgrey")
  lines(c(1,2),c(dat$A1C_3mo_after[dat$subject_id==i],
                 dat$A1C_6mo_post[dat$subject_id==i]),col="darkgrey")
  }
legend("topright",c('Gastro','Control'),pch=c(17,19),col=c("darkgrey","black"),lty=c(1,1),horiz=T,bty="n")



par(mfrow=c(1,3))
par(mar=c(3,3,2,2))

plot(c(0,2),c(115,230),type="n",main="24-Hour Mean Glucose by Period",ylab="24 Hour Mean Glucose",
     xaxt="n",xlab="Period")
axis(1,at=c(0,1,2),labels=c("Pre-","Post-1","Post-2"))
for (i in controls){
  points(0,dat$average_sensor_1[dat$subject_id==i],col="black",pch=19)
  points(1,dat$average_sensor_2[dat$subject_id==i],col="black",pch=19)
  points(2,dat$average_sensor_3[dat$subject_id==i],col="black",pch=19)
  lines(c(0,1),c(dat$average_sensor_1[dat$subject_id==i],dat$average_sensor_2[dat$subject_id==i]),col="black")
  lines(c(1,2),c(dat$average_sensor_2[dat$subject_id==i],dat$average_sensor_3[dat$subject_id==i]),col="black")
}
for (i in gas){
  points(0,dat$average_sensor_1[dat$subject_id==i],col="darkgrey",pch=17)
  points(1,dat$average_sensor_2[dat$subject_id==i],col="darkgrey",pch=17)
  points(2,dat$average_sensor_3[dat$subject_id==i],col="darkgrey",pch=17)
  lines(c(0,1),c(dat$average_sensor_1[dat$subject_id==i],dat$average_sensor_2[dat$subject_id==i]),col="darkgrey")
  lines(c(1,2),c(dat$average_sensor_2[dat$subject_id==i],dat$average_sensor_3[dat$subject_id==i]),col="darkgrey")
}
#legend(0.6,120,c('Gastro','Control'),pch=c(17,19),col=c("darkgrey","black"),lty=c(1,1),horiz=T,bty="n")

plot(c(0,2),c(115,230),type="n",main="Daytime Mean Glucose by Period",ylab="Daytime Mean Glucose",
     xaxt="n",xlab="Period")
axis(1,at=c(0,1,2),labels=c("Pre-","Post-1","Post-2"))
for (i in controls){
  points(0,dat$daytime_avg_sensor_glucose_1[dat$subject_id==i],col="black",pch=19)
  points(1,dat$daytime_avg_sensor_glucose_2[dat$subject_id==i],col="black",pch=19)
  points(2,dat$daytime_avg_sensor_glucose_3[dat$subject_id==i],col="black",pch=19)
  lines(c(0,1),c(dat$daytime_avg_sensor_glucose_1[dat$subject_id==i],
                 dat$daytime_avg_sensor_glucose_2[dat$subject_id==i]),col="black")
  lines(c(1,2),c(dat$daytime_avg_sensor_glucose_2[dat$subject_id==i],
                 dat$daytime_avg_sensor_glucose_3[dat$subject_id==i]),col="black")
}
for (i in gas){
  points(0,dat$daytime_avg_sensor_glucose_1[dat$subject_id==i],col="darkgrey",pch=17)
  points(1,dat$daytime_avg_sensor_glucose_2[dat$subject_id==i],col="darkgrey",pch=17)
  points(2,dat$daytime_avg_sensor_glucose_3[dat$subject_id==i],col="darkgrey",pch=17)
  lines(c(0,1),c(dat$daytime_avg_sensor_glucose_1[dat$subject_id==i],
                 dat$daytime_avg_sensor_glucose_2[dat$subject_id==i]),col="darkgrey")
  lines(c(1,2),c(dat$daytime_avg_sensor_glucose_2[dat$subject_id==i],
                 dat$daytime_avg_sensor_glucose_3[dat$subject_id==i]),col="darkgrey")
}
#legend(0.5,120,c('Gastro','Control'),pch=c(17,19),col=c("darkgrey","black"),lty=c(1,1),horiz=T,bty="n")

plot(c(0,2),c(115,230),type="n",main="Nighttime Mean Glucose by Period",ylab="Nighttime Mean Glucose",
     xaxt="n",xlab="Period")
axis(1,at=c(0,1,2),labels=c("Pre-","Post-1","Post-2"))
for (i in controls){
  points(0,dat$nighttime_avg_sens_glucose_1[dat$subject_id==i],col="black",pch=19)
  points(1,dat$nighttime_avg_sens_glucose_2[dat$subject_id==i],col="black",pch=19)
  points(2,dat$nighttime_avg_sens_glucose_3[dat$subject_id==i],col="black",pch=19)
  lines(c(0,1),c(dat$nighttime_avg_sens_glucose_1[dat$subject_id==i],
                 dat$nighttime_avg_sens_glucose_2[dat$subject_id==i]),col="black")
  lines(c(1,2),c(dat$nighttime_avg_sens_glucose_2[dat$subject_id==i],
                 dat$nighttime_avg_sens_glucose_3[dat$subject_id==i]),col="black")
}
for (i in gas){
  points(0,dat$nighttime_avg_sens_glucose_1[dat$subject_id==i],col="darkgrey",pch=17)
  points(1,dat$nighttime_avg_sens_glucose_2[dat$subject_id==i],col="darkgrey",pch=17)
  points(2,dat$nighttime_avg_sens_glucose_3[dat$subject_id==i],col="darkgrey",pch=17)
  lines(c(0,1),c(dat$nighttime_avg_sens_glucose_1[dat$subject_id==i],
                 dat$nighttime_avg_sens_glucose_2[dat$subject_id==i]),col="darkgrey")
  lines(c(1,2),c(dat$nighttime_avg_sens_glucose_2[dat$subject_id==i],
                 dat$nighttime_avg_sens_glucose_3[dat$subject_id==i]),col="darkgrey")
}
#legend(0.5,120,c('Gastro','Control'),pch=c(17,19),col=c("darkgrey","black"),lty=c(1,1),horiz=T,bty="n")
legend("topright",c('Gastro','Control'),pch=c(17,19),col=c("darkgrey","black"),lty=c(1,1),horiz=T,bty="n")


par(mfrow=c(1,1))

plot(c(0,2),c(0.20,0.45),type="n",main="Coefficient of Variation of Glucose by Period",ylab="Coefficient of Variation of Glucose",
     xaxt="n",xlab="Period")
axis(1,at=c(0,1,2),labels=c("Pre-","Post-1","Post-2"))
for (i in controls){
  points(0,dat$cv_1[dat$subject_id==i],col="black",pch=19)
  points(1,dat$cv_2[dat$subject_id==i],col="black",pch=19)
  points(2,dat$cv_3[dat$subject_id==i],col="black",pch=19)
  lines(c(0,1),c(dat$cv_1[dat$subject_id==i],
                 dat$cv_2[dat$subject_id==i]),col="black")
  lines(c(1,2),c(dat$cv_2[dat$subject_id==i],
                 dat$cv_3[dat$subject_id==i]),col="black")
}
for (i in gas){
  points(0,dat$cv_1[dat$subject_id==i],col="darkgrey",pch=17)
  points(1,dat$cv_2[dat$subject_id==i],col="darkgrey",pch=17)
  points(2,dat$cv_3[dat$subject_id==i],col="darkgrey",pch=17)
  lines(c(0,1),c(dat$cv_1[dat$subject_id==i],
                 dat$cv_2[dat$subject_id==i]),col="darkgrey")
  lines(c(1,2),c(dat$cv_2[dat$subject_id==i],
                 dat$cv_3[dat$subject_id==i]),col="darkgrey")
}
legend("bottomleft",c('Gastro','Control'),pch=c(17,19),col=c("darkgrey","black"),lty=c(1,1),horiz=T,bty="n")


####stratified

par(mfrow=c(1,2))
par(mar=c(3,3,2,2))

plot(c(0,2),c(0,90),type="n",main="% of Time Spent in Hypo (<70) by Period",ylab="% of Time Spent in Hypo",
     xaxt="n",xlab="Period")
axis(1,at=c(0,1,2),labels=c("Pre-","Post-1","Post-2"))
for (i in controls){
  points(0,dat$percent_time_under_70_1[dat$subject_id==i],col="black",pch=19)
  points(1,dat$percent_time_under_70_2[dat$subject_id==i],col="black",pch=19)
  points(2,dat$percent_time_under_70_3[dat$subject_id==i],col="black",pch=19)
  lines(c(0,1),c(dat$percent_time_under_70_1[dat$subject_id==i],dat$percent_time_under_70_2[dat$subject_id==i]),col="black")
  lines(c(1,2),c(dat$percent_time_under_70_2[dat$subject_id==i],dat$percent_time_under_70_3[dat$subject_id==i]),col="black")
}
for (i in gas){
  points(0,dat$percent_time_under_70_1[dat$subject_id==i],col="darkgrey",pch=17)
  points(1,dat$percent_time_under_70_2[dat$subject_id==i],col="darkgrey",pch=17)
  points(2,dat$percent_time_under_70_3[dat$subject_id==i],col="darkgrey",pch=17)
  lines(c(0,1),c(dat$percent_time_under_70_1[dat$subject_id==i],dat$percent_time_under_70_2[dat$subject_id==i]),col="darkgrey")
  lines(c(1,2),c(dat$percent_time_under_70_2[dat$subject_id==i],dat$percent_time_under_70_3[dat$subject_id==i]),col="darkgrey")
}
#legend(0.6,120,c('Gastro','Control'),pch=c(17,19),col=c("darkgrey","black"),lty=c(1,1),horiz=T,bty="n")
# 
# plot(c(0,2),c(0,90),type="n",main="% of Time Spent in Normal (70-180) by Period",ylab="% of Time Spent in Normal (7-180)",
#      xaxt="n",xlab="Period")
# axis(1,at=c(0,1,2),labels=c("Pre-","Post-1","Post-2"))
# for (i in controls){
#   points(0,dat$percent_time_70_180_1[dat$subject_id==i],col="black",pch=19)
#   points(1,dat$percent_time_70_180_2[dat$subject_id==i],col="black",pch=19)
#   points(2,dat$percent_time_70_180_3[dat$subject_id==i],col="black",pch=19)
#   lines(c(0,1),c(dat$percent_time_70_180_1[dat$subject_id==i],
#                  dat$percent_time_70_180_2[dat$subject_id==i]),col="black")
#   lines(c(1,2),c(dat$percent_time_70_180_2[dat$subject_id==i],
#                  dat$percent_time_70_180_3[dat$subject_id==i]),col="black")
# }
# for (i in gas){
#   points(0,dat$percent_time_70_180_1[dat$subject_id==i],col="darkgrey",pch=17)
#   points(1,dat$percent_time_70_180_2[dat$subject_id==i],col="darkgrey",pch=17)
#   points(2,dat$percent_time_70_180_3[dat$subject_id==i],col="darkgrey",pch=17)
#   lines(c(0,1),c(dat$percent_time_70_180_1[dat$subject_id==i],
#                  dat$percent_time_70_180_2[dat$subject_id==i]),col="darkgrey")
#   lines(c(1,2),c(dat$percent_time_70_180_2[dat$subject_id==i],
#                  dat$percent_time_70_180_3[dat$subject_id==i]),col="darkgrey")
# }
#legend(0.5,120,c('Gastro','Control'),pch=c(17,19),col=c("darkgrey","black"),lty=c(1,1),horiz=T,bty="n")

plot(c(0,2),c(0,90),type="n",main="% of Time Spent in Hyper (>180) by Period",ylab="% of Time Spent in Hyper (>180)",
     xaxt="n",xlab="Period")
axis(1,at=c(0,1,2),labels=c("Pre-","Post-1","Post-2"))
for (i in controls){
  points(0,dat$percent_time_over_180_1[dat$subject_id==i],col="black",pch=19)
  points(1,dat$percent_time_over_180_2[dat$subject_id==i],col="black",pch=19)
  points(2,dat$percent_time_over_180_3[dat$subject_id==i],col="black",pch=19)
  lines(c(0,1),c(dat$percent_time_over_180_1[dat$subject_id==i],
                 dat$percent_time_over_180_2[dat$subject_id==i]),col="black")
  lines(c(1,2),c(dat$percent_time_over_180_2[dat$subject_id==i],
                 dat$percent_time_over_180_3[dat$subject_id==i]),col="black")
}
for (i in gas){
  points(0,dat$percent_time_over_180_1[dat$subject_id==i],col="darkgrey",pch=17)
  points(1,dat$percent_time_over_180_2[dat$subject_id==i],col="darkgrey",pch=17)
  points(2,dat$percent_time_over_180_3[dat$subject_id==i],col="darkgrey",pch=17)
  lines(c(0,1),c(dat$percent_time_over_180_1[dat$subject_id==i],
                 dat$percent_time_over_180_2[dat$subject_id==i]),col="darkgrey")
  lines(c(1,2),c(dat$percent_time_over_180_2[dat$subject_id==i],
                 dat$percent_time_over_180_3[dat$subject_id==i]),col="darkgrey")
}
#legend(0.5,120,c('Gastro','Control'),pch=c(17,19),col=c("darkgrey","black"),lty=c(1,1),horiz=T,bty="n")

