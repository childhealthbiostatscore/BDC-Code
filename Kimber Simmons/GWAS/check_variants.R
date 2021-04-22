setwd("~/Dropbox/Work/Kimber Simmons/GWAS/Data_Cleaned/biobank_analysis")
miss_snp = read.table("merged-merge.missnp")
# Import
redo = read.table("./redo.bim")
redo = redo[redo$V2 %in% miss_snp$V1,]

biobank = read.table("./biobank1.bim")
biobank = biobank[biobank$V2 %in% miss_snp$V1,]

# Exclude SNPs where alleles are different
exclude = merge(redo,biobank,all = T,by = "V2")

exclude = apply(exclude,1,function(r){
  if (all(c(r["V5.x"],r["V6.x"]) %in% c(r["V5.y"],r["V6.y"]))){
    NA
  } else {r["V2"]}
})
write.table(exclude,file = "exclude_snps",row.names = F,quote = F,col.names = F)
