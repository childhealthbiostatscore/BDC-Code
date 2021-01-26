setwd("/media/tim/Work/Kimber Simmons/GWAS")
# Read in and re-write .fam files
redo = read.table("./Data_Cleaned/plink/redo.fam")
redo$V6 = 2
write.table(redo,file = "./Data_Cleaned/plink/redo.fam",row.names = F,quote = F,col.names = F)

biobank = read.table("./Data_Cleaned/plink/biobank2.fam")
diagnoses = read.csv("./Data_Raw/V2 - Biobank data on Hispanic Patients - Full Genetic Request/Table 2 Diagnoses.CSV")
biobank$V6 = 2
biobank$V6[which(!(biobank$V1 %in% diagnoses$Arb_Person_ID))] = 1
write.table(biobank,file = "./Data_Cleaned/plink/biobank2.fam",row.names = F,quote = F,col.names = F)
