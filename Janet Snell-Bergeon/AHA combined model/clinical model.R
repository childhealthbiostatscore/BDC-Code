library(sas7bdat)
library(glmnet)
library(tidyr)

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
final <- merge(final,pat,by="StudyID",all.x = T, all.y = F)
final <- final[,-1]
final <- final[final$CACprogV3 != "Unknown",]

final$CACprogV3_num <- ifelse(final$CACprogV3=="Progression",1,0)
final$CACprogV3 <- NULL
final$alb_num <- as.factor(ifelse(final$albuminuria %in% c("mac","mic"),1,
                        ifelse(final$albuminuria=="non",0,NA)))
final$albuminuria <- NULL
final$smknum <- as.factor(ifelse(final$smkstatus=="Current",1,
                       ifelse(final$smkstatus %in% c("Former","Never"),0,NA)))
final$smkstatus <- NULL
final$onhypermeds <- as.factor(final$onhypermeds)
final$onlipidmeds <- as.factor(final$onlipidmeds)
final$onstatinmeds <- as.factor(final$onstatinmeds)

write.csv(final,"B:\\Projects\\Janet Snell-Bergeon\\AHA collaborative grant\\Combined predictive model\\clinical data for lasso.csv",row.names = F)

# only complete cases
complete <- drop_na(final)

# LASSO works but CV doesn't
# it used to work until I made some of the variables factors
x <- as.matrix(subset(complete,select=-CACprogV3_num))
glmmod1 <- glmnet(x, y=as.factor(complete$CACprogV3_num), alpha=1, family="binomial")

cv.glmmod <- cv.glmnet(x, y=complete$CACprogV3_num, alpha=1)
best.lambda <- cv.glmmod$lambda.min
glmmod1$lambda==best.lambda
test <- glmmod1$lambda-best.lambda

round(coef(glmmod1,s=best.lambda),4)
