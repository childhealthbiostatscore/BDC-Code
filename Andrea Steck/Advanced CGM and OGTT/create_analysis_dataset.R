library(tidyverse)
library(readxl)
library(haven)
library(hms)
home_dir <- switch(Sys.info()["sysname"],
  "Darwin" = "/Users/tim/Library/CloudStorage/OneDrive-TheUniversityofColoradoDenver/Vigers/BDC/Andrea Steck/Advanced CGM and OGTT",
  "Windows" = "C:/Users/Tim/OneDrive - The University of Colorado Denver/Vigers/BDC/Andrea Steck/Advanced CGM and OGTT",
  "Linux" = "/home/tim/OneDrive/Vigers/BDC/Andrea Steck/Advanced CGM and OGTT"
)
setwd(home_dir)
# Import CGM data from Fran
cgm <- read_sas("./Data_Raw/Final data for CGM analyses 09012023/rawcgmdata_clean.sas7bdat")
# Convert from numeric time to datetime, round to nearest 5 minutes
cgm$sensordisplaytime <-
  as.POSIXct(cgm$sensordisplaytime, origin = "1960-01-01")
cgm$sensordisplaytime <- round_date(cgm$sensordisplaytime, "5 minutes")
# Separate date and time columns, format
cgm$Date <- as_date(cgm$sensordisplaytime)
cgm$Time <- as_hms(cgm$sensordisplaytime)
cgm <- cgm %>%
  rename(SensorValue = sensorvalue) %>%
  arrange(ID, sensordisplaytime) %>%
  select(ID, Date, Time, DOVISIT, SensorValue)
# For now, if people have duplicated sensor values, take the mean
cgm <- cgm %>%
  group_by(ID, Date, Time, DOVISIT) %>%
  summarise(SensorValue = mean(SensorValue, na.rm = T), .groups = "drop")
# Import demographic, etc. data
df <- read_excel("./Data_Raw/Final data for CGM analyses 09012023/final data including TESS.xls", na = ".")
# Remove unhelpful rows
df <- df %>% filter(!is.na(ID))
# Determine group
df$Group <- factor(is.na(df$`Date of T1D dx`),
  levels = c(T, F),
  labels = c("Non-Progressor", "Progressor")
)
# Convert columns
df$`age at clinic` <- as.numeric(df$`age at clinic`)
df$DOVISIT <- ymd(df$DOVISIT)
df$`calculated body` = as.numeric(df$`calculated body`)
df$`BMI-for-age Z`=as.numeric(df$`BMI-for-age Z`)
# Calculate final visit date (or T1D progression)
df$final_visit <- df$DOVISIT - round(df$yearsfromT1D * 365.25)
# Select only necessary columns
df <- df %>%
  select(
    ID, DOVISIT, A1C, `calculated body`, `BMI-for-age Z`, `age at clinic`, SEX,
    `FDR status`, Race_Ethn2, HLAGRP, Group, final_visit
  )
# Put together
cgm <- left_join(cgm, df, by = join_by(ID, DOVISIT))
# Sort
cgm <- cgm %>% arrange(ID, Date, Time)
# Calculate time from last visit, order columns, remove rows missing CGM value
cgm <- cgm %>%
  mutate(Days = as.numeric(difftime(Date, final_visit, units = "days"))) %>%
  select(
    ID, Group, SEX, `FDR status`, HLAGRP, Race_Ethn2, final_visit, DOVISIT,
    `age at clinic`, A1C, `calculated body`, `BMI-for-age Z`, Days, Date, Time,
    SensorValue
  ) %>%
  drop_na(SensorValue)
# Save
save(cgm, file = "./Data_Clean/analysis_dataset.RData")
