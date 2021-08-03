#setwd("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Janet Snell-Bergeon/AHA collaborative grant")
# SERRF normalization code
source("~/GitHub/BDC-Code/Janet Snell-Bergeon/serrf.R")
# Untargeted metabolomics
o = normalize("/Users/timvigers/Dropbox/Work/AHA/untargeted_metabolomics_for_SERRF.csv",
              methods = "SERRF",cores = 6)
