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

dat$ZNT8RW_OrderValue[dat$ZNT8RW_OrderValue=="0-127"]<-0.127
dat$ZNT8RW_OrderValue<-as.numeric(as.character(dat$ZNT8RW_OrderValue))
dat$ZN_pos_neg<-NA
dat$ZN_pos_neg[dat$ZNT8RW_OrderValue>eis$High[eis$X=="ZnT8RW"]]<-"POS"
dat$ZN_pos_neg[dat$ZNT8RW_OrderValue<=eis$High[eis$X=="ZnT8RW"]]<-"NEG"
dat$ZN_pos_neg<-as.factor(dat$ZN_pos_neg)
label(dat$ZN_pos_neg)<-"ZnT8RW Result"

##########OTHER LABS: MEASURED MORE THAN ONCE##########
labs<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Data/CAID_Labs_V4b_07192019_KateEdits_csv.csv")
labs_ref<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Data/CAID_Labs_refranges.csv")

#ONSET DATE & disease dates:
dat.onset<-dat[,c(which(colnames(dat)=="EPICMRN"),
                  which(colnames(dat)=="OnsetDate"),
                  which(colnames(dat)=="ThyroidDisease_DxDate"),
                  which(colnames(dat)=="AddisonsDisease_DxDate"),
                  which(colnames(dat)=="CeliacDisease_DxDate"))]
labs<-merge(labs,dat.onset,by="EPICMRN",all.x=T)
labs$age_years<-as.numeric(as.POSIXct(labs$ResultDate,format="%m/%d/%Y")- as.POSIXct(labs$DOB,format="%m/%d/%Y"))/365

#only keep labs we are interested in:
labs<-subset(labs,labs$LabSubGroupName %in% c("TTG IgA","21-OH","TPO Ab","Thyroglobulin Ab"))

dat.mrns<-unique(dat$EPICMRN)
labs<-subset(labs,labs$EPICMRN %in% dat.mrns)

#remove labs after diagnosis of each disease:
labs$AddisonsDisease_DxDate<-as.POSIXct(labs$AddisonsDisease_DxDate)
labs$CeliacDisease_DxDate<-as.POSIXct(labs$CeliacDisease_DxDate)
labs$ThyroidDisease_DxDate<-as.POSIXct(labs$ThyroidDisease_DxDate)
labs$ResultDate<-as.POSIXct(labs$ResultDate,format="%m/%d/%Y")

labs$after_caid<-0
labs$after_caid[labs$LabSubGroupName=="21-OH" & labs$ResultDate>=labs$AddisonsDisease_DxDate]<-1
labs$after_caid[labs$LabSubGroupName=="TTG IgA" & labs$ResultDate>=labs$CeliacDisease_DxDate]<-1
labs$after_caid[labs$LabSubGroupName=="TPO Ab" & labs$ResultDate>=labs$ThyroidDisease_DxDate]<-1
labs$after_caid[labs$LabSubGroupName=="Thyroglobulin Ab" & labs$ResultDate>=labs$ThyroidDisease_DxDate]<-1
labs<-subset(labs,labs$after_caid==0)
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
labs$ReferenceHigh[labs$ReferenceHigh=="<30"]<-30
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
#use 20 as cut-off ('weak positive' email from Erin on 12/11)
labs$pos_neg[labs$LabSubGroupName=="TTG IgA" & labs$ResultingAgency=="CHCO" &
               labs$OrderValue>20]<-"POS"
labs$pos_neg[labs$LabSubGroupName=="TTG IgA" & labs$ResultingAgency=="CHCO" &
               labs$OrderValue<=20]<-"NEG"
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

# summarize how many pts are positive at any time, and timing of positivity (relative to diabetes onset and CAIDs)
#3/13/2020: add positive/negative around onset (6mo)
labs<-labs[,c(which(colnames(labs)=="EPICMRN"),
              which(colnames(labs)=="OnsetDate"),
              which(colnames(labs)=="ResultDate"),
              which(colnames(labs)=="LabSubGroupName"),
              which(colnames(labs)=="pos_neg"))]
