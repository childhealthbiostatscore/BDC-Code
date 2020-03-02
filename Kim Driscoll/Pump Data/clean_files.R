library(tidyverse)
# Study dates
dates <- read.csv("/Volumes/peds/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Kim Driscoll/Baseline Pump Paper/Data_Cleaned/PumpItUp_Appt Times.csv")
dates[,2:ncol(dates)] <- lapply(dates[,2:ncol(dates)],lubridate::mdy)
# Original files
files <- list.files("/Volumes/peds/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Kim Driscoll/Baseline Pump Paper/Data_Cleaned/Pump Files Original/",full.names = T)
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
    colnames(table) <- table[start[1],]
    table <- table[-c(1:(start[1]+2)),]
  }
  # Date time column
  table$datetime <- paste(table$Date,table$Time)
  table$datetime <- lubridate::parse_date_time(table$datetime,
                                               orders = c("mdyHMS","ymdHMS"))
  # Get dates
  if (grepl("T1",id) == T) {
    end <- dates$T1_Date[which(dates$ID == id_no_timepoint)] 
    start <- end - 90
  } else if (grepl("T2",id) == T) {
    start <- dates$T1_Date[which(dates$ID == id_no_timepoint)]
    end <- dates$T2_Date[which(dates$ID == id_no_timepoint)] 
  } else if (grepl("T3",id) == T) {
    start <- dates$T2_Date[which(dates$ID == id_no_timepoint)]
    end <- dates$T3_Date[which(dates$ID == id_no_timepoint)] 
  } else if (grepl("T5",id) == T) {
    start <- dates$T4_Date[which(dates$ID == id_no_timepoint)]
    end <- dates$T5_Date[which(dates$ID == id_no_timepoint)] 
  }
  # Exclude incorrect times
  table <- table %>% filter(datetime >= start & datetime < end) %>%
    arrange(datetime)
  # Remove rows without important data
  table <- table[rowSums(is.na(table)) < 29,]
  # Write file
  filename <- paste0("/Volumes/peds/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Kim Driscoll/Baseline Pump Paper/Data_Cleaned/Pump Files Cleaned/",id,"_cleaned.csv")
  write.csv(table,file = filename,row.names = F,na="")
}
