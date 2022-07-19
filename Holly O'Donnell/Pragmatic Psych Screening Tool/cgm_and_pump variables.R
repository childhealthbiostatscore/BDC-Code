library(tidyverse)
library(readxl)
library(parsedate)
library(cgmanalysis)
source("C:/Users/timbv/Documents/GitHub/BDC-Code/Holly O'Donnell/Pragmatic Psych Screening Tool/pump_variables.R")
setwd("Z:/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Holly O'Donnell/Pragmatic Psych Screening Tool")
# Want data about 1 month prior to questionnaires
dates = read_excel("./Data_Raw/Device Files/Device Information thru 405.xlsx")
dates$`Date Questionnaires` = parse_date(dates$`Date Questionnaires`,approx = F)
# Carelink
files = list.files("./Data_Raw/Device Files/Carelink",full.names = T)
for (f in files) {
  # Pump
  id <- sub("_.*","",basename(f))
  date = dates$`Date Questionnaires`[match(as.numeric(id),dates$`Participant ID`)]
  # Read in
  table = read.csv(f,na.strings = "")
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
  table$datetime <- parse_date(table$datetime)
  # Remove data > 1 month before date
  rows = table$datetime <= date & table$datetime > (as.Date(date)-30)
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  }
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  # Write file
  filename <- paste0("./Data_Clean/Carelink Pump Files/",id,".csv")
  write.csv(table,file = filename,row.names = F,na = "")
  # Sensor
  # Read in
  table = read.csv(f,na.strings = "")
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
  table$timestamp = parse_date(paste(table[,date_col],table[,time_col]))
  table$subjectid = NA
  table = table[,c("subjectid","timestamp","sensorglucose")]
  # Remove data > 1 month before date
  rows = table$timestamp <= date & table$timestamp > (as.Date(date)-30)
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  }
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
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
# Dexcom
files = list.files("./Data_Raw/Device Files/Dexcom Files",full.names = T)
for (f in files) {
  id <- sub("_.*","",basename(f))
  date = dates$`Date Questionnaires`[match(as.numeric(id),dates$`Participant ID`)]
  # Read in
  table = read.csv(f,na.strings = "")
  # Format
  colnames(table)[grep("timestamp",tolower(colnames(table)))] = "timestamp"
  colnames(table)[grep("glucose.value",tolower(colnames(table)))] = "sensorglucose"
  table$subjectid = NA
  table$subjectid[1] = id
  table = table[,c("subjectid","timestamp","sensorglucose")]
  table$timestamp = parse_date(sub("T"," ",table$timestamp))
  table$sensorglucose = suppressWarnings(as.numeric(table$sensorglucose))
  # Remove data > 1 month before date
  rows = table$timestamp <= date & table$timestamp > (as.Date(date)-30)
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  }
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  if(sum(!is.na(table$sensorglucose))>0){
    # Write file
    filename <- paste0("./Data_Clean/Dexcom Files/",id,".csv")
    write.csv(table,file = filename,row.names = F,na = "")
  }
}
# Analyze
cgmvariables("./Data_Clean/Dexcom Files","./Data_Clean",
             outputname = "dexcom_sensor_summary",id_filename = T)
# TConnect
files = list.files("./Data_Raw/Device Files/TConnect",full.names = T)
for (f in files) {
  id <- sub("_.*","",basename(f))
  date = dates$`Date Questionnaires`[match(as.numeric(id),dates$`Participant ID`)]
  # Read in
  table = read.csv(f,na.strings = "")
  # Find pump data start
  start = which.min(rowSums(is.na(table)))
  colnames(table) = table[start,]
  table = table[(start+1):nrow(table),]
  # Format - change column names to match pump variable code
  table$EventDateTime = parse_date(sub("T","",table$EventDateTime))
  colnames(table)[colnames(table)=="BG"] = "bg"
  colnames(table)[colnames(table)=="EventDateTime"] = "datetime"
  colnames(table)[colnames(table)=="CarbSize"] = "BWZ.Carb.Input..grams."
  colnames(table)[colnames(table)=="InsulinDelivered"] = "Bolus.Volume.Delivered..U."
  table$BWZ.Estimate..U. = NA
  # Remove data > 1 month before date
  rows = table$EventDateTime <= date & table$EventDateTime > (as.Date(date)-30)
  if(sum(rows,na.rm = T) > 10){
    table = table[rows,]
  }
  # Write file
  filename <- paste0("./Data_Clean/TConnect Pump Files/",id,".csv")
  write.csv(table,file = filename,row.names = F,na = "")
}
# Analyze
pump_variables(indir = "./Data_Clean/Carelink Pump Files",
               outdir = "./Data_Clean",outname = "carelink_pump_summary")
cgmvariables("./Data_Clean/Dexcom Files","./Data_Clean",
             outputname = "dexcom_sensor_summary",id_filename = T)