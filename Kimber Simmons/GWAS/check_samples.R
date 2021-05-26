setwd("~/Dropbox/Work/Kimber Simmons/GWAS")
# Exclude based on diagnoses
diagnoses = read.csv("./Data_Raw/Table 2 Diagnoses EMY edits.csv")
exclude_samples = unique(diagnoses$Arb_Person_ID)

# Format output
exclude_samples = cbind(rep(0,length(exclude_samples)),paste(exclude_samples,exclude_samples,sep = "_"))
write.table(exclude_samples,file = "./Data_Cleaned/biobank_analysis/imputed/exclude_samples",row.names = F,quote = F,col.names = F)
