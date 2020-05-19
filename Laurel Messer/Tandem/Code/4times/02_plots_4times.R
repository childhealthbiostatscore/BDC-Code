####PLOT SURVEY FACTORS:
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/4times/00_data_4times.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/4times/01_survey_4times.R')

jpeg("S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Results/DS_boxplot.jpeg",
     height=5,width=8,units = "in",res=300)
par(mfrow=c(1,3))
boxplot(dat$baseline_factor1[dat$method_cat=="Injections"],
        dat$post2m_factor1[dat$method_cat=="Injections"],
        dat$post4m_factor1[dat$method_cat=="Injections"],
        dat$post6m_factor1[dat$method_cat=="Injections"],
        xlab="Time Point",xaxt="n",main="MDI",ylab="Device Satisfaction (DS) Score",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2mo","4mo","6mo"))

boxplot(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"],
        dat$post2m_factor1[dat$method_cat=="Non-Tandem Pump"],
        dat$post4m_factor1[dat$method_cat=="Non-Tandem Pump"],
        dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Non-Tandem Pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2mo","4mo","6mo"))

boxplot(dat$baseline_factor1[dat$method_cat=="Tandem Pump"],
        dat$post2m_factor1[dat$method_cat=="Tandem Pump"],
        dat$post4m_factor1[dat$method_cat=="Tandem Pump"],
        dat$post6m_factor1[dat$method_cat=="Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Tandem Pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2mo","4mo","6mo"))
dev.off()

####FACTOR 2
jpeg("S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Results/DI_boxplot.jpeg",
     height=5,width=8,units = "in",res=300)
par(mfrow=c(1,3))
boxplot(dat$baseline_factor2[dat$method_cat=="Injections"],
        dat$post2m_factor2[dat$method_cat=="Injections"],
        dat$post4m_factor2[dat$method_cat=="Injections"],
        dat$post6m_factor2[dat$method_cat=="Injections"],
        xlab="Time Point",xaxt="n",main="MDI",ylab="Diabetes Impact (DI) Score",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2mo","4mo","6mo"))

boxplot(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"],
        dat$post2m_factor2[dat$method_cat=="Non-Tandem Pump"],
        dat$post4m_factor2[dat$method_cat=="Non-Tandem Pump"],
        dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Non-Tandem Pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2mo","4mo","6mo"))

boxplot(dat$baseline_factor2[dat$method_cat=="Tandem Pump"],
        dat$post2m_factor2[dat$method_cat=="Tandem Pump"],
        dat$post4m_factor2[dat$method_cat=="Tandem Pump"],
        dat$post6m_factor2[dat$method_cat=="Tandem Pump"],
        xlab="Time Point",xaxt="n",main="Tandem Pump",
        ylim=c(1,10))
axis(1,at=c(1,2,3,4),labels=c("Baseline","2mo","4mo","6mo"))
dev.off()

