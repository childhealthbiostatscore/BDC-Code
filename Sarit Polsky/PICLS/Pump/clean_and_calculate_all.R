library(tidyverse)
library(readxl)
library(tools)
library(parsedate)
library(cgmanalysis)
library(pdftools)

source("/Users/pylell/Documents/GitHub/BDC-Code/Sarit Polsky/PICLS/Pump/pump_variables.R")
setwd("/Volumes/BDC/Projects/Sarit Polsky/PICLS")

# Want data about 1 month prior to questionnaires
#dates = read_excel("./Data_Raw/Device Files/Device Information thru 405.xlsx")
#dates$`Date Questionnaires` = parse_date(dates$`Date Questionnaires`,approx = F)
# Carelink
dir.create("./Data_Clean/Carelink Pump Files",showWarnings = F)
dir.create("./Data_Clean/Carelink Sensor Files",showWarnings = F)
files = list.files("./Data_Raw/Final raw CGM files for analysis",full.names = T)
for (f in files) {
  # Pump
  id <- sub(".csv*","",basename(f))
  print(id)
  #date = dates$`Date Questionnaires`[match(as.numeric(id),dates$`Participant ID`)]
  # Read in
  table = read.csv(f,na.strings = "", header=F)
  # Trim ends
  end <- which(table[,3] == "Sensor")
  if (length(end)> 0) {
    table <- table[-c((end-1):nrow(table)),]
  }
  start <- which(table[,1] == "Index")
  if (length(start) > 0) {
    colnames(table) <- table[start[1],]
    table <- table[-c(1:(start[1]+2)),]
  }
  # Remove micro boluses
  closed_loop = which(table$`Bolus Source` == "CLOSED_LOOP_MICRO_BOLUS")
  if(length(closed_loop)>0){
    table = table[-closed_loop,]
  }
  # Remove missing dates
  table = table[!is.na(table$Date) & !is.na(table$Time),]
  # Date time column
  table$datetime <- paste(table$Date,table$Time)
  table$datetime <- parse_date(table$datetime,approx = F)
  # Remove data > 1 month before date
  #rows = table$datetime <= date & table$datetime > (as.Date(date)-30)
  #if(sum(rows,na.rm = T) > 0){
  #  table = table[rows,]
  #} else {
  #  table = table[-c(1:nrow(table)),]
  #}
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  # 3 days for Holly to check
  #rows = table$datetime > (as.Date(table$datetime[1])-3)
  #if(sum(rows,na.rm = T) > 0){
  #  table = table[rows,]
  #} else {
  #  table = table[-c(1:nrow(table)),]
  #}
  # Write file
  if(nrow(table)>0){
    filename <- paste0("./Data_Clean/Carelink Pump Files/",id,".csv")
    write.csv(table,file = filename,row.names = F,na = "")
  }
  # Sensor
  # Read in
  table = read.csv(f,na.strings = "", header=F)
  # Find sensor, date, and time
  sensor_cols = which(unlist(lapply(table, function(c){
    "Sensor Glucose (mg/dL)" %in% c
  })))
  date_col = which(unlist(lapply(table, function(c){
    "Date" %in% c
  })))
  time_col = which(unlist(lapply(table, function(c){
    "Time" %in% c
  })))
  if(length(sensor_cols)>1){
    table$sensorglucose = rowSums(table[,sensor_cols],na.rm = T)
  } else {
    table$sensorglucose = table[,sensor_cols]
  }
  table$sensorglucose = suppressWarnings(as.numeric(table$sensorglucose))
  table$timestamp = parse_date(paste(table[,date_col],table[,time_col]),approx = F)
  table$subjectid = NA
  table = table[,c("subjectid","timestamp","sensorglucose")]
  # Remove data > 1 month before date
  #rows = table$timestamp <= date & table$timestamp > (as.Date(date)-30)
  #if(sum(rows,na.rm = T) > 100){
  #  table = table[rows,]
  #}else {
  #  table = table[-c(1:nrow(table)),]
  #}
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  # 3 days for Holly to check
  #rows = table$timestamp > (as.Date(table$timestamp[1])-3)
  #if(sum(rows,na.rm = T) > 10){
  #  table = table[rows,]
  #}else {
  #  table = table[-c(1:nrow(table)),]
  #}
  if(sum(!is.na(table$sensorglucose))>0){
    # Write file
    filename <- paste0("./Data_Clean/Carelink Sensor Files/",id,".csv")
    write.csv(table,file = filename,row.names = F,na = "")
  }
}

# Analyze
pump_variables(indir = "./Data_Clean/Carelink Pump Files",
               outdir = "./Data_Clean",outname = "carelink_pump_summary")
cgmvariables("./Data_Clean/Carelink Sensor Files","./Data_Clean",
             outputname = "carelink_sensor_summary",id_filename = T)

# need to find all rows with "other" in field AH "event marker" 
# then count the number of rows with field AD "BWZ status" set to delivered +/- 2 minutes of the other event marker
cleaned_files <- list.files("./Data_Clean/Carelink Pump Files/",full.names = T)
# 107A_1.11.20- 2.9.20, file 17, has boluses within 2 minutes
# 100A_5.9.19- 6.7.19, file 6, has undelivered boluses
# count variables are for the current file, total cumulative over all files
total_no_bolus <- 0
total_one_bolus <- 0
total_more_than_one_bolus <- 0
for (f in cleaned_files) {
  # Pump
  id <- sub(".csv*","",basename(f))
  print(id)
  table = read.csv(f,na.strings = "", header=T)
  table <- table %>% filter(!is.na(datetime))
  print(table$datetime)
  table$datetime <- as.POSIXct(table$datetime)
  times_target_bolus <- table %>% filter(Event.Marker=="Other")
  count_no_bolus_cumulative <- 0
  count_one_bolus_cumulative <- 0
  count_more_than_one_bolus_cumulative <- 0
  for (j in times_target_bolus) {
    print(times_target_bolus$datetime)
    # this needs to be divided by some constant to make in terms of minutes
    try(pull_data <- table %>% filter(abs(as.numeric(datetime-as.POSIXct(times_target_bolus$datetime))) <=120))
    pull_data_bolus <- pull_data %>% filter(BWZ.Status=="Delivered")
    count_this_bolus <- nrow(pull_data_bolus)
    count_no_bolus <- ifelse(count_this_bolus==0,1,0)
    count_no_bolus_cumulative <- count_no_bolus_cumulative + count_no_bolus
    count_one_bolus <- ifelse(count_this_bolus==1,1,0)
    count_one_bolus_cumulative <- count_one_bolus_cumulative + count_one_bolus
    count_more_than_one_bolus <- ifelse(count_this_bolus>1,1,0)
    count_more_than_one_bolus_cumulative <- count_more_than_one_bolus_cumulative + count_more_than_one_bolus
  }
  total_no_bolus <- total_no_bolus + count_no_bolus_cumulative
  total_one_bolus <- total_one_bolus + count_one_bolus_cumulative
  total_more_than_one_bolus <- total_more_than_one_bolus + count_more_than_one_bolus_cumulative
}