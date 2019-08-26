####PLOT SURVEY FACTORS:
par(mfrow=c(1,3))
boxplot(dat$baseline_factor1[dat$method_cat=="Injections"],
        dat$mid_factor1[dat$method_cat=="Injections"],
        dat$post6m_factor1[dat$method_cat=="Injections"],
        xlab="Time Point",xaxt="n",main="Previous Injections",
        ylim=c(2,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

boxplot(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"],
        dat$mid_factor1[dat$method_cat=="Non-Tandem Pump"],
        dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Non-Tandem pump",
        ylim=c(2,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

boxplot(dat$baseline_factor1[dat$method_cat=="Tandem Pump"],
        dat$mid_factor1[dat$method_cat=="Tandem Pump"],
        dat$post6m_factor1[dat$method_cat=="Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Tandem Pump",
        ylim=c(2,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

####FACTOR 2
par(mfrow=c(1,3))
boxplot(dat$baseline_factor2[dat$method_cat=="Injections"],
        dat$mid_factor2[dat$method_cat=="Injections"],
        dat$post6m_factor2[dat$method_cat=="Injections"],
        xlab="Time Point",xaxt="n",main="Previous Injections",
        ylim=c(0,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

boxplot(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"],
        dat$mid_factor2[dat$method_cat=="Non-Tandem Pump"],
        dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Non-Tandem pump",
        ylim=c(0,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))

boxplot(dat$baseline_factor2[dat$method_cat=="Tandem Pump"],
        dat$mid_factor2[dat$method_cat=="Tandem Pump"],
        dat$post6m_factor2[dat$method_cat=="Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Tandem Pump",
        ylim=c(0,10))
axis(1,at=c(1,2,3),labels=c("Baseline","Midpoint","6 Month"))
