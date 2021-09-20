library(tidyverse)
library(caret)
library(parallel)
# Import raw
setwd("Z:/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Howard Davidson/TEDDY data")
raw_data = readRDS("./Data_Raw/TEDDY_MP193_Data/raw_time_data.RDS")
# ID columns (common to all stored dataframes)
id_cols = c("y","ID","time")
# Loop through list, and pull out matrices
X = lapply(names(raw_data), function(x){
  var = tolower(gsub(" ","_",x))
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
  df = data.frame(do.call(rbind,ts)) # Bind together
  df = df[df$time == 0,] # time 0 only for now
})
names(X) = tolower(gsub(" ","_",names(raw_data)))
# Save data as a list with a dataframe for each assay
save(X,file = "./Data_Clean/time_0.RData")
