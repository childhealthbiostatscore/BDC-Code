library(redcapAPI)
library(tidyverse)
library(lubridate)
library(readxl)
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
activity <- read.csv("./Data_Raw/Actigraph/Data Transfer - 1_30_2025 5_19 PM UTC_638738544641160848/epochsummarydata.csv")
# Format dates
activity$Timestamp <- ymd_hms(sub("T", " ", activity$Timestamp))
# Remove rows with Wear == "False"
activity <- activity %>% filter(Wear == "True")
# There are some duplicate values, mostly due to daylight savings confusion
# For now average these, but ask Janet how she wants to handle them
# Find the duplicates
activity$id_time <- paste(activity$Subject, activity$Timestamp)
dupes <- activity$id_time[duplicated(activity$id_time)]
# Average only the duplicates (using group_by(Subject, Timestamp) on the whole
# dataframe is really slow)
dupes_df <- activity %>% filter(id_time %in% dupes)
activity <- activity %>% filter(!id_time %in% dupes)
dupes_df <- dupes_df %>%
  group_by(Subject, Timestamp) %>%
  summarise(across(
    c(Steps, AxisYCounts, Calories), ~ mean(.x, na.rm = TRUE)
  ))
# Merge back in
activity <- full_join(activity, dupes_df)
activity <- activity %>%
  rename(participant_id = Subject, timestamp = Timestamp) %>%
  select(participant_id, timestamp, Steps, AxisYCounts, Calories)
# Add to CGM data
cgm$timestamp <- round_date(cgm$timestamp, "1 minute")
cgm <- full_join(cgm, activity, by = join_by(participant_id, timestamp))
# List insulin files
insulin_files <- list.files("./Data_Clean/Insulin",
  recursive = T,
  full.names = T
)
# Loop and format files
insulin <- lapply(insulin_files, function(f) {
  id <- sub("_EX.*", "", basename(f))
  id <- paste0(id, "_EX")
  # Tidepool
  if (length(grep("\\.xls", f)) > 0) {
    basal <- read_excel(f, sheet = "Basal")
    bolus <- read_excel(f, sheet = "Bolus")
    # Round times to nearest minute.
    basal$`Local Time` <- round_date(basal$`Local Time`, "1 minute")
    bolus$`Local Time` <- round_date(bolus$`Local Time`, "1 minute")
    # For bolus, assume that column "normal" indicates insulin units. Only need
    # timestamp and insulin right now.
    basal <- basal %>%
      select(`Local Time`, `Duration (mins)`, Rate) %>%
      rename(
        timestamp = "Local Time", basal_duration = "Duration (mins)",
        basal_rate = Rate
      )
    bolus <- bolus %>%
      select(`Local Time`, Normal) %>%
      rename(bolus = "Normal", timestamp = "Local Time")
    insulin <- full_join(basal, bolus,
      by = join_by(timestamp),
      relationship = "many-to-many"
    )
  } else {
    insulin <- read_csv(f,
      locale = locale(encoding = "latin1"), show_col_types = F,
      name_repair = "unique_quiet", col_types = cols(.default = col_character())
    )
    if (ncol(insulin) == 14) {
      insulin <- insulin %>%
        select(`Timestamp (YYYY-MM-DDThh:mm:ss)`, `Insulin Value (u)`) %>%
        rename(
          timestamp = "Timestamp (YYYY-MM-DDThh:mm:ss)",
          bolus = "Insulin Value (u)"
        )
      insulin$timestamp <- round_date(
        ymd_hms(sub("T", " ", insulin$timestamp)), "1 minute"
      )
      insulin$basal_rate <- NA
      insulin$basal_duration <- NA
      insulin$bolus <- as.numeric(insulin$bolus)
    } else if (ncol(insulin) > 40) {
      colnames(insulin) <- insulin[which(insulin[, 3] == "Pump")[1] + 1, ]
      insulin$timestamp <- mdy_hms(paste(insulin$Date, insulin$Time), quiet = T)
      insulin$timestamp <- round_date(insulin$timestamp, "1 minute")
      insulin <- insulin %>%
        rename(
          basal_rate = "Basal Rate (U/h)",
          basal_duration = "Temp Basal Duration (h:mm:ss)",
          bolus = "Bolus Volume Delivered (U)"
        )
      insulin$basal_rate <- suppressWarnings(as.numeric(insulin$basal_rate))
      insulin$basal_duration <- suppressWarnings(as.numeric(insulin$basal_duration))
      insulin$bolus <- suppressWarnings(as.numeric(insulin$bolus))
    } else if (ncol(insulin) == 20) {
      colnames(insulin) <- insulin[which(insulin[, 2] == "BolusType")[1], ]
      insulin <- insulin[which(insulin[, 2] == "BolusType")[1] + 1:nrow(insulin), ]
      insulin <- insulin %>%
        rename(timestamp = CompletionDateTime, bolus = InsulinDelivered)
      insulin$timestamp <- round_date(
        ymd_hms(sub("T", " ", insulin$timestamp)), "1 minute"
      )
      insulin$basal_rate <- NA
      insulin$basal_duration <- NA
      insulin$bolus <- as.numeric(insulin$bolus)
    } else if (ncol(insulin) == 7) {
      colnames(insulin) <- insulin[1, ]
      insulin <- insulin[-1, ]
      insulin <- insulin %>%
        rename(
          timestamp = Timestamp, basal_rate = Rate,
          basal_duration = "Duration (minutes)"
        )
      insulin$timestamp <- round_date(mdy_hm(insulin$timestamp), "1 minute")
      insulin$basal_rate <- as.numeric(insulin$basal_rate)
      insulin$basal_duration <- as.numeric(insulin$basal_duration)
      insulin$bolus <- NA
    } else if (ncol(insulin) == 9) {
      colnames(insulin) <- insulin[1, ]
      insulin <- insulin[-1, ]
      insulin <- insulin %>%
        rename(
          timestamp = Timestamp, bolus = "Insulin Delivered (U)"
        )
      insulin$timestamp <- round_date(mdy_hm(insulin$timestamp), "1 minute")
      insulin$basal_rate <- NA
      insulin$basal_duration <- NA
      insulin$bolus <- as.numeric(insulin$bolus)
    }
  }
  insulin <- insulin %>% select(timestamp, basal_rate, basal_duration, bolus)
  # Add ID and return
  insulin$participant_id <- id
  return(insulin)
})
# Combine
insulin <- do.call(rbind, insulin)
# If there are duplicate timestamps, add them together
insulin <- insulin %>%
  group_by(timestamp) %>%
  summarise(
    basal_rate = sum(basal_rate, na.rm = T),
    basal_duration = sum(basal_duration, na.rm = T),
    bolus = sum(bolus, na.rm = T)
  )
# Convert 0s to missing since these are the result of adding together two NAs
insulin$basal_rate[insulin$basal_rate == 0] <- NA
insulin$basal_duration[insulin$basal_duration == 0] <- NA
insulin$bolus[insulin$bolus == 0] <- NA
# Add to CGM data
cgm <- full_join(cgm, insulin)
cgm$id_time <- NULL
# Save dataset
save(cgm, file = "./Data_Clean/analysis_data.RData")
