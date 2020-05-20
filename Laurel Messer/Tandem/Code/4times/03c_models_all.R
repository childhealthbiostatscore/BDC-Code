######MODELS FOR PRO TANDEM STUDY
###AUTHOR: KRISTEN CAMPBELL
###DATE: 5/4/2020
library(RColorBrewer)
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/4times/00_data_4times.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/4times/01_survey_4times.R')

dat.model<-dat[,c(which(colnames(dat) %in% c("ExternalReference","B_RESPONDENT","Baseline_A1C",
                                                   "Age","Gender","BaselineAGE","duration_of_diabetes_at_baseline_years","cgm_yn","method_cat",
                                                   "baseline_factor1","post2m_factor1","post4m_factor1","post6m_factor1",
                                                    "baseline_factor2","post2m_factor2","post4m_factor2","post6m_factor2")))]

dat.model$factor1_baseline<-dat.model$baseline_factor1
dat.model$factor2_baseline<-dat.model$baseline_factor2

###Mixed modeling: 

dat.long<-reshape(dat.model,
                  varying=c("baseline_factor1","baseline_factor2",
                            "post2m_factor1","post2m_factor2",
                            "post4m_factor1","post4m_factor2",
                            "post6m_factor1","post6m_factor2"),
                  v.names = c("factor1","factor2"),
                  timevar = "time",
                  times = c("baseline", "post2m", "post4m","post6m"),
        idvar="ExternalReference",direction="long")
dat.long<-dat.long[order(dat.long$ExternalReference,dat.long$time),]

dat.long$time<-factor(dat.long$time)
dat.long$factor1[dat.long$factor1=="NaN"]<-NA

###spaghetti plots:
#A: full trajectories:
num_measures<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    ##dat.temp <- subset(dat.long,dat.long$ExternalReference=="BDC_0001")
    dat.temp$num_factor1<-nrow(subset(dat.temp,!is.na(dat.temp$factor1)))
    dat.temp$num_factor2<-nrow(subset(dat.temp,!is.na(dat.temp$factor2)))
    dat.temp
    dat.temp})
  
  dat<-do.call(rbind,temp)
}
dat.long<-num_measures(dat.long$ExternalReference,dat.long)



#####FACTOR 1 - not normal

dat.long.1<-subset(dat.long,!is.na(dat.long$factor1))
dat.long.1<-subset(dat.long.1,!is.na(dat.long.1$factor1_baseline))
hist(dat.long.1$factor1)

dat.long.1$factor1_beta<-(dat.long.1$factor1-1)/(10-1)
quantile(dat.long.1$factor1_beta)

dat.long.1$factor1_beta_ex<-(dat.long.1$factor1_beta*(nrow(dat.long.1)-1)+0.5)/nrow(dat.long.1)
quantile(dat.long.1$factor1_beta_ex)
hist(dat.long.1$factor1_beta_ex)

#export to SAS:
#write.csv(dat.long.1,"S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/data_factor1_05122020.csv")


dat.long.2<-subset(dat.long,!is.na(dat.long$factor2))
dat.long.2<-subset(dat.long.2,!is.na(dat.long.2$factor2_baseline))
hist(dat.long.2$factor2)

dat.long.2$factor2_beta<-(dat.long.2$factor2-1)/(10-1)
quantile(dat.long.2$factor2_beta)

dat.long.2$factor2_beta_ex<-(dat.long.2$factor2_beta*(nrow(dat.long.2)-1)+0.5)/nrow(dat.long.2)
quantile(dat.long.2$factor2_beta_ex)
hist(dat.long.2$factor2_beta_ex)

#write.csv(dat.long.2,"S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/data_factor2_05122020.csv")

###Read in LSMeans and create tables:
dat1<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/lsmeans_factor1.csv")
est1<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/estimate_factor1.csv")

dat2<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/lsmeans_factor2.csv")
est2<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Data/estimate_factor2.csv")

#Tables of change:

mod1_inj<-data.frame("Baseline to 2mo"=est1$Adjp[est1$Label=="Injections: baseline to 2mo"],
                     "2mo to 4mo"=est1$Adjp[est1$Label=="Injections: 2mo to 4mo"],
                     "4mo to 6mo"=est1$Adjp[est1$Label=="Injections: 4mo to 6mo"])
