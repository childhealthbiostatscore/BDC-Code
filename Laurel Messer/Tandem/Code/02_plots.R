####PLOT SURVEY FACTORS:
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
# lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Tandem Pump"])
#                -1.96*sd(dat$change1_satis[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
#                mean(dat$change2_satis[dat$method_cat=="Tandem Pump"])
#                -1.96*sd(dat$change2_satis[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat))),lwd=1)
# lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Tandem Pump"])
#                +1.96*sd(dat$change1_satis[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat)),
#                mean(dat$change2_satis[dat$method_cat=="Tandem Pump"])
#                +1.96*sd(dat$change2_satis[dat$method_cat=="Tandem Pump"])/sqrt(nrow(dat))),lwd=1)
# 


points(1,mean(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"]),pch=17)
points(2,mean(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"]),pch=17)
lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"]),
               mean(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"])),lty=2,lwd=1)

# lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"])
#                -1.96*sd(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
#                mean(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"])
#                -1.96*sd(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat))),lwd=1, lty=2)
# lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"])
#                +1.96*sd(dat$change1_satis[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat)),
#                mean(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"])
#                +1.96*sd(dat$change2_satis[dat$method_cat=="Non-Tandem Pump"])/sqrt(nrow(dat))),lwd=1, lty=2)


points(1,mean(dat$change1_satis[dat$method_cat=="Injections"]),pch=15)
points(2,mean(dat$change2_satis[dat$method_cat=="Injections"]),pch=15)
lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Injections"]),
               mean(dat$change2_satis[dat$method_cat=="Injections"])),lty=3,lwd=1)

# lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Injections"])
#                -1.96*sd(dat$change1_satis[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
#                mean(dat$change2_satis[dat$method_cat=="Injections"])
#                -1.96*sd(dat$change2_satis[dat$method_cat=="Injections"])/sqrt(nrow(dat))),lwd=1, lty=3)
# lines(c(1,2),c(mean(dat$change1_satis[dat$method_cat=="Injections"])
#                +1.96*sd(dat$change1_satis[dat$method_cat=="Injections"])/sqrt(nrow(dat)),
#                mean(dat$change2_satis[dat$method_cat=="Injections"])
#                +1.96*sd(dat$change2_satis[dat$method_cat=="Injections"])/sqrt(nrow(dat))),lwd=1, lty=3)

# legend("topright",c("Injections","Non-Tandem Pump","Tandem Pump"),lty=c(3,2,1),lwd=c(1.5,1.5,1.5),
#        pch=c(15,17,19),title="Previous Method:")


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
# 
# dat$change1_burden_rev<-dat$change1_burden*-1
# dat$change2_burden_rev<-dat$change2_burden*-1
# 
# 
# plot(c(0.8,2.2),c(-0.1,2.5),main="Diabetes Burden",xlab="",
#      ylab="Decrease in Burden",type="n",xaxt="n")
# axis(1,at=c(1,2),c("Baseline to Midpoint","Midpoint to 6 Month"))
# points(1,mean(dat$change1_burden_rev[dat$method_cat=="Tandem Pump"]),pch=19)
# points(2,mean(dat$change2_burden_rev[dat$method_cat=="Tandem Pump"]),pch=19)
# lines(c(1,2),c(mean(dat$change1_burden_rev[dat$method_cat=="Tandem Pump"]),
#                mean(dat$change2_burden_rev[dat$method_cat=="Tandem Pump"])),lwd=1.5)
# 
# points(1,mean(dat$change1_burden_rev[dat$method_cat=="Non-Tandem Pump"]),pch=17)
# points(2,mean(dat$change2_burden_rev[dat$method_cat=="Non-Tandem Pump"]),pch=17)
# lines(c(1,2),c(mean(dat$change1_burden_rev[dat$method_cat=="Non-Tandem Pump"]),
#                mean(dat$change2_burden_rev[dat$method_cat=="Non-Tandem Pump"])),lty=2,lwd=1.5)
# 
# points(1,mean(dat$change1_burden_rev[dat$method_cat=="Injections"]),pch=15)
# points(2,mean(dat$change2_burden_rev[dat$method_cat=="Injections"]),pch=15)
# lines(c(1,2),c(mean(dat$change1_burden_rev[dat$method_cat=="Injections"]),
#                mean(dat$change2_burden_rev[dat$method_cat=="Injections"])),lty=3,lwd=1.5)
# legend("topright",c("Injections","Non-Tandem Pump","Tandem Pump"),lty=c(3,2,1),lwd=c(1.5,1.5,1.5),
#        pch=c(15,17,19),title="Previous Method:",cex=.7)