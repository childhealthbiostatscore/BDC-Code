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
        DaysFromEndpoint = as.numeric(difftime(
            Date,
            LastVisitDate,
            units = "days"
        )),
        WeeksFromEndpoint = as.numeric(difftime(
            Date,
            LastVisitDate,
            units = "weeks"
        ))
    )
cgm$TimePeriod <- ceiling(cgm$WeeksFromEndpoint)
cgm <- cgm %>%
    group_by(ID, Group, TimePeriod, Time) %>%
    summarise(
        SensorValue = mean(SensorValue, na.rm = TRUE),
        .groups = "drop"
    )
# Create sparse datasets
sparse_cgm_prog <- cgm %>%
    filter(Group == "Progressor") %>%
    select(ID, TimePeriod, SensorValue) %>%
    rename(subj = ID, argvals = TimePeriod, y = SensorValue) %>%
    drop_na()
sparse_cgm_non_prog <- cgm %>%
    filter(Group == "Non-Progressor") %>%
    select(ID, TimePeriod, SensorValue) %>%
    rename(subj = ID, argvals = TimePeriod, y = SensorValue) %>%
    drop_na()
face_fit_prog <- face.sparse(
    sparse_cgm_prog,
    calculate.scores = TRUE,
    two_step = TRUE
)
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
