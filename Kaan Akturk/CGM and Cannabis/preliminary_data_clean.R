library(readxl)
setwd("/Users/timvigers/cannabis")
dates <- read_excel("./TDemographics_Dates.xlsx")
dates$Name <- tolower(gsub(" ","",dates$Name))
dates[,c("Date_Start","Date_End")] <- lapply(dates[,c("Date_Start","Date_End")],
                                             lubridate::mdy)
files <- list.files("./formatted",full.names = T)

for (f in files) {
  name <- tolower(basename(tools::file_path_sans_ext(f)))
  start <- dates$Date_Start[which(dates$Name == name)]
  end <- dates$Date_End[which(dates$Name == name)]
  table <- read.csv(f,stringsAsFactors = F,na.strings = "")
  table$subjectid <- table$subjectid[1]
  table$timestamp <- sub("T"," ",table$timestamp)
  table$timestamp <- 
    lubridate::parse_date_time(table$timestamp,
                               orders = c("mdy_HMS","mdy_HM","ymd_HMS","ymd_HM"))
  table$sensorglucose <- suppressWarnings(as.numeric(table$sensorglucose))
  # Remove irrelevant dates and sort
  table <- table[table$timestamp > start & table$timestamp < end,]
  table <- table[order(table$timestamp),]
  # Remove missing sensor glucose values with duplicate times
  time_diffs <- diff(table$timestamp)
  units(time_diffs) <- "secs"
  dups <- which(time_diffs < 5)
  delete <- dups[which(is.na(table$sensorglucose[dups+1]))]+1
  if(length(delete > 0)){table <- table[-c(delete),]}
  # Average remaining rows with duplicate times 
  time_diffs <- diff(table$timestamp)
  units(time_diffs) <- "secs"
  dups <- which(time_diffs < 5)
  means <- lapply(dups, function(x){
    return(mean(table$sensorglucose[x],table$sensorglucose[x+1],na.rm = T))
  })
  if(length(dups) > 0){
    table <- table[-c(dups),]
    table$sensorglucose[dups] <- unlist(means)
  }
  # Write csv
  write.csv(table,file = paste0("./cleaned/",name,".csv"),row.names = F,na = "")
}
