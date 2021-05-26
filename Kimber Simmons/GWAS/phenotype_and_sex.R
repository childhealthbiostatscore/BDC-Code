setwd("~/Dropbox/Work/Kimber Simmons/GWAS")
# Read in and re-write .fam files
fam = read.table("./Data_Cleaned/biobank_analysis/imputed/merged_imputed.fam")
# Original files
kimber = read.table("./Data_Cleaned/biobank_analysis/redo.fam")
biobank1 = read.table("./Data_Cleaned/biobank_analysis/biobank1.fam")
biobank2 = read.table("./Data_Cleaned/biobank_analysis/biobank2.fam")
ref_fam = rbind(kimber,biobank1)
ref_fam = rbind(ref_fam,biobank2)
# Match imputed formating
ref_fam$V2 = paste(ref_fam$V1,ref_fam$V2,sep = "_")
# Kimber's are all cases, biobank1 are all controls, biobank2 has around 20 cases
fam$V6 = ref_fam$V6[match(fam$V2,ref_fam$V2)]
fam$V5 = ref_fam$V5[match(fam$V2,ref_fam$V2)]
# Write
write.table(fam,file = "./Data_Cleaned/biobank_analysis/imputed/merged_imputed.fam",
            row.names = F,quote = F,col.names = F)
