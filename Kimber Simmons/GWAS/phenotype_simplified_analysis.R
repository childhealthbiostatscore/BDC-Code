setwd("/mnt/c/Users/Tim\ Vigers/Dropbox/Work/Kimber\ Simmons/GWAS/")
# Read in and re-write .fam files
redo = read.table("./Data_Cleaned/simplified_analysis/redo.fam")
clinical = read.csv("./Data_Cleaned/clinical.csv")
clinical$Hispanic..0.N..1.Y. = 
  factor(clinical$Hispanic..0.N..1.Y.,labels = c("Non-Hispanic","Hispanic"))

redo$V6 = as.numeric(clinical$Hispanic..0.N..1.Y.[match(gsub(".*_","",redo$V2),clinical$correct_labID)])
write.table(redo,file = "./Data_Cleaned/simplified_analysis/redo.fam",row.names = F,quote = F,col.names = F)