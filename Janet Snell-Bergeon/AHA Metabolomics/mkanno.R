# Program: Complete annotations for Tangier metabolomics
library(plyr)
library(dplyr)
# specifically want to add pubchemID, smiles, inchikey for ChemRICH

# first upload data
# Tim, we had two separate data frames, which you'll see clumsily dealt with separately, throughout the script
anno.aq = as.data.frame(read_tsv(file = "A:/tangier/metabolomics/analysis/data/compound_info_aq.txt", col_names = T))
anno.lip = as.data.frame(read_tsv(file = "A:/tangier/metabolomics/analysis/data/compound_info_lip.txt", col_names = T))

#HMDB database - download here https://hmdb.ca/downloads
hmdb = as.data.frame(read_tsv(file = "C:/Users/johnrand/Desktop/Metabolomics Databases/HMDB_table.txt"), col_names = T)

#Tim, you can also download the lipid maps database for free (here https://www.lipidmaps.org/data/structure/download.php), but I omitted all that code here, since you don't have LMP Ids.

# need to update our HMP_ID to HMDBv4.0 format--has 2 extra 00 after "HMDB"
# documentation here: https://hmdb.ca/release-notes
# first check that all ours have old format 4+5 characters: HMDB#####
len = nchar(anno.lip$HMP_ID)
len2 = nchar(anno.aq$HMP_ID)
summary(len)#all 9
summary(len2)#all 9

#add 2 extra 00 after "HMDB" to match new format: HMDB#######
anno.aq$HMP_ID = sub("HMDB","HMDB00", anno.aq$HMP_ID)
anno.lip$HMP_ID = sub("HMDB","HMDB00", anno.lip$HMP_ID)

len = nchar(anno.lip$HMP_ID)
len2 = nchar(anno.aq$HMP_ID)
summary(len)#all 11
summary(len2)#all 11


#how many matches to expect generally
length(is.na(anno.aq$HMP_ID))

length(which(anno.aq$HMP_ID %in% hmdb$HMP_ID))#278
length(which(anno.lip$HMP_ID %in% hmdb$HMP_ID))#565

#add hmdb
anno.aq = merge(anno.aq, hmdb[,c("HMP_ID","smiles","inchikey")], by = "HMP_ID", all.x = T)
anno.lip = merge(anno.lip, hmdb[,c("HMP_ID","smiles","inchikey")], by = "HMP_ID", all.x = T)

#export unique inchikeys, to get pubchem_id for all (hmdb doesn't provide)
anno.all = rbind.fill(anno.aq, anno.lip)
inchikey = unique(anno.all$InChiKeys[which(!is.na(anno.all$InChiKeys))])

write.table(inchikey, file = "A:/tangier/metabolomics/analysis/enrichment/unq.inchikeys.csv", row.names = F, col.names = F, sep=",")
#use inchikeys to get pubchem cid from here: https://pubchem.ncbi.nlm.nih.gov/idexchange/idexchange.cgi

#import and add pubchemcid to anno
cidkey= as.data.frame(read_tsv(file = "A:/tangier/metabolomics/analysis/enrichment/inchikey_cid.txt", col_names = F))
colnames(cidkey) = c("InChiKeys","cid")

#pubchem exchange always creates duplicates--we'll keep the first
cidkey2 = cidkey %>%
  distinct(InChiKeys, .keep_all = T)

cidkey2 = cidkey2[which(!is.na(cidkey2$cid)),]#647 aren't NA

#add cid to both frames
anno.aq = merge(anno.aq, cidkey2, by = "InChiKeys", all.x = T)
anno.lip = merge(anno.lip, cidkey2, by = "InChiKeys", all.x = T)

write.table(anno.aq, file="A:/tangier/metabolomics/analysis/enrichment/anno.aq.rich.txt", row.names = F, col.names = T, sep = "\t", quote = F, na="")
write.table(anno.lip, file="A:/tangier/metabolomics/analysis/enrichment/anno.lip.rich.txt", row.names = F, col.names = T, sep = "\t", quote = F, na="")


