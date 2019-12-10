#########LABS##########
source("C:/Users/campbkri/Documents/GitHub/BDC-Code/Kimber Simmons/CAID/data_prep.R")
#1. Eisenbarth labs:

#located in the patient level report, only measured once per pt
#reference ranges:
eis<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Data/Eisenbarth Reference Ranges.csv")

dat$MIAA_pos_neg<-NA
dat$MIAA_pos_neg[dat$MIAA_OrderValue>eis$High[eis$X=="MIAA"]]<-"POS"
dat$MIAA_pos_neg[dat$MIAA_OrderValue<=eis$High[eis$X=="MIAA"]]<-"NEG"
dat$MIAA_pos_neg<-as.factor(dat$MIAA_pos_neg)
label(dat$MIAA_pos_neg)<-"MIAA Result"

dat$GADA_OrderValue[dat$GADA_OrderValue=="error"]<-NA
dat$GADA_OrderValue[dat$GADA_OrderValue==">30.0"]<-30 #cut-off for pos/neg is 20
dat$GADA_OrderValue<-as.numeric(as.character(dat$GADA_OrderValue))
dat$GADA_pos_neg<-NA
dat$GADA_pos_neg[dat$GADA_OrderValue>eis$High[eis$X=="GADA"]]<-"POS"
dat$GADA_pos_neg[dat$GADA_OrderValue<=eis$High[eis$X=="GADA"]]<-"NEG"
dat$GADA_pos_neg<-as.factor(dat$GADA_pos_neg)
label(dat$GADA_pos_neg)<-"GADA Result"

dat$IA2_OrderValue[dat$IA2_OrderValue=="IN-PROCESS"]<-NA
dat$IA2_OrderValue<-as.numeric(as.character(dat$IA2_OrderValue))
dat$IA2_pos_neg<-NA
dat$IA2_pos_neg[dat$IA2_OrderValue>eis$High[eis$X=="IA-2"]]<-"POS"
dat$IA2_pos_neg[dat$IA2_OrderValue<=eis$High[eis$X=="IA-2"]]<-"NEG"
dat$IA2_pos_neg<-as.factor(dat$IA2_pos_neg)
label(dat$IA2_pos_neg)<-"IA-2 Result"

dat$ZNT8RW_OrderValue[dat$ZNT8RW_OrderValue=="0-127"]<-NA
dat$ZNT8RW_OrderValue<-as.numeric(as.character(dat$ZNT8RW_OrderValue))
dat$ZN_pos_neg<-NA
dat$ZN_pos_neg[dat$ZNT8RW_OrderValue>eis$High[eis$X=="ZnT8RW"]]<-"POS"
dat$ZN_pos_neg[dat$ZNT8RW_OrderValue<=eis$High[eis$X=="ZnT8RW"]]<-"NEG"
dat$ZN_pos_neg<-as.factor(dat$ZN_pos_neg)
label(dat$ZN_pos_neg)<-"ZnT8RW Result"

##########OTHER LABS: MEASURED MORE THAN ONCE##########
labs<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Data/CAID_Labs_V4b_07192019_KateEdits_csv.csv")
labs_ref<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Data/CAID_Labs_refranges.csv")

labs$age_years<-as.numeric(as.POSIXct(labs$ResultDate,format="%m/%d/%Y")- as.POSIXct(labs$DOB,format="%m/%d/%Y"))/365

#only keep labs we are interested in:
labs<-subset(labs,labs$LabSubGroupName %in% c("TTG IgA","21-OH","TPO Ab","Thyroglobulin Ab"))
#options(max.print=999999)
#Convert OrderValue into a numeric:
#a.if "<" in the order value, it's negative. if ">" is in orderval, then positive
#search for those < and >, change ordervalue to 0 for now
labs$lessthan<-0
labs$lessthan[grepl("<",labs$OrderValue)]<-1
labs$greaterthan<-0
labs$greaterthan[grepl(">",labs$OrderValue)]<-1
labs$OrderValue[labs$lessthan==1]<-NA
labs$OrderValue[labs$greaterthan==1]<-NA
#b. deal with characters:
labs$auto_pos<-0
labs$auto_pos[labs$OrderValue %in% c("GREATER THAN 100","GREATER THAN 100.0","GREATER THAN 30.0",
                                       "GREATER THAN 499.00","GREATER THAN 500.00","GREATER THAN 550.0",
                                       "POSITIVE","Positive","WEAK POSITIVE")]<-1
