library(tidyverse)
library(readxl)
library(tools)
library(parsedate)
library(cgmanalysis)
library(pdftools)
source("~/Documents/GitHub/BDC-Code/Holly O'Donnell/Pragmatic Psych Screening Tool/pump_variables.R")
setwd("/Volumes/BDC/Projects/Holly O'Donnell/Device data/March 2023")

# Want data about 1 month prior to questionnaires
dates = read_excel("./Data_Raw/dates.xlsx")
dates$`Date Questionnaires` = parse_date(dates$`Date Questionnaires`,approx = F)
# Carelink
dir.create("./Data_Clean/Carelink Pump Files",showWarnings = F)
dir.create("./Data_Clean/Carelink Sensor Files",showWarnings = F)
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
  table$datetime <- parse_date(table$datetime,approx = F)
  # Remove data > 1 month before date
  rows = table$datetime <= date & table$datetime > (as.Date(date)-30)
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  } else {
    table = table[-c(1:nrow(table)),]
  }
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  # 2 days for Holly to check
  rows = table$datetime > (as.Date(table$datetime[1])-2)
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  } else {
    table = table[-c(1:nrow(table)),]
  }
  # Write file
  if(nrow(table)>0){
    filename <- paste0("./Data_Clean/Carelink Pump Files/",id,".csv")
    write.csv(table,file = filename,row.names = F,na = "")
  }
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
  table$timestamp = parse_date(paste(table[,date_col],table[,time_col]),approx = F)
  table$subjectid = NA
  table = table[,c("subjectid","timestamp","sensorglucose")]
  # Remove data > 1 month before date
  rows = table$timestamp <= date & table$timestamp > (as.Date(date)-30)
  if(sum(rows,na.rm = T) > 100){
    table = table[rows,]
  }else {
    table = table[-c(1:nrow(table)),]
  }
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  # 2 days for Holly to check
  rows = table$timestamp > (as.Date(table$timestamp[1])-2)
  if(sum(rows,na.rm = T) > 10){
    table = table[rows,]
  }else {
    table = table[-c(1:nrow(table)),]
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
#cgmvariables("./Data_Clean/Carelink Sensor Files","./Data_Clean",
#             outputname = "carelink_sensor_summary",id_filename = T)
# Dexcom
dir.create("./Data_Clean/Dexcom Files",showWarnings = F)
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
  table$timestamp = parse_date(sub("T"," ",table$timestamp),approx = F)
  table$sensorglucose = suppressWarnings(as.numeric(table$sensorglucose))
  # Remove data > 1 month before date
  rows = table$timestamp <= date & table$timestamp > (as.Date(date)-30)
  if(sum(rows,na.rm = T) > 288){
    table = table[rows,]
  }else {
    table = table[-c(1:nrow(table)),]
  }
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  # 2 days for Holly to check
  rows = table$timestamp > (as.Date(table$timestamp[1])-2)
  if(sum(rows,na.rm = T) > 288){
    table = table[rows,]
  }else {
    table = table[-c(1:nrow(table)),]
  }
  if(sum(!is.na(table$sensorglucose))>0){
    # Write file
    filename <- paste0("./Data_Clean/Dexcom Files/",id,".csv")
    write.csv(table,file = filename,row.names = F,na = "")
  }
}
# Analyze
#cgmvariables("./Data_Clean/Dexcom Files","./Data_Clean",
#             outputname = "dexcom_sensor_summary",id_filename = T)
# TConnect
dir.create("./Data_Clean/TConnect Pump Files",showWarnings = F)
dir.create("./Data_Clean/TConnect Sensor Files",showWarnings = F)
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
  table$EventDateTime = parse_date(sub("T","",table$EventDateTime),approx = F)
  colnames(table)[colnames(table)=="BG"] = "bg"
  colnames(table)[colnames(table)=="EventDateTime"] = "datetime"
  colnames(table)[colnames(table)=="CarbSize"] = "BWZ.Carb.Input..grams."
  colnames(table)[colnames(table)=="InsulinDelivered"] = "Bolus.Volume.Delivered..U."
  table$BWZ.Estimate..U. = NA
  table$Bolus.Type = NA
  # Remove data > 1 month before date
  rows = table$datetime <= date & table$datetime > (as.Date(date)-30)
  if(sum(rows,na.rm = T) > 10){
    table = table[rows,]
  }else {
    table = table[-c(1:nrow(table)),]
  }
  # 2 days for Holly
  rows = table$datetime > (as.Date(table$datetime[1])-2)
  if(sum(rows,na.rm = T) > 10){
    table = table[rows,]
  }else {
    table = table[-c(1:nrow(table)),]
  }
  # Write file
  if(nrow(table)>0){
    filename <- paste0("./Data_Clean/TConnect Pump Files/",id,".csv")
    write.csv(table,file = filename,row.names = F,na = "")
  }
  # Sensor
  table = read.csv(f,na.strings = "")
  w = which(table == "Readings (CGM / BGM)", arr.ind=TRUE)
  if(nrow(w)==0){
    next
  }
  colnames(table) = table[w[1],]
  table = table[,c("EventDateTime","Readings (CGM / BGM)")]
  colnames(table) = c("timestamp","sensorglucose")
  table$subjectid = NA
  table = table[,c("subjectid","timestamp","sensorglucose")]
  table$timestamp = parse_date(sub("T"," ",table$timestamp),approx = F)
  table$sensorglucose = suppressWarnings(as.numeric(table$sensorglucose))
  # Remove data > 1 month before date
  rows = table$timestamp <= date & table$timestamp > (as.Date(date)-30)
  if(sum(rows,na.rm = T) > 100){
    table = table[rows,]
  }else {
    table = table[-c(1:nrow(table)),]
  }
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  # 2 days for Holly to check
  rows = table$timestamp > (as.Date(table$timestamp[1])-2)
  if(sum(rows,na.rm = T) > 100){
    table = table[rows,]
  }else {
    table = table[-c(1:nrow(table)),]
  }
  if(sum(!is.na(table$sensorglucose))>0){
    # Write file
    filename <- paste0("./Data_Clean/TConnect Sensor Files/",id,".csv")
    write.csv(table,file = filename,row.names = F,na = "")
  }
}
# Analyze
pump_variables(indir = "./Data_Clean/TConnect Pump Files",
               outdir = "./Data_Clean",outname = "tconnect_pump_summary")
