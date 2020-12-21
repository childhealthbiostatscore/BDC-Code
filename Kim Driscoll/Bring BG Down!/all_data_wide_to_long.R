library(tidyverse)
setwd("C:/Users/Tim Vigers/Desktop/bbgd")
# Read in file
child = read.csv("./BringBGDownChild_DATA.csv")
# Convert all columns to character for easier combination
child = child %>% mutate_all(as.character)
# Get time dependent variables
vars = colnames(child)[grep(".*_t[0-9]",colnames(child))]
vars = unique(gsub("_t[0-9]","",vars))
# For each variable, add empty columns for missing times
all_vars <- expand_grid(time = paste0("t", 1:8), value = vars) %>% 
  unite("vars",value,time)
missing_vars <- setdiff(all_vars$vars, names(child))
child[missing_vars] <- NA
# Pivot longer
long <- child %>% 
  pivot_longer(c_hea_number_yn_t1:c_hospital_hypo_12mo_t8,
               names_to = c(".value","time"),
               names_pattern = "c_(.*)_(.*)",
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
