library(data.table)
setwd("~/Documents/Work/")
delete_cols = c("PHENO1","ALLELE_CT","NAMED_ALLELE_DOSAGE_SUM")
# Import
redo = read.table("Kimber Simmons/GWAS/Data_Cleaned/harmonized_analysis/redo.sscore",
                  comment.char = "",header = T)
redo[,delete_cols] = NULL
colnames(redo) = sub("_AVG","",colnames(redo))
biobank1 = read.table("Kimber Simmons/GWAS/Data_Cleaned/harmonized_analysis/biobank1.sscore",
                  comment.char = "",header = T)
biobank1[,delete_cols] = NULL
colnames(biobank1) = sub("_AVG","",colnames(biobank1))
biobank2 = read.table("Kimber Simmons/GWAS/Data_Cleaned/harmonized_analysis/biobank2.sscore",
                  comment.char = "",header = T)
biobank2[,delete_cols] = NULL
colnames(biobank2) = sub("_AVG","",colnames(biobank2))
ref = read.table("./GWAS/TGP/QC/ref_pcs.eigenvec",
                 comment.char = "",header = T)
# Combine
all_pcs = rbindlist(list(redo,biobank1,biobank2,ref))
# Write
write.table(all_pcs,"Kimber Simmons/GWAS/Data_Cleaned/harmonized_analysis/all_pcs",quote = F,row.names = F,col.names = F)
