library(tidyverse)
library(caret)
library(parallel)
# Import raw
setwd("~/UCD/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Howard Davidson/TEDDY data")
raw_data = readRDS("./Data_Raw/TEDDY_MP193_Data/raw_time_data.RDS")
# ID columns (common to all stored dataframes)
id_cols = c("y","id","time")
# Loop through list, and pull out matrices
X = lapply(names(raw_data), function(x){
  var = tolower(gsub(" ","_",x))
  dats = raw_data[[x]]
  ts = lapply(names(dats), function(t){
    d = dats[[t]]$X # Predictors (variable column numbers)
    # Lower case ID columns
    y = dats[[t]]$Y
    colnames(y) = tolower(colnames(y))
    # Some overlap between positive and negative lipidomics, so specify which is which
    if(x== "Negative Lipidomics"){
      colnames(d) = paste0(colnames(d),"_negative")
    }
    if(x=="Positive Lipidomics"){
      colnames(d) = paste0(colnames(d),"_positive")
    }
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
})
names(X) = tolower(gsub(" ","_",names(raw_data)))
names(X$positive_lipidomics)
# Turn into long dataset, sort
df = X %>% reduce(full_join) %>% as.data.frame(.)
df = df %>% select(id,time,y,everything()) %>%
  arrange(id,time)
# Save data as a list with a dataframe for each assay
save(df,file = "./Data_Clean/all_timepoints.RData")
