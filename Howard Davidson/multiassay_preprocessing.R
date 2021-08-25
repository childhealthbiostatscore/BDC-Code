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
cores = 12
# Remove columns with >= 80% missing and with CV > 30% (per Speake paper)
cl = makeCluster(cores,type = "FORK")
keep = parLapply(cl,names(df[,-c(1:5)]),function(n){
  missing = mean(is.na(df[,n]))
  cv = sd(df[,n],na.rm = T)/mean(df[,n],na.rm = T)
  if (cv <= 0.3 & missing < 0.8){
    return(n)
  } else {
    return(NA)
  }
})
stopCluster(cl)
keep = c(colnames(df)[1:5],unlist(keep)[!is.na(keep)])
df = df[,keep]
# Save data
save(df,file = "./Data_Clean/rectangular_data.RData")
