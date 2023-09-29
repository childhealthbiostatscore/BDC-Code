library(tidyverse)
library(readxl)
library(tools)
library(parsedate)
library(cgmanalysis)
library(pdftools)
library(stringr)
source("~/GitHub/BDC-Code/Holly O'Donnell/Pragmatic Psych Screening Tool/pump_variables.R")
setwd("/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Holly O'Donnell/Device data/March 2023")

# Want data about 1 month prior to questionnaires
dates = read_excel("./Data_Raw/dates.xlsx")
dates$yr <- str_sub(dates$`Date Questionnaires`,1,4)
dates$mo <- str_sub(dates$`Date Questionnaires`,6,7)
dates$day <- str_sub(dates$`Date Questionnaires`,9,10)
dates$mo <- str_remove(dates$mo,"0")
dates$day <- ifelse(dates$day<10,str_remove(dates$day,"0"),dates$day)
dates$`Date Questionnaires` <- paste0(dates$mo,"/",dates$day,"/",dates$yr)
dates$`Date Questionnaires` <- as.Date(dates$`Date Questionnaires`,format="%m/%d/%Y")
#dates$`Date Questionnaires` = parse_date(dates$`Date Questionnaires`,approx = F)

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
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  # 2 days for Holly to check
  rows = table$datetime < (as.Date(dates[dates$`Participant ID`==id,]$`Date Questionnaires`)+1)
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  } else {
    table = table[-c(1:nrow(table)),]
  }
  rows = table$datetime >= (as.Date(dates[dates$`Participant ID`==id,]$`Date Questionnaires`)-1)
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
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  # 2 days for Holly to check
  rows = table$timestamp <= (as.Date(dates[dates$`Participant ID`==id,]$`Date Questionnaires`)+1)
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  } else {
    table = table[-c(1:nrow(table)),]
  }
  rows = table$timestamp >= (as.Date(dates[dates$`Participant ID`==id,]$`Date Questionnaires`)-1)
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  } else {
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
  table$BWZ.Estimate..U. = as.numeric(table$FoodDelivered) + as.numeric(table$CorrectionDelivered)
  table$Bolus.Type = NA
  # 2 days for Holly to check
  # rows = table$datetime > (as.Date(table$datetime[1])-2)
  rows = table$datetime <= (as.Date(dates[dates$`Participant ID`==id,]$`Date Questionnaires`))
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  } else {
    table = table[-c(1:nrow(table)),]
  }
  rows = table$datetime >= (as.Date(dates[dates$`Participant ID`==id,]$`Date Questionnaires`)-1)
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  } else {
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
  # Remove blank rows
  blank = which(rowSums(is.na(table))==ncol(table))
  if(length(blank)>0){
    table = table[-blank,]
  }
  # 2 days for Holly to check
  # rows = table$datetime > (as.Date(table$datetime[1])-2)
  rows = table$timestamp <= (as.Date(dates[dates$`Participant ID`==id,]$`Date Questionnaires`))
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  } else {
    table = table[-c(1:nrow(table)),]
  }
  rows = table$timestamp >= (as.Date(dates[dates$`Participant ID`==id,]$`Date Questionnaires`)-1)
  if(sum(rows,na.rm = T) > 0){
    table = table[rows,]
  } else {
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
      bolus = bolus[bolus$`Sub Type` != "automated",]
      if ("Extended" %in% colnames(bolus)){
        bolus = bolus %>% select(`Local Time`,`Sub Type`,Extended,Normal)
        bolus$Normal = rowSums(bolus[,c("Normal","Extended")],na.rm = T)
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
  v1 = dates$`Date Questionnaires`[match(id,dates$`Participant ID`)]
  # 2 days for Holly to check
  rows = t$datetime <= (as.Date(dates[dates$`Participant ID`==id,]$`Date Questionnaires`))
  if(sum(rows,na.rm = T) > 0){
    t = t[rows,]
  } else {
    t = t[-c(1:nrow(t)),]
  }
  rows = t$datetime >= (as.Date(dates[dates$`Participant ID`==id,]$`Date Questionnaires`)-1)
  if(sum(rows,na.rm = T) > 0){
    t = t[rows,]
  } else {
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