labs$ResultDate<-as.POSIXct(labs$ResultDate,format="%m/%d/%Y")
labs$OnsetDate<-as.POSIXct(labs$OnsetDate,format="%m/%d/%Y")
labs$onset_to_lab<-difftime(labs$ResultDate,labs$OnsetDate,units='days')
# dat.long<-merge(dat,labs,by="EPICMRN",all=T)
# dat.long$years_labs_minus_onset<-as.numeric((dat.long$ResultDate-dat.long$OnsetDate)/60/60/24/365)

by_pt<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(labs,labs$EPICMRN==617672)
    
    ###for each patient and for each lab, calculate pos/neg and timing of pos
    by_lab<-function(ID,data){
      
      temp2<-lapply(unique(ID), function(x){
        
        dat.temp2 <- subset(data, ID == x)
        # dat.temp2<-subset(dat.temp,dat.temp$LabSubGroupName=="TPO Ab")
        dat.temp2<-dat.temp2[order(dat.temp2$ResultDate),]
        
        dat.temp2$lab_row_num<-rep(1:nrow(dat.temp2)) #count of repeat visits per patient
        dat.temp2$lab_num_pos<-nrow(subset(dat.temp2,dat.temp2$pos_neg=="POS"))
        dat.temp2$lab_num_neg<-nrow(subset(dat.temp2,dat.temp2$pos_neg=="NEG"))
        dat.temp2$lab_date_pos<-NA
        dat.temp2$lab_date_pos<-as.POSIXct(dat.temp2$lab_date_pos)
        if (dat.temp2$lab_num_pos[1]>0){
          dat.temp2$lab_date_pos<-dat.temp2$ResultDate[dat.temp2$pos_neg=="POS"][1]
        }
        ###added 3/13: baseline pos/neg:
        closest<-min(abs(dat.temp2$onset_to_lab),na.rm=T)[1]
        dat.temp2$lab_baseline<-NA
        if (is.na(closest)){
          dat.temp2$lab_baseline<-"lab not measured"
        }
        if (closest>=6*30.4167){
          dat.temp2$lab_baseline<-"closest outside of 6mo window"
        }
        if (!is.na(closest) & closest<6*30.4167){
          closest_posneg<-dat.temp2$pos_neg[abs(dat.temp2$onset_to_lab)==closest][1]
          dat.temp2$lab_baseline<-closest_posneg
        }
        dat.temp2
        #print(dat.temp2$MRN)
        #print(dat.temp2$yeargrouping)
        
        dat.temp2})
      
      dat<-do.call(rbind,temp2)
    }
    dat.temp<-by_lab(dat.temp$LabSubGroupName,dat.temp)
    #print(dat.temp$EPICMRN)
    #print(dat.temp$lab_date_pos)
    dat.temp})
  
  dat<-do.call(rbind,temp)
}

labs<-by_pt(labs$EPICMRN,labs)

labs.ttg.all<-subset(labs,labs$LabSubGroupName=="TTG IgA")

labs.one<-subset(labs,labs$lab_row_num==1)

labs.tpo<-subset(labs.one,labs.one$LabSubGroupName=="TPO Ab")
labs.tpo<-labs.tpo[,c(which(colnames(labs.tpo)=="EPICMRN"),
                      which(colnames(labs.tpo)=="pos_neg"),
                      which(colnames(labs.tpo)=="lab_date_pos"),
                      which(colnames(labs.tpo)=="lab_baseline"))]
colnames(labs.tpo)<-c("EPICMRN","pos_tpo","date_tpo","baseline_tpo")

labs.21<-subset(labs.one,labs.one$LabSubGroupName=="21-OH")
labs.21<-labs.21[,c(which(colnames(labs.21)=="EPICMRN"),
                    which(colnames(labs.21)=="pos_neg"),
                    which(colnames(labs.21)=="lab_date_pos"),
                    which(colnames(labs.21)=="lab_baseline"))]
colnames(labs.21)<-c("EPICMRN","pos_21","date_21","baseline_21")

labs.thy<-subset(labs.one,labs.one$LabSubGroupName=="Thyroglobulin Ab")
labs.thy<-labs.thy[,c(which(colnames(labs.thy)=="EPICMRN"),
                      which(colnames(labs.thy)=="pos_neg"),
                      which(colnames(labs.thy)=="lab_date_pos"),
                      which(colnames(labs.thy)=="lab_baseline"))]
colnames(labs.thy)<-c("EPICMRN","pos_thy","date_thy","baseline_thy")

