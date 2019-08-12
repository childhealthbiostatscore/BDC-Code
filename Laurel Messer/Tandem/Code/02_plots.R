####PLOT SURVEY FACTORS:

boxplot(dat$baseline_factor1,dat$mid_factor1,dat$post6m_factor1,
        xlab="Time Point",xaxt="n",main="Factor 1: Utility")
axis(1,at=c(1,2,3),labels=c("Baseline","Mid-Point","6 Month"))

boxplot(dat$baseline_factor2,dat$mid_factor2,dat$post6m_factor2,
        xlab="Time Point",xaxt="n",main="Factor 2: Usability")
axis(1,at=c(1,2,3),labels=c("Baseline","Mid-Point","6 Month"))

boxplot(dat$baseline_factor3,dat$mid_factor3,dat$post6m_factor3,
        xlab="Time Point",xaxt="n",main="Factor 3: Hypoglycemia Burden")
axis(1,at=c(1,2,3),labels=c("Baseline","Mid-Point","6 Month"))
