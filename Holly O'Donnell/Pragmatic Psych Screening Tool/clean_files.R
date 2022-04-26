library(tidyverse)
library(readxl)
library(lubridate)
setwd("~/Documents")
# Make folder for cleaned files
dir.create("Data_Clean/Pump Files",showWarnings = F)
# Want data about 1 month prior to questionnaires
dates = read_excel("./Data_Raw/Device Files/Device Information 1.24.22.xlsx")
dates$`Date Questionnaires` = ymd(dates$`Date Questionnaires`)
# Carelink
files = list.files("./Data_Raw/Device Files/Carelink",full.names = T)
for (f in files) {
  id <- as.numeric(sub("_.*","",basename(f)))
  date = dates$`Date Questionnaires`[match(id,dates$`Participant ID`)]
  # Read in
  table = read.csv(f,na.strings = "")
  # Trim ends
  end <- which(table[,3] == "Sensor")
  if (length(end )> 0) {
    table <- table[-c((end-1):nrow(table)),]
  }
  start <- which(table[,1] == "Index")
  if (length(start) > 0) {
    colnames(table) <- table[start[1],]
    table <- table[-c(1:(start[1]+2)),]
  }
  # Remove micro boluses
  table = table[table$`Bolus Source` != "CLOSED_LOOP_MICRO_BOLUS",]
  # Remove missing dates
  table = table[!is.na(table$Date) & !is.na(table$Time),]
  # Date time column
  table$datetime <- paste(table$Date,table$Time)
  table$datetime <- parse_date_time(table$datetime,orders = c("mdyHMS","ymdHMS"))
  # Remove data > 1 month before date
  table = table[table$datetime <= date & table$datetime > (date - 30),]
  # Write file
  filename <- paste0("./Data_Clean/Pump Files/",id,"_cleaned.csv")
  write.csv(table,file = filename,row.names = F,na = "")
}
# Dexcom
files = list.files("./Data_Raw/Device Files/Dexcom Files",full.names = T)
for (f in files) {
  id <- as.numeric(sub("_.*","",basename(f)))
  date = dates$`Date Questionnaires`[match(id,dates$`Participant ID`)]
  # Read in
  table = read.csv(f,na.strings = "")
}