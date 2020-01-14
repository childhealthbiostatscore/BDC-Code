library(tidyverse)
# Study dates
dates <- read.csv("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Kim Driscoll/Baseline Pump Paper/Data_Cleaned/PumpItUp_Appt Times.csv")
dates[,2:ncol(dates)] <- lapply(dates[,2:ncol(dates)],lubridate::mdy)
# Original files
files <- list.files("/Users/timvigers/Desktop/Pump Files Original",full.names = T)
# Clean
for (f in files) {
  id <- sub("_pump.csv","",basename(f))
  id_no_timepoint <- sub(".*_","",id)
  table <- read.csv(f,stringsAsFactors = F,na="",check.names = F)
  end <- which(table[,3] == "Sensor")
  if (length(end )> 0) {
    table <- table[-c((end-1):nrow(table)),]
  }
  start <- which(table[,1] == "Index")
  if (length(start) > 0) {
    colnames(table) <- table[start,]
    table <- table[-c(1:(start+2)),]
  }
  table$Date <- lubridate::mdy(table$Date)
  # Get dates
  if (grepl("T1",id) == T) {
    end <- dates$T1_Date[which(dates$ID == id_no_timepoint)] + 1
    start <- end - 90
  } else if (grepl("T2",id) == T) {
    start <- dates$T1_Date[which(dates$ID == id_no_timepoint)]
    end <- dates$T2_Date[which(dates$ID == id_no_timepoint)] + 1
  } else if (grepl("T3",id) == T) {
    start <- dates$T2_Date[which(dates$ID == id_no_timepoint)]
    end <- dates$T3_Date[which(dates$ID == id_no_timepoint)] + 1
  } else if (grepl("T5",id) == T) {
    start <- dates$T4_Date[which(dates$ID == id_no_timepoint)]
    end <- dates$T5_Date[which(dates$ID == id_no_timepoint)] + 1
  }
  table <- table %>% filter(Date >= start & Date <= end)
  filename <- paste0("/Users/timvigers/Desktop/cleaned/",id,"_cleaned.csv")
  write.csv(table,file = filename,row.names = F,na="")
}