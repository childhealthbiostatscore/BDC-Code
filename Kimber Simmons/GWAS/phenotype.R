setwd("/home/tim/Work/Kimber Simmons/GWAS/Data_Cleaned/plink")
# Read in and re-write .fam files
redo = read.table("./redo.fam")
redo$V6 = 2
write.table(redo,file = "redo.fam",row.names = F,quote = F,col.names = F)

biobank = read.table("./biobank2.fam")
biobank$V6 = 2
write.table(biobank,file = "./biobank2.fam",row.names = F,quote = F,col.names = F)