mod1_nt<-data.frame("Baseline to 2mo"=est1$Adjp[est1$Label=="Non-Tandem: baseline to 2mo"],
                     "2mo to 4mo"=est1$Adjp[est1$Label=="Non-Tandem: 2mo to 4mo"],
                     "4mo to 6mo"=est1$Adjp[est1$Label=="Non-Tandem: 4mo to 6mo"])
mod1_t<-data.frame("Baseline to 2mo"=est1$Adjp[est1$Label=="Tandem: baseline to 2mo"],
                    "2mo to 4mo"=est1$Adjp[est1$Label=="Tandem: 2mo to 4mo"],
                    "4mo to 6mo"=est1$Adjp[est1$Label=="Tandem: 4mo to 6mo"])
mod1<-rbind(mod1_inj,mod1_nt,mod1_t)
mod1_data<-dat1[,c(3,2,16:18)]
mod1_data$mu_trans<-round(mod1_data$mu_trans,2)
mod1_data$muUpper_trans<-round(mod1_data$muUpper_trans,2)
mod1_data$muLower_trans<-round(mod1_data$muLower_trans,2)

mod2_inj<-data.frame("Baseline to 2mo"=est2$Adjp[est2$Label=="Injections: baseline to 2mo"],
                     "2mo to 4mo"=est2$Adjp[est2$Label=="Injections: 2mo to 4mo"],
                     "4mo to 6mo"=est2$Adjp[est2$Label=="Injections: 4mo to 6mo"])
mod2_nt<-data.frame("Baseline to 2mo"=est2$Adjp[est2$Label=="Non-Tandem: baseline to 2mo"],
                    "2mo to 4mo"=est2$Adjp[est2$Label=="Non-Tandem: 2mo to 4mo"],
                    "4mo to 6mo"=est2$Adjp[est2$Label=="Non-Tandem: 4mo to 6mo"])
mod2_t<-data.frame("Baseline to 2mo"=est2$Adjp[est2$Label=="Tandem: baseline to 2mo"],
                   "2mo to 4mo"=est2$Adjp[est2$Label=="Tandem: 2mo to 4mo"],
                   "4mo to 6mo"=est2$Adjp[est2$Label=="Tandem: 4mo to 6mo"])
mod2<-rbind(mod2_inj,mod2_nt,mod2_t)
mod2_data<-dat2[,c(3,2,16:18)]
mod2_data$mu_trans<-round(mod2_data$mu_trans,2)
mod2_data$muUpper_trans<-round(mod2_data$muUpper_trans,2)
mod2_data$muLower_trans<-round(mod2_data$muLower_trans,2)

#Estimated plots
jpeg("S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Results/DS_model_bw.jpeg",
     height=7,width=5,units = "in",res=300)

plot(c(1,4),c(7,10),type="n",xlab="Time",ylab="Estimated Device Satisfaction (DS) Score",xaxt="n",
     main="")
axis(1,at=c(1,2,3,4),c("Baseline","2mo","4mo","6mo"))
col<-col2rgb(brewer.pal(9, "Greys")[4])

polygon(c(1,2,3,4,4,3,2,1),c(dat1$muLower_trans[dat1$method_cat=="Injections"],
                             rev(dat1$muUpper_trans[dat1$method_cat=="Injections"])),
        col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
        border=NA)

