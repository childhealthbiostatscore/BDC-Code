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
# Get effect sizes
res = read.delim(paste0("./logistic_",pc_num,"pcs.PHENO1.glm.logistic.hybrid"))
res = res[res$TEST == "ADD" & res$ERRCODE == ".",]
res$bonf = p.adjust(res$P,"bonferroni")
write.table(res[,c("ID","A1","OR")],"./effect_sizes",quote = F,sep = "\t",row.names = F)
# Get p values
write.table(res[,c("ID","P")],"./SNP.pvalue",quote = F,sep = "\t",row.names = F)
