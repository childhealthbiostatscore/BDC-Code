library(tidyverse)
library(caret)
library(parallel)
# Import raw
setwd("/mnt/UCD/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Howard Davidson/TEDDY data")
raw_data = readRDS("./Data_Raw/TEDDY_MP193_Data/raw_time_data.RDS")
# ID columns (common to all stored dataframes)
id_cols = c("y","ID","time","due_num","pair")
# Loop through list, and pull out matrices
X = lapply(names(raw_data), function(x){
  var = x
  var = tolower(gsub(" ","_",var))
  dats = raw_data[[x]]
  ts = lapply(names(dats), function(t){
    d = dats[[t]]$X # Predictors (variable column numbers)
    y = dats[[t]]$Y
    y = y[,c(id_cols)] # All need same columns for y
    d = cbind(d,y)
    if(ncol(dats[[t]]$X) == 1){
      colnames(d)[1] = var
    } else {
      colnames(d) = tolower(gsub(" ","_",colnames(d)))
    }
    return(d)
  })
  data.frame(do.call(rbind,ts)) # Bind together
})
# Use purrr's reduce function to merge all dataframes
df = X %>% reduce(full_join) %>% arrange(ID,time) %>% 
  select(ID,time,due_num,pair,y,everything())
# Save data
save(df,predictors,file = "./Data_Clean/all_timepoints.RData")
# Pull data by timepoint
get_timepoint = function(data = raw_data,time){
  timepoint = paste0("Time_",time)
  t = lapply(names(raw_data), function(x){
    var = x
    var = tolower(gsub(" ","_",var))
    dats = raw_data[[x]][[timepoint]]
    if(ncol(dats$X)==1){colnames(dats$X) = var}
    df = data.frame(cbind(dats$X,dats$Y))
  })
  t = t %>% reduce(full_join) %>%  
    select(ID,time,due_num,pair,y,everything())
  return(t)
}
# Get all times and save
time_0 = get_timepoint(time = 0)
time_minus_1 = get_timepoint(time = -1)
time_minus_2 = get_timepoint(time = -2)
time_minus_3 = get_timepoint(time = -3)
time_minus_4 = get_timepoint(time = -4)
# Save data
save(time_0,time_minus_1,time_minus_2,time_minus_3,time_minus_4,
     file = "./Data_Clean/separate_timepoints.RData")