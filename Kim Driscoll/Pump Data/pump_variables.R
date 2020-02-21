library(tidyverse)
# Import data
indir <- "/Users/timvigers/Desktop/PIU/cleaned"
outdir <- "/Users/timvigers/Desktop/PIU"
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
  bg_datetimes = NULL
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
    bg_datetimes <- c(bg_datetimes,as.character(table$datetime[r]))
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
  # Get dates with bg gaps >= 6 hours
  bg_time_df <- as.data.frame(bg_datetimes)
  bg_time_df$date <- as.Date(bg_time_df$bg_datetimes)
  bg_time_df$time <- lubridate::hour(bg_time_df$bg_datetimes)
  bg_time_df$bg_datetimes <- lubridate::ymd_hms(bg_time_df$bg_datetimes)
  bg_time_df <- bg_time_df %>%
    mutate(diff = (bg_datetimes - lag(bg_datetimes))/60)
  bg_time_df <- bg_time_df[bg_time_df$time %in% c(6:11),]
  bg_time_df <- bg_time_df %>% group_by(date) %>% 
    summarise(m = suppressWarnings(max(diff,na.rm = T))) %>% filter(m > -Inf)
  # Count carb behaviors
  table$BWZ.Carb.Input..grams.[table$BWZ.Carb.Input..grams. == 0] <- NA
  # Carb counters
  total_carbs = 0
  weekday_carbs = 0
  weekend_carbs = 0
  carb_dates = NULL
  carb_datetimes = NULL
  for (r in 1:nrow(table)) {
    # Skip NAs or blackout window
    if (is.na(table$BWZ.Carb.Input..grams.[r]) | r %in% skip) {next()}
    skip <- c()
    # Total readings and by day
    total_carbs <- total_carbs + 1
    if (table$weekday[r] %in% c(2:6)) {weekday_carbs <- weekday_carbs + 1}
    if (table$weekday[r] %in% c(1,7)) {weekend_carbs <- weekend_carbs + 1}
    # Dates
    carb_datetimes <- c(carb_datetimes,as.character(table$datetime[r]))
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
  skip <- c()
  # Count bolus behaviors
  table$Bolus.Volume.Delivered..U.[table$Bolus.Volume.Delivered..U. == 0] <- NA
  # Bolus counters
  total_bolus = 0
  weekday_bolus = 0
  weekend_bolus = 0
  bolus_equal_bwz = 0
  bolus_lower_bwz = 0
  bolus_higher_bwz = 0
  bg_with_bolus_70 = 0
  bg_with_bolus_70_149 = 0
  bg_with_bolus_150_249 = 0
  bg_with_bolus_above_250 = 0
  bg_with_carb_bolus_70 = 0
  bg_with_carb_bolus_70_149 = 0
  bg_with_carb_bolus_150_249 = 0
  bg_with_carb_bolus_above_250 = 0
  bolus_within_15_of_bg = 0
  bolus_dates = NULL
  bolus_datetimes = NULL
  lower_dates = NULL
  higher_dates = NULL
  for (r in 1:nrow(table)) {
    # Skip NAs or blackout window
    if (is.na(table$Bolus.Volume.Delivered..U.[r]) | r %in% skip) {next()}
    skip <- c()
    # Total readings and by day
    total_bolus <- total_bolus + 1
    if (table$weekday[r] %in% c(2:6)) {weekday_bolus <- weekday_bolus + 1}
    if (table$weekday[r] %in% c(1,7)) {weekend_bolus <- weekend_bolus + 1}
    # Dates
    bolus_datetimes <- c(bolus_datetimes,as.character(table$datetime[r]))
    bolus_dates <- c(bolus_dates,table$Date[r])
    # BWZ check
    estimate = c()
    total_delivered = c()
    # Look forward for estimate and delivery
    for (b in r:nrow(table)) {
      if (is.na(table$BWZ.Estimate..U.[b]) & is.na(table$Bolus.Volume.Delivered..U.[b])) {next()}
      if (table$datetime[b] > (table$datetime[r] + 180)) {next()}
      if (table$datetime[b] <= (table$datetime[r] + 180)) {
        estimate <- c(estimate, table$BWZ.Estimate..U.[b])
        total_delivered <- c(total_delivered, table$Bolus.Volume.Delivered..U.[b])
      }
    }
    # Look backward for estimate and delivery
    for (b in nrow(table):1) {
      if (is.na(table$BWZ.Estimate..U.[b]) & is.na(table$Bolus.Volume.Delivered..U.[b])) {next()}
      if (!is.na(table$Bolus.Type[b]) & !(grepl("Dual",table$Bolus.Type[b]))) {next()}
      if (table$datetime[b] >= table$datetime[r] | table$datetime[b] < (table$datetime[r] - 180)) {next()}
      if (table$datetime[b] > (table$datetime[r] - 180)) {
        estimate <- c(estimate, table$BWZ.Estimate..U.[b])
        total_delivered <- c(total_delivered, table$Bolus.Volume.Delivered..U.[b])
      }
    }
    if (table$Bolus.Type[r] == "Normal") {
      total_delivered <- unique(na.omit(total_delivered))
      estimate <- na.omit(estimate)[1]
    } else {
      total_delivered <- sum(total_delivered,na.rm = T)
      estimate <- sum(estimate,na.rm = T)
    }
    # Compare delivery to BWZ
    if (total_delivered == estimate) {
      bolus_equal_bwz <- bolus_equal_bwz + 1
    } else if (total_delivered < estimate) {
      bolus_lower_bwz <- bolus_lower_bwz + 1
      lower_dates <- c(lower_dates,as.character(table$datetime[r]))
    } else if (total_delivered > estimate) {
      bolus_higher_bwz <- bolus_higher_bwz + 1
      higher_dates <- c(higher_dates,as.character(table$datetime[r]))
    }
    # "Blackout" window
    bolus_time <- table$datetime[r]
    next_time <- table$datetime[r] + 15*60
    for (s in r:nrow(table)) {
      if (table$datetime[s] >= bolus_time & table$datetime[s] <= next_time) {
        skip <- c(skip,s)
      }
    }
  }
  # Get dates with bolus gaps >= 6 hours
  bolus_time_df <- as.data.frame(bolus_datetimes)
  bolus_time_df$date <- as.Date(bolus_time_df$bolus_datetimes)
  bolus_time_df$time <- lubridate::hour(bolus_time_df$bolus_datetimes)
  bolus_time_df$bolus_datetimes <- lubridate::ymd_hms(bolus_time_df$bolus_datetimes)
  bolus_time_df <- bolus_time_df %>%
    mutate(diff = (bolus_datetimes - lag(bolus_datetimes))/60)
  bolus_time_df <- bolus_time_df[bolus_time_df$time %in% c(6:11),]
  bolus_time_df <- bolus_time_df %>% group_by(date) %>% 
    summarise(m = suppressWarnings(max(diff,na.rm = T))) %>% filter(m > -Inf)
  # Link behaviors
  carb_datetimes <- lubridate::ymd_hms(carb_datetimes)
  bolus_datetimes <- lubridate::ymd_hms(bolus_datetimes)
  bg_datetimes <- lubridate::ymd_hms(bg_datetimes)
  for (bgt in bg_datetimes) {
    # Check for a carb input within 15 minutes
    bg <- unique(table$bg[which(table$datetime == bgt)])
    time.range.15 <- (bgt:(bgt+40*60))
    if (any(bolus_datetimes %in% time.range.15)) {
      # Count by BG level
      if (bg < 70) {bg_with_bolus_70 <- bg_with_bolus_70 + 1}
      if (bg < 70 & (any(carb_datetimes %in% time.range.15))) {bg_with_carb_bolus_70 <- bg_with_carb_bolus_70 + 1}
      if (bg %in% 70:149) {bg_with_bolus_70_149 <- bg_with_bolus_70_149 + 1}
      if (bg %in% 70:149 & (any(carb_datetimes %in% time.range.15))) {bg_with_carb_bolus_70_149 <- bg_with_carb_bolus_70_149 + 1}
      if (bg %in% 150:249) {bg_with_bolus_150_249 <- bg_with_bolus_150_249 + 1}
      if (bg %in% 150:249 & (any(carb_datetimes %in% time.range.15))) {bg_with_carb_bolus_150_249 <- bg_with_carb_bolus_150_249 + 1}
      if (bg >= 250) {bg_with_bolus_above_250 <- bg_with_bolus_above_250 + 1}
      if (bg >= 250 & (any(carb_datetimes %in% time.range.15))) {bg_with_carb_bolus_above_250 <- bg_with_carb_bolus_above_250 + 1}
    }
  }
  # Fill in summary df
  # Subject
  summary[f,"subject_id"] <- id
  summary[f,"StudyVisit"] <- timepoint
  summary[f,"days_worn"] <- days
  # BG readings
  summary[f,"total_readings"] <- total_readings
  summary[f,"readings_per_day"] <- (total_readings/days)
  summary[f,"weekday_readings"] <- (weekday_readings/weekdays)
  summary[f,"weekend_readings"] <- (weekend_readings/weekends)
  summary[f,"perc_days_4_bgs"] <- (length(which(table(bg_dates)>=4)) / days)*100
  summary[f,"total_70"] <- total_70
  summary[f,"total_70_149"] <- total_70_149
  summary[f,"total_70_180"] <- total_70_180
  summary[f,"total_150_249"] <- total_150_249
  summary[f,"total_181_250"] <- total_181_250
  summary[f,"total_251_400"] <- total_251_400
  summary[f,"total_above_250"] <- total_above_250
  summary[f,"total_above_400"] <- total_above_400
  summary[f,"days_bg_>=6_hours"] <- length(which(bg_time_df$m >= 6))
  # Carbs
  summary[f,"total_carbs"] <- total_carbs
  summary[f,"weekday_carbs"] <- (weekday_carbs/weekdays)
  summary[f,"weekend_carbs"] <- (weekend_carbs/weekends)
  summary[f,"perc_days_3_carbs"] <- (length(which(table(carb_dates)>=3)) / days)*100
  # Boluses
  summary[f,"total_bolus"] <- total_bolus
  summary[f,"weekday_bolus"] <- (weekday_bolus/weekdays)
  summary[f,"weekend_bolus"] <- (weekend_bolus/weekends)
  summary[f,"perc_days_3_bolus"] <- (length(which(table(bolus_dates)>=3)) / days)*100
  summary[f,"bolus_equal_bwz"] <- bolus_equal_bwz
  summary[f,"bolus_lower_bwz"] <- bolus_lower_bwz
  summary[f,"bolus_higher_bwz"] <- bolus_higher_bwz
  summary[f,"days_bolus_>=6_hours"] <- length(which(bolus_time_df$m >= 6))
  # Link behaviors
  summary[f,"lowBG_without_carb_with_bolus"] <- (lowBG_followed_by_bolus/(lowBGcount-lowBG_with_carb))*100
  summary[f,"lowBG_with_carb_and_bolus"] <- (lowBG_with_carb_bolus/lowBG_with_carb)*100

  summary[f,"intargetBG_without_carb_with_bolus"] <- (intargetBG_followed_by_bolus/(intargetBGcount-intargetBG_with_carb))*100
  summary[f,"intargetBG_with_carb_and_bolus"] <- (intargetBG_with_carb_bolus/intargetBG_with_carb)*100

  summary[f,"highBG_without_carb_with_bolus"] <- (highBG_followed_by_bolus/(highBGcount-highBG_with_carb))*100
  summary[f,"highBG_with_carb_and_bolus"] <- (highBG_with_carb_bolus/highBG_with_carb)*100

  summary[f,"veryhighBG_without_carb_with_bolus"] <- (veryhighBG_followed_by_bolus/(veryhighBGcount-veryhighBG_with_carb))*100
  summary[f,"veryhighBG_with_carb_and_bolus"] <- (veryhighBG_with_carb_bolus/veryhighBG_with_carb)*100

  summary[f,"extremeBG_without_carb_with_bolus"] <- (extremeBG_followed_by_bolus/(extremeBGcount-extremeBG_with_carb))*100
  summary[f,"extremeBG_with_carb_and_bolus"] <- (extremeBG_with_carb_bolus/extremeBG_with_carb)*100
}
