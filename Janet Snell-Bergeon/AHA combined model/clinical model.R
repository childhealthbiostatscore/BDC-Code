library(sas7bdat)

allvisits_long <- read.sas7bdat("Y:\\CACTI\\Analysis of Data\\SAS Datasets\\Core Datasets\\Longitudinal\\allvisits_long.sas7bdat")
v1 <- allvisits_long[allvisits_long$Visit==1,]
v1 <- v1[,c("StudyID","age","duration","bmi","whr","onhypermeds","onlipidmeds","onstatinmeds","avediabp","avesystbp","smkstatus","ldl","hdlc","tri",
            "CKDepi","ac","albuminuria","insdoseperkg","hba1c","l45vsf","l45sqf","egdr","apob","crp","fib","homo","pai1","eis")]

cac <- read.csv("B:\\Projects\\Janet Snell-Bergeon\\AHA collaborative grant\\Proteomics\\Data_Cleaned\\cac_groups.csv")
cac$CACprogV3 <- ifelse(cac$C3 - cac$C1 >= 2.5,"Progression","No Progression")
cac$CACprogV3[is.na(cac$CACprogV3)] <- "Unknown"
cac <- cac[,c("StudyID","CACprogV3")]

final <- merge(cac,v1,by="StudyID",all.x = T, all.y = T)

ua <- read.sas7bdat("Y:\\CACTI\\Analysis of Data\\SAS Datasets\\uricacid_b.sas7bdat")
ua <- ua[,c("StudyID","UA")]
final <- merge(final,ua,by="StudyID",all.x = T, all.y = F)
  
pat <- read.sas7bdat("Y:\\CACTI\\Analysis of Data\\SAS Datasets\\PAT V1-V3\\PATwide.sas7bdat")
pat$StudyID <- pat$STUDYID
pat <- pat[,c("StudyID","pfatcm_v1")]
final <- merge(final,ua,by="StudyID",all.x = T, all.y = F)
final <- final[,-1]
final <- final[final$CACprogV3 != "Unknown",]

write.csv(final,"B:\\Projects\\Janet Snell-Bergeon\\AHA collaborative grant\\Combined predictive model\\clinical data for lasso.csv",row.names = F)
