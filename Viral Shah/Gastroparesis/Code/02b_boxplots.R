###boxplots: 
setwd("C:/Users/campbkri/Documents/GitHub/BDC-Code/Viral Shah/Gastroparesis/Code")
source('01_data.R')
###A1c, boxplots
plot(c(0,9),c(6,9),type="n",main="",ylab="HbA1c (%)",
     xaxt="n",xlab="")
boxplot(dat$A1C_3mo_pre[dat$Group=="Gastroparesis"],dat$A1C_3mo_pre[dat$Group=="Control"],
        dat$A1C_3mo_after[dat$Group=="Gastroparesis"],dat$A1C_3mo_after[dat$Group=="Control"],
        dat$A1C_6mo_post[dat$Group=="Gastroparesis"],dat$A1C_6mo_post[dat$Group=="Control"],
        at=c(1,2,4,5,7,8), xaxt="n",
        col=c("grey90","grey50"),
        add = T)
axis(1,at=c(1.5,4.5,7.5),labels=c("Baseline","3 months","6 months"),tick=F,cex.axis=1.2)
legend("topright",c("Gastroparesis","Control"),
       col=c("grey90","grey50"),fill=c("grey90","grey50"))


text(2.5,9,"Gastroparesis Group Changes:")
lines(c(0.8,4),c(8.75,8.75),lty=2)
text(2.4,8.8,"p=0.14")

lines(c(0.8,7),c(8.5,8.5),lty=2)
text(3.9,8.55,"p=0.10")

text(2.5,6.60,"Control Group Changes:")
lines(c(2,5),c(6.35,6.35),lty=2)
text(3.5,6.4,"p=0.04")

lines(c(2,8),c(6.15,6.15),lty=2)
text(5,6.20,"p=0.06")

# between group differences
# text(1.5,6.8,"p=0.05")
# text(4.6,6.3,"p=0.54")
# text(7.6,6.4,"p=0.79")

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

legend("topright",c("Gastroparesis","Control"),
       col=c("grey90","grey50"),fill=c("grey90","grey50"),bty="n")

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

legend("bottomleft",c("Gastroparesis","Control"),
       col=c("grey90","grey50"),fill=c("grey90","grey50"),bty="n")

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
