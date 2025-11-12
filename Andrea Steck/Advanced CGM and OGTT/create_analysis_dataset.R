library(tidyverse)
library(readxl)
library(haven)
library(hms)
home_dir <- switch(
  Sys.info()[["user"]],
  "laurapyle" = "/Users/laurapyle/Library/CloudStorage/OneDrive-TheUniversityofColoradoDenver/Vigers/BDC/Andrea Steck/Advanced CGM and OGTT",
  "lpyle" = "/Users/lpyle/Library/CloudStorage/OneDrive-UW/Bjornstad/Biostatistics Core Shared Drive/TODAY subaward",
  "tim" = "/Users/tim/Library/CloudStorage/OneDrive-UW/UWMDI/Andrea Steck/Advanced CGM and OGTT"
)
setwd(home_dir)
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
# Save
write.csv(cgm, file = "./Data_Clean/cgm.csv", row.names = F, na = "")
save(cgm, file = "./Data_Clean/analysis_dataset.RData")
