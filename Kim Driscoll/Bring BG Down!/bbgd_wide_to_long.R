library(tidyverse)
setwd("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Kim Driscoll/Bring BG Down!")
# Read in files
child_questionnaires <- read.csv("./Data_Cleaned/child_questionnaire_data.csv")
# Column name prefixes
time_prefix <- function(x){
  split <- strsplit(x,"_")[[1]]
  t <- grep("t.",split)
  ind <- c(1:length(split)) 
  if(length(t)>0){
    ind <- c(t,ind[-t])
  }
  return(paste(split[ind],collapse = "_"))
}
colnames(child_questionnaires) <- 
  lapply(colnames(child_questionnaires), time_prefix)
# For each variable, add empty columns for missing times
variable_list <- 
  colnames(child_questionnaires)[grep("t\\d_",colnames(child_questionnaires))]
variable_list <- unique(sub("t\\d_","",variable_list))

all_vars <- expand_grid(
  time = paste0("t", 1:6),
  value = variable_list
) %>% unite("vars", everything())

missing_vars <- setdiff(all_vars$vars, names(child_questionnaires))
child_questionnaires[missing_vars] <- NA
# Format columns
num_cols <- c("t1_child_hea1_1a")
child_questionnaires[,num_cols] <- lapply(child_questionnaires[,num_cols],as.numeric)
# Pivot longer
child_questionnaires %>% 
  pivot_longer(t1_child_name_first:t6_last_name,
               names_to = c("time",".value"),
               names_pattern = "(.)_(.*)",
               values_drop_na = T)