labs.ttg<-subset(labs.one,labs.one$LabSubGroupName=="TTG IgA")
labs.ttg<-labs.ttg[,c(which(colnames(labs.ttg)=="EPICMRN"),
                      which(colnames(labs.ttg)=="pos_neg"),
                      which(colnames(labs.ttg)=="lab_date_pos"),
                      which(colnames(labs.ttg)=="lab_baseline"))]
colnames(labs.ttg)<-c("EPICMRN","pos_ttg","date_ttg","baseline_ttg")

labs.final<-merge(labs.tpo,labs.21,by="EPICMRN",all=T)
labs.final<-merge(labs.final,labs.thy,by="EPICMRN",all=T)
labs.final<-merge(labs.final,labs.ttg,by="EPICMRN",all=T)
labs.final$which<-"labs"

dat<-merge(dat,labs.final,by="EPICMRN",all=T)


####TTG - want more summary stats on number of tests (pos/neg):
ttg_bypt<-function(ID,data){
  
  temp<-lapply(unique(ID), function(x){
    
    dat.temp <- subset(data, ID == x)
    # dat.temp <- subset(labs.ttg.all,labs.ttg.all$EPICMRN==617672)
    
    ###for each patient and for each lab, calculate pos/neg and timing of pos
    dat.temp<-dat.temp[order(dat.temp$ResultDate),]
    dat.temp$num_ttg<-nrow(dat.temp)
    dat.temp$length_testing<-NA
    dat.temp$avg_testing<-NA
    if (dat.temp$num_ttg[1]>=2){
      first<-dat.temp$ResultDate[1]
      last<-dat.temp$ResultDate[dat.temp$lab_row_num==dat.temp$num_ttg]
      dat.temp$length_testing<-difftime(last,first,unit='days')
      dat.temp$avg_testing<-dat.temp$length_testing/dat.temp$num_pos_ttg
    }
    #print(dat.temp$EPICMRN)
    #print(dat.temp$lab_date_pos)
    dat.temp})
  
  dat<-do.call(rbind,temp)
}

labs.ttg<-ttg_bypt(labs.ttg.all$EPICMRN,labs.ttg.all)

labs.ttg<-subset(labs.ttg,labs.ttg$lab_row_num==1)
###########PICK UP HERE WITH TTG: SUMMARIZE THESE VALUES: LAB_NUM_POS, LAB_NUM_NEG, NUM_TTG, LENGTH TESTING, AVG_TESING


dat$months_onset_to_21<-(dat$date_21-dat$OnsetDate)/60/60/24/30.6
dat$timing_21<-NA
dat$timing_21[dat$pos_21=="POS" & dat$months_onset_to_21>0]<-"After Diabetes Onset"
dat$timing_21[dat$pos_21=="POS" & dat$months_onset_to_21<0]<-"Before Diabetes Onset"
dat$timing_21[dat$pos_21=="POS" & dat$months_onset_to_21==0]<-"At Diabetes Onset"
dat$timing_21<-as.factor(dat$timing_21)
label(dat$timing_21)<-"21-OH: timing"

#all addison's disease was after diabetes onset:
#only 3 pts had positive OH-21 and Addison's disease
dat$timing_add_21<-NA
dat$timing_add_21[dat$pos_21=="POS" & dat$addison_yn==1 & 
                    dat$months_onset_to_21>dat$addison_months_if_yes]<-"Onset -> Addison's -> OH-21 POS"
dat$timing_add_21[dat$pos_21=="POS" & dat$addison_yn==1 & 
                    dat$months_onset_to_21<dat$addison_months_if_yes]<-"Onset -> OH-21 POS -> Addison's"
dat$timing_add_21<-as.factor(dat$timing_add_21)
label(dat$timing_add_21)<-"21-OH: timing vs. addison"


dat$months_onset_to_ttg<-(dat$date_ttg-dat$OnsetDate)/60/60/24/30.6
dat$timing_ttg<-NA
dat$timing_ttg[dat$pos_ttg=="POS" & dat$months_onset_to_ttg>0]<-"After Diabetes Onset"
dat$timing_ttg[dat$pos_ttg=="POS" & dat$months_onset_to_ttg<0]<-"Before Diabetes Onset"
dat$timing_ttg[dat$pos_ttg=="POS" & dat$months_onset_to_ttg==0]<-"At Diabetes Onset"
dat$timing_ttg<-as.factor(dat$timing_ttg)
label(dat$timing_ttg)<-"TTG IgA: timing"

