library(tidyverse)
library(readxl)
library(snpStats)
setwd("/Users/timvigers/Documents/Work/BDC/Janet Snell-Bergeon/AHA collaborative grant")
# Sample info (cleaned for metabolomics)
sample_info <- read_excel("./Reports/QVisits_LastVisit.xlsx")
# To numeric
num_vars <- c("StudyID", "apobV1", "CKDepiV1", "crpV1", "fibV1", "homoV1", "pai1V1")
sample_info[, num_vars] <- lapply(sample_info[, num_vars], as.numeric)
# Calculated variables
# Current smoker pack years
sample_info$SmkStatusV1 <- factor(sample_info$SmkStatusV1,
  levels = c("Current", "Former", "Never")
)
sample_info$smknum <- sample_info$SmkStatusV1
levels(sample_info$smknum) <- c("Yes", "No", "No")
sample_info$smknum <- relevel(sample_info$smknum, ref = "No")
# Calculated outcomes
sample_info$Deceased[is.na(sample_info$Deceased)] <- "Alive"
sample_info$Deceased <- factor(sample_info$Deceased)
sample_info$CACprogV3 <- cut(sample_info$C3 - sample_info$C1,
  breaks = c(-Inf, 2.5, Inf),
  labels = c("No Progression", "Progression"),
  right = F
)
sample_info$cac_prog_last_vis <- apply(sample_info, 1, function(r) {
  last <- max(which(!is.na(r[c("C1", "C2", "C3", "C4")])))
  cs <- as.numeric(r[c("C1", "C2", "C3", "C4")])
  d <- cs[last] - cs[1]
  if (d >= 2.5) {
    return("Progression")
  } else {
    return("No Progression")
  }
})
sample_info$cac_change_per_yr <- apply(sample_info, 1, function(r) {
  last <- max(which(!is.na(r[c("C1", "C2", "C3", "C4")])))
  cs <- as.numeric(r[c("C1", "C2", "C3", "C4")])
  if (last == 4) {
    change <- (cs[last] - cs[1]) / 12
  } else if (last == 2 | last == 3) {
    change <- (cs[last] - cs[1]) / ((last - 1) * 3)
  } else if (last == 1) {
    change <- NA
  }
  return(change)
})
# Clinical variable list
clinical_predictors <- c(
  "acV1", "age", "apobV1", "avediabpV1", "avesystbpV1", "bmiV1",
  "cholV1", "CKDepiV1", "crpV1", "dia", "durcatV1", "fibV1",
  "hba1cV1", "hdlcV1", "homoV1", "insdoseperkgV1", "l45sqfV1",
  "l45vsfV1", "ldlV1", "NHW", "onhypermedsV1", "onlipidmedsV1",
  "pai1V1", "PAT_V1", "sex", "smknum", "triV1", "UA_V1", "whrV1"
)
aha_outcomes <- c(
  "CACprogV3", "cac_prog_last_vis", "cac_change_per_yr", "Deceased",
  "CAD", "HardCAD", "CVD", "HardCVD"
)
# Factor variables
med_vars <- colnames(sample_info)[grep("on.*med", colnames(sample_info))]
cat_vars <- c(
  "sex", "race", "State", "dia", "NHW", med_vars, "cac_prog_last_vis",
  "pumporinjV1", "albuminuriaV1", "type2bydefV1", "CACanyV1",
  "maritalV1", "SmkStatusV1", "diabetic", "spanorg", "hyperbydeffV1",
  "agecatV1", "durcatV1", "CAD", "HardCAD", "CVD", "HardCVD"
)
sample_info[, cat_vars] <- lapply(sample_info[, cat_vars], as.factor)
# Log transform all numeric clinical variables except age and cholesterol
num_vars <- unique(c(num_vars, colnames(sample_info)[lapply(sample_info, class) == "numeric"]))
log_transform <- num_vars[num_vars %in% clinical_predictors]
log_transform <- log_transform[!log_transform %in% c("age", "cholV1")]
sample_info[, log_transform] <- lapply(sample_info[, log_transform], log)
# Remove 0s from event time data
sample_info$PersonYrsCAD[sample_info$PersonYrsCAD == 0] <- NA
sample_info$PersonYrsHardCAD[sample_info$PersonYrsHardCAD == 0] <- NA
sample_info$PersonYrsCVD[sample_info$PersonYrsCVD == 0] <- NA
sample_info$PersonYrsHardCVD[sample_info$PersonYrsHardCVD == 0] <- NA
# Targeted metabolites
targeted_metabs <- read.csv("./Metabolomics/Data_Cleaned/targeted.csv", na.strings = "")
targeted_metabs <- targeted_metabs %>% select(StudyID, Betaine:linoleic.acid)
colnames(targeted_metabs) <- sub("[.]$", "", colnames(targeted_metabs))
sample_info <- left_join(sample_info, targeted_metabs, by = "StudyID")
targeted_metabs <- colnames(targeted_metabs)[2:ncol(targeted_metabs)]
# Start making analyte info dataframe
targeted_info <- read_excel("./Metabolomics/Data_Raw/AHA_06172019_TargetedMetabolomics_ConcentrationTable_Sent to UCD.xlsx",
  sheet = "compound description"
)
targeted_info <- targeted_info %>%
  mutate(
    `Compound Name` = make.names(`Compound Name`),
    `Omics Platform` = "Targeted Metabolomics"
  ) %>%
  select(`Compound Name`, `Omics Platform`, `Mol. Wt`)
