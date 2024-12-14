library(redcapAPI)
library(tidyverse)
library(lubridate)
library(cgmanalysis)
# Get tracking information
unlockREDCap(c(rcon = "MERIT Study"),
  keyring = "API_KEYs",
  envir = 1,
  url = "https://redcap.ucdenver.edu/api/"
)
tracking <- exportReportsTyped(rcon, report_id = 127037)
tracking <- tracking %>%
  select(
    participant_id,
    track_period_start, track_date_postitive,
    track_period_start_mo2, track_date_positive_ovu_2,
    track_period_start_mo3, track_date_positive_ovu_3
  )
# Working directory
setwd("/Users/timvigers/Library/CloudStorage/OneDrive-TheUniversityofColoradoDenver/Vigers/BDC/Janet Snell-Bergeon/MERIT")
# Pull in everyone's CGM data
cgm <- list.files("./Data_Raw/Dexcom Data", full.names = T, recursive = T)
cgm <- cgm[grep("CSV/\\d", cgm)]
cgm <- lapply(cgm, function(f) {
  id <- str_extract(f, "\\d{3,}_EX")
  df <- read.csv(f, na.strings = "")
  # Determine the type of CGM, convert to 3 column format
  if (ncol(df) == 14) {
    df <- df[, c(1, 2, 8)]
    colnames(df) <- c("participant_id", "timestamp", "sensorglucose")
    df$timestamp <- ymd_hms(sub("T", " ", df$timestamp), tz = "America/Denver")
  } else {
    print(f)
  }
  # Clean the 3 column format
  df$participant_id <- id
  df <- df[!is.na(df$timestamp), ]
  # Replace "Low" and "High" values
  df$sensorglucose[df$sensorglucose == "Low"] <- 39
  df$sensorglucose[df$sensorglucose == "High"] <- 401
  # Return
  return(df)
})
# Combine CGM tables together
cgm <- do.call(rbind, cgm)
# Add study phase
cgm <- left_join(cgm, tracking, by = join_by(participant_id))
cgm$study_phase <- "Month 1"
cgm$study_phase[cgm$timestamp >= cgm$track_period_start_mo2] <- "Month 2"
cgm$study_phase[cgm$timestamp >= cgm$track_period_start_mo3] <- "Month 3"
# Add menstrual cycle phase
cgm$menstrual_phase <- "Follicular"
cgm$menstrual_phase[cgm$study_phase == "Month 1" &
  cgm$timestamp >= cgm$track_date_postitive + days(1)] <- "Luteal"
cgm$menstrual_phase[cgm$study_phase == "Month 2" &
  cgm$timestamp >= cgm$track_date_positive_ovu_2 + days(1)] <- "Luteal"
cgm$menstrual_phase[cgm$study_phase == "Month 3" &
  cgm$timestamp >= cgm$track_date_positive_ovu_3 + days(1)] <- "Luteal"
