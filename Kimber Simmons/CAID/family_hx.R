######## Kimber Simmons #########
library(Hmisc)
#pt level data:
dat.pt<-read.csv('S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Data/CAID_PatientLevelRport_V1_07091029_Cleaned.csv')

#Family co-morbitities#
dat.co<-read.csv('S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Data/CAID_FamilyHx_DX_FirstDegreeMem_AllOtherMem_V2_07102019.csv')
dat.co<-subset(dat.co,dat.co$EPICMRN %in% dat.pt$EPICMRN)

#create "other" category:
all_levels<-c(levels(dat.co$DXName),"Other")
dat.co$DXName<-factor(dat.co$DXName,levels=all_levels)
dat.co$DXName[!(dat.co$DXName %in% c("Thyroid Disease","Diabetes type 1",
                                     "Celiac","Rheumatoid Arthritis","Hypothyroidism","Addison's disease","Vitiligo"))]<-"Other"
dat.co$DXName<-factor(dat.co$DXName)
#create "ANY" comorbity dataset (n=1552 unique MRNS)
temp<-(table(dat.co$EPICMRN,dat.co$DXName)>0)*1
co<-data.frame(id=rownames(temp),temp)
colnames(co)<-paste0(colnames(co),"_Any")
co$EPICMRN<-co$id_Any
co<-co[,-1]
#create "1st degree" comorbity dataset (n=652 unique MRNs with 1st degree family member comorbitities)
dat.1<-subset(dat.co,dat.co$Relation=="1stDegreeFamMem")
temp.1<-(table(dat.1$EPICMRN,dat.1$DXName)>0)*1
co.1<-data.frame(id=rownames(temp.1),temp.1)
colnames(co.1)<-paste0(colnames(co.1),"_1stDegree")
co.1$EPICMRN<-co.1$id_1stDegree
co.1<-co.1[,-1]

#create "Other family member" comorbity dataset (n=1309 unique MRNs wiwth other family member comorbitities)
dat.oth<-subset(dat.co,dat.co$Relation=="OtherFamMem")
temp.oth<-(table(dat.oth$EPICMRN,dat.oth$DXName)>0)*1
co.oth<-data.frame(id=rownames(temp.oth),temp.oth)
colnames(co.oth)<-paste0(colnames(co.oth),"_Other")
co.oth$EPICMRN<-co.oth$id_Other
co.oth<-co.oth[,-1]

#merge them all together:
dat.temp<-merge(co,co.1,by="EPICMRN",all.x=T)
dat.c<-merge(dat.temp,co.oth,by="EPICMRN",all.x=T)
dat.c[is.na(dat.c)]<-0

dat.c$num_comorb<-0
dat.c$num_comorb<-rowSums(dat.c[,c(2:9)])
dat.c$num_1st<-0
dat.c$num_1st<-rowSums(dat.c[,c(9:17)])
dat.c$num_other<-0
dat.c$num_other<-rowSums(dat.c[,c(18:25)])

dat.c[,c(2:25)]<-lapply(dat.c[,c(2:25)],factor)
for (i in c(2:25)){
  label(dat.c[,i])<-paste0(colnames(dat.c[i]))
}  

#merge in with full dat.ca:
dat.c.full<-merge(dat.pt,dat.c,by="EPICMRN",all.x=T)
  
