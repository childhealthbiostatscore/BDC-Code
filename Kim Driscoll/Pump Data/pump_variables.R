library(tidyverse)
# Import data
indir <- "/Users/timvigers/Desktop/cleaned"
outdir <- "/Users/timvigers/Desktop"
files <- list.files(indir,full.names = T)
# Make a summary variables table.
summary <- data.frame(matrix(nrow = length(files),ncol = 0))
# Iterate through each file
for (f in files) {
  # Read in
  table <- read.csv(f,header = T,stringsAsFactors = FALSE,na.strings = "")
  # Date time column
  table$datetime <- paste(table$Date,table$Time)
  table$datetime <- lubridate::parse_date_time(table$datetime,
                                               orders = c("mdyHMS","ymdHMS"))
  # Combine BG columns
  table$bg <- pmax(table$BG.Reading..mg.dL.,table$BWZ.BG.Input..mg.dL.,na.rm = T)
  table$bg <- pmax(table$bg,table$Sensor.Calibration.BG..mg.dL.,na.rm = T)
  table$bg[table$bg == 0] <- NA
  # Count BG check behaviors
  # BG counters
  # Totals in range
  total_70 = 0
  total_70_149 = 0
  total_70_180 = 0
  total_150_249 = 0
  total_above_250 = 0
  total_181_250 = 0
  total_251_400 = 0
  total_above_400 = 0
  for (r in 1:nrow(table)) {
    # Skip NAs or blackout window
    if (is.na(table$bg[r])) {next()}
    if (r %in% skip) {next()}
    skip <- c()
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
}