library(tidyverse)
library(readxl)
setwd("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Janet Snell-Bergeon/AHA collaborative grant")
# Import SERRF normalization R code from Fiehn lab
source("~/GitHub/BDC-Code/Janet Snell-Bergeon/AHA Lipidomics/serrf.R")
# Sample info (cleaned for metabolomics)
sample_info = read.csv("./Metabolomics/Data_Cleaned/targeted.csv",na.strings = "")
# Delete empty columns
sample_info[,which(colSums(is.na(sample_info))==nrow(sample_info))] = NULL
# Targeted metabolites
targeted_metabs = 
  colnames(sample_info)[which(colnames(sample_info)=="Betaine"):ncol(sample_info)]
# Add three CAC groups and progression
three_group = read.delim("./Metabolomics/Data_Raw/CAC Trajectories 3 groups.txt",
                         na.strings = "")
sample_info = left_join(sample_info,three_group[,c("StudyID","GROUP")],by = "StudyID")
sample_info$CACp = cut(sample_info$c3 - sample_info$c1,c(-Inf,2.5,Inf),
                       labels = c("No","Yes"),right = F)
# Add untargeted metabolites
untargeted = read.csv("./Metabolomics/Data_Cleaned/complete_untargeted.csv",na.strings = "")
untargeted_metabs = 
  colnames(untargeted)[grep("GROUP",colnames(untargeted))+1:ncol(untargeted)]
untargeted_metabs = untargeted_metabs[!is.na(untargeted_metabs)]
untarget_samples = read.csv("./Metabolomics/Data_Cleaned/sample_list.csv")
untargeted$StudyID = 
  untarget_samples$SampleID[match(untargeted$GlobalSampleID,
                                  untarget_samples$Injection)]
untargeted = untargeted[,c("StudyID",untargeted_metabs)]
sample_info = left_join(sample_info,untargeted,by = "StudyID",na.strings = "")
# Add lipidomics
lipid_df = read.csv("./Lipidomics/Data_Cleaned/aha_lipidomics_new_annotation.csv",
                    stringsAsFactors = F,na.strings = "")
lipids = lipid_df$LipidMolec
lipid_df[,1:5] = NULL
lipid_df = as.data.frame(t(lipid_df))
colnames(lipid_df) = lipids
lipid_df$StudyID = gsub("\\.","_p",rownames(lipid_df))
order = read_excel("./Lipidomics/Data_Raw/20210509 Sample Information of AHA-239 study.xlsx")
lipid_df$StudyID = 
  order$`Original SampleID`[match(lipid_df$StudyID,order$`sample order`)]
sample_info = left_join(sample_info,lipid_df,by = "StudyID")
# Add global proteomics
proteins = read.csv("./Proteomics/Data_Cleaned/global_proteome.csv",na.strings = "")
global_proteins = proteins$Accession
manifest = read.csv("./Proteomics/Data_Cleaned/sample_acquisition.csv",na.strings = "")
normalized_df = proteins %>% select(Abundances..Normalized...F1..Sample:Abundances..Normalized...F287..Sample)
colnames(normalized_df) = sub("Abundances..Normalized...","",colnames(normalized_df))
colnames(normalized_df) = sub("..Sample","",colnames(normalized_df))
rownames(normalized_df) = global_proteins
normalized_df = as.data.frame(t(normalized_df))
normalized_df$StudyID = manifest$Sample.ID..from.hospital.[match(rownames(normalized_df),manifest$File.ID)]
sample_info = left_join(sample_info,normalized_df,by = "StudyID")
# Add glycated proteomics
glycated = read.csv("./Proteomics/Data_Cleaned/peptide_abundance.csv")
colnames(glycated)[3:ncol(glycated)] = paste0("gly_",colnames(glycated)[3:ncol(glycated)])
glycated_proteins = colnames(glycated)[3:ncol(glycated)]
glycated$Master.Protein.Accessions = NULL
sample_info = left_join(sample_info,glycated,by = "StudyID")
# Save
df = sample_info
save(untargeted_metabs,targeted_metabs,global_proteins,glycated_proteins,lipids,df,
     file = "./aha_master_data.Rdata")