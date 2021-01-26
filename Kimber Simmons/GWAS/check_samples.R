setwd("/media/tim/Work/Kimber Simmons/GWAS")
# Exclude based on diagnoses
diagnoses = read.csv("./Data_Raw/Table 2 Diagnoses EMY edits.csv")
exclude_samples = unique(diagnoses$Arb_Person_ID)
exclude_samples = cbind(exclude_samples,exclude_samples)
write.table(exclude_samples,file = "./Data_Cleaned/plink/exclude_samples",row.names = F,quote = F,col.names = F)
