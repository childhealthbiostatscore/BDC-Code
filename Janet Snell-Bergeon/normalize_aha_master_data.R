#setwd("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Janet Snell-Bergeon/AHA collaborative grant")
# SERRF normalization code
source("~/GitHub/BDC-Code/Janet Snell-Bergeon/serrf.R")
# Normalization function
serrf = function(file_in,file_out,cores_ratio = 0.5){
  t = read.csv(file_in,header = F)
  p_labels = as.character(t[5:nrow(t),2])
  n_labels = as.character(t[4,3:ncol(t)])
  o = normalize(file_in,methods = "SERRF",detectcores_ratio = cores_ratio)
  normed = t(o$normalized_dataset$SERRF)
  rownames(normed) = n_labels
  colnames(normed) = p_labels
  write.csv(normed,file = file_out,row.names = T,col.names = T,na = "")
}
# Test
serrf("/Users/timvigers/Desktop/test.csv","/Users/timvigers/Desktop/test_normalized.csv")
# Untargeted metabolomics
