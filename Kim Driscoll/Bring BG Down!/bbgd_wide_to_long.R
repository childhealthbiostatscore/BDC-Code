library(tidyverse)
setwd("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Kim Driscoll/Bring BG Down!")
# Define functions
time_prefix <- function(x){
  split <- strsplit(x,"_")[[1]]
  t <- grep("t\\d(?!d)",split,perl = T)
  ind <- c(1:length(split)) 
  if(length(t)>0){
    ind <- c(t,ind[-t])
  }
  return(paste(split[ind],collapse = "_"))
}
mean_impute <- function(x){
  if(!all(is.na(x))){
    x[is.na(x)] <- mean(as.numeric(x),na.rm = T)
  }
  return(round(x,1))
}
# Read in files
# Manually changed t1 gold column names (added _t1)
child <- read.csv("./Data_Cleaned/child_questionnaire_data.csv")
# Manually changed questionnaire date column names
# Also, the original file contains two T1Q columns, so manually deleted 
# the left (incorrect) one. Also manually changed id column name. 
q_dates <- read.csv("./Data_Cleaned/questionnaire_dates.csv",na.strings = "")
child_q_dates <- q_dates[q_dates$MOTHER==0,]
parent_q_dates <- q_dates[q_dates$MOTHER==1,]
# Delete HEA survey data, bcos as character
child[,grep("hea1",colnames(child))] <- NULL
child[,grep("hea2",colnames(child))] <- NULL
child$child_bocs3_t4_other <- 
  as.character(child$child_bocs3_t4_other)
child$child_bcos6_t4_other <- 
  as.character(child$child_bcos6_t4_other)
# Column name prefixes
colnames(child) <- 
  lapply(colnames(child), time_prefix)
# Add questionnaire completion dates
child <- left_join(child,child_q_dates,by = "participant_id")
# For each variable, add empty columns for missing times
variable_list <- 
  colnames(child)[grep("t\\d_",colnames(child))]
variable_list <- unique(sub("t\\d_","",variable_list))

all_vars <- expand_grid(
  time = paste0("t", 1:6),
  value = variable_list
) %>% unite("vars", everything())

missing_vars <- setdiff(all_vars$vars, names(child))
child[missing_vars] <- NA
# Pivot longer
long <- child %>% 
  pivot_longer(t1_child_name_first:t6_last_name,
               names_to = c("time",".value"),
               names_pattern = "t(.)_(.*)",
               values_drop_na = T)
# Mean imputation
long[,grep("gad",colnames(long))] <- 
  t(apply(long[,grep("gad",colnames(long))],1,mean_impute))
long[,grep("child_foh1",colnames(long))] <- 
  t(apply(long[,grep("child_foh1",colnames(long))],1,mean_impute))
long[,grep("child_foh2",colnames(long))] <- 
  t(apply(long[,grep("child_foh2",colnames(long))],1,mean_impute))
long[,grep("^gold",colnames(long))] <- 
  t(apply(long[,grep("^gold",colnames(long))],1,mean_impute))
# Write CSV
write.csv(long,file = "./Data_Cleaned/long_child_data.csv",
          row.names = F,na = '')
# Same approach for adult data
# Read in files
# Manually changed t1 gold column names (added _t1)
parent <- read.csv("./Data_Cleaned/parent_questionnaire_data.csv")
# Delete HEA survey data
parent[,grep("hea1",colnames(parent))] <- NULL
parent[,grep("hea2",colnames(parent))] <- NULL
# Column name prefixes
colnames(parent) <- 
  lapply(colnames(parent), time_prefix)
# Add questionnaire completion dates
parent <- left_join(parent,parent_q_dates,by = "participant_id")
# For each variable, add empty columns for missing times
variable_list <- 
  colnames(parent)[grep("t\\d_",colnames(parent))]
variable_list <- unique(sub("t\\d_","",variable_list))

all_vars <- expand_grid(
  time = paste0("t", 1:6),
  value = variable_list
) %>% unite("vars", everything())

missing_vars <- setdiff(all_vars$vars, names(parent))
parent[missing_vars] <- NA
# Pivot longer
long <- parent %>% 
  pivot_longer(t1_par_name_first:t6_par_otherch5_illness,
               names_to = c("time",".value"),
               names_pattern = "t(.)_(.*)",
               values_drop_na = T)
# Mean imputation
long[,grep("gad",colnames(long))] <- 
  t(apply(long[,grep("gad",colnames(long))],1,mean_impute))
long[,grep("par_foh1",colnames(long))] <- 
  t(apply(long[,grep("par_foh1",colnames(long))],1,mean_impute))
long[,grep("par_foh2",colnames(long))] <- 
  t(apply(long[,grep("par_foh2",colnames(long))],1,mean_impute))
long[,grep("par_oci",colnames(long))] <- 
  t(apply(long[,grep("par_oci",colnames(long))],1,mean_impute))
long[,grep("^gold",colnames(long))] <- 
  t(apply(long[,grep("^gold",colnames(long))],1,mean_impute))
# Write CSV
write.csv(long,file = "./Data_Cleaned/long_parent_data.csv",
          row.names = F,na = '')
