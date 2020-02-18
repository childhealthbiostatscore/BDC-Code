library(tidyverse)
# Import data
indir <- "/Users/timvigers/Desktop/cleaned"
outdir <- "/Users/timvigers/Desktop"
files <- list.files(indir,full.names = T)
# Make a summary variables table.
summary <- data.frame(matrix(nrow = length(files),ncol = 0))
# Iterate through each file
for (f in 1:length(files)) {
  # Read in
  table <- read.csv(files[f],header = T,stringsAsFactors = FALSE,na.strings = "")
  # ID and visit
  id <- sub("_cleaned.csv","",basename(files[f]))
  timepoint <- sub("_.*","",id)
  id <- sub(".*_","",id)
  # Date time column
  table$datetime <- paste(table$Date,table$Time)
  table$datetime <- lubridate::parse_date_time(table$datetime,
                                               orders = c("mdyHMS","ymdHMS"))
  # Get day of the week
  table$weekday <- lubridate::wday(table$datetime)
  # Count days and days of week
  day_table <- table %>% group_by(Date) %>%
    summarise(day = weekday[1])
  days <- nrow(day_table)
  weekdays <- length(which(day_table$day %in% c(2:6)))
  weekends <- length(which(day_table$day %in% c(1,7)))
  # Combine BG columns
  table$bg <- pmax(table$BG.Reading..mg.dL.,table$BWZ.BG.Input..mg.dL.,na.rm = T)
  table$bg <- pmax(table$bg,table$Sensor.Calibration.BG..mg.dL.,na.rm = T)
  table$bg[table$bg == 0] <- NA
  # Count BG check behaviors
  # BG counters
  total_readings = 0
  weekday_readings = 0
  weekend_readings = 0
  total_70 = 0
  total_70_149 = 0
  total_70_180 = 0
  total_150_249 = 0
  total_above_250 = 0
  total_181_250 = 0
  total_251_400 = 0
  total_above_400 = 0
  bg_dates = NULL
  skip <- c()
  for (r in 1:nrow(table)) {
    # Skip NAs or blackout window
    if (is.na(table$bg[r]) | r %in% skip) {next()}
    skip <- c()
    # Total readings and by day
    total_readings <- total_readings + 1
    if (table$weekday[r] %in% c(2:6)) {weekday_readings <- weekday_readings + 1}
    if (table$weekday[r] %in% c(1,7)) {weekend_readings <- weekend_readings + 1}
    # Dates
    bg_dates <- c(bg_dates,table$Date[r])
    # Count by BG range
    if (table$bg[r] < 70) {total_70 = total_70 + 1} 
    if (table$bg[r] >= 70 & table$bg[r] <= 149) {total_70_149 = total_70_149 + 1} 
    if (table$bg[r] >= 70 & table$bg[r] <= 180) {total_70_180 = total_70_180 + 1}
    if (table$bg[r] >= 150 & table$bg[r] <= 249) {total_150_249 = total_150_249 + 1}
    if (table$bg[r] >= 250) {total_above_250 = total_above_250 + 1}
    if (table$bg[r] >= 181 & table$bg[r] <= 250) {total_181_250 = total_181_250 + 1}
    if (table$bg[r] >= 251 & table$bg[r] <= 400) {total_251_400 = total_251_400 + 1}
    if (table$bg[r] > 400) {total_above_400 = total_above_400 + 1}
    # "Blackout" window
    bg_time <- table$datetime[r]
    next_time <- table$datetime[r] + 15*60
    for (s in r:nrow(table)) {
      if (table$datetime[s] >= bg_time & table$datetime[s] <= next_time) {
        skip <- c(skip,s)
      }
    }
  }
  skip <- c()
  # Count carb behaviors
  table$BWZ.Carb.Input..grams.[table$BWZ.Carb.Input..grams. == 0] <- NA
  # Carb counters
  total_carbs = 0
  weekday_carbs = 0
  weekend_carbs = 0
  carb_dates = NULL
  for (r in 1:nrow(table)) {
    # Skip NAs or blackout window
    if (is.na(table$BWZ.Carb.Input..grams.[r]) | r %in% skip) {next()}
    skip <- c()
    # Total readings and by day
    total_carbs <- total_carbs + 1
    if (table$weekday[r] %in% c(2:6)) {weekday_carbs <- weekday_carbs + 1}
    if (table$weekday[r] %in% c(1,7)) {weekend_carbs <- weekend_carbs + 1}
    # Dates
    carb_dates <- c(carb_dates,table$Date[r])
    # "Blackout" window
    carb_time <- table$datetime[r]
    next_time <- table$datetime[r] + 15*60
    for (s in r:nrow(table)) {
      if (table$datetime[s] >= carb_time & table$datetime[s] <= next_time) {
        skip <- c(skip,s)
      }
    }
  }
  # Fill in summary df
  # Subject
  summary[f,"subject_id"] <- id
  summary[f,"StudyVisit"] <- timepoint
  summary[f,"days_worn"] <- days
  # BG readings
  summary[f,"total_readings"] <- total_readings
  summary[f,"readings_per_day"] <- (total_readings/days)*100
  summary[f,"weekday_readings"] <- (weekday_readings/weekdays)*100
  summary[f,"weekend_readings"] <- (weekend_readings/weekends)*100
  summary[f,"perc_days_4_bgs"] <- (length(which(table(bg_dates)>=4)) / days)*100
  summary[f,"total_70"] <- total_70
  summary[f,"total_70_149"] <- total_70_149
  summary[f,"total_70_180"] <- total_70_180
  summary[f,"total_150_249"] <- total_150_249
  summary[f,"total_181_250"] <- total_181_250
  summary[f,"total_251_400"] <- total_251_400
  summary[f,"total_above_250"] <- total_above_250
  summary[f,"total_above_400"] <- total_above_400
  # Carbs
  summary[f,"total_carbs"] <- total_carbs
  summary[f,"weekday_carbs"] <- (weekday_carbs/weekdays)*100
  summary[f,"weekend_carbs"] <- (weekend_carbs/weekends)*100
  summary[f,"perc_days_3_carbs"] <- (length(which(table(carb_dates)>=3)) / days)*100
}