setwd("/home/tim/Work/Kimber Simmons/GWAS/Data_Cleaned/plink")

kimber = read.delim("./merged_final.bim",header=F, quote="")
tgp = read.delim("./all_phase3.bim", header=F, quote="")
kimber = kimber[kimber$V2 %in% tgp$V2,]
