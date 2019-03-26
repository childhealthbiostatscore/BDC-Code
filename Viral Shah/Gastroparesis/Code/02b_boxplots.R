###boxplots: 
setwd("C:/Users/campbkri/Documents/GitHub/BDC-Code/Viral Shah/Gastroparesis/Code")
source('01_data.R')
###A1c, boxplots
boxplot(dat$A1C_3mo_pre[dat$Group=="Gastroparesis"],dat$A1C_3mo_pre[dat$Group=="Control"],
        dat$A1C_6mo_post[dat$Group=="Gastroparesis"],dat$A1C_6mo_post[dat$Group=="Control"],
        at=c(1,2,4,5),names=c("Gastro","Control","Gastro","Control"),
        col=c("grey90","grey50"),main="Figure 1: Change in A1C by Group",
        ylab="A1C")
mtext("Pre",1,3,adj=0.20,cex=1.5)
mtext("Post",1,3,adj=0.80,cex=1.5)


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
