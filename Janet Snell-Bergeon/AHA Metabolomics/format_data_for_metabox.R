library(tidyverse)
library(webchem)
library(opencpu)
setwd("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Janet Snell-Bergeon/AHA collaborative grant/Metabolomics")
# Read in raw data
raw_data <- read.csv("./Data_Cleaned/metabolomics.csv",
                     stringsAsFactors = F,na.strings = c("","NA"))
# Format
df <- raw_data %>% 
  unite(compounds,Compound,Compound.1,na.rm = T) %>% #combine compound names from different tiers
  mutate(`quant m/z` = Neutral.Mass..Da.+1.0078) %>% # number the features and get m/z (per Qibin's email about MetaboAnalyst)
  select(compounds,`quant m/z`,HMDB.No.)
# Sample information
samples <- raw_data %>% select(IsoMS_results_QC01_190618171010_converted.csv:
                                 IsoMS_results_S227_Batch07_1400_RA8_converted.csv)
# Rename columns
colnames(samples) <- gsub("IsoMS_results_","",colnames(samples))
colnames(samples) <- gsub("*_.*","",colnames(samples))
# Sample info
sample_info <- data.frame(matrix(nrow = 0,ncol = ncol(samples)))
colnames(sample_info) <- colnames(samples)
sample_info["sampleID",] <- colnames(samples)
sample_info["QC",] <- grepl("QC",sample_info["sampleID",])
# Add batch info
batch <- read.csv("./Data_Cleaned/injection_seq.csv",stringsAsFactors = F)
batch$batch <- sapply(strsplit(batch$SampleName,"_"),`[`,2)
batch$batch[nrow(batch)] <- batch$batch[(nrow(batch)-1)]
batch$batch <- sub("Batch0","",batch$batch)
batch <- batch %>% fill(batch,.direction = "up") %>%
  mutate(order = 1:n())
sample_info["Batch",] <- batch$batch[match(sample_info["sampleID",],batch$GlobalSampleID)]
sample_info["Order",] <- batch$order[match(sample_info["sampleID",],batch$GlobalSampleID)]
# Convert HMDB to PubChem ID - this is very slow. 
# choices = "all" can produce interactive window for multiple matches
temp <- cts_convert(df$HMDB.No.,"Human Metabolome Database","PubChem CID",choices = 1)
df$PubChem <- temp[match(df$HMDB.No.,names(temp))]
# Same again for inchikey
temp <- cts_convert(df$HMDB.No.,"Human Metabolome Database","inchikey",choices = 1)
df$`InChI key` <- temp[match(df$HMDB.No.,names(temp))]
# Add known vs. unknown column
df$Known <- !(is.na(df$HMDB.No.))
# Empty row
sample_info[nrow(sample_info)+1,] <- NA
# Sample info on top of sample data
samples <- rbind(sample_info,samples)
# rownames to column
samples$inf <- rownames(samples)
samples$inf[nrow(sample_info):nrow(samples)] <- NA
samples <- samples %>% select(inf,everything())
# Add empty rows to df
empty <- data.frame(matrix(nrow = nrow(sample_info),ncol = ncol(df)))
colnames(empty) <- colnames(df)
empty[nrow(empty),] <- colnames(empty)
df <- rbind(empty,df)
# Combine df and samples
df <- cbind(df,samples)
# Write
write.table(df,file = "./Data_Cleaned/data_for_metabox.csv",na="",
          row.names = F,col.names = F,sep = ",")
# For Metabox, open the server (uncomment line below) and go to 
# http://localhost:5656/ocpu/library/metabox/www/ in a browser
ocpu_start_server()
