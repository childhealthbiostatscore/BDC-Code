library(biomaRt)
library(tidyverse)
setwd("~/Library/CloudStorage/OneDrive-TheUniversityofColoradoDenver/BDC/Janet Snell-Bergeon/CACTI DCCT EDIC omics R01")
# Set up biomaRt for annotation
ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
# Untargeted metabolomics
metabs <- read.csv("./Metabolomics/EDIC metabolomics final data matrix.csv",
  stringsAsFactors = F, na.strings = c("", "NA")
)
metabs <- metabs %>%
  mutate(
    compound = coalesce(NovaMT.Library.No., External.Identifier),
    m.z = Neutral.Mass..Da. + 1.0078,
    rt = RT..s.,
    masserror = Mass.Error..ppm.,
    rterror = RT.Error..s.
  ) %>%
  select(compound, m.z, rt, masserror, rterror)
metabs$name <- paste(
  metabs$compound,
  metabs$m.z,
  metabs$rt,
  sep = "_"
)
metabs <- metabs %>% select(name, everything())
metabs$Platform = "Untargeted Metabolomics"
# Import proteomics
proteins <- read.delim("./Proteomics/Raw data/EDIC_WP_DDA_60SPD_Proteins.txt")
proteins <- proteins$Accession
# Find Entrez IDs
p <- getBM(
  attributes = c("uniprot_gn_id", "ensembl_gene_id","entrezgene_id"),
  filters = "uniprot_gn_id", values = proteins,
  mart = ensembl
)
# Check isoforms
p2 <- getBM(
  attributes = c("uniprot_isoform","ensembl_gene_id", "entrezgene_id"),
  filters = "uniprot_isoform",
  values = proteins[!proteins %in% p$uniprot_gn_id],
  mart = ensembl
)
# Check Swiss-Prot
p3 <- getBM(
  attributes = c("uniprotswissprot","ensembl_gene_id", "entrezgene_id"),
  filters = "uniprotswissprot",
  values = proteins[!proteins %in% c(p$uniprot_gn_id, p2$uniprot_isoform)],
  mart = ensembl
)
cnames <- c("name","Ensembl", "Entrez")
prots <- rbind(setNames(p, cnames), setNames(p2, cnames), setNames(p3, cnames))
prots$Platform = "Proteomics"
# Lipidomics
lipids = read.csv("./Lipidomics/Data_raw/EDIC lipidomics data matrix_Skyline_2021.02.25.csv")
lipids$Platform = "Lipidomics"
lipids = lipids %>% select(LipidSpecies,Platform) %>% rename(name = LipidSpecies)
# Combine and format
df = full_join(metabs,prots,by = join_by(name, Platform))
df = full_join(df,lipids,by = join_by(name, Platform))
df = df %>%
  select(name,Platform,compound:rterror,Entrez,Ensembl) %>%
  rename(Name = name,Compound = compound,`M/Z` = m.z,
         RT = rt,`Mass Error` = masserror,`RT Error` = rterror,
         `Entrez Gene ID` = Entrez,`Ensembl Gene ID`)
# Save
write.csv(df,file = "Data_Clean/DCCT-EDIC Analyte Info.csv",na="",row.names = F)
