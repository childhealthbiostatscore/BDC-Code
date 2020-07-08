library(tidyverse)
setwd("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Kim Driscoll/Bring BG Down!")
# Read in files
child_questionnaires <- read.csv("./Data_Cleaned/child_questionnaire_data.csv")


# Column name prefixes
paste(strsplit("gold2_1_t6","_")[[1]][c(grep("t.",strsplit("gold2_1_t6","_")[[1]]),1:2)],collapse = "_")

get_prefix <- function(x){
  split <- strsplit(x,"_")[[1]]
  t <- grep("t.",split)
  ind <- c(1:length(split)) 
  ind <- c(t,ind[-t])
  return(paste(split[ind],collapse = "_"))
}

# Pivot longer
child_questionnaires %>% pivot_longer()