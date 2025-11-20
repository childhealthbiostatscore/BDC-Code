library(tidyverse)
library(plotly)
library(nlme)
library(JM)
library(JMbayes2)
library(ggsurvfit)
library(knitr)
home_dir <- switch(
  Sys.info()["user"],
  "laurapyle" = "/Users/laurapyle/Library/CloudStorage/OneDrive-SharedLibraries-UW(2)/Tim Vigers - UWMDI/Andrea Steck/Advanced CGM and OGTT",
  "lpyle" = "/Users/lpyle/Library/CloudStorage/OneDrive-SharedLibraries-UW(2)/Tim Vigers - UWMDI/Andrea Steck/Advanced CGM and OGTT",
  "pylell" = "/Users/pylell/Library/CloudStorage/OneDrive-SharedLibraries-UW(2)/Tim Vigers - UWMDI/Andrea Steck/Advanced CGM and OGTT",
  "tvigers" = "/gscratch/togo/tvigers/Data/BDC/Andrea Steck/Advanced CGM and OGTT",
  "root" = "/gscratch/togo/tvigers/Data/BDC/Andrea Steck/Advanced CGM and OGTT",
  "tim" = "/Users/tim/Library/CloudStorage/OneDrive-UW/UWMDI/Andrea Steck/Advanced CGM and OGTT"
)
setwd(home_dir)
# See BDC-Code/Andrea Steck/Advanced CGM and OGTT/create_analysis_dataset.R
load("./Data_Clean/analysis_dataset.RData")
# Calculate age and days from progression or last visit, and time from first CGM
cgm <- cgm |>
  mutate(
    Age = as.numeric(difftime(dov_CGM, DOB, units = "days")) / 365.25,
    AgeEndpoint = as.numeric(difftime(LastVisitDate, DOB, units = "days")),
    CGMDaysFromEndpoint = as.numeric(difftime(
      dov_CGM,
      LastVisitDate,
      units = "days"
    ))
  ) |>
  group_by(ID, study) |>
  mutate(
    FirstCGMDate = first(dov_CGM),
    TimeFromFirstCGM = as.numeric(difftime(
      dov_CGM,
      FirstCGMDate,
      units = "days"
    )),
    TimeOfEndpoint = as.numeric(difftime(
      LastVisitDate,
      FirstCGMDate,
      units = "days"
    ))
  ) |>
  ungroup()
# Exclude 05-01813's weird 2019-12-17 CGM per Brigs
cgm <- cgm |> filter(!(ID == "05-01813" & dov_CGM == "2019-12-17"))
# Time periods per Andrea and Brigs
cgm <- cgm |>
  mutate(
    nTime = as.numeric(Time),
    TimePeriod = case_when(
      nTime >= 82800 | nTime < 18000 ~ "11pm - 5am",
      nTime >= 18000 & nTime < 39600 ~ "5am - 11am",
      nTime >= 39600 & nTime < 61200 ~ "11am - 5pm",
      nTime >= 61200 & nTime < 82800 ~ "5pm - 11pm",
      .default = "other"
    ),
    # Shift numeric time so that 11pm is our 0
    nTime = ifelse(nTime >= 82800, nTime - 82800, nTime + 3600)
  )
cgm$TimePeriod <- factor(
  cgm$TimePeriod,
  levels = c("11pm - 5am", "5am - 11am", "11am - 5pm", "5pm - 11pm")
)
# For each CGM wear, calculate summary metrics for LMMs
cgm_lmm <- cgm |>
  filter(CGMDaysFromEndpoint <= 0) |>
  group_by(
    ID,
    Group,
    sex,
    Race_Ethn2,
    screen_FDR_GP,
    maxAB_group,
    Age
  ) |>
  summarise(
    mean_glucose = median(SensorValue, na.rm = TRUE),
    eA1c = (mean_glucose + 46.7) / 28.7,
    sd_glucose = sd(SensorValue, na.rm = TRUE),
    .groups = "drop"
  ) |>
  drop_na()
# Create survival dataset
cgm_surv <- cgm |>
  group_by(
    ID,
    Group,
    sex,
    Race_Ethn2,
    screen_FDR_GP,
    maxAB_group
  ) |>
  summarise(AgeEndpoint = unique(AgeEndpoint) / 365.25, .groups = "drop") |>
  rename(Ages = AgeEndpoint) |>
  filter(ID %in% cgm_lmm$ID)
cgm_surv$event = as.numeric(cgm_surv$Group == "Progressor")
# Drop unused levels
cgm_lmm$maxAB_group <- droplevels(cgm_lmm$maxAB_group)
cgm_surv$maxAB_group <- droplevels(cgm_surv$maxAB_group)
# Mean glucose
lme_fit_mean_ri <- lme(
  mean_glucose ~ Age,
  random = ~ 1 | ID,
  data = cgm_lmm
)
lme_fit_mean_rs <- lme(
  mean_glucose ~ Age,
  random = ~ Age | ID,
  data = cgm_lmm
)
cox_fit <- coxph(
  Surv(Ages, event) ~ sex +
    Race_Ethn2 +
    screen_FDR_GP +
    maxAB_group,
  x = T,
  model = T,
  data = cgm_surv
)
joint_fit_mean <- jm(
  cox_fit,
  lme_fit_mean_rs,
  time_var = "Age",
  id_var = "ID",
  n_iter = 1e6,
  n_burnin = 1e4,
  # For some reason, the snow package doesn't seem to work on the Hyak. Not
  # entirely clear why, but the function just hangs and doesn't throw any
  # errors.
  parallel = "multicore",
  control = list(n_chains = 4, cores = 4)
)
# SD
lme_fit_sd_ri <- lme(
  sd_glucose ~ Age,
  random = ~ 1 | ID,
  data = cgm_lmm,
  control = list(opt = "optim")
)
lme_fit_sd_rs <- lme(
  sd_glucose ~ Age,
  random = ~ Age | ID,
  data = cgm_lmm,
  control = list(opt = "optim")
)
joint_fit_sd <- jm(
  cox_fit,
  lme_fit_sd_rs,
  time_var = "Age",
  id_var = "ID",
  n_iter = 1e6,
  n_burnin = 1e4,
  parallel = "multicore",
  control = list(n_chains = 4, cores = 4)
)
# Both
joint_fit_mean_sd <- jm(
  cox_fit,
  list(lme_fit_mean_rs, lme_fit_sd_rs),
  time_var = "Age",
  id_var = "ID",
  n_iter = 1e6,
  n_burnin = 1e4,
  parallel = "multicore",
  control = list(n_chains = 4, cores = 4)
)
# Save everything
save(
  cgm,
  cgm_lmm,
  cgm_surv,
  cox_fit,
  lme_fit_mean_ri,
  lme_fit_mean_rs,
  joint_fit_mean,
  lme_fit_sd_ri,
  lme_fit_sd_rs,
  joint_fit_sd,
  joint_fit_mean_sd,
  file = "./Data_Clean/joint_model_results.RData"
)