dat$timing_cel_ttg<-NA
#scenarios where at least 2 dates are equal:
dat$timing_cel_ttg[dat$OnsetDate==dat$date_ttg & dat$date_ttg==dat$CeliacDisease_DxDate]<-"Onset=TTG=Celiac"
dat$timing_cel_ttg[dat$OnsetDate==dat$date_ttg & dat$date_ttg<dat$CeliacDisease_DxDate]<-"Onset=TTG->Celiac"
dat$timing_cel_ttg[dat$CeliacDisease_DxDate<dat$OnsetDate & dat$OnsetDate==dat$date_ttg]<-"Celiac->Onset=TTG"
dat$timing_cel_ttg[dat$OnsetDate<dat$date_ttg & dat$date_ttg==dat$CeliacDisease_DxDate]<-"Onset->TTG=Celiac"
dat$timing_cel_ttg[dat$date_ttg==dat$CeliacDisease_DxDate & dat$CeliacDisease_DxDate<dat$OnsetDate]<-"TTG=Celiac -> Onset"
dat$timing_cel_ttg[dat$OnsetDate==dat$CeliacDisease_DxDate & dat$CeliacDisease_DxDate<dat$date_ttg]<-"Onset=Celiac -> TTG"
dat$timing_cel_ttg[dat$date_ttg<dat$OnsetDate & dat$OnsetDate==dat$CeliacDisease_DxDate]<-"TTG -> Onset=Celiac"
#scenarios where all dates are different:
dat$timing_cel_ttg[dat$OnsetDate<dat$date_ttg & dat$date_ttg<dat$CeliacDisease_DxDate]<-"Onset -> TTG -> Celiac"
dat$timing_cel_ttg[dat$OnsetDate<dat$CeliacDisease_DxDate & dat$CeliacDisease_DxDate<dat$date_ttg]<-"Onset -> Celiac -> TTG"
dat$timing_cel_ttg[dat$date_ttg<dat$OnsetDate & dat$OnsetDate<dat$CeliacDisease_DxDate]<-"TTG -> Onset -> Celiac"
dat$timing_cel_ttg[dat$date_ttg<dat$CeliacDisease_DxDate & dat$CeliacDisease_DxDate<dat$OnsetDate]<-"TTG -> Celiac -> Onset"
dat$timing_cel_ttg[dat$CeliacDisease_DxDate<dat$OnsetDate & dat$OnsetDate<dat$date_ttg]<-"Celiac -> Onset -> TTG"
dat$timing_cel_ttg[dat$CeliacDisease_DxDate<dat$date_ttg & dat$date_ttg<dat$OnsetDate]<-"Celiac -> TTG -> Onset"
dat$timing_cel_ttg[is.na(dat$celiac_timing)]<-NA
dat$timing_cel_ttg[dat$pos_ttg=="NEG"]<-NA

dat$timing_cel_ttg<-as.factor(dat$timing_cel_ttg)

label(dat$timing_cel_ttg)<-"TTG IgA: timing vs. celiac's"

dat$months_onset_to_tpo<-(dat$date_tpo-dat$OnsetDate)/60/60/24/30.6
dat$timing_tpo<-NA
dat$timing_tpo[dat$pos_tpo=="POS" & dat$months_onset_to_tpo>0]<-"After Diabetes Onset"
dat$timing_tpo[dat$pos_tpo=="POS" & dat$months_onset_to_tpo<0]<-"Before Diabetes Onset"
dat$timing_tpo[dat$pos_tpo=="POS" & dat$months_onset_to_tpo==0]<-"At Diabetes Onset"
dat$timing_tpo<-as.factor(dat$timing_tpo)
label(dat$timing_tpo)<-"TPO Ab: timing"

