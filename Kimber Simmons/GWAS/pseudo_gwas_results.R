setwd("~/Documents/Work/Kimber Simmons/GWAS/Data_Cleaned/harmonized_analysis/")
files = read.table("ancestry_split_files")
files = unlist(files)
files = files[1:2]
logit_results_name = ".PHENO1.glm.logistic.hybrid"
# Import results
l = lapply(files,function(r){
  res = read.delim(paste0(r,logit_results_name))
  res = res[res$P > 0.0001,]
  res = res[!is.na(res$P),"ID"]
  return(res)
})
keep = unique(unlist(l))