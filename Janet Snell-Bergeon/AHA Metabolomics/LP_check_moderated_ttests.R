
library(readxl)
# load NormalizeMets first, metabolomics second
library(NormalizeMets)
#library(metabolomics)
library(pca3d)
library(pcaMethods)
library(ggplot2)
library(rgl)
library(stringr)
library(data.table)
library(dplyr)
library(mixOmics)
library(Hmisc)
library("FactoMineR")
library("factoextra")
library(tableone)
library(reshape2)
library(corrplot)
library(car)

# read data
data <- read.csv("T:\\Janet Snell-Bergeon\\AHA collaborative grant\\Metabolomics\\Data_Cleaned\\aha_metabolomics_LP_check.csv")

# metabolite
metabolite <- colnames(data)
metabolite <- as.data.frame(metabolite[8:374])
names(metabolite) <- "Comp.ID"
row.names(metabolite) <- metabolite$Comp.ID

# feature data
pptvars <- c("age","sex","race","CACp","group","batch")
featuredata <- subset(data, select = -c(age,sex,race,CACp,GROUP,batch))
row.names(featuredata) <- featuredata$GlobalSampleID
featuredata$GlobalSampleID <- NULL

# sampledata
sampledata <- subset(data, select = c(GlobalSampleID,age,sex,race,CACp,GROUP,batch))
row.names(sampledata) <- sampledata$GlobalSampleID
sampledata$GlobalSampleID <- NULL
sampledata$CACp_cat <- ifelse(sampledata$CACp=="No Progression",0,1)
sampledata$CACp_contrast1 <- ifelse(sampledata$CACp=="No Progression",-1,1)
sampledata$CACp_contrast2 <- cbind(rep(1,nrow(sampledata)),sampledata$CACp_cat)

# combine 3 dataframes
alldata <- list(featuredata=featuredata,sampledata=sampledata,metabolitedata=metabolite)

# regular lm function
p <- NULL
for (i in 8:374) {
  temp <- lm(data[,i] ~ data$GROUP, data=data)
  p <- c(p,summary(temp)$coefficients[2,4])
}
p <- sort(p)
length(p[p<0.05])
padj <- p.adjust(p)

# regular lm function
p_cac <- NULL
for (i in 8:374) {
  temp <- lm(data[,i] ~ data$CACp, data=data)
  p_cac <- c(p_cac,summary(temp)$coefficients[2,4])
}
p_cac <- sort(p_cac)
length(p_cac[p_cac<0.05])
p_cacadj <- p.adjust(p_cac)

#Linear model fit with moderated statistics
# DESIGN MATRIX IS WRONG
modFit<-LinearModelFit(featuredata=alldata$featuredata,
                       ruv2=FALSE,
                       moderated=TRUE,
                       factormat=alldata$sampledata$GROUP,
                       outputname = "T:\\Janet Snell-Bergeon\\AHA collaborative grant\\Metabolomics\\Data_Cleaned\\modFit_group",
                       saveoutput = TRUE)

#Linear model fit with regular statistics
# DESIGN MATRIX IS WRONG
modFit<-LinearModelFit(featuredata=alldata$featuredata,
                       ruv2=FALSE,
                       moderated=FALSE,
                       factormat=alldata$sampledata$GROUP,
                       outputname = "T:\\Janet Snell-Bergeon\\AHA collaborative grant\\Metabolomics\\Data_Cleaned\\lmFit_group",
                       saveoutput = TRUE)

#Linear model fit with moderated statistics
modFit<-LinearModelFit(featuredata=alldata$featuredata,
                       ruv2=FALSE,
                       moderated=TRUE,
                       factormat=alldata$sampledata$CACp_cat,
                       outputname = "T:\\Janet Snell-Bergeon\\AHA collaborative grant\\Metabolomics\\Data_Cleaned\\modFit_CACp",
                       saveoutput = TRUE)

#Linear model fit with regular statistics
modFit<-LinearModelFit(featuredata=alldata$featuredata,
                       ruv2=FALSE,
                       moderated=FALSE,
                       factormat=alldata$sampledata$CACp_cat,
                       outputname = "T:\\Janet Snell-Bergeon\\AHA collaborative grant\\Metabolomics\\Data_Cleaned\\lmFit_CACp",
                       saveoutput = TRUE)

#Linear model fit with moderated statistics
modFit<-LinearModelFit(featuredata=alldata$featuredata,
                       ruv2=FALSE,
                       moderated=TRUE,
                       factormat=alldata$sampledata$CACp_contrast2,
                       outputname = "T:\\Janet Snell-Bergeon\\AHA collaborative grant\\Metabolomics\\Data_Cleaned\\modFit_CACp_contrast",
                       saveoutput = TRUE)

#Linear model fit with regular statistics
modFit<-LinearModelFit(featuredata=alldata$featuredata,
                       ruv2=FALSE,
                       moderated=FALSE,
                       factormat=alldata$sampledata$CACp_contrast2,
                       outputname = "T:\\Janet Snell-Bergeon\\AHA collaborative grant\\Metabolomics\\Data_Cleaned\\lmFit_CACp_contrast",
                       saveoutput = TRUE)

#Linear model fit with moderated statistics
modFit<-LinearModelFit(featuredata=alldata$featuredata,
                       ruv2=FALSE,
                       moderated=TRUE,
                       factormat=alldata$sampledata$CACp_contrast1,
                       outputname = "C:\\temp\\modFit_CACp_contrast",
                       saveoutput = TRUE)

#Linear model fit with regular statistics
modFit<-LinearModelFit(featuredata=alldata$featuredata,
                       ruv2=FALSE,
                       moderated=FALSE,
                       factormat=alldata$sampledata$CACp_contrast1,
                       outputname = "C:\\temp\\lmFit_CACp_contrast",
                       saveoutput = TRUE)
