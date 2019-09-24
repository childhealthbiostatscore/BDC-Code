# Split by time period
dates <- read.csv("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Janet Snell-Bergeon/Afrezza CGMs/Data_cleaned/dates.csv")
dates[,2:ncol(dates)] <- lapply(dates[,2:ncol(dates)],lubridate::mdy)
files <- list.files("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Janet Snell-Bergeon/Afrezza CGMs/Data_cleaned/patient_glucose",full.names = T)
for (file in files) {
  table <- read.csv(file,stringsAsFactors = F)
  id <- table$Patient.report[1]
  id <- gsub(".*Pt ","",id)
  colnames(table) <- as.character(table[2,])
  table <- table[-c(1,2),]
  table$subjectid <- NA
  table <- table[,c("subjectid","Meter Timestamp","Historic Glucose(mg/dL)")]
  colnames(table) <- c("subjectid","timestamp","sensorglucose")
  table$timestamp <- lubridate::mdy_hm(table$timestamp)
  start <- dates[which(dates$PID == id),"Date.1st.CGM.placed"]
  final <- dates[which(dates$PID == id),"Date.Final.CGM.placed"]
  end <- dates[which(dates$PID == id),"Final.Visit.Date"]
  if(id != "1-006") {
    t1 <- table[which(table$timestamp >= start & table$timestamp < final),]
    t1$subjectid[1] <- paste0(id,"_time1")
  }
  t2 <- table[which(table$timestamp >= final & table$timestamp < end),]
  t2$subjectid[1] <- paste0(id,"_time2")
  outdir <- "/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Janet Snell-Bergeon/Afrezza CGMs/Data_cleaned/cleaned/"
  write.csv(t1,file = paste(outdir,t1$subjectid[1],".csv"),row.names = F)
  write.csv(t2,file = paste(outdir,t2$subjectid[1],".csv"),row.names = F)
}
# Get cgm summary variables
cgmanalysis::cgmvariables("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Janet Snell-Bergeon/Afrezza CGMs/Data_cleaned/cleaned",
                          "/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Janet Snell-Bergeon/Afrezza CGMs/Data_cleaned/",
                          printname = F)
