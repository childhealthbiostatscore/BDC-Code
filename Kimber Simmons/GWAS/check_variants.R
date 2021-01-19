setwd("/home/tim/Work/Kimber Simmons/GWAS/Data_Cleaned/plink")
miss_snp = read.table("merged2-merge.missnp")

redo_flip = read.table("./redo_flip.bim")
redo_flip = redo_flip[redo_flip$V2 %in% miss_snp$V1,]
redo_flip = redo_flip[order(redo_flip$V2),]

redo = read.table("./redo.bim")
redo = redo[redo$V2 %in% miss_snp$V1,]
redo = redo[order(redo$V2),]

biobank = read.table("./biobank1.bim")
biobank = biobank[biobank$V2 %in% miss_snp$V1,]
biobank = biobank[order(biobank$V2),]

t1 = biobank[which(biobank$V6 != redo_flip$V6),]
t2 = redo_flip[which(redo_flip$V6 != biobank$V6),]