labs$OrderValue[labs$auto_pos==1]<-NA
labs$auto_neg<-0
labs$auto_neg[labs$OrderValue %in% c("LESS THAN 0.01","LESS THAN 1.0","LESS THAN 1.9",
                                     "LESS THAN 5.0","Negative","NEGATIVE",
                                     "No deficiency")]<-1
labs$OrderValue[labs$auto_neg==1]<-NA
labs$OrderValue<-factor(labs$OrderValue)
labs$OrderValue<-as.numeric(as.character(labs$OrderValue))

#POS/NEG Variable:
labs$pos_neg<-NA
labs$pos_neg[labs$lessthan==1]<-"NEG"
labs$pos_neg[labs$greaterthan==1]<-"POS"
labs$pos_neg[labs$auto_pos==1]<-"POS"
labs$pos_neg[labs$auto_neg==1]<-"NEG"

#use reference ranges if available:
labs$ReferenceHigh[labs$ReferenceHigh=="NULL"]<-NA
labs$ReferenceHigh[labs$ReferenceHigh=="Deficiency"]<-NA #check with kate
labs$ReferenceHigh[labs$ReferenceHigh=="<30"]<-30 #check with kate
labs$ReferenceHigh[labs$ReferenceHigh==">=15"]<-15
labs$ReferenceHigh[labs$ReferenceHigh==">=15.0"]<-15
labs$ReferenceHigh[labs$ReferenceHigh==">10"]<-10
labs$ReferenceHigh[labs$ReferenceHigh==">10.0"]<-10
labs$ReferenceHigh[labs$ReferenceHigh==">60"]<-60
labs$ReferenceHigh<-factor(labs$ReferenceHigh)
labs$ReferenceHigh<-as.numeric(as.character(labs$ReferenceHigh))

labs$pos_neg[labs$OrderValue>labs$ReferenceHigh]<-"POS"
labs$pos_neg[labs$OrderValue<=labs$ReferenceHigh]<-"NEG"

#for null reference ranges, merge in reference sheet:
labs$ResultingAgency[labs$ResultingAgency=="CHCO Main Lab"]<-"CHCO"
labs$ResultingAgency[labs$ResultingAgency=="CHCO POINT OF CARE TESTING"]<-"CHCO"
labs$ResultingAgency[labs$ResultingAgency=="CHCO SOUTH"]<-"CHCO"
labs$ResultingAgency[labs$ResultingAgency=="CHILDRENS COLORADO LABORATORY - BRIARGATE"]<-"CHCO"
labs$ResultingAgency[labs$ResultingAgency=="CHILDRENS HOSPITAL COLORADO LABORATORY"]<-"CHCO"
labs$ResultingAgency[labs$ResultingAgency=="CHILDRENS HOSPITAL COLORADO LABORATORY - SOUTH CAMPUS"]<-"CHCO"
labs$ResultingAgency[labs$ResultingAgency=="LabCorp-Denver"]<-"LABCORP - DENVER"
labs$ResultingAgency[labs$ResultingAgency=="QUEST"]<-"QUEST DIAGNOSTICS"

# labs<-merge(labs,labs_ref,by=c("LabSubGroupName","ResultingAgency"),all=T)
# 
# missing_refs<-subset(labs,is.na(labs$ReferenceHigh) & is.na(labs$ReferenceHigh_new) & is.na(labs$pos_neg))
# missing_refs<-missing_refs[!duplicated(missing_refs[,c(1,2)]),]
#manual from missing_refs:
labs$pos_neg[labs$EPICMRN==1608512 & labs$LabSubGroupName=="TPO Ab" & labs$OrderValue==414]<-"POS"
labs$pos_neg[labs$EPICMRN==1190282 & labs$LabSubGroupName=="TTG IgA" & labs$OrderValue==1]<-"NEG"

####INDIVIDUAL LABS TYPES, USING REFERENCE RANGES SHEET:
#Thyroglobulin Ab:
labs$pos_neg[labs$LabSubGroupName=="Thyroglobulin Ab" & labs$ResultingAgency=="CHCO" &
               labs$OrderValue>1.8]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="Thyroglobulin Ab" & labs$ResultingAgency=="CHCO" &
               labs$OrderValue<=1.8]<-"NEG"
