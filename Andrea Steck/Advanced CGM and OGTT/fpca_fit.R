# Setup
library(tidyverse)
library(face)
library(ff)
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
sparse_cgm <- cgm %>%
    select(ID, TimeFromEndpoint, SensorValue) %>%
    rename(argvals = TimeFromEndpoint, subj = ID, y = SensorValue) %>%
    drop_na()
sparse_cgm$subj <- as.factor(sparse_cgm$subj)
sparse_cgm <- as.ffdf(sparse_cgm)
face_fit <- face.sparse(sparse_cgm, calculate.scores = TRUE, pve = 0.95)
save(face_fit, sparse_cgm, file = "./Data_Clean/face_fit_sparse_cgm.RData")
