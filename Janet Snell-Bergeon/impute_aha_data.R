library(tidyverse)
library(caret)
library(mice)
setwd("~/UCD/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects")
#setwd("/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects")
load("./Janet Snell-Bergeon/AHA collaborative grant/aha_master_data.Rdata")
# Make new variables
df$smknum = as.numeric(!(df$SmkStatusV1 == "Former" | df$SmkStatusV1 == "Never"))
df$SmkPackYrsV1[df$SmkStatusV1 == "Former" | df$SmkStatusV1 == "Never"] = 0
df$smknum = df$smknum * df$SmkPackYrsV1
df$duration_cat = cut(df$durationV1,breaks = c(-Inf,23,Inf),right = F)
# Columns from Laura's model
columns_from_laura = c(snps,"gly_P02671.7","gly_P02671.5",
                       "gly_P02671.4","gly_P02671.3","AAA01201000179.0807263.4",
                       "gly_P02679","HMDB00510161.0696402.9",
                       "AAA01201000179.0809235.7","gly_P02675.4","gly_P02675",
                       "gly_P02647","P02655","gly_P02647.1",
                       "HMDB00510161.0694436","gly_P02652","gly_P01009",
                       "gly_P01834.11","P01817","AcCa 10:3",
                       "HMDB0028822260.1378628.6","AAA01201000179.0807263.4",
                       "gly_P02671.3","gly_P02671.7","age", "onhypermedsV1",
                       "onlipidmedsV1", "ldlV1", "smknum","SmkStatusV1","race","cholV1", 
                       "duration_cat")
outcomes = c("CACanyV1")
# Log transform some
to_transform = c("bmiV1","avediabpV1","hdlcV1","CKDepiV1","acV1",
                 "insdoseperkgV1","hba1cV1")
log_transformed = paste0("l.",sub("V1","",to_transform))
df[,log_transformed] = log(df[,to_transform])
df[,to_transform] = NULL
# Remove duplicates
df = df[!df$StudyID %in% df$StudyID[duplicated(df$StudyID)],]
# Rename columns - mice has trouble with spaces
columns_from_laura = gsub(" |[[:punct:]]","_",columns_from_laura)
colnames(df) = gsub(" |[[:punct:]]","_",colnames(df))
# Remove variables no variance for imputation model
exclude = c("StudyID",snps,colnames(df)[nearZeroVar(df)])
exclude = unique(exclude)
t = df %>% select(-all_of(exclude))
# Impute
imputed_aha = mice(t,m = 10,method = "cart",printFlag = F,seed = 1017)
# Reassemble
imputed_aha = cbind(imputed_aha,df[,c(exclude,outcomes)])
# Filter to SNPs only
imputed_aha = filter(imputed_aha,!is.na(rs10949670))
# Write
save(imputed_aha,file = "./Janet Snell-Bergeon/AHA collaborative grant/aha_imputed_data.Rdata")
