###boxplots: 
setwd("C:/Users/campbkri/Documents/GitHub/BDC-Code/Viral Shah/Gastroparesis/Code")
source('01_data.R')
###A1c, boxplots
plot(c(0,9),c(6.2,8.4),type="n",main="A1C",ylab="A1C",
     xaxt="n",xlab="")
boxplot(dat$A1C_3mo_pre[dat$Group=="Gastroparesis"],dat$A1C_3mo_pre[dat$Group=="Control"],
        dat$A1C_3mo_after[dat$Group=="Gastroparesis"],dat$A1C_3mo_after[dat$Group=="Control"],
        dat$A1C_6mo_post[dat$Group=="Gastroparesis"],dat$A1C_6mo_post[dat$Group=="Control"],
        at=c(1,2,4,5,7,8), xaxt="n",
        col=c("grey90","grey50"),
        add = T)
axis(1,at=c(1.5,4.5,7.5),labels=c("Pre","Post-1","Post-2"),tick=F,cex.axis=1.5)
legend(1,6.5,c("Gastroparesis","Control"),
       col=c("grey90","grey50"),fill=c("grey90","grey50"))



#cgm: 
par(mfrow=c(1,3))
#par(mar=c(3,3,2,2))
plot(c(0,9),c(115,230),type="n",main="24-Hour Mean Glucose",ylab="24 Hour Mean Glucose",
     xaxt="n",xlab="")
boxplot(dat$average_sensor_1[dat$Group=="Gastroparesis"],dat$average_sensor_1[dat$Group=="Control"],
        dat$average_sensor_2[dat$Group=="Gastroparesis"],dat$average_sensor_2[dat$Group=="Control"],
        dat$average_sensor_3[dat$Group=="Gastroparesis"],dat$average_sensor_3[dat$Group=="Control"],
        at=c(1,2,4,5,7,8), xaxt="n",
        col=c("grey90","grey50"),
       add = T)
axis(1,at=c(1.5,4.5,7.5),labels=c("Pre","Post-1","Post-2"),tick=F,cex.axis=1.5)

plot(c(0,9),c(115,230),type="n",main="Daytime Mean Glucose by Period",ylab="Daytime Mean Glucose",
     xaxt="n",xlab="")
boxplot(dat$daytime_avg_sensor_glucose_1[dat$Group=="Gastroparesis"],dat$daytime_avg_sensor_glucose_1[dat$Group=="Control"],
        dat$daytime_avg_sensor_glucose_2[dat$Group=="Gastroparesis"],dat$daytime_avg_sensor_glucose_2[dat$Group=="Control"],
        dat$daytime_avg_sensor_glucose_3[dat$Group=="Gastroparesis"],dat$daytime_avg_sensor_glucose_3[dat$Group=="Control"],
        at=c(1,2,4,5,7,8),xaxt='n',
        col=c("grey90","grey50"),
        add=T)
axis(1,at=c(1.5,4.5,7.5),labels=c("Pre","Post-1","Post-2"),tick=F,cex.axis=1.5)

plot(c(0,9),c(115,230),type="n",main="Nighttime Mean Glucose by Period",ylab="Nighttime Mean Glucose",
     xaxt="n",xlab="")

boxplot(dat$nighttime_avg_sens_glucose_1[dat$Group=="Gastroparesis"],dat$nighttime_avg_sens_glucose_1[dat$Group=="Control"],
        dat$nighttime_avg_sens_glucose_2[dat$Group=="Gastroparesis"],dat$nighttime_avg_sens_glucose_2[dat$Group=="Control"],
        dat$nighttime_avg_sens_glucose_3[dat$Group=="Gastroparesis"],dat$nighttime_avg_sens_glucose_3[dat$Group=="Control"],
        at=c(1,2,4,5,7,8),xaxt='n',
        col=c("grey90","grey50"),
        add=T)
axis(1,at=c(1.5,4.5,7.5),labels=c("Pre","Post-1","Post-2"),tick=F,cex.axis=1.5)

legend(3,220,c("Gastroparesis","Control"),
       col=c("grey90","grey50"),fill=c("grey90","grey50"))

##supplemental materials: CV plot
par(mfrow=c(1,1))
plot(c(0,9),c(0.20,0.45),type="n",main="Coefficient of Variation of Glucose",ylab="Coefficient of Variation of Glucose",
     xaxt="n",xlab="Period")
boxplot(dat$cv_1[dat$Group=="Gastroparesis"],dat$cv_1[dat$Group=="Control"],
        dat$cv_2[dat$Group=="Gastroparesis"],dat$cv_2[dat$Group=="Control"],
        dat$cv_3[dat$Group=="Gastroparesis"],dat$cv_3[dat$Group=="Control"],
        at=c(1,2,4,5,7,8),xaxt='n',
        col=c("grey90","grey50"),
        add=T)
axis(1,at=c(1.5,4.5,7.5),labels=c("Pre","Post-1","Post-2"),tick=F,cex.axis=1.5)

legend(3,220,c("Gastroparesis","Control"),
       col=c("grey90","grey50"),fill=c("grey90","grey50"))

##hyper/hypo plot:
par(mfrow=c(1,2))
plot(c(0,9),c(0,10),type="n",main="Percent of Time in Hypo (<70)",ylab="% of Time in Hypo (<70)",
     xaxt="n",xlab="Period")
boxplot(dat$percent_time_under_70_1[dat$Group=="Gastroparesis"],dat$percent_time_under_70_1[dat$Group=="Control"],
        dat$percent_time_under_70_2[dat$Group=="Gastroparesis"],dat$percent_time_under_70_2[dat$Group=="Control"],
        dat$percent_time_under_70_3[dat$Group=="Gastroparesis"],dat$percent_time_under_70_3[dat$Group=="Control"],
        at=c(1,2,4,5,7,8),xaxt='n',
        col=c("grey90","grey50"),
        add=T)
axis(1,at=c(1.5,4.5,7.5),labels=c("Pre","Post-1","Post-2"),tick=F,cex.axis=1.5)

plot(c(0,9),c(10,70),type="n",main="Percent of time in hyper (>180)",ylab="% of time in hyper (>180)",
     xaxt="n",xlab="Period")
boxplot(dat$percent_time_over_180_1[dat$Group=="Gastroparesis"],dat$percent_time_over_180_1[dat$Group=="Control"],
        dat$percent_time_over_180_2[dat$Group=="Gastroparesis"],dat$percent_time_over_180_2[dat$Group=="Control"],
        dat$percent_time_over_180_3[dat$Group=="Gastroparesis"],dat$percent_time_over_180_3[dat$Group=="Control"],
        at=c(1,2,4,5,7,8),xaxt='n',
        col=c("grey90","grey50"),
        add=T)
axis(1,at=c(1.5,4.5,7.5),labels=c("Pre","Post-1","Post-2"),tick=F,cex.axis=1.5)
legend(5,65,c("Gastroparesis","Control"),
       col=c("grey90","grey50"),fill=c("grey90","grey50"))
