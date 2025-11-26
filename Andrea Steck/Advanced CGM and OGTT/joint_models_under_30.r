library(tidyverse)
library(plotly)
library(nlme)
library(JM)
library(JMbayes2)
library(GLMMadaptive)
library(ggsurvfit)
library(knitr)
base_dir <- switch(
  Sys.info()["nodename"],
  "togo" = "/home/tvigers/Documents/Data",
  "Tims-MacBook-Air.local" = "/Users/tim/Library/CloudStorage/OneDrive-UW",
)
data_dir <- switch(
  Sys.info()["nodename"],
  "togo" = "/BDC/Andrea Steck/Advanced CGM and OGTT",
  "Tims-MacBook-Air.local" = "/UWMDI/Andrea Steck/Advanced CGM and OGTT",
)
setwd(paste0(base_dir, data_dir))
# See BDC-Code/Andrea Steck/Advanced CGM and OGTT/create_analysis_dataset.R
load("./Data_Clean/analysis_dataset.RData")
# Filter out age > 30
cgm_lmm = cgm_lmm |> filter(Age <= 30)
cgm_surv = cgm_surv |> filter(ID %in% unique(cgm_lmm$ID))
# Cox model
cox_fit <- coxph(
  Surv(Ages, event) ~ sex +
    Race_Ethn2 +
    screen_FDR_GP +
    maxAB_group,
  x = T,
  model = T,
  data = cgm_surv
)
# Mean glucose
lme_fit_mean_rs <- lme(
  mean_glucose ~ Age,
  random = ~ Age | ID,
  data = cgm_lmm
)
joint_fit_mean <- jm(
  cox_fit,
  lme_fit_mean_rs,
  time_var = "Age",
  id_var = "ID",
  n_iter = 1e6,
  n_burnin = 1e3,
  control = list(n_chains = 4, cores = 4)
)
# SD
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
  n_burnin = 1e3,
  control = list(n_chains = 4, cores = 4)
)
# Both
joint_fit_mean_sd <- jm(
  cox_fit,
  list(lme_fit_mean_rs, lme_fit_sd_rs),
  time_var = "Age",
  id_var = "ID",
  n_iter = 1e6,
  n_burnin = 1e3,
  control = list(n_chains = 4, cores = 4)
)
# CV
lme_fit_cv_rs <- lme(
  cv_glucose ~ Age,
  random = ~ Age | ID,
  data = cgm_lmm
)
joint_fit_cv <- jm(
  cox_fit,
  lme_fit_cv_rs,
  time_var = "Age",
  id_var = "ID",
  n_iter = 1e6,
  n_burnin = 1e3,
  control = list(n_chains = 4, cores = 4)
)
# TAR
lme_fit_tar_rs = mixed_model(
  perc_time_over_140 ~ Age,
  random = ~ Age | ID,
  data = cgm_lmm,
  family = "negative.binomial"
)
joint_fit_tar <- jm(
  cox_fit,
  lme_fit_tar_rs,
  time_var = "Age",
  id_var = "ID",
  n_iter = 1e6,
  n_burnin = 1e3,
  control = list(n_chains = 4, cores = 4)
)
# HbA1c
lme_fit_hba1c_rs <- lme(
  hba1c ~ Age,
  random = ~ Age | ID,
  data = cgm_lmm
)
joint_fit_hba1c <- jm(
  cox_fit,
  lme_fit_hba1c_rs,
  time_var = "Age",
  id_var = "ID",
  n_iter = 1e6,
  n_burnin = 1e3,
  control = list(n_chains = 4, cores = 4)
)
# Save everything
save(
  cgm,
  cgm_lmm,
  cgm_surv,
  cox_fit,
  lme_fit_mean_rs,
  lme_fit_sd_rs,
  lme_fit_cv_rs,
  lme_fit_tar_rs,
  lme_fit_hba1c_rs,
  joint_fit_mean,
  joint_fit_sd,
  joint_fit_mean_sd,
  joint_fit_cv,
  joint_fit_tar,
  joint_fit_hba1c,
  file = "./Data_Clean/joint_model_under_30_results.RData"
)
