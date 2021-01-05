library(readxl)
setwd("/Users/timvigers/Work/Sarit/Tim")
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
  # Loop through files
  for (f in files) {
    df = read.csv(f,na.strings = "",header = F)
  # Check file type by number of columns
    if (ncol(df) < 40) {
      colnames(df) = df[1,]
      df = df[-1,]
      df = df[,grep("timestamp|glucose value",tolower(colnames(df)))]
      colnames(df) = c("timestamp","sensorglucose")
      df = df[!is.na(df$timestamp),]
      df$timestamp = sub("T"," ",df$timestamp)
    }
  }
}


