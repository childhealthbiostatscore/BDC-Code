library(redcapAPI)
library(tidyverse)
library(lubridate)
# Download from REDCap
unlockREDCap(c(rcon = "MERIT Study"),
  keyring = "API_KEYs",
  envir = 1,
  url = "https://redcap.ucdenver.edu/api/"
)
df <- exportRecordsTyped(rcon)
# Subset tracking data
tracking <- df %>%
  select(
    participant_id, contains("screening_exercise_order"), contains("track_bc"),
    track_period_start, track_date_postitive,
    track_period_start_mo2, track_date_positive_ovu_2,
    track_period_start_mo3, track_date_positive_ovu_3,
    contains("mo1_ex"), contains("mo2_ex"), contains("mo3_ex")
  ) %>%
  group_by(participant_id) %>%
  summarise(across(everything(), ~ first(.x, na_rm = T)))
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
# Format glucose column
cgm$sensorglucose <- as.numeric(cgm$sensorglucose)
cgm <- cgm[!is.na(cgm$sensorglucose), ]
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
cgm$menstrual_phase[cgm$track_bc == "Yes"] <- "On Birth Control"
# Add exercise timing info
cgm$exercising <- "No"
cgm$exercising[cgm$timestamp >= cgm$mo1_ex1_time &
  cgm$timestamp < cgm$mo1_ex1_time_stop] <- "Yes"
cgm$exercising[cgm$timestamp >= cgm$mo1_ex2_time &
  cgm$timestamp < cgm$mo1_ex2_time_stop] <- "Yes"
cgm$exercising[cgm$timestamp >= cgm$mo2_ex1_time &
  cgm$timestamp < cgm$mo2_ex1_time_stop] <- "Yes"
cgm$exercising[cgm$timestamp >= cgm$mo2_ex2_time &
  cgm$timestamp < cgm$mo2_ex2_time_stop] <- "Yes"
cgm$exercising[cgm$timestamp >= cgm$mo3_ex1_time &
  cgm$timestamp < cgm$mo3_ex1_time_stop] <- "Yes"
cgm$exercising[cgm$timestamp >= cgm$mo3_ex2_time &
  cgm$timestamp < cgm$mo3_ex2_time_stop] <- "Yes"
# 24 hours post-exercise
cgm$exercise_24_hr_window <- "No"
cgm$exercise_24_hr_window[cgm$timestamp >= cgm$mo1_ex1_time_stop &
  cgm$timestamp < (cgm$mo1_ex1_time_stop + hours(24))] <- "Yes"
cgm$exercise_24_hr_window[cgm$timestamp >= cgm$mo1_ex2_time_stop &
  cgm$timestamp < (cgm$mo1_ex2_time_stop + hours(24))] <- "Yes"
cgm$exercise_24_hr_window[cgm$timestamp >= cgm$mo2_ex1_time_stop &
  cgm$timestamp < (cgm$mo2_ex1_time_stop + hours(24))] <- "Yes"
cgm$exercise_24_hr_window[cgm$timestamp >= cgm$mo2_ex2_time_stop &
  cgm$timestamp < (cgm$mo2_ex2_time_stop + hours(24))] <- "Yes"
cgm$exercise_24_hr_window[cgm$timestamp >= cgm$mo3_ex1_time_stop &
  cgm$timestamp < (cgm$mo3_ex1_time_stop + hours(24))] <- "Yes"
cgm$exercise_24_hr_window[cgm$timestamp >= cgm$mo3_ex2_time_stop &
  cgm$timestamp < (cgm$mo3_ex2_time_stop + hours(24))] <- "Yes"
# Exercise type
cgm$exercise_type <- cgm$screening_exercise_order_mo1
cgm$exercise_type[cgm$study_phase == "Month 2"] <-
  cgm$screening_exercise_order_mo2[cgm$study_phase == "Month 2"]
cgm$exercise_type[cgm$study_phase == "Month 3"] <-
  cgm$screening_exercise_order_mo3[cgm$study_phase == "Month 3"]
# For now use standard definitions of daytime and nighttime
cgm$time_of_day <- "Day"
cgm$time_of_day[hour(cgm$timestamp) < 6 | hour(cgm$timestamp) > 23] <- "Night"
# Remove unnecessary columns
cgm <- cgm %>%
  select(
    participant_id, timestamp, sensorglucose, time_of_day, study_phase,
    menstrual_phase, exercise_type, exercising, exercise_24_hr_window
  )
# Activity
activity <- read.csv("./Data_Raw/ActiGraph Watch Data Downloads/Data Transfer - 12_19_2024 9_18 PM UTC_638702400035593179/epochsummarydata.csv")
# Round timestamps to 1 minute and combine
# activity$timestamp <- round_date(activity$timestamp, "1 minute")
# cgm$timestamp <- round_date(cgm$timestamp, "1 minute")
# cgm <- full_join(cgm, activity, by = join_by(participant_id, timestamp))
# Save dataset
save(cgm, file = "./Data_Clean/analysis_data.RData")