#cgmvariables("./Data_Clean/TConnect Sensor Files","./Data_Clean",
#             outputname = "tconnect_sensor_summary",id_filename = T)
# Tidepool
dir.create("./Data_Clean/Tidepool Files",showWarnings = F)
files = list.files("./Data_Raw/Device Files/Tidepool",full.names = T)
# Iterate through
for (f in files) {
  id <- sub("_.*","",basename(f))
  print(basename(f))
  # Read tab names
  tabs = excel_sheets(f)
  if ("Insulin use and carbs" %in% tabs) {
    t = suppressWarnings(read_excel(f,"Insulin use and carbs"))
    t = t %>% rename(`Bolus Volume Delivered (U)` = `Bolus Volume (U)`,
                     `BWZ Carb Input (grams)` = `Carbs(g)`)
    smbg = suppressWarnings(read_excel(f,"Name and glucose"))
    start = which(smbg[,1]=="Time")
    colnames(smbg) = smbg[start,]
    smbg = smbg[-c(0:start+1),]
    colnames(smbg)[tolower(colnames(smbg)) == "mg/dl"] = 'bg'
    if (nrow(t) > 0) {
      t = full_join(t,smbg[,c("Time","bg")],by = "Time")
    } else {
      t = smbg
    }
    t$Date = sapply(strsplit(t$Time," "),"[[",1)
    t$Time = sub(".* ","",t$Time)
  } else {
    # BG checks
    if ("SMBG" %in% tabs) {
      smbg = suppressWarnings(read_excel(f,"SMBG"))
      smbg = smbg %>% select(`Local Time`,Value)
      colnames(smbg) = c("datetime","bg")
      smbg$bg = round(as.numeric(smbg$bg))
      smbg = as.data.frame(smbg)
    } else {
      smbg = matrix(nrow = 1,ncol = 2)
    }
    # Boluses
    if (any(grepl("bolus",tolower(tabs)))){
      bolus = suppressWarnings(read_excel(f,"Bolus"))
      if ("Extended" %in% colnames(bolus)){
        bolus = bolus %>% select(`Local Time`,`Sub Type`,Extended,Normal)
        bolus$Normal[!is.na(bolus$Extended)] = bolus$Normal[!is.na(bolus$Extended)] +
          bolus$Extended[!is.na(bolus$Extended)]
        bolus$Extended = NULL
      } else {
        bolus = bolus %>% select(`Local Time`,`Sub Type`,Normal)
      }
    } else {
      bolus = matrix(nrow = 1,ncol = 3)
    }
    colnames(bolus) = c("datetime","Bolus Type","Bolus Volume Delivered (U)")
    bolus = as.data.frame(bolus)
    # Carbs and bolus recommendation if available
    if ("Bolus Calculator" %in% tabs) {
      carbs = suppressWarnings(read_excel(f,"Bolus Calculator"))
      carbs = carbs %>% select(`Local Time`,`Carb Input`,`Recommended Net`)
    } else {
      carbs = matrix(nrow = 1,ncol = 3)
    }
    colnames(carbs) = c("datetime","BWZ Carb Input (grams)","BWZ Estimate (U)")
    carbs = as.data.frame(carbs)
    # Merge
    t = full_join(smbg,bolus,by = "datetime")
    t = full_join(t,carbs,by = "datetime")
    t$Date = as.Date(t$datetime)
    t$Time = sub(".* ","",t$datetime)
    t = t %>% arrange(datetime)
  }
  vars = c("Date","Time","bg","BG Reading (mg/dL)","Sensor Calibration BG (mg/dL)",
           "BWZ Carb Input (grams)","BWZ Estimate (U)",
           "Bolus Volume Delivered (U)","Bolus Type")
  missing = vars[which(!(vars %in% colnames(t)))]
  t[,missing] = NA
  t$Date = parse_date(t$Date,approx = F)
  # Remove dates with year 2009
  t = t[lubridate::year(t$Date)!=2009,]
  # Get dates
  v1 = dates$`Date Questionnaires`[match(as.numeric(id),dates$`Participant ID`)]
  # Remove data > 1 month before date
  rows = t$datetime <= v1 & t$datetime > (as.Date(v1)-30)
  if(sum(rows,na.rm = T) > 0){
    t = t[rows,]
  }else {
    t = t[-c(1:nrow(t)),]
  }
  # 2 days for Holly to check
  rows = t$datetime > (as.Date(t$datetime[1])-2)
  if(sum(rows,na.rm = T) > 0){
    t = t[rows,]
  }else {
    t = t[-c(1:nrow(t)),]
  }
  # Write file
  if(nrow(t)>0){
    filename <- paste0("./Data_Clean/Tidepool Files/",id,".csv")
    write.csv(t[,vars],file = filename,row.names = F,na = "")
  }
}
# Analyze
pump_variables(indir = "./Data_Clean/Tidepool Files",
               outdir = "./Data_Clean",outname = "tidepool_pump_summary")
