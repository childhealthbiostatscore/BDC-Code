set.seed(1017)
library(statTarget)
# shiftCor requires two saved files (doesn't work on imported data):
# 1. A 4 column file with injection order information
# 2. The data matrix with samples in columns
# It creates a folder in the working directory to output all results
# Can do LOESS of random forest normalization
# I (Tim) found it easiest to format the input files by hand
# After comparing the plots for RF and LOESS, we decided to go with RF
shared_folder = '/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Janet Snell-Bergeon/AHA collaborative grant/'
# Untargeted metabolomics
setwd(paste0(shared_folder,'Metabolomics/Data_Cleaned/untargeted_normalization'))
shiftCor('untargeted_metabolomics_order.csv',
         'untargeted_metabolomics_data_matrix.csv', 
         MLmethod = 'QCRFSC', imputeM = 'KNN',plot = T)
# Targeted metabolomics
setwd(paste0(shared_folder,'Lipidomics/Data_Cleaned/normalization'))
shiftCor('lipidomics_order.csv',
         'lipidomics_data_matrix.csv', 
         MLmethod = 'QCRFSC', imputeM = 'KNN',plot = T)
