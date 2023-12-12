library(biomaRt)
library(tidyverse)
setwd("~/Library/CloudStorage/OneDrive-TheUniversityofColoradoDenver/BDC/Janet Snell-Bergeon/CACTI DCCT EDIC omics R01")
# Set up biomaRt for annotation
ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
# Untargeted metabolomics
metabolite_annotation <- read.csv("./Metabolomics/EDIC metabolomics final data matrix.csv",
  stringsAsFactors = F, na.strings = c("", "NA")
)
metabolite_annotation <- metabolite_annotation %>%
  mutate(
    compound = coalesce(NovaMT.Library.No., External.Identifier),
    m.z = Neutral.Mass..Da. + 1.0078,
    rt = RT..s.,
    masserror = Mass.Error..ppm.,
    rterror = RT.Error..s.
  ) %>%
  select(compound, m.z, rt, masserror, rterror)
metabolite_annotation$name <- paste(
  metabolite_annotation$compound,
  metabolite_annotation$m.z,
  metabolite_annotation$rt,
  sep = "_"
)
metabolite_annotation <- metabolite_annotation %>% select(name, everything())
# Import proteomics
proteins <- read.delim("./Proteomics/Raw data/EDIC_WP_DDA_60SPD_Proteins.txt")
proteins <- proteins$Accession
# Find Entrez IDs
p <- getBM(
  attributes = c("uniprot_gn_id", "entrezgene_id"),
  filters = "uniprot_gn_id", values = proteins,
  mart = ensembl
)
# Check isoforms
p2 <- getBM(
  attributes = c("uniprot_isoform", "entrezgene_id"),
  filters = "uniprot_isoform",
  values = proteins[!proteins %in% p$uniprot_gn_id],
  mart = ensembl
)
# Check Swiss-Prot
p3 <- getBM(
  attributes = c("uniprotswissprot", "entrezgene_id"),
  filters = "uniprotswissprot",
  values = proteins[!proteins %in% c(p$uniprot_gn_id, p2$uniprot_isoform)],
  mart = ensembl
)
cnames <- c("UniProt", "Entrez")
protein_anotation <- rbind(setNames(p, cnames), setNames(p2, cnames), setNames(p3, cnames))
# Save
save(metabolite_annotation,protein_anotation,
     file = "./Data_Raw/annotations.RData")
