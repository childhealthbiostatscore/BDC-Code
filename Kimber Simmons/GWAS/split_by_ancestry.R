setwd("~/Documents/Work/Kimber Simmons/GWAS/Data_Cleaned/harmonized_analysis/")
# Import inferred ancestry from RF
redo = read.csv("redo_pop.csv")
biobank1 = read.csv("biobank1_pop.csv")
biobank2 = read.csv("biobank2_pop.csv")
# Split and write
redo = split.data.frame(redo,redo$SuperPop)
write.table(names(redo),"redo_pops",quote = F,row.names = F,col.names = F)
invisible(lapply(names(redo), function(n){
  write.table(redo[[n]][1:2],paste0(n,"_redo"),quote = F,row.names = F,col.names = F)
}))
biobank1 = split.data.frame(biobank1,biobank1$SuperPop)
write.table(names(biobank1),"biobank1_pops",quote = F,row.names = F,col.names = F)
invisible(lapply(names(biobank1), function(n){
  write.table(biobank1[[n]][1:2],paste0(n,"_biobank1"),quote = F,row.names = F,col.names = F)
}))
biobank2 = split.data.frame(biobank2,biobank2$SuperPop)
write.table(names(biobank2),"biobank2_pops",quote = F,row.names = F,col.names = F)
invisible(lapply(names(biobank2), function(n){
  write.table(biobank2[[n]][1:2],paste0(n,"_biobank2"),quote = F,row.names = F,col.names = F)
}))
# List all files
files = c(paste0(names(redo),"_redo"),paste0(names(biobank1),"_biobank1"),paste0(names(biobank2),"_biobank2"))
write.table(files,"ancestry_split_files",quote = F,row.names = F,col.names = F)