labs$pos_neg[labs$LabSubGroupName=="Thyroglobulin Ab" & labs$ResultingAgency=="MAYO MEDICAL LABORATORIES" &
               labs$OrderValue>4]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="Thyroglobulin Ab" & labs$ResultingAgency=="MAYO MEDICAL LABORATORIES" &
               labs$OrderValue<=4]<-"NEG"
labs$pos_neg[labs$LabSubGroupName=="Thyroglobulin Ab" & labs$ResultingAgency=="QUEST DIAGNOSTICS" &
               labs$OrderValue>1]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="Thyroglobulin Ab" & labs$ResultingAgency=="QUEST DIAGNOSTICS" &
               labs$OrderValue<=1]<-"NEG"
#21-OH:
labs$pos_neg[labs$LabSubGroupName=="21-OH" & labs$ResultingAgency=="CHCO" &
               labs$OrderValue>0.5]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="21-OH" & labs$ResultingAgency=="CHCO" &
               labs$OrderValue<=0.5]<-"NEG"
labs$pos_neg[labs$LabSubGroupName=="21-OH" & labs$ResultingAgency=="LABCORP - DENVER" &
               labs$OrderValue>1]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="21-OH" & labs$ResultingAgency=="LABCORP - DENVER" &
               labs$OrderValue<=1]<-"NEG"
labs$pos_neg[labs$LabSubGroupName=="21-OH" & labs$ResultingAgency=="MAYO MEDICAL LABORATORIES" &
               labs$OrderValue>1]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="21-OH" & labs$ResultingAgency=="MAYO MEDICAL LABORATORIES" &
               labs$OrderValue<=1]<-"NEG"

#TTG IgA:

######need to check with kate on this one
labs$pos_neg[labs$LabSubGroupName=="TTG IgA" & labs$ResultingAgency=="CHCO" &
               labs$OrderValue>30]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TTG IgA" & labs$ResultingAgency=="CHCO" &
               labs$OrderValue<=30]<-"NEG"
######end check
labs$pos_neg[labs$LabSubGroupName=="TTG IgA" & labs$ResultingAgency=="LABCORP - DENVER" &
               labs$OrderValue>3]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TTG IgA" & labs$ResultingAgency=="LABCORP - DENVER" &
               labs$OrderValue<=3]<-"NEG"
labs$pos_neg[labs$LabSubGroupName=="TTG IgA" & labs$ResultingAgency=="QUEST DIAGNOSTICS" &
               labs$OrderValue>4]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TTG IgA" & labs$ResultingAgency=="QUEST DIAGNOSTICS" &
               labs$OrderValue<=4]<-"NEG"

#TPO Ab:
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="CHCO"  &
               labs$OrderValue>9]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="CHCO"  &
               labs$OrderValue<=9]<-"NEG"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="QUEST DIAGNOSTICS"  &
               labs$OrderValue>9]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="QUEST DIAGNOSTICS"  &
               labs$OrderValue<=9]<-"NEG"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="ESOTERIX LABORATORY SERVICES, INC"  &
               labs$OrderValue>9]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="ESOTERIX LABORATORY SERVICES, INC"  &
               labs$OrderValue<=9]<-"NEG"
#this one depends on age:
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="LABCORP - DENVER" & labs$age_years>0.916666667 & labs$age_years<=5 &
               labs$OrderValue>13]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="LABCORP - DENVER" & labs$age_years>0.916666667 & labs$age_years<=5 &
               labs$OrderValue<=13]<-"NEG"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="LABCORP - DENVER" & labs$age_years>5 & labs$age_years<=10 &
               labs$OrderValue>18]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="LABCORP - DENVER" & labs$age_years>5 & labs$age_years<=10 &
               labs$OrderValue<=18]<-"NEG"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="LABCORP - DENVER" & labs$age_years>10 & labs$age_years<=19 &
               labs$OrderValue>26]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="LABCORP - DENVER" & labs$age_years>10 & labs$age_years<=19 &
               labs$OrderValue<=26]<-"NEG"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="LABCORP - DENVER" & labs$age_years>19 & 
               labs$OrderValue>34]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TPO Ab" & labs$ResultingAgency=="LABCORP - DENVER" & labs$age_years>19 & 
               labs$OrderValue<=34]<-"NEG"

#TODO: summarize how many pts are positive at any time, and timing of positivity (relative to diabetes onset and CAIDs)
