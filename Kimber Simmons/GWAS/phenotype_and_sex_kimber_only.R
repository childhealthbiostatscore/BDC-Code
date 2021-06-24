setwd("~/Dropbox/Work/Kimber Simmons/GWAS")
# Read in and re-write .fam files
fam = read.table("./Data_Cleaned/kimber_only_analysis/imputed/kimber_imputed.fam")
# Sex and race files
clinical = read.csv("./Data_Cleaned/clinical.csv")
# Match
fam$V6 = clinical$Hispanic..0.N..1.Y.[match(sapply(strsplit(fam$V2,"_"),"[[",4),clinical$correct_labID)]+1
fam$V5 = clinical$Gender[match(sapply(strsplit(fam$V2,"_"),"[[",4),clinical$correct_labID)]
fam$V5 = as.numeric(factor(fam$V5,levels = c("M","F")))
# Write
write.table(fam,file = "./Data_Cleaned/kimber_only_analysis/imputed/kimber_imputed.fam",
            row.names = F,quote = F,col.names = F)
