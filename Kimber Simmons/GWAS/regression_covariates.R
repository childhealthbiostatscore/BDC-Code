library(data.table)
setwd("~/Dropbox/Work/Kimber Simmons/GWAS/Data_Cleaned/biobank_analysis/imputed/")
pc_num = 4
# Read in and process the covariates
covariate <- read.delim("p.phen",header = F)
colnames(covariate) = c("FID","IID","Sex","Pheno")
pcs <- fread(paste0(pc_num,"pcs"))
colnames(pcs) = c("FID","IID", paste0("PC",1:(ncol(pcs)-2)))
covariate$Pheno = NULL
covariate = merge(covariate,pcs)
write.table(covariate,"./covar.txt",quote = F,sep = "\t",row.names = F)
