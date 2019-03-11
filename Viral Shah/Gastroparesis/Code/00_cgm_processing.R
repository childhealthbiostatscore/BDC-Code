######Processing CGM Files:

#Tim's package:
#install.packages('cgmanalysis')
library(cgmanalysis)
setwd("S:/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data/Final CGM/")
###can't calculate CONGA, so read in special function:
source("S:/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Code/cgmvariables_no_CONGA.R")
#create summarized datasets:
##months -3 to 0
cgmvariables("S:/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data/Cleaned CGM CSV/month_-3_0/",
             outputdirectory = "S:/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data/Final CGM/",
             outputname = "month_-3_0",
             aboveexcursionlength = 35,
             belowexcursionlength = 10,
             magedef = "1sd",
             congan = 1,
             daystart = 6,
             dayend = 22,
             format = "rows")

##months 0 to 3
cgmvariables("S:/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data/Cleaned CGM CSV/month_0_3/",
             outputdirectory = "S:/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data/Final CGM/",
             outputname = "month_0_3",
             aboveexcursionlength = 35,
             belowexcursionlength = 10,
             magedef = "1sd",
             congan = 1,
             daystart = 6,
             dayend = 22,
             format = "rows")

##months 3 to 6
cgmvariables("S:/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data/Cleaned CGM CSV/month_3_6/",
             outputdirectory = "S:/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data/Final CGM/",
             outputname = "month_3_6",
             aboveexcursionlength = 35,
             belowexcursionlength = 10,
             magedef = "1sd",
             congan = 1,
             daystart = 6,
             dayend = 22,
             format = "rows")

#merge everything together:
dat_1<-read.csv("month_-3_0.csv")
dat_2<-read.csv("month_0_3.csv")
dat_3<-read.csv("month_3_6.csv")

colnames(dat_1)<-paste0(colnames(dat_1),"_1")
colnames(dat_2)<-paste0(colnames(dat_2),"_2")
colnames(dat_3)<-paste0(colnames(dat_3),"_3")

##create matching subject ids:
dat_1$subject_id<-substr(dat_1$subject_id_1,1,2)
dat_2$subject_id<-substr(dat_2$subject_id_2,1,2)
dat_3$subject_id<-substr(dat_3$subject_id_3,1,2)

dat<-merge(dat_1,dat_2,by="subject_id")

dat_cgm<-merge(dat,dat_3,by="subject_id")
write.csv(dat_cgm,"cgm_final.csv")
