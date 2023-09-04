library(arsenal)

prot <- read.csv("/Volumes/BDC/Projects/Janet Snell-Bergeon/CACTI DCCT EDIC omics R01/Proteomics/Raw data/QEDIC_WP_DDA_60SPD_StudyInformat.csv")

met <- read.csv("/Volumes/BDC/Projects/Janet Snell-Bergeon/CACTI DCCT EDIC omics R01/Metabolomics/QEDIC_WP_DDA_60SPD_StudyInformat.csv")

comparedf(prot, met)
# they are the same