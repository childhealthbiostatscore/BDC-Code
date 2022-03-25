library(readxl)
# Study dates
dates <- read_excel("/Users/timvigers/Documents/DP3 V1 Dates.xlsx")
dates$V1_Completed <- lubridate::ymd(dates$V1_Completed)
# Original files
files <- list.files("/Users/timvigers/Documents/Libre V1 Files (use this one)",full.names = T)
# Clean
for (f in files) {
  ext = tools::file_ext(f)
  id <- sub("_V1.*","",basename(f))
  # Get dates
  end_date = dates$V1_Completed[which(dates$record_id == paste0("HRTM_",id))] 
  start_date = end_date - 90
  if(ext == "txt"){
    table = read.delim(f,header = F)
    # Format table
    start = which(tolower(table[,1])=="id")
    colnames(table) = table[start,]
    table = table[start+1:nrow(table),]
    # Date time column
    table$timestamp <- lubridate::parse_date_time(table$Time,orders = c("mdyHM","ymdHM"))
    # Datetime and glucose
    table = table[,c("timestamp","Historic Glucose (mg/dL)")]
    colnames(table)[2] = "sensorglucose"
  } else if (ext == "csv"){
    table = read.csv(f)
    if(ncol(table)>3){
      # Date time column
      table$timestamp <- table[,grep("Timestamp",colnames(table))]
      table$timestamp <- 
        lubridate::parse_date_time(sub("T"," ",table$timestamp),orders = c("ymdHMS","mdyHM"))
      table = table[,c("timestamp","Glucose.Value..mg.dL.")]
      colnames(table)[2] = "sensorglucose"
    } else {
      # Format table
      start = which(tolower(table[,1])=="time")
      colnames(table) = table[start,]
      table = table[start+1:nrow(table),]
      # Date time column
      table$timestamp <- lubridate::parse_date_time(table$Time,orders = c("mdyHM","ymdHM"))
      # Datetime and glucose
      table = table[,c("timestamp","mg/dl")]
      colnames(table)[2] = "sensorglucose"
    }
  }
  # Exclude incorrect times
  table = table[table$timestamp >= start_date & table$timestamp < end_date,]
  table = table[order(table$timestamp),]
  # ID column
  table$subjectid = NA
  table$subjectid[1] = id
  table = table[,c("subjectid","timestamp","sensorglucose")]
  # Write file
  filename <- paste0("/Users/timvigers/Documents/libre_cleaned/",id,"_V1_cleaned.csv")
  write.csv(table,file = filename,row.names = F,na="")
}