points(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Injections"],pch=19,col=brewer.pal(9, "Greys")[4])
lines(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Injections"],col=brewer.pal(9, "Greys")[4])

col<-col2rgb(brewer.pal(9, "Greys")[6])

polygon(c(1,2,3,4,4,3,2,1),c(dat1$muLower_trans[dat1$method_cat=="Non-Tandem Pump"],
                             rev(dat1$muUpper_trans[dat1$method_cat=="Non-Tandem Pump"])),
        col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
        border=NA)

points(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Non-Tandem Pump"],pch=19,col=brewer.pal(9, "Greys")[6])
lines(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Non-Tandem Pump"],col=brewer.pal(9, "Greys")[6])

col<-col2rgb(brewer.pal(9, "Greys")[9])

polygon(c(1,2,3,4,4,3,2,1),c(dat1$muLower_trans[dat1$method_cat=="Tandem Pump"],
                             rev(dat1$muUpper_trans[dat1$method_cat=="Tandem Pump"])),
        col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
        border=NA)
points(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Tandem Pump"],pch=19,col=brewer.pal(9, "Greys")[9])
lines(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Tandem Pump"],col=brewer.pal(9, "Greys")[9])

legend("bottomright",c("MDI","Non-Tandem Pump","Tandem Pump"),
       lty=1,pch=19,col=c(brewer.pal(9, "Greys")[4],
                          brewer.pal(9, "Greys")[6],
                          brewer.pal(9, "Greys")[9]),title = "Previous Insulin Method")
dev.off()

#########DIABETES BURDEN
jpeg("S:/Shared Projects/Laura/BDC/Projects/Laurel Messer/Tandem/Results/DI_model_bw.jpeg",
     height=7,width=5,units = "in",res=300)

plot(c(1,4),c(1,6),type="n",xlab="Time",ylab="Estimated Diabetes Impact (DI) Score",xaxt="n",
     main="")
axis(1,at=c(1,2,3,4),c("Baseline","2mo","4mo","6mo"))
col<-col2rgb(brewer.pal(9, "Greys")[4])

polygon(c(1,2,3,4,4,3,2,1),c(dat2$muLower_trans[dat2$method_cat=="Injections"],
                             rev(dat2$muUpper_trans[dat2$method_cat=="Injections"])),
        col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
        border=NA)

points(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Injections"],pch=19,col=brewer.pal(9, "Greys")[4])
lines(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Injections"],col=brewer.pal(9, "Greys")[4])

col<-col2rgb(brewer.pal(9, "Greys")[6])

polygon(c(1,2,3,4,4,3,2,1),c(dat2$muLower_trans[dat2$method_cat=="Non-Tandem Pump"],
                             rev(dat2$muUpper_trans[dat2$method_cat=="Non-Tandem Pump"])),
        col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
        border=NA)

points(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Non-Tandem Pump"],pch=19,col=brewer.pal(9, "Greys")[6])
lines(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Non-Tandem Pump"],col=brewer.pal(9, "Greys")[6])

col<-col2rgb(brewer.pal(9, "Greys")[9])

polygon(c(1,2,3,4,4,3,2,1),c(dat2$muLower_trans[dat2$method_cat=="Tandem Pump"],
                             rev(dat2$muUpper_trans[dat2$method_cat=="Tandem Pump"])),
        col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
        border=NA)
points(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Tandem Pump"],pch=19,col=brewer.pal(9, "Greys")[9])
lines(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Tandem Pump"],col=brewer.pal(9, "Greys")[9])

legend("bottomright",c("MDI","Non-Tandem Pump","Tandem Pump"),
       lty=1,pch=19,col=c(brewer.pal(9, "Greys")[4],
                          brewer.pal(9, "Greys")[6],
                          brewer.pal(9, "Greys")[9]),title = "Previous Insulin Method")
dev.off()

###overlaid on boxplots:
# boxplot(dat$baseline_factor1[dat$method_cat=="Injections"],
#         dat$post2m_factor1[dat$method_cat=="Injections"],
#         dat$post4m_factor1[dat$method_cat=="Injections"],
#         dat$post6m_factor1[dat$method_cat=="Injections"],
#         xlab="Time Point",xaxt="n",main="Previous Injections",
#         ylim=c(1,10))
# axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))
# 
# col<-col2rgb(brewer.pal(3, "Set1")[1])
# 
# polygon(c(1,2,3,4,4,3,2,1),c(dat1$muLower_trans[dat1$method_cat=="Injections"],
#                              rev(dat1$muUpper_trans[dat1$method_cat=="Injections"])),
#         col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
#         border=NA)
# 
# points(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Injections"],pch=19,col=brewer.pal(3, "Set1")[1])
# lines(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Injections"],col=brewer.pal(3, "Set1")[1])
# 
# 
# boxplot(dat$baseline_factor1[dat$method_cat=="Non-Tandem Pump"],
#         dat$post2m_factor1[dat$method_cat=="Non-Tandem Pump"],
#         dat$post4m_factor1[dat$method_cat=="Non-Tandem Pump"],
#         dat$post6m_factor1[dat$method_cat=="Non-Tandem Pump"],
#         xlab="Time Point",xaxt="n",main="Previous Non-Tandem pump",
#         ylim=c(1,10))
# axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))
# 
# 
# col<-col2rgb(brewer.pal(3, "Set1")[2])
# 
# polygon(c(1,2,3,4,4,3,2,1),c(dat1$muLower_trans[dat1$method_cat=="Non-Tandem Pump"],
#                              rev(dat1$muUpper_trans[dat1$method_cat=="Non-Tandem Pump"])),
#         col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
#         border=NA)
# 
# points(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Non-Tandem Pump"],pch=19,col=brewer.pal(3, "Set1")[2])
# lines(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Non-Tandem Pump"],col=brewer.pal(3, "Set1")[2])
# 
# 
# boxplot(dat$baseline_factor1[dat$method_cat=="Tandem Pump"],
#         dat$post2m_factor1[dat$method_cat=="Tandem Pump"],
#         dat$post4m_factor1[dat$method_cat=="Tandem Pump"],
#         dat$post6m_factor1[dat$method_cat=="Tandem Pump"],
#         xlab="Time Point",xaxt="n",main="Previous Tandem Pump",
#         ylim=c(1,10))
# axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))
# 
# 
# col<-col2rgb(brewer.pal(3, "Set1")[3])
# 
# polygon(c(1,2,3,4,4,3,2,1),c(dat1$muLower_trans[dat1$method_cat=="Tandem Pump"],
#                              rev(dat1$muUpper_trans[dat1$method_cat=="Tandem Pump"])),
#         col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
#         border=NA)
# points(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Tandem Pump"],pch=19,col=brewer.pal(3, "Set1")[3])
# lines(c(1,2,3,4),dat1$mu_trans[dat1$method_cat=="Tandem Pump"],col=brewer.pal(3, "Set1")[3])
# 
# 
# boxplot(dat$baseline_factor2[dat$method_cat=="Injections"],
#         dat$post2m_factor2[dat$method_cat=="Injections"],
#         dat$post4m_factor2[dat$method_cat=="Injections"],
#         dat$post6m_factor2[dat$method_cat=="Injections"],
#         xlab="Time Point",xaxt="n",main="Previous Injections",
#         ylim=c(1,10))
# axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))
# 
# col<-col2rgb(brewer.pal(3, "Set1")[1])
# 
# polygon(c(1,2,3,4,4,3,2,1),c(dat2$muLower_trans[dat2$method_cat=="Injections"],
#                              rev(dat2$muUpper_trans[dat2$method_cat=="Injections"])),
#         col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
#         border=NA)
# 
# points(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Injections"],pch=19,col=brewer.pal(3, "Set1")[1])
# lines(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Injections"],col=brewer.pal(3, "Set1")[1])
# 
# 
# boxplot(dat$baseline_factor2[dat$method_cat=="Non-Tandem Pump"],
#         dat$post2m_factor2[dat$method_cat=="Non-Tandem Pump"],
#         dat$post4m_factor2[dat$method_cat=="Non-Tandem Pump"],
#         dat$post6m_factor2[dat$method_cat=="Non-Tandem Pump"],
#         xlab="Time Point",xaxt="n",main="Previous Non-Tandem pump",
#         ylim=c(1,10))
# axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))
# 
# col<-col2rgb(brewer.pal(3, "Set1")[2])
# 
# polygon(c(1,2,3,4,4,3,2,1),c(dat2$muLower_trans[dat2$method_cat=="Non-Tandem Pump"],
#                              rev(dat2$muUpper_trans[dat2$method_cat=="Non-Tandem Pump"])),
#         col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
#         border=NA)
# 
# points(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Non-Tandem Pump"],pch=19,col=brewer.pal(3, "Set1")[2])
# lines(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Non-Tandem Pump"],col=brewer.pal(3, "Set1")[2])
# 
# 
# boxplot(dat$baseline_factor2[dat$method_cat=="Tandem Pump"],
#         dat$post2m_factor2[dat$method_cat=="Tandem Pump"],
#         dat$post4m_factor2[dat$method_cat=="Tandem Pump"],
#         dat$post6m_factor2[dat$method_cat=="Tandem Pump"],
#         xlab="Time Point",xaxt="n",main="Previous Tandem Pump",
#         ylim=c(1,10))
# axis(1,at=c(1,2,3,4),labels=c("Baseline","2 Month","4 Month","6 Month"))
# 
# col<-col2rgb(brewer.pal(3, "Set1")[3])
# 
# polygon(c(1,2,3,4,4,3,2,1),c(dat2$muLower_trans[dat2$method_cat=="Tandem Pump"],
#                              rev(dat2$muUpper_trans[dat2$method_cat=="Tandem Pump"])),
#         col=rgb(col[1], col[2], col[3], max = 255, alpha = 125, names = "blue50"),
#         border=NA)
# points(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Tandem Pump"],pch=19,col=brewer.pal(3, "Set1")[3])
# lines(c(1,2,3,4),dat2$mu_trans[dat2$method_cat=="Tandem Pump"],col=brewer.pal(3, "Set1")[3])