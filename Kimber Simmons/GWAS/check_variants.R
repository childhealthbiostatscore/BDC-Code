setwd("/home/tim/Work/Kimber Simmons/GWAS/Data_Cleaned/plink")
miss_snp = read.table("merged2-merge.missnp")
# Import and sort
redo_flip = read.table("./redo_flip.bim")
redo_flip = redo_flip[redo_flip$V2 %in% miss_snp$V1,]
redo_flip = redo_flip[order(redo_flip$V2),]

redo = read.table("./redo.bim")
redo = redo[redo$V2 %in% miss_snp$V1,]
redo = redo[order(redo$V2),]

biobank = read.table("./biobank1.bim")
biobank = biobank[biobank$V2 %in% miss_snp$V1,]
biobank = biobank[order(biobank$V2),]

# Exclude SNPs where alleles are different
exclude_snps = unique(redo$V2[redo$V5 != "."])
write.table(exclude_snps,file = "exclude_snps.txt",row.names = F,quote = F,col.names = F)

# Find which are correct but have an allele missing in the redo file
redo_correct = which(redo$V6 == biobank$V6)
redo$V5[redo_correct] = biobank$V5[redo_correct]

flip_correct = which(redo_flip$V6 == biobank$V6)
redo$V5[flip_correct] = biobank$V5[flip_correct]
redo$V6[flip_correct] = redo_flip$V6[flip_correct]

# Write
redo_all = read.table("./redo.bim")
redo_all$V5[match(redo$V2,redo_all$V2)] = redo$V5
redo_all$V6[match(redo$V2,redo_all$V2)] = redo$V6
write.table(redo_all,file = "redo_final.bim",row.names = F,quote = F,col.names = F)
