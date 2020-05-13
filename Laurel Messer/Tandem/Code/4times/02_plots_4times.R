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

f1<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/lsmeans_factor1.csv")

plot(c(1,4),c(5,10),type="n",xlab="Time point",ylab="Estimated value - satisfaction")

polygon(c(-20,-20,vlines[2],vlines[2]),c(-10,1.2,1.2,-10),col=brewer.pal(7,"Greys")[1],
        border=NA)
polygon(c(vlines[2],vlines[2],vlines[3],vlines[3]),c(-10,1.2,1.2,-10),col=brewer.pal(7,"Greys")[2],
        border=NA)
polygon(c(vlines[3],vlines[3],vlines[4],vlines[4]),c(-10,1.2,1.2,-10),col=brewer.pal(7,"Greys")[3],
        border=NA)
polygon(c(vlines[4],vlines[4],vlines[5],vlines[5]),c(-10,1.2,1.2,-10),col=brewer.pal(7,"Greys")[4],
        border=NA)
polygon(c(vlines[5],vlines[5],300,300),c(-10,1.2,1.2,-10),col=brewer.pal(7,"Greys")[5],
        border=NA)

points(1,f1$mu_trans[f1$time=="baseline" & f1$method_cat=="Injections"],col="red",pch=19)
points(2,f1$mu_trans[f1$time=="post2m" & f1$method_cat=="Injections"],col="red",pch=19)
points(3,f1$mu_trans[f1$time=="post4m" & f1$method_cat=="Injections"],col="red",pch=19)
points(4,f1$mu_trans[f1$time=="post6m" & f1$method_cat=="Injections"],col="red",pch=19)
lines(c(1,2),c(f1$mu_trans[f1$time=="baseline" & f1$method_cat=="Injections"],
               f1$mu_trans[f1$time=="post2m" & f1$method_cat=="Injections"]),col="red")
lines(c(2,3),c(f1$mu_trans[f1$time=="post2m" & f1$method_cat=="Injections"],
               f1$mu_trans[f1$time=="post4m" & f1$method_cat=="Injections"]),col="red")
lines(c(3,4),c(f1$mu_trans[f1$time=="post4m" & f1$method_cat=="Injections"],
               f1$mu_trans[f1$time=="post6m" & f1$method_cat=="Injections"]),col="red")

points(1,f1$mu_trans[f1$time=="baseline" & f1$method_cat=="Non-Tandem Pump"],col="blue",pch=19)
points(2,f1$mu_trans[f1$time=="post2m" & f1$method_cat=="Non-Tandem Pump"],col="blue",pch=19)
points(3,f1$mu_trans[f1$time=="post4m" & f1$method_cat=="Non-Tandem Pump"],col="blue",pch=19)
points(4,f1$mu_trans[f1$time=="post6m" & f1$method_cat=="Non-Tandem Pump"],col="blue",pch=19)
lines(c(1,2),c(f1$mu_trans[f1$time=="baseline" & f1$method_cat=="Non-Tandem Pump"],
               f1$mu_trans[f1$time=="post2m" & f1$method_cat=="Non-Tandem Pump"]),col="blue")
lines(c(2,3),c(f1$mu_trans[f1$time=="post2m" & f1$method_cat=="Non-Tandem Pump"],
               f1$mu_trans[f1$time=="post4m" & f1$method_cat=="Non-Tandem Pump"]),col="blue")
lines(c(3,4),c(f1$mu_trans[f1$time=="post4m" & f1$method_cat=="Non-Tandem Pump"],
               f1$mu_trans[f1$time=="post6m" & f1$method_cat=="Non-Tandem Pump"]),col="blue")

points(1,f1$mu_trans[f1$time=="baseline" & f1$method_cat=="Tandem Pump"],col="darkgreen",pch=19)
points(2,f1$mu_trans[f1$time=="post2m" & f1$method_cat=="Tandem Pump"],col="darkgreen",pch=19)
points(3,f1$mu_trans[f1$time=="post4m" & f1$method_cat=="Tandem Pump"],col="darkgreen",pch=19)
points(4,f1$mu_trans[f1$time=="post6m" & f1$method_cat=="Tandem Pump"],col="darkgreen",pch=19)
lines(c(1,2),c(f1$mu_trans[f1$time=="baseline" & f1$method_cat=="Tandem Pump"],
               f1$mu_trans[f1$time=="post2m" & f1$method_cat=="Tandem Pump"]),col="darkgreen")
lines(c(2,3),c(f1$mu_trans[f1$time=="post2m" & f1$method_cat=="Tandem Pump"],
               f1$mu_trans[f1$time=="post4m" & f1$method_cat=="Tandem Pump"]),col="darkgreen")
lines(c(3,4),c(f1$mu_trans[f1$time=="post4m" & f1$method_cat=="Tandem Pump"],
               f1$mu_trans[f1$time=="post6m" & f1$method_cat=="Tandem Pump"]),col="darkgreen")

legend("bottom",c("Injections","Non-Tandem Pump","Tandem Pump"),lty=1,col=c("red","blue","darkgreen"))



