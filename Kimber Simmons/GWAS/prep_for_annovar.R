setwd("/home/tim/UCD/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Kimber Simmons/GWAS/Data_Cleaned/kimber_only_analysis/imputed")
annovar = read.delim("plink2.PHENO1.glm.logistic.adjusted", header=FALSE, comment.char="#")
annovar = annovar[annovar$V4 < 0.05,]
annovar = strsplit(annovar$V2,":")
annovar = data.frame(do.call(rbind,annovar))
annovar$X1 = as.numeric(sub("chr","",annovar[,1]))
annovar$X5 = annovar$X2
annovar = annovar[,c("X1","X2","X5","X3","X4")]
write.table(annovar,file = "annovar.avinput",col.names = F,quote = F,row.names = F)
