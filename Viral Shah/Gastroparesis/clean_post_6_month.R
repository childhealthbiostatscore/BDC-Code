library(lubridate)
indir <- "/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data/Data after 6 months CSV"
outdir <- "/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/Gastroparesis/Data/Data after 6 months Cleaned CSV"

files <- list.files(indir,full.names = T)

for (f in 1:length(files)) {
  dir.create(outdir,showWarnings = F)
  table <- read.csv(files[f],stringsAsFactors = F)
  id <- paste0(substr(basename(files[f]),1,2),"C")
  colnames(table) <- c("Date","Time","sensorglucose")
  table$timestamp <- paste(table$Date,substr(table$Time,12,nchar(table$Time)))
  table$timestamp <- ymd_hms(table$timestamp)
  table$subjectid <- NA
  table$subjectid <- id
  table <- table[,c("subjectid","timestamp","sensorglucose")]
  if(f == 1) {
    all_data <- table
  } else {
    all_data <- rbind(all_data,table)
  }
  split <- split(all_data,all_data$subjectid)
  for (df in split) {
    df <- as.data.frame(df)
    colnames(df) <- c("subjectid","timestamp","sensorglucose")
    filename <- paste0(outdir,"/",df$subjectid[1],".csv")
    write.csv(df,file = filename,row.names = F)
  }
}