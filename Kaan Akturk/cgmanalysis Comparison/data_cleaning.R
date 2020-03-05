library(tidyverse)
## Dexcom
# Clean exported data based on dates in patient list
files <- list.files("/Users/timvigers/Medtronic, Dexcom, Libre/Dexcom",full.names = T)
# Remove patient sumnary from files list
files <- files[-c(which(grepl("Patient List",files)))]
# Patient summary, format dates and names
patient_list <- read.csv("/Users/timvigers/Medtronic, Dexcom, Libre/Dexcom/Patient List_Dexcom.csv",stringsAsFactors = F)
patient_list[,c("Start.Date","End.Date")] <- 
  lapply(patient_list[,c("Start.Date","End.Date")], lubridate::mdy)
patient_list$Patient.Name <- tolower(patient_list$Patient.Name)
# Output directory
outdir <- "/Users/timvigers/CGMs/Dexcom"
# Loop through exports and remove incorrect dates
for (f in 1:length(files)) {
  dat <- read.csv(files[f],stringsAsFactors = F,na.strings = "")
  id <- tolower(paste(dat$Patient.Info[1:2],collapse = " "))
  start <- patient_list$Start.Date[which(patient_list$Patient.Name == id)]
  end <- patient_list$End.Date[which(patient_list$Patient.Name == id)]
  dat$timestamp <- lubridate::ymd_hms(sub("T"," ",dat$Timestamp..YYYY.MM.DDThh.mm.ss.))
  dat$subjectid <- NA
  colnames(dat)[which(colnames(dat)=="Glucose.Value..mg.dL.")] <- "sensorglucose"
  dat <- dat[which(!is.na(dat$timestamp)),
             c("subjectid","timestamp","sensorglucose")]
  dat$subjectid[1] <- id
  dat <- dat[which(dat$timestamp >= start & dat$timestamp <= end),]
  filename <- paste0(outdir,"/",id,".csv")
  if (nrow(dat) > 10) {
    write.csv(dat,file = filename,row.names = F,na = "")
  }
}

## Libre
# Clean exported data based on dates in patient list
files <- list.files("/Users/timvigers/Medtronic, Dexcom, Libre/Libre",full.names = T)
# Remove patient sumnary from files list
files <- files[-c(which(grepl("Patient List",files)))]
# Patient summary, format dates and names
patient_list <- read.csv("/Users/timvigers/Medtronic, Dexcom, Libre/Libre/Patient List_Libre.csv",stringsAsFactors = F)
patient_list[,c("Start.Date","End.Date")] <- 
  lapply(patient_list[,c("Start.Date","End.Date")], lubridate::mdy)
patient_list$Patient.Name <- tolower(patient_list$Patient.Name)
# Output directory
outdir <- "/Users/timvigers/CGMs/Libre"
# Loop through exports and remove incorrect dates
for (f in 1:length(files)) {
  dat <- read.csv(files[f],stringsAsFactors = F,na.strings = "",skipNul = T)
  id <- tolower(paste(dat[1,1],collapse = " "))
  start <- patient_list$Start.Date[which(patient_list$Patient.Name == id)]
  end <- patient_list$End.Date[which(patient_list$Patient.Name == id)]
  dat$timestamp <- suppressWarnings(lubridate::mdy_hm(dat[,3]))
  dat$subjectid <- NA
  colnames(dat)[5] <- "sensorglucose"
  dat <- dat[which(!is.na(dat$timestamp)),
             c("subjectid","timestamp","sensorglucose")]
  dat$subjectid[1] <- id
  dat <- dat[which(dat$timestamp >= start & dat$timestamp <= end),]
  filename <- paste0(outdir,"/",id,".csv")
  if (nrow(dat) > 10) {
    write.csv(dat,file = filename,row.names = F,na = "")
  }
}

## Medtronic
# Clean exported data based on dates in patient list
files <- list.files("/Users/timvigers/Medtronic, Dexcom, Libre/Medtronic",full.names = T)
# Remove patient sumnary from files list
files <- files[-c(which(grepl("Patient Sheet",files)))]
# Patient summary, format dates and names
patient_list <- read.csv("/Users/timvigers/Medtronic, Dexcom, Libre/Medtronic/Patient Sheet_Medtronic.csv",stringsAsFactors = F)
patient_list[,c("Start.Date","End.Date")] <- 
  lapply(patient_list[,c("Start.Date","End.Date")], lubridate::mdy)
patient_list$Name <- tolower(patient_list$Name)
# Output directory
outdir <- "/Users/timvigers/CGMs/Medtronic"
# Loop through exports and remove incorrect dates
for (f in 1:length(files)) {
  dat <- read.csv(files[f],stringsAsFactors = F,na.strings = "")
  id <- tolower(paste(dat$First.Name[1],dat$Last.Name[1],collapse = " "))
  sens_start <- which(dat[,3] == "Sensor")
  colnames(dat) <- dat[sens_start[1]+1,]
  dat <- dat[-c(1:(sens_start[1]+2)),]
  start <- patient_list$Start.Date[which(patient_list$Name == id)]
  end <- patient_list$End.Date[which(patient_list$Name == id)]
  dat$timestamp <- suppressWarnings(lubridate::mdy_hms(paste(dat$Date,dat$Time)))
  dat$subjectid <- NA
  colnames(dat)[which(colnames(dat)=="Sensor Glucose (mg/dL)")] <- "sensorglucose"
  dat <- dat[which(!is.na(dat$timestamp)),
             c("subjectid","timestamp","sensorglucose")]
  dat$subjectid[1] <- id
  dat <- dat[which(dat$timestamp >= start & dat$timestamp <= end),]
  filename <- paste0(outdir,"/",id,".csv")
  if (nrow(dat) > 10) {
    write.csv(dat,file = filename,row.names = F,na = "")
  }
}
