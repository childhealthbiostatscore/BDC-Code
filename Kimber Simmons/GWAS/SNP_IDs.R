library(biomaRt)
# Import
snps = read.csv("~/Dropbox/Work/Kimber Simmons/GWAS/Data_Cleaned/Variants in any T1D GRS.csv")
# Ensembl
snp_mart = useMart(biomart="ENSEMBL_MART_SNP",host="grch37.ensembl.org",dataset="hsapiens_snp")
locations <- getBM(attributes = c('refsnp_id','chr_name','chrom_start'), filters = c('snp_filter'), 
                   values = snps$SNP, mart = snp_mart)
# Import .bim
bim = read.delim("/Users/timvigers/Dropbox/Work/Kimber Simmons/GWAS/Data_Cleaned/biobank_analysis/imputed/merged_imputed_qc.bim",header = F)
ids <- getBM(attributes = 'refsnp_id', filters = c('chr_name','start'), 
             values = list(sapply(strsplit(bim$V2,":"),"[[",1),
                           sapply(strsplit(bim$V2,":"),"[[",2)), 
             mart = snp_mart)
# Write
write.csv(locations,"/Users/timvigers/Dropbox/Work/Kimber Simmons/GWAS/Data_Cleaned/erin_snp_pos.csv",
          row.names = F)

write.csv(ids,"/Users/timvigers/Dropbox/Work/Kimber Simmons/GWAS/Data_Cleaned/erin_snp_ids.csv",
          row.names = F)
