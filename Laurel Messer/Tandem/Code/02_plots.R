####PLOT SURVEY FACTORS:
#source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/00_data.R')
#source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/01_survey_factors.R')
#source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/03_models.R')


par(mfrow=c(1,3))
boxplot(dat$baseline_factor1[dat$method_cat=="Injections"],
        dat$mid_factor1[dat$method_cat=="Injections"],
        dat$post6m_factor1[dat$method_cat=="Injections"],
        xlab="Time Point",xaxt="n",main="Previous Injections",
        ylim=c(1,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

boxplot(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"],
        dat$mid_factor1[dat$method_cat=="Non-Tandem Pump"],
        dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Non-Tandem pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

boxplot(dat$baseline_factor1[dat$method_cat=="Tandem Pump"],
        dat$mid_factor1[dat$method_cat=="Tandem Pump"],
        dat$post6m_factor1[dat$method_cat=="Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Tandem Pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

####FACTOR 2
par(mfrow=c(1,3))
boxplot(dat$baseline_factor2[dat$method_cat=="Injections"],
        dat$mid_factor2[dat$method_cat=="Injections"],
        dat$post6m_factor2[dat$method_cat=="Injections"],
        xlab="Time Point",xaxt="n",main="Previous Injections",
        ylim=c(1,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

boxplot(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"],
        dat$mid_factor2[dat$method_cat=="Non-Tandem Pump"],
        dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Non-Tandem pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

boxplot(dat$baseline_factor2[dat$method_cat=="Tandem Pump"],
        dat$mid_factor2[dat$method_cat=="Tandem Pump"],
        dat$post6m_factor2[dat$method_cat=="Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Tandem Pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

####CHANGE PLOTS####

dat$change1_satis<-dat$mid_factor1-dat$baseline_factor1
dat$change2_satis<-dat$post6m_factor1-dat$mid_factor1

dat$change1_burden<-dat$mid_factor2-dat$baseline_factor2
dat$change2_burden<-dat$post6m_factor2-dat$mid_factor2
par(mfrow=c(1,2))


plot(c(0.8,2.2),c(0,2.5),main="Satisfaction Increase",xlab="",
     ylab="Increase in Satisfaction",type="n",xaxt="n")
axis(1,at=c(1,2),c("Baseline to Midpoint","Midpoint to 6 Month"))
x<-c(1,1,2,2)
y<-c(mean(dat$change1_satis[dat$method_cat=="Injections"])
     -1.96*sd(dat$change1_satis[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$change1_satis[dat$method_cat=="Injections"])
     +1.96*sd(dat$change1_satis[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$change2_satis[dat$method_cat=="Injections"])
     +1.96*sd(dat$change2_satis[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$change2_satis[dat$method_cat=="Injections"])
     -1.96*sd(dat$change2_satis[dat$method_cat=="Injections"])/sqrt(nrow(dat))
)
polygon(x,y,col=grey(0.8),border=NA)

x<-c(1,1,2,2)
y<-c(mean(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"])
     -1.96*sd(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"])
     +1.96*sd(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"])
     +1.96*sd(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"])
     -1.96*sd(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat))
)
polygon(x,y,col=grey(0.7),border=NA)

x<-c(1,1,2,2)
y<-c(mean(dat$change1_satis[dat$method_cat=="Tandem Pump"])
     -1.96*sd(dat$change1_satis[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change1_satis[dat$method_cat=="Tandem Pump"])
     +1.96*sd(dat$change1_satis[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change2_satis[dat$method_cat=="Tandem Pump"])
     +1.96*sd(dat$change2_satis[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change2_satis[dat$method_cat=="Tandem Pump"])
     -1.96*sd(dat$change2_satis[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat))
)
polygon(x,y,col=grey(0.9),border=NA)

points(1,mean(dat$change1_satis[dat$method_cat=="Tandem Pump"]),pch=19)
points(2,mean(dat$change2_satis[dat$method_cat=="Tandem Pump"]),pch=19)
lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Tandem Pump"]),
               mean(dat$change2_satis[dat$method_cat=="Tandem Pump"])),lwd=1)

points(1,mean(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"]),pch=17)
points(2,mean(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"]),pch=17)
lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"]),
               mean(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"])),lty=2,lwd=1)


points(1,mean(dat$change1_satis[dat$method_cat=="Injections"]),pch=15)
points(2,mean(dat$change2_satis[dat$method_cat=="Injections"]),pch=15)
lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Injections"]),
               mean(dat$change2_satis[dat$method_cat=="Injections"])),lty=3,lwd=1)

plot(c(0.8,2.2),c(-2.2,0.1),main="Diabetes Burden Decrease",xlab="",
     ylab="Decrease in Burden",type="n",xaxt="n")
axis(1,at=c(1,2),c("Baseline to Midpoint","Midpoint to 6 Month"))
x<-c(1,1,2,2)
y<-c(mean(dat$change1_burden[dat$method_cat=="Injections"])
     -1.96*sd(dat$change1_burden[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$change1_burden[dat$method_cat=="Injections"])
     +1.96*sd(dat$change1_burden[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$change2_burden[dat$method_cat=="Injections"])
     +1.96*sd(dat$change2_burden[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$change2_burden[dat$method_cat=="Injections"])
     -1.96*sd(dat$change2_burden[dat$method_cat=="Injections"])/sqrt(nrow(dat))
)
polygon(x,y,col=grey(0.8),border=NA)

x<-c(1,1,2,2)
y<-c(mean(dat$change1_burden[dat$method_cat=="Non-Tandem Pump"])
     -1.96*sd(dat$change1_burden[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change1_burden[dat$method_cat=="Non-Tandem Pump"])
     +1.96*sd(dat$change1_burden[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change2_burden[dat$method_cat=="Non-Tandem Pump"])
     +1.96*sd(dat$change2_burden[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change2_burden[dat$method_cat=="Non-Tandem Pump"])
     -1.96*sd(dat$change2_burden[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat))
)
polygon(x,y,col=grey(0.7),border=NA)

x<-c(1,1,2,2)
y<-c(mean(dat$change1_burden[dat$method_cat=="Tandem Pump"])
     -1.96*sd(dat$change1_burden[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change1_burden[dat$method_cat=="Tandem Pump"])
     +1.96*sd(dat$change1_burden[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change2_burden[dat$method_cat=="Tandem Pump"])
     +1.96*sd(dat$change2_burden[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$change2_burden[dat$method_cat=="Tandem Pump"])
     -1.96*sd(dat$change2_burden[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat))
)
polygon(x,y,col=grey(0.9),border=NA)

points(1,mean(dat$change1_burden[dat$method_cat=="Tandem Pump"]),pch=19)
points(2,mean(dat$change2_burden[dat$method_cat=="Tandem Pump"]),pch=19)
lines(c(1,2),c(mean(dat$change1_burden[dat$method_cat=="Tandem Pump"]),
               mean(dat$change2_burden[dat$method_cat=="Tandem Pump"])),lwd=1)

points(1,mean(dat$change1_burden[dat$method_cat=="Non-Tandem Pump"]),pch=17)
points(2,mean(dat$change2_burden[dat$method_cat=="Non-Tandem Pump"]),pch=17)
lines(c(1,2),c(mean(dat$change1_burden[dat$method_cat=="Non-Tandem Pump"]),
               mean(dat$change2_burden[dat$method_cat=="Non-Tandem Pump"])),lty=2,lwd=1)
points(1,mean(dat$change1_burden[dat$method_cat=="Injections"]),pch=15)
points(2,mean(dat$change2_burden[dat$method_cat=="Injections"]),pch=15)
lines(c(1,2),c(mean(dat$change1_burden[dat$method_cat=="Injections"]),
               mean(dat$change2_burden[dat$method_cat=="Injections"])),lty=3,lwd=1)

legend("bottomright",c("Injections","Non-Tandem Pump","Tandem Pump"),lty=c(3,2,1),lwd=c(1,1,1),
       pch=c(15,17,19),pt.bg	
=c(grey(0.8), grey(0.7),grey(0.9)),border=NA,
       title="Previous Method:",cex=.8,seg.len=4)

####MEAN PLOTS####

plot(c(-0.2,2.2),c(6,10),main="Satisfaction",xlab="",
     ylab="Satisfaction Score",type="n",xaxt="n")
axis(1,at=c(0,1,2),c("Baseline","Midpoint","6 Month"))
x<-c(0,0,1,2,2,1)
y<-c(mean(dat$baseline_factor1[dat$method_cat=="Injections"])
     -1.96*sd(dat$baseline_factor1[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$baseline_factor1[dat$method_cat=="Injections"])
     +1.96*sd(dat$baseline_factor1[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$mid_factor1[dat$method_cat=="Injections"])
     +1.96*sd(dat$mid_factor1[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor1[dat$method_cat=="Injections"])
     +1.96*sd(dat$post6m_factor1[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor1[dat$method_cat=="Injections"])
     -1.96*sd(dat$post6m_factor1[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$mid_factor1[dat$method_cat=="Injections"])
     -1.96*sd(dat$mid_factor1[dat$method_cat=="Injections"])/sqrt(nrow(dat)))
polygon(x,y,col=grey(0.8),border=NA)

x<-c(0,0,1,2,2,1)
y<-c(mean(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"])
     -1.96*sd(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"])
     +1.96*sd(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$mid_factor1[dat$method_cat=="Non-Tandem Pump"])
     +1.96*sd(dat$mid_factor1[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"])
     +1.96*sd(dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"])
     -1.96*sd(dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$mid_factor1[dat$method_cat=="Non-Tandem Pump"])
     -1.96*sd(dat$mid_factor1[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)))
polygon(x,y,col=grey(0.7),border=NA)

x<-c(0,0,1,2,2,1)
y<-c(mean(dat$baseline_factor1[dat$method_cat=="Tandem Pump"])
     -1.96*sd(dat$baseline_factor1[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$baseline_factor1[dat$method_cat=="Tandem Pump"])
     +1.96*sd(dat$baseline_factor1[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$mid_factor1[dat$method_cat=="Tandem Pump"])
     +1.96*sd(dat$mid_factor1[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor1[dat$method_cat=="Tandem Pump"])
     +1.96*sd(dat$post6m_factor1[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor1[dat$method_cat=="Tandem Pump"])
     -1.96*sd(dat$post6m_factor1[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$mid_factor1[dat$method_cat=="Tandem Pump"])
     -1.96*sd(dat$mid_factor1[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)))
polygon(x,y,col=grey(0.9),border=NA)

points(0,mean(dat$baseline_factor1[dat$method_cat=="Tandem Pump"]),pch=19)
points(1,mean(dat$mid_factor1[dat$method_cat=="Tandem Pump"]),pch=19)
points(2,mean(dat$post6m_factor1[dat$method_cat=="Tandem Pump"]),pch=19)
lines(c(0,1),c(mean(dat$baseline_factor1[dat$method_cat=="Tandem Pump"]),
               mean(dat$mid_factor1[dat$method_cat=="Tandem Pump"])),lwd=1)
lines(c(1,2),c(mean(dat$mid_factor1[dat$method_cat=="Tandem Pump"]),
               mean(dat$post6m_factor1[dat$method_cat=="Tandem Pump"])),lwd=1)

points(0,mean(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"]),pch=17)
points(1,mean(dat$mid_factor1[dat$method_cat=="Non-Tandem Pump"]),pch=17)
points(2,mean(dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"]),pch=17)
lines(c(0,1),c(mean(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"]),
               mean(dat$mid_factor1[dat$method_cat=="Non-Tandem Pump"])),lwd=1,lty=2)
lines(c(1,2),c(mean(dat$mid_factor1[dat$method_cat=="Non-Tandem Pump"]),
               mean(dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"])),lwd=1,lty=2)

points(0,mean(dat$baseline_factor1[dat$method_cat=="Injections"]),pch=15)
points(1,mean(dat$mid_factor1[dat$method_cat=="Injections"]),pch=15)
points(2,mean(dat$post6m_factor1[dat$method_cat=="Injections"]),pch=15)
lines(c(0,1),c(mean(dat$baseline_factor1[dat$method_cat=="Injections"]),
               mean(dat$mid_factor1[dat$method_cat=="Injections"])),lwd=1,lty=3)
lines(c(1,2),c(mean(dat$mid_factor1[dat$method_cat=="Injections"]),
               mean(dat$post6m_factor1[dat$method_cat=="Injections"])),lwd=1,lty=3)

plot(c(-0.2,2.2),c(6,10),main="Satisfaction",xlab="",
     ylab="Satisfaction Score",type="n",xaxt="n")
axis(1,at=c(0,1,2),c("Baseline","Midpoint","6 Month"))
x<-c(0,0,1,2,2,1)
y<-c(mean(dat$baseline_factor2[dat$method_cat=="Injections"])
     -1.96*sd(dat$baseline_factor2[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$baseline_factor2[dat$method_cat=="Injections"])
     +1.96*sd(dat$baseline_factor2[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$mid_factor2[dat$method_cat=="Injections"])
     +1.96*sd(dat$mid_factor2[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor2[dat$method_cat=="Injections"])
     +1.96*sd(dat$post6m_factor2[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor2[dat$method_cat=="Injections"])
     -1.96*sd(dat$post6m_factor2[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
     mean(dat$mid_factor2[dat$method_cat=="Injections"])
     -1.96*sd(dat$mid_factor2[dat$method_cat=="Injections"])/sqrt(nrow(dat)))
polygon(x,y,col=grey(0.8),border=NA)

x<-c(0,0,1,2,2,1)
y<-c(mean(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"])
     -1.96*sd(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"])
     +1.96*sd(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$mid_factor2[dat$method_cat=="Non-Tandem Pump"])
     +1.96*sd(dat$mid_factor2[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"])
     +1.96*sd(dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"])
     -1.96*sd(dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$mid_factor2[dat$method_cat=="Non-Tandem Pump"])
     -1.96*sd(dat$mid_factor2[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)))
polygon(x,y,col=grey(0.7),border=NA)

x<-c(0,0,1,2,2,1)
y<-c(mean(dat$baseline_factor2[dat$method_cat=="Tandem Pump"])
     -1.96*sd(dat$baseline_factor2[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$baseline_factor2[dat$method_cat=="Tandem Pump"])
     +1.96*sd(dat$baseline_factor2[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$mid_factor2[dat$method_cat=="Tandem Pump"])
     +1.96*sd(dat$mid_factor2[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor2[dat$method_cat=="Tandem Pump"])
     +1.96*sd(dat$post6m_factor2[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$post6m_factor2[dat$method_cat=="Tandem Pump"])
     -1.96*sd(dat$post6m_factor2[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
     mean(dat$mid_factor2[dat$method_cat=="Tandem Pump"])
     -1.96*sd(dat$mid_factor2[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)))
polygon(x,y,col=grey(0.9),border=NA)

points(0,mean(dat$baseline_factor2[dat$method_cat=="Tandem Pump"]),pch=19)
points(1,mean(dat$mid_factor2[dat$method_cat=="Tandem Pump"]),pch=19)
points(2,mean(dat$post6m_factor2[dat$method_cat=="Tandem Pump"]),pch=19)
lines(c(0,1),c(mean(dat$baseline_factor2[dat$method_cat=="Tandem Pump"]),
               mean(dat$mid_factor2[dat$method_cat=="Tandem Pump"])),lwd=1)
lines(c(1,2),c(mean(dat$mid_factor2[dat$method_cat=="Tandem Pump"]),
               mean(dat$post6m_factor2[dat$method_cat=="Tandem Pump"])),lwd=1)

points(0,mean(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"]),pch=17)
points(1,mean(dat$mid_factor2[dat$method_cat=="Non-Tandem Pump"]),pch=17)
points(2,mean(dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"]),pch=17)
lines(c(0,1),c(mean(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"]),
               mean(dat$mid_factor2[dat$method_cat=="Non-Tandem Pump"])),lwd=1,lty=2)
lines(c(1,2),c(mean(dat$mid_factor2[dat$method_cat=="Non-Tandem Pump"]),
               mean(dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"])),lwd=1,lty=2)

points(0,mean(dat$baseline_factor2[dat$method_cat=="Injections"]),pch=15)
points(1,mean(dat$mid_factor2[dat$method_cat=="Injections"]),pch=15)
points(2,mean(dat$post6m_factor2[dat$method_cat=="Injections"]),pch=15)
lines(c(0,1),c(mean(dat$baseline_factor2[dat$method_cat=="Injections"]),
               mean(dat$mid_factor2[dat$method_cat=="Injections"])),lwd=1,lty=3)
lines(c(1,2),c(mean(dat$mid_factor2[dat$method_cat=="Injections"]),
               mean(dat$post6m_factor2[dat$method_cat=="Injections"])),lwd=1,lty=3)

legend("bottomright",c("Injections","Non-Tandem Pump","Tandem Pump"),lty=c(3,2,1),lwd=c(1,1,1),
       pch=c(15,17,19),pt.bg	
       =c(grey(0.8), grey(0.7),grey(0.9)),border=NA,
       title="Previous Method:",cex=.8,seg.len=4)

###forest plots:
library(plotrix)
jpeg("abstract_figure.jpg",units="in", width=10, height=6,res=450)
par(mfrow=c(1,2),mar=c(3,4.1,3,2.1))
plotCI(c(0.9,1,1.1),ch1.fac1.means_plots$lsmean,li=ch1.fac1.means_plots$lower.CL,
       ui=ch1.fac1.means_plots$upper.CL,err="y",xlim=c(0.7,2.3),ylim=c(-0.3,3),
       pch=15,xlab="",ylab="Average Change (CI)",xaxt="n",
       main="Figure 1A: Change in Satisfaction",slty=c(1,2,3))
abline(h=0,lty=1)
axis(1,at=c(1,2),c("Baseline to midpoint","Midpoint to 6 months"))

plotCI(c(1.9,2,2.1),ch2.fac1.means_plots$lsmean,li=ch2.fac1.means_plots$lower.CL,
       ui=ch2.fac1.means_plots$upper.CL,err="y",xlim=c(0.5,2.5),ylim=c(-0.3,3),
       pch=15,xlab="",ylab="Average Change (CI)",xaxt="n",
       main="Figure 1A: Change in Satisfaction",slty=c(1,2,3),add=T)
#legend("topright",c("MDI","Non-Tandem Pump","Tandem Pump"),lty=c(1,2,3),pch=c(15,15,15))

###2nd plot:
# par(mar=c(3,4.1,3,2.1))
plotCI(c(0.9,1,1.1),ch1.fac2.means_plots$lsmean,li=ch1.fac2.means_plots$lower.CL,
       ui=ch1.fac2.means_plots$upper.CL,err="y",xlim=c(0.7,2.3),ylim=c(-3,0.35),
       pch=15,xlab="",ylab="Average Change (CI)",xaxt="n",
       main="Figure 1B: Change in Diabetes Burden",slty=c(1,2,3))
abline(h=0,lty=1)
axis(1,at=c(1,2),c("Baseline to midpoint","Midpoint to 6 months"))

plotCI(c(1.9,2,2.1),ch2.fac2.means_plots$lsmean,li=ch2.fac2.means_plots$lower.CL,
       ui=ch2.fac2.means_plots$upper.CL,err="y",xlim=c(0.5,2.5),ylim=c(-0.3,3),
       pch=15,xlab="",ylab="Average Change (CI)",xaxt="n",
       main="Figure 1A: Change in Diabetes Burden",slty=c(1,2,3),add=T)
legend("bottomright",c("MDI","Non-Tandem Pump","Tandem Pump"),
       lty=c(1,2,3),pch=c(15,15,15),seg.len=3,title = "Previous Insulin Method:")
dev.off()

###for poster:
jpeg("abstract_figure.jpg",units="in", width=10, height=6,res=450)
par(mfrow=c(1,2),mar=c(3,4.1,3,1))
plotCI(c(0.9,1,1.1),ch1.fac1.means_plots$lsmean,li=ch1.fac1.means_plots$lower.CL,
       ui=ch1.fac1.means_plots$upper.CL,err="y",xlim=c(0.7,2.3),ylim=c(-0.3,3),
       pch=15,xlab="",ylab="Average Change (CI)",xaxt="n",
       main="A: Device Satisfaction",slty=c(1,2,3),lwd=2,cex.axis=1.2,cex.lab=1.2,yaxt="n")
abline(h=0,lty=1)
axis(1,at=c(1,2),c("Baseline to midpoint","Midpoint to 6 months"),cex.axis=1.2)
axis(2,at=c(0,1,2,3),c("0","1","2","3"),cex.axis=1.2)

plotCI(c(1.9,2,2.1),ch2.fac1.means_plots$lsmean,li=ch2.fac1.means_plots$lower.CL,
       ui=ch2.fac1.means_plots$upper.CL,err="y",xlim=c(0.5,2.5),ylim=c(-0.3,3),
       pch=15,xlab="",ylab="Average Change (CI)",xaxt="n",
       main="A: Device Satisfaction",slty=c(1,2,3),add=T,lwd=2,cex.axis=1.2,cex.lab=1.2)
#legend("topright",c("MDI","Non-Tandem Pump","Tandem Pump"),lty=c(1,2,3),pch=c(15,15,15))

###2nd plot:
# par(mar=c(3,4.1,3,2.1))
plotCI(c(0.9,1,1.1),ch1.fac2.means_plots$lsmean,li=ch1.fac2.means_plots$lower.CL,
       ui=ch1.fac2.means_plots$upper.CL,err="y",xlim=c(0.7,2.3),ylim=c(-3,0.35),
       pch=15,xlab="",ylab="Average Change (CI)",xaxt="n",
       main="B: Diabetes Impact",slty=c(1,2,3),lwd=2,cex.axis=1.2,cex.lab=1.2,yaxt="n")
abline(h=0,lty=1)
axis(1,at=c(1,2),c("Baseline to midpoint","Midpoint to 6 months"),cex.axis=1.2)
axis(2,at=c(-3,-2,-1,0),c("-3","-2","-1","0"),cex.axis=1.2)

plotCI(c(1.9,2,2.1),ch2.fac2.means_plots$lsmean,li=ch2.fac2.means_plots$lower.CL,
       ui=ch2.fac2.means_plots$upper.CL,err="y",xlim=c(0.5,2.5),ylim=c(-0.3,3),
       pch=15,xlab="",ylab="Average Change (CI)",xaxt="n",
       main="B: Diabetes Impact",slty=c(1,2,3),add=T,lwd=2)
legend("bottomright",c("MDI","Non-Tandem Pump","Tandem Pump"),
       lty=c(1,2,3),pch=c(15,15,15),lwd=2,seg.len=3,title = "Previous Insulin Method:",cex=1.2)
dev.off()