####PLOT SURVEY FACTORS:
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/4times/00_data_4times.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/4times/01_survey_4times.R')
#source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/03_models.R')


par(mfrow=c(1,3))
boxplot(dat$baseline_factor1[dat$method_cat=="Injections"],
        dat$post2m_factor1[dat$method_cat=="Injections"],
        dat$post4m_factor1[dat$method_cat=="Injections"],
        dat$post6m_factor1[dat$method_cat=="Injections"],
        xlab="Time Point",xaxt="n",main="Previous Injections",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))

boxplot(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"],
        dat$post2m_factor1[dat$method_cat=="Non-Tandem Pump"],
        dat$post4m_factor1[dat$method_cat=="Non-Tandem Pump"],
        dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Non-Tandem pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))

boxplot(dat$baseline_factor1[dat$method_cat=="Tandem Pump"],
        dat$post2m_factor1[dat$method_cat=="Tandem Pump"],
        dat$post4m_factor1[dat$method_cat=="Tandem Pump"],
        dat$post6m_factor1[dat$method_cat=="Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Tandem Pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))

####FACTOR 2
par(mfrow=c(1,3))
boxplot(dat$baseline_factor2[dat$method_cat=="Injections"],
        dat$post2m_factor2[dat$method_cat=="Injections"],
        dat$post4m_factor2[dat$method_cat=="Injections"],
        dat$post6m_factor2[dat$method_cat=="Injections"],
        xlab="Time Point",xaxt="n",main="Previous Injections",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))

boxplot(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"],
        dat$post2m_factor2[dat$method_cat=="Non-Tandem Pump"],
        dat$post4m_factor2[dat$method_cat=="Non-Tandem Pump"],
        dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Non-Tandem pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))

boxplot(dat$baseline_factor2[dat$method_cat=="Tandem Pump"],
        dat$post2m_factor2[dat$method_cat=="Tandem Pump"],
        dat$post4m_factor2[dat$method_cat=="Tandem Pump"],
        dat$post6m_factor2[dat$method_cat=="Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Previous Tandem Pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))

####PLOTS FROM MODELS####
