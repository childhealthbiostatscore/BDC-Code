setwd("/mnt/c/Users/Tim\ Vigers/Dropbox/Work/Kimber\ Simmons/GWAS/")
# setwd("C:/Users/Tim Vigers/Dropbox/Work/Kimber Simmons/GWAS/")
# Read in and add phenotype to .fam files
# Kimber
redo = read.table("./Data_Cleaned/simplified_analysis/redo.fam")
clinical = read.csv("./Data_Cleaned/clinical.csv")
clinical$Hispanic..0.N..1.Y. = 
  factor(clinical$Hispanic..0.N..1.Y.,labels = c("Non-Hispanic","Hispanic"))
redo$V6 = as.numeric(clinical$Hispanic..0.N..1.Y.[match(gsub(".*_","",redo$V2),clinical$correct_labID)])
write.table(redo,file = "./Data_Cleaned/simplified_analysis/redo.fam",row.names = F,quote = F,col.names = F)
# Biobank 1
biobank1 = read.table("./Data_Cleaned/simplified_analysis/biobank1.fam")
biobank1$V6 = 2
write.table(biobank1,file = "./Data_Cleaned/simplified_analysis/biobank1.fam",row.names = F,quote = F,col.names = F)
# Biobank 2
biobank2 = read.table("./Data_Cleaned/simplified_analysis/biobank2.fam")
clinical = read.csv("./Data_Raw/V2 - Biobank data on Hispanic Patients - Full Genetic Request/Table 1 Patient.csv")
clinical$Ethnicity = factor(clinical$Ethnicity,levels = c("Non-Hispanic","Hispanic"))
biobank2$V6 = as.numeric(clinical$Ethnicity[match(biobank2$V2,clinical$Arb_Person_ID)])
write.table(biobank2,file = "./Data_Cleaned/simplified_analysis/biobank2.fam",row.names = F,quote = F,col.names = F)
