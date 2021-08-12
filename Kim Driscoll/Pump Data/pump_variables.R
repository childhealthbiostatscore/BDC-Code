library(tidyverse)
# Import data
indir <- "/home/tim/.local/share/Cryptomator/mnt/Vault/Work/Tidepool Test/cleaned_run"
outdir <- "/home/tim/.local/share/Cryptomator/mnt/Vault/Work/Tidepool Test"
files <- list.files(indir,full.names = T)
# Make a summary variables table.
summary <- data.frame(matrix(nrow = length(files),ncol = 0))
# Iterate through each file
for (f in 1:length(files)) {
  print(files[f])
  # Read in
  table = read.csv(files[f],header = T,stringsAsFactors = FALSE,na.strings = "")
  if (nrow(table) == 0){
    print(paste("Delete",files[f]))
    next
  }
  # Remove blank rows
  table = table[rowSums(is.na(table))<ncol(table),]
  # Remove micro boluses
  micro = which(table$Bolus.Source == "CLOSED_LOOP_MICRO_BOLUS")
  if (length(micro)>0){
    table = table[-c(micro),]
  }
  # ID
  id <- sub(".csv","",basename(files[f]))
  timepoint <- sub("_.*","",id)
  id <- sub("T._","",id)
  # Date time column
  table$datetime <- paste(table$Date,table$Time)
  table$datetime <- 
    lubridate::parse_date_time(table$datetime,exact = T,
                               orders = c("%m/%d/%Y %H:%M","%m/%d/%Y %H:%M:%S",
                                          "%m/%d/%y %H:%M","%m/%d/%y %H:%M:%S",
                                          "%Y/%m/%d %H:%M","%Y/%m/%d %H:%M:%S",
                                          "%Y-%m-%d %H:%M","%Y-%m-%d %H:%M:%S"))
  table = table[!is.na(table$datetime),]
  # Sort by datetime
  table = table[order(table$datetime),]
  # Get day of the week
  table$weekday <- lubridate::wday(table$datetime)
  # Count days and days of week
  day_table <- table %>% group_by(Date) %>%
    summarise(day = weekday[1],.groups = "drop_last")
  days <- nrow(day_table)
  weekdays <- length(which(day_table$day %in% c(2:6)))
  weekends <- length(which(day_table$day %in% c(1,7)))
  # Combine BG columns
  if (!("bg" %in% colnames(table)) | sum(is.na(table$bg)) == nrow(table)){
    bg_cols = c("BG.Reading..mg.dL.","BWZ.BG.Input..mg.dL.","Sensor.Calibration.BG..mg.dL.")
    if (any(bg_cols %in% colnames(table))){
      m = match(bg_cols,colnames(table))
      m = m[!is.na(m)]
      table$bg <- suppressWarnings(apply(table[,m],1,function(r){max(r,na.rm = T)}))
      table$bg[table$bg == -Inf] = NA
    } else {
      table$bg = NA
    }
  }
  table$bg[table$bg == 0] <- NA
  # Get rewind times
  rewind_datetimes = table$datetime[!is.na(table$Rewind)]
  rewind_diffs = as.numeric(diff(rewind_datetimes))
  if (length(rewind_diffs) > 0) {
    mean_rewind = mean(rewind_diffs,na.rm = T)
  } else {mean_rewind = NA}
  # Simplify table
  table <- table %>% select(Date,datetime,weekday,bg,BWZ.Carb.Input..grams.,
                            BWZ.Estimate..U.,Bolus.Volume.Delivered..U.,Bolus.Type)
  table <- table[rowSums(is.na(table)) < 5,]
  table <- unique(table)
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
  bg_values = NULL
  skip <- c()
  for (r in which(!is.na(table$bg))) {
    # Skip NAs or blackout window
    if (r %in% skip) {next()}
    skip <- c()
    # Total readings and by day
    total_readings <- total_readings + 1
    if (table$weekday[r] %in% c(2:6)) {weekday_readings <- weekday_readings + 1}
    if (table$weekday[r] %in% c(1,7)) {weekend_readings <- weekend_readings + 1}
    # Dates
    bg_datetimes <- c(bg_datetimes,as.character(table$datetime[r]))
    bg_dates <- c(bg_dates,table$Date[r])
    # Value
    bg_values <- c(bg_values,table$bg[r])
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
    skip <- which(table$datetime >= bg_time & 
                    table$datetime <= next_time)
    skip <- skip[skip > r]
  }
  skip <- c()
  # Get dates with bg gaps >= 6 hours
  bg_time_df <- as.data.frame(bg_datetimes,stringsAsFactors = F)
  bg_time_df$bg_datetimes <- lubridate::parse_date_time(bg_time_df$bg_datetimes,
                                                        c("ymd HMS","ymd HM","ymd"))
  bg_time_df$bg_datetimes <- lubridate::round_date(bg_time_df$bg_datetimes, unit = "min")
  bg_time_df$time = lubridate::hour(bg_time_df$bg_datetimes) + 
    lubridate::minute(bg_time_df$bg_datetimes)*0.01
  bg_time_df$date = as.Date(bg_time_df$bg_datetimes)
  # Create fake BG checks at 6am and 11pm
  bg_time_df <- bg_time_df %>% filter(time >=6 & time < 23) %>% group_by(date) %>%
    group_modify(~ add_row(.,time = 6.0,.before=0)) %>%
    group_modify(~ add_row(.,time = 23.0)) %>% ungroup
  bg_time_df$time_char = 
    sapply(strsplit(as.character(bg_time_df$time),"\\."),
           function(x){
             if (length(x) > 1) {
               paste(x,collapse = ":")
             } else if (length(x == 1)) {
               paste(c(x,'00'),collapse = ":")
             }})
  bg_time_df$bg_datetimes = 
    lubridate::ymd_hm(paste(bg_time_df$date,bg_time_df$time_char))
  bg_time_df = bg_time_df %>% 
    mutate(diff = difftime(bg_datetimes,lag(bg_datetimes),units = "hours"))
  bg_diffs <- bg_time_df %>% group_by(date) %>%
    summarise(m = suppressWarnings(max(diff,na.rm = T)),.groups="drop_last")
  bg_days_6 = sum(bg_diffs$m >= 6)
  # Count carb behaviors
  table$BWZ.Carb.Input..grams.[table$BWZ.Carb.Input..grams. == 0] <- NA
  # Carb counters
  total_carbs = 0
  weekday_carbs = 0
  weekend_carbs = 0
  carb_dates = NULL
  carb_datetimes = NULL
  for (r in which(!is.na(table$BWZ.Carb.Input..grams.))) {
    # Skip NAs or blackout window
    if (r %in% skip) {next()}
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
    skip <- which(table$datetime >= carb_time & 
                    table$datetime <= next_time)
    skip <- skip[skip > r]
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
  total_estimates = 0
  bg_with_bolus_70 = 0
  bg_with_bolus_70_149 = 0
  bg_with_bolus_150_249 = 0
  bg_with_bolus_above_250 = 0
  bg_with_carb_70 = 0
  bg_with_carb_70_149 = 0
  bg_with_carb_150_249 = 0
  bg_with_carb_above_250 = 0
  bg_with_carb_bolus_70 = 0
  bg_with_carb_bolus_70_149 = 0
  bg_with_carb_bolus_150_249 = 0
  bg_with_carb_bolus_above_250 = 0
  bolus_dates = NULL
  bolus_datetimes = NULL
  estimate_dates = NULL
  equal_dates = NULL
  lower_dates = NULL
  higher_dates = NULL
  for (r in which(!is.na(table$Bolus.Volume.Delivered..U.))) {
    # Skip NAs or blackout window
    if (r %in% skip) {next()}
    skip <- c()
    # Total readings and by day
    total_bolus <- total_bolus + 1
    if (table$weekday[r] %in% c(2:6)) {weekday_bolus <- weekday_bolus + 1}
    if (table$weekday[r] %in% c(1,7)) {weekend_bolus <- weekend_bolus + 1}
    # Dates
    bolus_datetimes <- c(bolus_datetimes,as.character(table$datetime[r]))
    bolus_dates <- c(bolus_dates,table$Date[r])
    # "Blackout" window
    bolus_time <- table$datetime[r]
    next_time <- table$datetime[r] + 15*60
    skip <- which(table$datetime >= bolus_time & 
                    table$datetime <= next_time)
    skip <- skip[skip > r]
  }
  skip <- c()
  # BWZ check
  for (r in which(!is.na(table$BWZ.Estimate..U.))) {
    if (r %in% skip) {next()}
    estimate <- table$BWZ.Estimate..U.[r]
    total_estimates <- total_estimates + 1
    estimate_dates <- c(estimate_dates,as.character(table$datetime[r]))
    delivered <- c()
    skip <- c()
    # Check rows going forwards and backwards
    for (b in which(!is.na(table$Bolus.Volume.Delivered..U.))) {
      if (table$datetime[b] > table$datetime[r] + (15*60)) {next()}
      if (table$datetime[b] < table$datetime[r] - (15*60)) {next()}
      delivered <- c(delivered,table$Bolus.Volume.Delivered..U.[b])
      if (grepl("Normal",table$Bolus.Type[b])) {break()}
    }
    delivered <- sum(as.numeric(delivered),na.rm = T)
    # Compare delivery to BWZ
    if (delivered == estimate) {
      bolus_equal_bwz <- bolus_equal_bwz + 1
      equal_dates <- c(equal_dates,as.character(table$datetime[r]))
    } else if (delivered < estimate) {
      bolus_lower_bwz <- bolus_lower_bwz + 1
      lower_dates <- c(lower_dates,as.character(table$datetime[r]))
    } else if (delivered > estimate) {
      bolus_higher_bwz <- bolus_higher_bwz + 1
      higher_dates <- c(higher_dates,as.character(table$datetime[r]))
    }
    # "Blackout" window
    estimate_time <- table$datetime[r]
    next_time <- table$datetime[r] + 15*60
    skip <- which(table$datetime >= estimate_time &
                    table$datetime <= next_time)
    skip <- skip[skip > r]
  }
  # Get dates with bolus gaps >= 6 hours
  bolus_time_df <- as.data.frame(bolus_datetimes,stringsAsFactors = F)
  bolus_time_df$date <- as.Date(bolus_time_df$bolus_datetimes)
  if (nrow(bolus_time_df) > 0){
    bolus_time_df$time <- lubridate::hour(bolus_time_df$bolus_datetimes)
  }
  bolus_time_df$bolus_datetimes <- lubridate::ymd_hms(bolus_time_df$bolus_datetimes)
  bolus_time_df <- bolus_time_df %>%
    mutate(diff = (bolus_datetimes - lag(bolus_datetimes))/60)
  bolus_time_df <- bolus_time_df[bolus_time_df$time %in% c(6:11),]
  bolus_time_df <- bolus_time_df %>% group_by(date) %>% 
    summarise(m = suppressWarnings(max(diff,na.rm = T)),.groups="drop_last") %>% 
    filter(m > -Inf)
  # Link behaviors
  carb_datetimes <- lubridate::ymd_hms(carb_datetimes)
  bolus_datetimes <- lubridate::ymd_hms(bolus_datetimes)
  bg_datetimes <- lubridate::parse_date_time(bg_datetimes,c("ymd HMS","ymd"))
  for (bgt in bg_datetimes[!is.na(bg_datetimes)]) {
    # Check for a carb input within 15 minutes
    bg <- unique(table$bg[which(table$datetime == bgt)])
    bg <- bg[!is.na(bg)][[1]]
    time.range <- (bgt:(bgt+15*60))
    # Count boluses with no carbs
    if (any(bolus_datetimes %in% time.range) & !any(carb_datetimes %in% time.range)) {
      # Count by BG level
      if (bg < 70) {bg_with_bolus_70 <- bg_with_bolus_70 + 1}
      if (bg %in% 70:149) {bg_with_bolus_70_149 <- bg_with_bolus_70_149 + 1}
      if (bg %in% 150:249) {bg_with_bolus_150_249 <- bg_with_bolus_150_249 + 1}
      if (bg >= 250) {bg_with_bolus_above_250 <- bg_with_bolus_above_250 + 1}
    }
    # Count carbs with no boluses
    if (any(carb_datetimes %in% time.range) & !any(bolus_datetimes %in% time.range)) {
      if (bg < 70) {bg_with_carb_70 <- bg_with_carb_70 + 1}
      if (bg %in% 70:149) {bg_with_carb_70_149 <- bg_with_carb_70_149 + 1}
      if (bg %in% 150:249) {bg_with_carb_150_249 <- bg_with_carb_150_249 + 1}
      if (bg >= 250) {bg_with_carb_above_250 <- bg_with_carb_above_250 + 1}
    }
    # Count carbs and boluses
    if (any(bolus_datetimes %in% time.range) & any(carb_datetimes %in% time.range)) {
      if (bg < 70) {bg_with_carb_bolus_70 <- bg_with_carb_bolus_70 + 1}
      if (bg %in% 70:149) {bg_with_carb_bolus_70_149 <- bg_with_carb_bolus_70_149 + 1}
      if (bg %in% 150:249) {bg_with_carb_bolus_150_249 <- bg_with_carb_bolus_150_249 + 1}
      if (bg >= 250) {bg_with_carb_bolus_above_250 <- bg_with_carb_bolus_above_250 + 1}
    }
  }
  # Of all boluses given, how many a BG reading within 15 minutes prior
  bolus_within_15_of_bg = 0
  for (d in bolus_datetimes) {
    if (any(bg_datetimes > (d - 15*60) & bg_datetimes <= d)) {
      bolus_within_15_of_bg = bolus_within_15_of_bg + 1
    }
  }
  # Fill in summary df
  # Subject
  summary[f,"subject_id"] <- id
  summary[f,"study_visit"] <- timepoint
  summary[f,"start_date"] = table$Date[1]
  summary[f,"end_date"] = table$Date[nrow(table)]
  summary[f,"days_worn"] <- days
  summary[f,"weekday_days"] <- weekdays
  summary[f,"weekend_days"] <- weekends
  # BG readings
  summary[f,"total_readings"] <- total_readings
  summary[f,"weekday_readings"] <- weekday_readings
  summary[f,"weekend_readings"] <- weekend_readings
  summary[f,"total_70"] <- total_70
  summary[f,"total_70_149"] <- total_70_149
  summary[f,"total_70_180"] <- total_70_180
  summary[f,"total_150_249"] <- total_150_249
  summary[f,"total_181_250"] <- total_181_250
  summary[f,"total_251_400"] <- total_251_400
  summary[f,"total_above_250"] <- total_above_250
  summary[f,"total_above_400"] <- total_above_400
  summary[f,"days_4_bgs"] <- length(which(table(bg_dates)>=4))
  summary[f,"days_bg_>=6_hours"] <- bg_days_6
  # Carbs
  summary[f,"total_carbs"] <- total_carbs
  summary[f,"weekday_carbs"] <- weekday_carbs
  summary[f,"weekend_carbs"] <- weekend_carbs
  summary[f,"days_3_carbs"] <- length(which(table(carb_dates)>=3))
  # Boluses
  summary[f,"total_bolus"] <- total_bolus
  summary[f,"bolus_within_15_of_bg"] <- bolus_within_15_of_bg
  summary[f,"weekday_bolus"] <- weekday_bolus
  summary[f,"weekend_bolus"] <- weekend_bolus
  summary[f,"days_3_bolus"] <- length(which(table(bolus_dates)>=3))
  summary[f,"total_BWZ_estimates"] <- total_estimates
  summary[f,"bolus_equal_bwz"] <- bolus_equal_bwz
  summary[f,"bolus_lower_bwz"] <- bolus_lower_bwz
  summary[f,"bolus_higher_bwz"] <- bolus_higher_bwz
  summary[f,"days_bolus_>=6_hours"] <- length(which(bolus_time_df$m >= 6))
  # Link behaviors
  summary[f,"bg_under_70_with_bolus_only"] <- bg_with_bolus_70
  summary[f,"bg_under_70_with_carb_only"] <- bg_with_carb_70
  summary[f,"bg_under_70_with_bolus_carb"] <- bg_with_carb_bolus_70
  
  summary[f,"bg_70_149_with_bolus_only"] <- bg_with_bolus_70_149
  summary[f,"bg_70_149_with_carb_only"] <- bg_with_carb_70_149
  summary[f,"bg_70_149_with_bolus_carb"] <- bg_with_carb_bolus_70_149
  
  summary[f,"bg_150_249_with_bolus_only"] <- bg_with_bolus_150_249
  summary[f,"bg_150_249_with_carb_only"] <- bg_with_carb_150_249
  summary[f,"bg_150_249_with_bolus_carb"] <- bg_with_carb_bolus_150_249
  
  summary[f,"bg_above_250_with_bolus_only"] <- bg_with_bolus_above_250
  summary[f,"bg_above_250_with_carb_only"] <- bg_with_carb_above_250
  summary[f,"bg_above_250_with_bolus_carb"] <- bg_with_carb_bolus_above_250
  
  summary[f,"avg_mins_btw_rewinds"] <- round(mean_rewind,3)
  # Print progress
  print(paste0(round(f / length(files) * 100,1),"% complete"))
}
# Write summary variables
filename <- paste0(outdir,"/summary.csv")
write.csv(summary,file = filename,row.names = F,na = "")
