#####################
# Program: makes usable R datasets from metabolomics databases
# Databases included (download location):
#     HMDB https://hmdb.ca/downloads
#     LipidMaps https://www.lipidmaps.org/data/structure/download.php
#####################

require(XML)
library(plyr)#should always load plyr first if need both
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ChemmineR")

library(ChemmineR)#can read (and visualize) sdf files
library(data.table)

###########################
#HMDB

library(tidyverse)
library(xml2)
library(stringr)
hmdb <- read_xml('C:/Users/johnrand/Desktop/Metabolomics Databases/HMDB_serum_metabolites_20190117.xml') %>%
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

write.table(table, file = "C:/Users/johnrand/Desktop/Metabolomics Databases/HMDB_table.txt", row.names = F, col.names = T, sep = "\t", quote = F, na="")


###########################
#LipidMaps
sdfset <- read.SDFset("C:/Users/johnrand/Desktop/Metabolomics Databases/LMSD_20191002.sdf")
blockmatrix <- datablock2ma(datablocklist=datablock(sdfset))

write.table(blockmatrix, file = "C:/Users/johnrand/Desktop/Metabolomics Databases/LMSD_table.txt", row.names = F, col.names = T, sep = "\t", quote = F, na="")
