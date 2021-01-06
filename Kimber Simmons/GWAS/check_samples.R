setwd("/Users/timvigers/Work/Kimber Simmons/GWAS/Data_Raw")

biobank1 = read.csv("./Simmons Biobank/Biobank Hispanic Patients - Compass Mapping File.csv")
biobank2 = read.csv("./V2 - Biobank data on Hispanic Patients - Full Genetic Request/Table 1 Patient.csv")

# Exclude based on diagnoses
diagnoses = read.csv("./Table 2 Diagnoses EMY edits.csv")
exclude_samples = unique(diagnoses$Arb_Person_ID)
write.table(exclude_samples,file = "exclude_samples.txt",row.names = F,quote = F,col.names = F)
