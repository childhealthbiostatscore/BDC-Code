setwd("/home/tim/Work/Kimber Simmons/GWAS")

biobank1 = read.csv("./Data_Raw/Simmons Biobank/Biobank Hispanic Patients - Compass Mapping File.csv")
biobank2 = read.csv("./Data_Raw/V2 - Biobank data on Hispanic Patients - Full Genetic Request/Table 1 Patient.csv")

# Exclude based on diagnoses
diagnoses = read.csv("./Data_Raw/Table 2 Diagnoses EMY edits.csv")
exclude_samples = unique(diagnoses$Arb_Person_ID)
exclude_samples = cbind(exclude_samples,exclude_samples)
write.table(exclude_samples,file = "./Data_Cleaned/plink/exclude_samples",row.names = F,quote = F,col.names = F)
