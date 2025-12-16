library(tidyverse)
library(readxl)
library(haven)
library(hms)
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
# Import CGM data from Fran
cgm <- read_sas(
  "./Data_Raw/Final data20250801/tim_allcgmclean_gt4days.sas7bdat"
)
# Import demographics
demo <- read_sas("./Data_Raw/Final data20250801/demo270.sas7bdat")
add_demo <- read_sas("./Data_Raw/Final data20250801/adddata.sas7bdat")
maxab <- read_sas("./Data_Raw/Final data20250801/maxab.sas7bdat")
# Format demographics columns
demo$Race_Ethn2 <- factor(
  demo$Race_Ethn2,
  levels = c("AA", "HISP", "NHW", "Other"),
  labels = c("Other", "Other", "NHW", "Other")
)
# Get max AB group (the file from Fran isn't actually the maximum, it's the AB)
# status at each visit
maxab <- maxab |>
  group_by(ID, study) |>
  summarise(maxAB_group = max(maxAB_group), .groups = "drop")
maxab$maxAB_group <- factor(maxab$maxAB_group)
# Add max AB to demographics
demo <- left_join(demo, maxab, by = join_by(study, ID))
# Find date of last visit
demo$LastVisitDate <- demo$lastage * 365.25 + ymd(demo$DOB)
# Convert from numeric time to datetime, round to nearest 5 minutes
cgm$sensordisplaytime <- as.POSIXct(cgm$newsensortime, origin = "1960-01-01")
cgm$sensordisplaytime <- round_date(cgm$sensordisplaytime, "5 minutes")
# Separate date and time columns, format
cgm$Date <- as_date(cgm$sensordisplaytime)
cgm$Time <- as_hms(cgm$sensordisplaytime)
cgm <- cgm %>% rename(SensorValue = sensor_glucose)
# For now, if people have duplicated sensor values, take the mean
cgm <- cgm %>%
  group_by(ID, study, dov_CGM, Date, Time) %>%
  summarise(SensorValue = mean(SensorValue, na.rm = TRUE), .groups = "drop") %>%
  arrange(ID, Date, Time)
# Merge
cgm <- full_join(cgm, demo, by = join_by(ID, study))
cgm <- full_join(cgm, add_demo, by = join_by(ID, study, dov_CGM))
# Determine group
cgm$Group <- factor(
  cgm$case_T1D,
  levels = c(0, 1),
  labels = c("Non-Progressor", "Progressor")
)
# Format dates, etc.
cgm$DOVISIT <- ymd(cgm$DOVISIT)
cgm$EventVisDt_t1d <- ymd(cgm$EventVisDt_t1d)
cgm$lastVisDt <- ymd(cgm$lastVisDt)
# Order and select columns
cgm <- cgm %>%
  select(
    ID,
    study,
    Group,
    sex,
    Race_Ethn2,
    screen_FDR_GP,
    maxAB_group,
    DOB,
    dov_CGM,
    LastVisitDate,
    Date,
    Time,
    A1C,
    bmi,
    bmiz,
    DOVISIT,
    dov_CGM,
    SensorValue
  )
# Some more formatting
cgm$sex <- factor(cgm$sex)
cgm$screen_FDR_GP <- factor(cgm$screen_FDR_GP)
cgm$study <- factor(cgm$study)
# Data for joint models
# Calculate age and days from progression or last visit, and time from first CGM
cgm <- cgm |>
  mutate(
    Age = as.numeric(difftime(dov_CGM, DOB, units = "days")) / 365.25,
    AgeEndpoint = as.numeric(difftime(LastVisitDate, DOB, units = "days")) /
      365.25,
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
    )) /
      365.25,
    TimeOfEndpoint = as.numeric(difftime(
      LastVisitDate,
      FirstCGMDate,
      units = "days"
    )) /
      365.25
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
    study,
    Group,
    sex,
    Race_Ethn2,
    screen_FDR_GP,
    maxAB_group,
    Age,
    TimeFromFirstCGM
  ) |>
  summarise(
    mean_glucose = mean(SensorValue, na.rm = TRUE),
    sd_glucose = sd(SensorValue, na.rm = TRUE),
    cv_glucose = sd_glucose / mean_glucose,
    perc_time_over_140 = round(mean(SensorValue > 140, na.rm = T) * 100),
    hba1c = unique(A1C),
    .groups = "drop"
  ) |>
  drop_na()
# Create survival dataset
cgm_surv <- cgm |>
  group_by(
    ID,
    study,
    Group,
    sex,
    Race_Ethn2,
    screen_FDR_GP,
    maxAB_group
  ) |>
  summarise(
    AgeEndpoint = unique(AgeEndpoint),
    EndTime = unique(TimeOfEndpoint),
    .groups = "drop"
  ) |>
  filter(ID %in% cgm_lmm$ID)
cgm_surv$event = as.numeric(cgm_surv$Group == "Progressor")
# Drop unused levels
cgm_lmm$maxAB_group <- droplevels(cgm_lmm$maxAB_group)
cgm_surv$maxAB_group <- droplevels(cgm_surv$maxAB_group)
# Save
save(cgm, cgm_lmm, cgm_surv, file = "./Data_Clean/analysis_dataset.RData")
