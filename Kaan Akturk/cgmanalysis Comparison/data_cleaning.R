library(tidyverse)
library(pdftools)
## Dexcom
# Clean exported data based on dates in patient list
files <- list.files("/Users/timvigers/Medtronic, Dexcom, Libre/Dexcom",full.names = T)
# Remove patient summary from files list
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
  dat <- dat[which(dat$timestamp >= start & dat$timestamp <= end),]
  filename <- paste0(outdir,"/",id,".csv")
  if (nrow(dat) > 10) {
    dat$subjectid[1] <- id
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
  dat <- dat[which(dat$timestamp >= start & dat$timestamp <= end),]
  filename <- paste0(outdir,"/",id,".csv")
  if (nrow(dat) > 10) {
    dat$subjectid[1] <- id
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
  dat <- dat[which(dat$timestamp >= start & dat$timestamp <= end),]
  filename <- paste0(outdir,"/",id,".csv")
  if (nrow(dat) > 10) {
    dat$subjectid[1] <- id
    write.csv(dat,file = filename,row.names = F,na = "")
  }
}

# Get PDF data for dexcom and tandem
files = list.files("/Users/timvigers/Medtronic, Dexcom, Libre/Tandem and Dexcom Data",
                   full.names = T,recursive = T)
# Summary data frame
pdf_summary = data.frame()
# Iterate through files
for (f in 1:length(files)) {
  # Get ID and CGM Type
  id = as.numeric(sub("-.*","",basename(files[f])))
  cgm = sub(".*-","",basename(files[f]))
  cgm = tolower(sub(".pdf","",cgm))
  # Read PDF into list
  pdf = pdf_data(files[f])
  # Find correct page
  df = as.data.frame(pdf[[length(pdf)]])
  df = df %>% arrange(x,y)
  # Get data
  if (grepl("dexcom",tolower(basename(files[f])))) {
    # Percent TIRs - Dexcom
    y = df$y[which(df$text == "Glucose")[1]]
    x1 = df$x[which(df$text == "Very")[1]]
    x2 = df$x[max(which(df$text == "High"))]
    percs = df[which(abs(df$y - y) < 5 & (df$x > x1 & df$x < x2)),"text"]
    percs = percs[grep("%",percs)]
    percs = as.numeric(gsub("%","",percs))
    # SD
    x = df$x[which(df$text == "SD")]
    sd = as.numeric(df[which(abs(df$y - y) < 5 & abs(df$x - x) < 5),"text"])
  } else {
    # Percent TIRs - Tandem
    x = df$x[which(df$text == "High")[1]]
    y1 = df$y[which(df$text == "(>=250" | df$text == "(>=251")[1]]
    y2 = df$y[which(df$text == "Average")[1]]
    percs = df[which((df$y > y1 & df$y < y2) & df$x == x),"text"]
    percs = percs[grep("%",percs)]
    percs = as.numeric(gsub("%","",percs))
    percs[2] = percs[1] + percs[2]
    percs = rev(percs)
    # SD
    w = df$y[which(df$text == "Standard")[1]]
    sd = as.numeric(df[which(abs(df$y - w) < 5 & (df$x > 175 & df$x < 185)),"text"])
    }
  # Store results
  pdf_summary[f,"id"] = id
  pdf_summary[f,"cgm"] = cgm
  pdf_summary[f,c("u54","u70","70_180","a180","a250")] = percs
  pdf_summary[f,"sd"] = sd
}

