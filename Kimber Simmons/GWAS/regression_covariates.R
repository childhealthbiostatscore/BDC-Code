library(data.table)
library(caret)
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
# Test - train split for evaluation
set.seed(1017)
pheno = read.table("./merged_imputed_qc.fam")
train_index = createDataPartition(pheno$V6,p=0.75,list=F)
write.table(pheno[train_index,1:2],"./train_samples",quote = F,sep = "\t",row.names = F,col.names = F)
write.table(pheno[-train_index,1:2],"./test_samples",quote = F,sep = "\t",row.names = F,col.names = F)
