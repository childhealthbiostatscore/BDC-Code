library(tidyverse)
library(xml2)
library(stringr)
# Read XML
hmdb <- read_xml('/Volumes/Vault/Documents/Work/Metabolomics/HMDB/hmdb_metabolites.xml') %>%
  as_list()

HMP_ID = unlist(sapply(hmdb$hmdb, "[[", "accession"))
name = unlist(sapply(hmdb$hmdb, "[[", "name"))
formula = unlist(sapply(hmdb$hmdb, "[[", "chemical_formula"))
smiles = unlist(sapply(hmdb$hmdb, "[[", "smiles"))
inchikey = unlist(sapply(hmdb$hmdb, "[[", "inchikey"))

# couldn't figure out how to get class/subclass
# they're more embedded in the list but could be informative for lipidss

table <- cbind.data.frame(HMP_ID = HMP_ID, name = name, 
                          formula = formula, 
                          smiles = smiles, inchikey = inchikey)

write.table(table, file = "/Volumes/Vault/Documents/Work/Metabolomics/HMDB/HMDB_table.txt", 
            row.names = F, col.names = T, sep = "\t", quote = F, na="")