# Glooko
dir.create("./Data_Clean/Glooko Files",showWarnings = F)
files = list.files("./Data_Raw/Device Files/Glooko (PDFs)",full.names = T)
# Summary data frame
pdf_summary = data.frame()
# Iterate through files
for (f in 1:length(files)) {
  id <- sub("_.*","",basename(files[f]))
  # Read PDF into list
  pdf = pdf_data(files[f])
  # First page
  # Page as a dataframe, sort by x and y values
  df = as.data.frame(pdf[[1]])
  df = df %>% arrange(x,y)
  # Average and readings
  avg_sg = as.numeric(df$text[which(df$x == 107 & df$y == 186)])
  sd_sg = as.numeric(df$text[which(df$x == 107 & df$y == 196)])
  readings = as.numeric(df$text[which(df$x == 107 & df$y == 206)])
  # Insulin and diet
  basal = as.numeric(df$text[which(df$x %in% c(374,383,380,389) & df$y == 116)])
  bolus = as.numeric(df$text[which(df$x == 469 & df$y == 116)])
  overrides = df$text[which(df$x == 466 & df$y == 161)]
  bolus_day = as.numeric(df$text[which(df$x == 466 & df$y == 171)])
  carbs_day = as.numeric(df$text[which(df$x == 467 & (df$y == 227 | df$y == 228))])
  entries_day = as.numeric(df$text[which(df$x == 467 & df$y == 238)])
  # TIR
  # CGM data
  very_high = sub("%","",df$text[which(df$x == 109 & df$y == 118)])
  high = sub("%","",df$text[which(df$x == 109 & df$y == 129)])
  target = sub("%","",df$text[which(df$x == 109 & df$y == 142)])
  low = sub("%","",df$text[which(df$x == 109 & df$y == 155)])
  very_low = sub("%","",df$text[which(df$x == 109 & (df$y == 165 | df$y == 166))])
  # Add to summary df
  pdf_summary[f,"id"] = id
  pdf_summary[f,"readings_per_day"] = readings
  pdf_summary[f,"basal_units"] = basal
  pdf_summary[f,"bolus_units"] = bolus
  pdf_summary[f,"overrides"] = overrides
  pdf_summary[f,"bolus_per_day"] = bolus_day
  pdf_summary[f,"carbs_per_day"] = carbs_day
  pdf_summary[f,"carb_entries_per_day"] = entries_day
  pdf_summary[f,"very_high"] = very_high
  pdf_summary[f,"high"] = high
  pdf_summary[f,"tir"] = target
  pdf_summary[f,"low"] = low
  pdf_summary[f,"very_low"] = very_low
  pdf_summary[f,"avg_sg"] = avg_sg
  pdf_summary[f,"sd_sg"] = sd_sg
}
write.csv(pdf_summary,file = paste0("./Data_Clean/glooko_summary.csv"),row.names = F,na = "")