dat$timing_thy_tpo<-NA
#scenarios where at least 2 dates are equal:
dat$timing_thy_tpo[dat$OnsetDate==dat$date_tpo & dat$date_tpo==dat$ThyroidDisease_DxDate]<-"Onset=TPO=Thyroid"
dat$timing_thy_tpo[dat$OnsetDate==dat$date_tpo & dat$date_tpo<dat$ThyroidDisease_DxDate]<-"Onset=TPO->Thyroid"
dat$timing_thy_tpo[dat$ThyroidDisease_DxDate<dat$OnsetDate & dat$OnsetDate==dat$date_tpo]<-"Thyroid->Onset=TPO"
dat$timing_thy_tpo[dat$OnsetDate<dat$date_tpo & dat$date_tpo==dat$ThyroidDisease_DxDate]<-"Onset->TPO=Thyroid"
dat$timing_thy_tpo[dat$date_tpo==dat$ThyroidDisease_DxDate & dat$ThyroidDisease_DxDate<dat$OnsetDate]<-"TPO=Thyroid -> Onset"
dat$timing_thy_tpo[dat$OnsetDate==dat$ThyroidDisease_DxDate & dat$ThyroidDisease_DxDate<dat$date_tpo]<-"Onset=Thyroid -> TPO"
dat$timing_thy_tpo[dat$date_tpo<dat$OnsetDate & dat$OnsetDate==dat$ThyroidDisease_DxDate]<-"TPO -> Onset=Thyroid"
#scenarios where all dates are different:
dat$timing_thy_tpo[dat$OnsetDate<dat$date_tpo & dat$date_tpo<dat$ThyroidDisease_DxDate]<-"Onset -> TPO -> Thyroid"
dat$timing_thy_tpo[dat$OnsetDate<dat$ThyroidDisease_DxDate & dat$ThyroidDisease_DxDate<dat$date_tpo]<-"Onset -> Thyroid -> TPO"
dat$timing_thy_tpo[dat$date_tpo<dat$OnsetDate & dat$OnsetDate<dat$ThyroidDisease_DxDate]<-"TPO -> Onset -> Thyroid"
dat$timing_thy_tpo[dat$date_tpo<dat$ThyroidDisease_DxDate & dat$ThyroidDisease_DxDate<dat$OnsetDate]<-"TPO -> Thyroid -> Onset"
dat$timing_thy_tpo[dat$ThyroidDisease_DxDate<dat$OnsetDate & dat$OnsetDate<dat$date_tpo]<-"Thyroid -> Onset -> TPO"
dat$timing_thy_tpo[dat$ThyroidDisease_DxDate<dat$date_tpo & dat$date_tpo<dat$OnsetDate]<-"Thyroid -> TPO -> Onset"
dat$timing_thy_tpo[is.na(dat$thyroid_timing)]<-NA
dat$timing_thy_tpo[dat$pos_tpo=="NEG"]<-NA

dat$timing_thy_tpo<-as.factor(dat$timing_thy_tpo)
label(dat$timing_thy_tpo)<-"TPO Ab: Timing vs. Thyroid Disease"

dat$months_onset_to_thy<-(dat$date_thy-dat$OnsetDate)/60/60/24/30.6
dat$timing_thy<-NA
dat$timing_thy[dat$pos_thy=="POS" & dat$months_onset_to_thy>0]<-"After Diabetes Onset"
dat$timing_thy[dat$pos_thy=="POS" & dat$months_onset_to_thy<0]<-"Before Diabetes Onset"
dat$timing_thy[dat$pos_thy=="POS" & dat$months_onset_to_thy==0]<-"At Diabetes Onset"
dat$timing_thy<-as.factor(dat$timing_thy)
label(dat$timing_thy)<-"Thyroglobulin Ab: timing"

