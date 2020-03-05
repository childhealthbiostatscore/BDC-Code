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
  # dat <- dat[which(dat$timestamp >= start & dat$timestamp <= end),]
  dat$subjectid <- NA
  colnames(dat)[which(colnames(dat)=="Glucose.Value..mg.dL.")] <- "sensorglucose"
  dat <- dat[which(!is.na(dat$timestamp)),
             c("subjectid","timestamp","sensorglucose")]
  dat$subjectid[1] <- id
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
  # dat <- dat[which(dat$timestamp >= start & dat$timestamp <= end),]
  dat$subjectid <- NA
  colnames(dat)[which(colnames(dat)=="Glucose.Value..mg.dL.")] <- "sensorglucose"
  dat <- dat[which(!is.na(dat$timestamp)),
             c("subjectid","timestamp","sensorglucose")]
  dat$subjectid[1] <- id
  filename <- paste0(outdir,"/",id,".csv")
  if (nrow(dat) > 10) {
    write.csv(dat,file = filename,row.names = F,na = "")
  }
}