# For some reason, L-Erythronic acid is just called Erythronic.acid in targeted_metabs
targeted_info$`Compound Name`[targeted_info$`Compound Name` == "L.Erythronic.acid"] <- "Erythronic.acid"
# Add untargeted metabolites
untargeted <- read.csv("./Metabolomics/Data_Cleaned/complete_untargeted.csv", na.strings = "")
untargeted_metabs <-
  colnames(untargeted)[grep("GROUP", colnames(untargeted)) + 1:ncol(untargeted)]
untargeted_metabs <- untargeted_metabs[!is.na(untargeted_metabs)]
untarget_samples <- read.csv("./Metabolomics/Data_Cleaned/sample_list.csv")
untargeted$StudyID <- untarget_samples$SampleID[match(
  untargeted$GlobalSampleID,
  untarget_samples$Injection
)]
untargeted <- untargeted[, c("StudyID", untargeted_metabs)]
sample_info <- left_join(sample_info, untargeted, by = "StudyID")
# Analyte info
untargeted_info <- read_excel("./Metabolomics/Data_Raw/CIL global metabolomics data matrix_20190725_Import.xlsx",
  sheet = "Variables"
)
untargeted_info <- untargeted_info %>%
  unite(`Compound Name`, `HMDB No.`, `LI Library No.`, na.rm = T, remove = F) %>%
  unite(Compound, Compound...14, Compound...18, na.rm = T, remove = F) %>%
  mutate(
    `Compound Name` = paste(`Compound Name`, `Neutral Mass (Da)`, `RT (s)`, sep = "_"),
    `Omics Platform` = "Untargeted Metabolomics"
  ) %>%
  select(`Compound Name`, `HMDB No.`, `LI Library No.`, Compound, `Neutral Mass (Da)`, `RT (s)`, `Omics Platform`)
# Add lipidomics
lipid_df <- read.csv("./Lipidomics/Data_Cleaned/aha_lipidomics_new_annotation.csv",
  stringsAsFactors = F, na.strings = ""
)
lipid_info <- lipid_df %>%
  select(LipidMolec:Avrage.RT) %>%
  mutate(`Omics Platform` = "Lipidomics")
lipids <- lipid_df$LipidMolec
lipid_df[, 1:5] <- NULL
lipid_df <- as.data.frame(t(lipid_df))
colnames(lipid_df) <- lipids
lipid_df$StudyID <- gsub("\\.", "_p", rownames(lipid_df))
order <- read_excel("./Lipidomics/Data_Raw/20210509 Sample Information of AHA-239 study.xlsx")
lipid_df$StudyID <- order$`Original SampleID`[match(lipid_df$StudyID, order$`sample order`)]
sample_info <- left_join(sample_info, lipid_df, by = "StudyID")
# Format lipid info
lipid_info <- lipid_info %>% rename(`Compound Name` = LipidMolec)
# Add global proteomics
proteins <- read.csv("./Proteomics/Data_Cleaned/global_proteome.csv", na.strings = "")
global_proteins <- proteins$Accession
protein_info <- proteins %>%
  select(Accession, MW..kDa., Gene.Symbol, Gene.ID, Description) %>%
  rename(`Compound Name` = Accession) %>%
  mutate(`Omics Platform` = "Proteomics")
manifest <- read.csv("./Proteomics/Data_Cleaned/sample_acquisition.csv", na.strings = "")
normalized_df <- proteins %>% select(Abundances..Normalized...F1..Sample:Abundances..Normalized...F287..Sample)
colnames(normalized_df) <- sub("Abundances..Normalized...", "", colnames(normalized_df))
colnames(normalized_df) <- sub("..Sample", "", colnames(normalized_df))
rownames(normalized_df) <- global_proteins
normalized_df <- as.data.frame(t(normalized_df))
normalized_df$StudyID <- as.numeric(manifest$Sample.ID..from.hospital.[match(rownames(normalized_df), manifest$File.ID)])
sample_info <- left_join(sample_info, normalized_df, by = "StudyID")
# Add glycated proteomics
glycated <- read.csv("./Proteomics/Data_Cleaned/peptide_abundance.csv")
colnames(glycated)[3:ncol(glycated)] <- paste0("gly_", colnames(glycated)[3:ncol(glycated)])
glycated_proteins <- colnames(glycated)[3:ncol(glycated)]
glycated$Master.Protein.Accessions <- NULL
sample_info <- left_join(sample_info, glycated, by = "StudyID")
# Add genomic data
snp_data <- read.plink("./Genomics/Data_Raw/Imputed SNPS - Updated 7-20-15/CACTI_FINAL_HG19_1KGpos")
snps <- snp_data$map$snp.name
# Match IDs
ids <- read.delim("./Genomics/Data_Raw/CACTI_SampleID_KEY.txt")
t <- data.frame(as(snp_data$genotypes, "character"))
t$StudyID <- ids$StudyID[match(rownames(t), ids$UVA_ID)]
t <- t[-which(duplicated(t$StudyID)), ]
# Remove SNPs not in map file and data
snps <- colnames(t)[colnames(t) %in% snps]
t <- t[, c("StudyID", snps)]
t[, snps] <- lapply(t[, snps], function(c) {
  factor(c, levels = c("A/A", "A/B", "B/B"))
})
# Merge
sample_info <- left_join(sample_info, t, by = "StudyID")
analyte_info <- full_join(targeted_info, untargeted_info)
analyte_info <- full_join(analyte_info, lipid_info)
analyte_info <- full_join(analyte_info, protein_info)
# Save
df <- as.data.frame(sample_info)
save(untargeted_metabs, targeted_metabs, global_proteins, glycated_proteins, lipids,
  snps, df, clinical_predictors, aha_outcomes, analyte_info,
  file = "./aha_master_data.Rdata"
)
