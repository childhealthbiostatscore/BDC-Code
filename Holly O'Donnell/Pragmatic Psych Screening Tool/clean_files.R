library(tidyverse)
setwd("~/Documents")
# Make folder for cleaned files
dir.create("Data_Clean/Pump Files",showWarnings = F)
# Carelink
files = list.files("./Data_Raw/Device Files/Carelink",full.names = T)
for (f in files) {
  id <- sub("_.*","",basename(f))
  
}