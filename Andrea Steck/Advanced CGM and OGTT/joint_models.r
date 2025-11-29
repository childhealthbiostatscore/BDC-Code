library(tidyverse)
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
  "Tims-Mac-mini.local" = "/Users/tim/Library/CloudStorage/OneDrive-UW",
  "Mac" = "/Users/tim/Library/CloudStorage/OneDrive-UW"
)
data_dir <- switch(
  Sys.info()["nodename"],
  "togo" = "/BDC/Andrea Steck/Advanced CGM and OGTT",
  "Tims-MacBook-Air.local" = "/UWMDI/Andrea Steck/Advanced CGM and OGTT",
  "Tims-Mac-mini.local" = "/UWMDI/Andrea Steck/Advanced CGM and OGTT",
  "Mac" = "/UWMDI/Andrea Steck/Advanced CGM and OGTT"
)
setwd(paste0(base_dir, data_dir))
# See BDC-Code/Andrea Steck/Advanced CGM and OGTT/create_analysis_dataset.R
load("./Data_Clean/analysis_dataset.RData")
# Filter out age > 30
# cgm_lmm = cgm_lmm |> filter(Age <= 30)
# cgm_surv = cgm_surv |> filter(ID %in% unique(cgm_lmm$ID))
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
save(cox_fit, file = "./Data_Clean/Joint Model Results/All/cox_fit.RData")
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
  control = list(n_chains = 4, cores = 1)
)
# Save and clean up memory
save(
  joint_fit_mean,
  file = "./Data_Clean/Joint Model Results/All/joint_fit_mean.RData"
)
rm(joint_fit_mean)
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
  control = list(n_chains = 4, cores = 1)
)
# Save and clean up memory
save(
  joint_fit_sd,
  file = "./Data_Clean/Joint Model Results/All/joint_fit_sd.RData"
)
rm(joint_fit_sd)
# Both
joint_fit_mean_sd <- jm(
  cox_fit,
  list(lme_fit_mean_rs, lme_fit_sd_rs),
  time_var = "Age",
  id_var = "ID",
  n_iter = 1e6,
  n_burnin = 1e3,
  control = list(n_chains = 4, cores = 1)
)
# Save and clean up memory
save(
  lme_fit_mean_rs,
  lme_fit_sd_rs,
  joint_fit_mean_sd,
  file = "./Data_Clean/Joint Model Results/All/joint_fit_mean_sd.RData"
)
rm(lme_fit_mean_rs, lme_fit_sd_rs, joint_fit_mean_sd)
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
  control = list(n_chains = 4, cores = 1)
)
# Save and clean up memory
save(
  lme_fit_cv_rs,
  joint_fit_cv,
  file = "./Data_Clean/Joint Model Results/All/joint_fit_cv.RData"
)
rm(lme_fit_cv_rs, joint_fit_cv)
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
  control = list(n_chains = 4, cores = 1)
)
# Save and clean up memory
save(
  lme_fit_tar_rs,
  joint_fit_tar,
  file = "./Data_Clean/Joint Model Results/All/joint_fit_tar.RData"
)
rm(lme_fit_tar_rs, joint_fit_tar)
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
  control = list(n_chains = 4, cores = 1)
)
# Save
save(
  lme_fit_hba1c_rs,
  joint_fit_hba1c,
  file = "./Data_Clean/Joint Model Results/All/joint_fit_hba1c.RData"
)
