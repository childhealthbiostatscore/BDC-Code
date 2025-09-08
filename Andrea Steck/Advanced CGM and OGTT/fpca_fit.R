# Setup
library(tidyverse)
library(face)
home_dir <- switch(
    Sys.info()[["user"]],
    "laurapyle" = "/Users/laurapyle/Library/CloudStorage/OneDrive-TheUniversityofColoradoDenver/Vigers/BDC/Andrea Steck/Advanced CGM and OGTT",
    "lpyle" = "/Users/lpyle/Library/CloudStorage/OneDrive-UW/Bjornstad/Biostatistics Core Shared Drive/TODAY subaward",
    "tim" = "/Users/tim/Library/CloudStorage/OneDrive-TheUniversityofColoradoDenver/Vigers/BDC/Andrea Steck/Advanced CGM and OGTT",
    "tvigers" = "/gscratch/togo/tvigers/BDC/Andrea Steck/Advanced CGM and OGTT"
)
setwd(home_dir)
# Import
load(file = "./Data_Clean/analysis_dataset.RData")
# We want to use sparse/irregular FPCA for these data. For now, we'll set the
# domain as time to last visit
ids <- unique(cgm$ID)[1:5]
sparse_cgm <- cgm %>%
    select(ID, TimeFromEndpoint, SensorValue) %>%
    filter(ID %in% ids) %>%
    rename(argvals = TimeFromEndpoint, subj = ID, y = SensorValue) %>%
    drop_na()
face_fit <- face.sparse(sparse_cgm, calculate.scores = TRUE, pve = 0.95)
