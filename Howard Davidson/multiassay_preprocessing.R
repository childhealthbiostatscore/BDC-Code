library(tidyverse)
library(caret)
library(parallel)
# Import raw
setwd("/mnt/UCD/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Howard Davidson/TEDDY data")
raw_data = readRDS("./Data_Raw/TEDDY_MP193_Data/raw_time_data.RDS")
# Loop through list, and pull out matrices
X = lapply(names(raw_data), function(x){
  var = x
  var = tolower(gsub(" ","_",var))
  dats = raw_data[[x]]
  ts = lapply(names(dats), function(t){
    d = dats[[t]]$X # Predictors (variable column numbers)
    y = dats[[t]]$Y
    y = y[,c("y","ID","time","due_num","pair")] # All need same columns for y
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
# Data cleaning (in parallel)
cores = 6
cl = makeCluster(cores,type = "FORK")
# Remove columns with CV > 30% (per Speake paper)
cv = parLapply(cl,df[,6:ncol(df)],function(c){sd(c,na.rm = T)/mean(c,na.rm = T)})
# Save data
# save(df,file = "./Data_Clean/rectangular_data.RData")
