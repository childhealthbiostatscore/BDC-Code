# Setup
library(tidyverse)
library(refund)
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
# We want to use sparse/irregular FPCA for these data. Unfortunately the
# face.sparse function can't handle large dataset, so for now we'll average by
# time of day across 1 week periods.
# Calculate days from progression or last visit
cgm <- cgm %>%
    mutate(
        CGMDaysFromEndpoint = as.numeric(difftime(
            dov_CGM,
            LastVisitDate,
            units = "days"
        )),
    )
# Average by hour of day for each CGM wear
cgm_wear <- cgm %>%
    group_by(ID, CGMDaysFromEndpoint, Time) %>%
    summarise(SensorValue = mean(SensorValue, na.rm = TRUE), .groups = "drop")
# None of this is working and I think that we may have too much/too spare data
# for the FDA packages. Hang on to the code for now, but don't bother running
# it.
# Create sparse datasets
sparse_cgm_prog1 <- cgm %>%
    filter(ID %in% c("00174-0", "00376-0")) %>%
    select(ID, TimeFromEndpoint, SensorValue) %>%
    rename(subj = ID, argvals = TimeFromEndpoint, y = SensorValue) %>%
    drop_na()
sparse_cgm_prog2 <- cgm %>%
    filter(ID %in% c("00174-0", "00376-0", "00670-0")) %>%
    select(ID, TimeFromEndpoint, SensorValue) %>%
    rename(subj = ID, argvals = TimeFromEndpoint, y = SensorValue) %>%
    drop_na()
face_fit_non_prog1 <- face.sparse(sparse_cgm_prog1)
face_fit_non_prog2 <- face.sparse(sparse_cgm_prog2)

sparse_cgm_non_prog <- cgm %>%
    filter(Group == "Non-Progressor") %>%
    select(ID, TimeFromEndpoint, SensorValue) %>%
    rename(.id = ID, .index = TimeFromEndpoint, .value = SensorValue) %>%
    drop_na()
face_fit_prog <- fpca.sc(ydata = sparse_cgm_prog)
face_fit_non_prog <- face.sparse(
    sparse_cgm_non_prog,
    calculate.scores = TRUE,
    two_step = TRUE
)
save(
    face_fit_prog,
    sparse_cgm_prog,
    face_fit_non_prog,
    sparse_cgm_non_prog,
    file = "./Data_Clean/face_fit_sparse_cgm.RData"
)
