setwd("/home/tim/Work/Kimber Simmons/GWAS/Data_Cleaned/plink")
miss_snp = read.table("merged2-merge.missnp")
# Import
redo = read.table("./redo.bim")
redo = redo[redo$V2 %in% miss_snp$V1,]

biobank = read.table("./biobank1.bim")
biobank = biobank[biobank$V2 %in% miss_snp$V1,]

# Exclude SNPs where alleles are different
exclude_snps = unique(redo$V2[redo$V5 != "."])
write.table(exclude_snps,file = "exclude_snps",row.names = F,quote = F,col.names = F)

# Allele update file
redo[,c(1,3,4)] = NULL
redo = cbind(redo,biobank[match(redo$V2,biobank$V2),c(5,6)])

write.table(redo,file = "redo_update",row.names = F,quote = F,col.names = F)