dat$timing_thy_thy<-NA
#scenarios where at least 2 dates are equal:
dat$timing_thy_thy[dat$OnsetDate==dat$date_thy & dat$date_thy==dat$ThyroidDisease_DxDate]<-"Onset=Thyroglobulin=Thyroid"
dat$timing_thy_thy[dat$OnsetDate==dat$date_thy & dat$date_thy<dat$ThyroidDisease_DxDate]<-"Onset=Thyroglobulin->Thyroid"
dat$timing_thy_thy[dat$ThyroidDisease_DxDate<dat$OnsetDate & dat$OnsetDate==dat$date_thy]<-"Thyroid->Onset=Thyroglobulin"
dat$timing_thy_thy[dat$OnsetDate<dat$date_thy & dat$date_thy==dat$ThyroidDisease_DxDate]<-"Onset->Thyroglobulin=Thyroid"
dat$timing_thy_thy[dat$date_thy==dat$ThyroidDisease_DxDate & dat$ThyroidDisease_DxDate<dat$OnsetDate]<-"Thyroglobulin=Thyroid -> Onset"
dat$timing_thy_thy[dat$OnsetDate==dat$ThyroidDisease_DxDate & dat$ThyroidDisease_DxDate<dat$date_thy]<-"Onset=Thyroid -> Thyroglobulin"
dat$timing_thy_thy[dat$date_thy<dat$OnsetDate & dat$OnsetDate==dat$ThyroidDisease_DxDate]<-"Thyroglobulin -> Onset=Thyroid"
#scenarios where all dates are different:
dat$timing_thy_thy[dat$OnsetDate<dat$date_thy & dat$date_thy<dat$ThyroidDisease_DxDate]<-"Onset -> Thyroglobulin -> Thyroid"
dat$timing_thy_thy[dat$OnsetDate<dat$ThyroidDisease_DxDate & dat$ThyroidDisease_DxDate<dat$date_thy]<-"Onset -> Thyroid -> Thyroglobulin"
dat$timing_thy_thy[dat$date_thy<dat$OnsetDate & dat$OnsetDate<dat$ThyroidDisease_DxDate]<-"Thyroglobulin -> Onset -> Thyroid"
dat$timing_thy_thy[dat$date_thy<dat$ThyroidDisease_DxDate & dat$ThyroidDisease_DxDate<dat$OnsetDate]<-"Thyroglobulin -> Thyroid -> Onset"
dat$timing_thy_thy[dat$ThyroidDisease_DxDate<dat$OnsetDate & dat$OnsetDate<dat$date_thy]<-"Thyroid -> Onset -> Thyroglobulin"
dat$timing_thy_thy[dat$ThyroidDisease_DxDate<dat$date_thy & dat$date_thy<dat$OnsetDate]<-"Thyroid -> Thyroglobulin -> Onset"
dat$timing_thy_thy[is.na(dat$thyroid_timing)]<-NA
dat$timing_thy_thy[dat$pos_thy=="NEG"]<-NA

dat$timing_thy_thy<-as.factor(dat$timing_thy_thy)
label(dat$timing_thy_thy)<-"Thyroglobulin Ab: Timing vs. Thyroid Disease"

# dat$timing_21[dat$pos_21=="POS" & dat$addison_yn==1 & dat$months_onset_to_21>dat$addison_months_if_yes]<-"After Addison Dx"
# dat$timing_21[dat$pos_21=="POS" & dat$addison_yn==1 & dat$months_onset_to_21<dat$addison_months_if_yes
#               & ]<-"Before Addison Dx"
# dat$timing_21[dat$pos_21=="POS" & dat$addison_yn==1 & dat$years_onset_to_21==dat$addison_months_if_yes]<-"At Addison Dx"
dat$pos_21[is.na(dat$pos_21)]<-"never tested"
dat$pos_thy[is.na(dat$pos_thy)]<-"never tested"
dat$pos_tpo[is.na(dat$pos_tpo)]<-"never tested"
dat$pos_ttg[is.na(dat$pos_ttg)]<-"never tested"

dat$pos_21<-as.factor(dat$pos_21)
dat$pos_thy<-as.factor(dat$pos_thy)
dat$pos_tpo<-as.factor(dat$pos_tpo)
dat$pos_ttg<-as.factor(dat$pos_ttg)

label(dat$pos_21)<-"21-OH: Ever Positive"
label(dat$pos_thy)<-"Thyroglobulin Ab: Ever Positive"
label(dat$pos_tpo)<-"TPO Ab: Ever Positive"
label(dat$pos_ttg)<-"TTG IgA: Ever Positive"

dat$baseline_21[is.na(dat$baseline_21)]<-"never tested"
dat$baseline_thy[is.na(dat$baseline_thy)]<-"never tested"
dat$baseline_tpo[is.na(dat$baseline_tpo)]<-"never tested"
dat$baseline_ttg[is.na(dat$baseline_ttg)]<-"never tested"

label(dat$baseline_21)<-"21-OH: Baseline Positive"
label(dat$baseline_thy)<-"Thyroglobulin Ab: Baseline Positive"
label(dat$baseline_tpo)<-"TPO Ab: Baseline Positive"
label(dat$baseline_ttg)<-"TTG IgA: Baseline Positive"


