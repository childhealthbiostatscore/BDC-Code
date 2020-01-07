#####sensitivity analysis: 
#Month 2 vs. Month 4

source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/00_data.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/01_survey_factors.R')

dat<-dat
dat<-subset(dat,dat$post2m_complete_yn==1 & dat$post4m_complete_yn==1)

boxplot(dat$baseline_factor1,dat$post2m_factor1,dat$post4m_factor1,
        dat$post6m_factor1)

boxplot(dat$baseline_factor2,dat$post2m_factor2,dat$post4m_factor2,
        dat$post6m_factor2)

plot(c(1,2,3,4),c(mean(dat$baseline_factor2),mean(dat$post2m_factor2),mean(dat$post4m_factor2),
     mean(dat$post6m_factor2)),ylab="Diabetes Burden Score",xaxt="n",xlab="Time")
lines(c(1,2,3,4),c(mean(dat$baseline_factor2),mean(dat$post2m_factor2),mean(dat$post4m_factor2),
                  mean(dat$post6m_factor2)))
axis(1,c(1,2,3,4),labels = c("Baseline","2mo","4mo","6mo"))

dat$diff_factor1<-dat$post4m_factor1-dat$post2m_factor1
t.test(dat$diff_factor1)

dat$diff1_factor1<-dat$baseline_factor1-dat$post2m_factor1
dat$diff2_factor1<-dat$baseline_factor1-dat$post4m_factor1
t.test(dat$diff1_factor1)
t.test(dat$diff2_factor1)

dat$diff3_factor1<-dat$post6m_factor1-dat$post2m_factor1
dat$diff4_factor1<-dat$post6m_factor1-dat$post4m_factor1
t.test(dat$diff3_factor1)
t.test(dat$diff4_factor1)


dat$diff_factor2<-dat$post4m_factor2-dat$post2m_factor2
t.test(dat$diff_factor2)

hist(dat$diff_factor1)
hist(dat$diff_factor2)

quantile(dat$post2m_factor1)
quantile(dat$post4m_factor1)

quantile(dat$post2m_factor2)
quantile(dat$post4m_factor2)
