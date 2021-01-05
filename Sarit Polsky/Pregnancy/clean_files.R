library(readxl)
library(lubridate)
setwd("/Users/timvigers/Work/Sarit/Tim")
dateparseorder <- c("mdy HM","mdy HMS","mdY HM","mdY HMS","dmy HM","dmy HMS",
                    "dmY HM","dmY HMS","Ymd HM","Ymd HMS","ymd HM","ymd HMS",
                    "Ydm HM","Ydm HMS","ydm HM","ydm HMS")
# Output location
outdir = "/Users/timvigers/Work/Sarit/Tim/Cleaned/"
# Import dates 
dates = read_excel("./Trimester Dates.xlsx")
# List all the directories
dirs = list.dirs("RAW DATA- CGM downloads")
# Loop through directories
for (d in dirs[2:length(dirs)]) {
  # Get name
  name = tolower(sub("_.*","",basename(d)))
  name = sub(" ","",name)
  last_name = strsplit(name,",")[[1]][1]
  first_name = strsplit(name,",")[[1]][2]
  # Get dates
  r = which(tolower(dates$`Last name`) == last_name & tolower(dates$`First name`) ==  first_name)
  t0 = dates$`t=0`[r]
  wk14 = dates$`14 wks`[r]
  wk28 = dates$`28 wks`[r]
  edd = dates$EDD[r]
  # List files
  files = list.files(d,full.names = T)
  # Loop through files, combine into 1
  l = lapply(files, function(f) {
    print(f)
    df = read.csv(f,na.strings = "",header = F)
    # Check file type by number of columns
    if (ncol(df) == 14) {
      colnames(df) = df[1,]
      df = df[-1,]
      df = df[,grep("timestamp|glucose value",tolower(colnames(df)))]
      colnames(df) = c("timestamp","sensorglucose")
      df$timestamp = sub("T"," ",df$timestamp)
      df$timestamp = parse_date_time(df$timestamp,dateparseorder,tz = "UTC")
    } else if (ncol(df) >= 48) {
      sensor = which(df$V3 == "Sensor")
      colnames(df) = df[sensor[1]+1,]
      df = df[(sensor[1]+2):nrow(df),]
      df$timestamp = parse_date_time(paste(df$Date,df$Time),dateparseorder,tz = "UTC")
      df = df[,grep("timestamp|sensor glucose",tolower(colnames(df)))]
      colnames(df)[1] = "sensorglucose"
    } else if (ncol(df) == 19) {
      colnames(df) = df[3,]
      df = df[4:nrow(df),]
      df = df[,grep("timestamp|historic glucose",tolower(colnames(df)))]
      colnames(df) = c("timestamp","sensorglucose")
      df$timestamp = parse_date_time(df$timestamp,dateparseorder,tz = "UTC")
    }
    return(df)
  })
  # Bind
  df = do.call(rbind,l)
  # remove duplicates
  df = df[!duplicated(df),]
  df = df[!is.na(df$timestamp),]
  # ID
  df$subjectid = NA
  id = paste0(last_name,", ",first_name)
  df = df[,c("subjectid","timestamp","sensorglucose")]
  # Split and write CSVs
  t0_wk14 = df[df$timestamp >= t0 & df$timestamp < wk14,]
  if (nrow(t0_wk14)>0){
    t0_wk14$subjectid[1] = id
    write.csv(t0_wk14,file = paste0(outdir,last_name,"_",first_name,"_t0_wk14.csv"),
              row.names = F,na = "")
  }
  
  wk14_wk28 = df[df$timestamp >= wk14 & df$timestamp < wk28,]
  if (nrow(wk14_wk28) > 0) {
    wk14_wk28$subjectid[1] = id
    write.csv(wk14_wk28,file = paste0(outdir,last_name,"_",first_name,"_wk14_wk28.csv"),
              row.names = F,na = "")
  }
  
  wk28_edd = df[df$timestamp >= wk28 & df$timestamp < edd,]
  if(nrow(wk28_edd) > 0) {
    wk28_edd$subjectid[1] = id
    write.csv(wk28_edd,file = paste0(outdir,last_name,"_",first_name,"_wk28_edd.csv"),
              row.names = F,na = "")
  }
}


