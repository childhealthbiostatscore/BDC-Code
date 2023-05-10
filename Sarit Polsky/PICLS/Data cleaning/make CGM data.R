library(cgmanalysis)
library(parsedate)
library(cgmanalysis)
library(readxl)
library(dplyr)
library(stringr)
library(lubridate)

# setup
setwd("/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Final raw CGM files for analysis")
outdir <- "/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data_Clean/Cleaned CGM data"

# read in file with trimester dates, admission dates, discharge dates
# trimester 3 will end at admission, PP will start at discharge
tri_dates <- read.csv("/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data cleaning/CGM Data Check.csv")
tri_dates$FirstTri <- as.Date(tri_dates$FirstTri,format = "%m/%d/%Y")
tri_dates$SecondTri <- as.Date(tri_dates$SecondTri,format = "%m/%d/%Y")
tri_dates$ThirdTri <- as.Date(tri_dates$ThirdTri,format = "%m/%d/%Y")
tri_dates$Delivery.Date <- as.Date(tri_dates$Delivery.Date,format = "%m/%d/%Y")

# read in labor admission dates
labor_dates <- read_xlsx("/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data cleaning/L&D Admission Dates for PICLS.xlsx")
labor_dates$pid <- labor_dates$`Study ID`
labor_dates$`Study ID` <- NULL
labor_dates <- labor_dates %>% filter(!is.na(pid))
dates <- merge(tri_dates,labor_dates,by="pid",all.x = T,all.y = T)
dates$subjectid <- dates$pid
dates$pid <- NULL

# get date of visit 15 for restarting PP data
ppdates <- read.csv("/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data cleaning/Data files/PICLSStudyHCLVsSAPTI-V15Dates_DATA_2022-11-07_2228.csv")
ppdates <- ppdates %>% filter(redcap_repeat_instrument=="pregnancy_visits")
ppdates$subjectid <- ppdates$pid
ppdates$pid <- NULL
ppdates <- ppdates %>% select(date_preg,subjectid)
colnames(ppdates) <- c("v15date","subjectid")

# combine all the data files into 1
d <- getwd()
files <-list.files(d, full.names = T)
alldata <- NULL

for (f in 1:length(files)) {
#for (f in 122:130) {
  print(files[f])
  df <- read.csv(files[f], na.strings = "", header = F)
  df <- df[8:nrow(df),]
  df <- as.data.frame(cbind(df[,2],df[,3],df[,32]))
  names(df) <- c("date","time","sensorglucose")
  df$sensorglucose <- as.numeric(df$sensorglucose)
  df$date <- parse_date_time(df$date, orders = c('ymd','mdy', 'dmy'))
  df <- df %>% filter(!is.na(df$sensorglucose))
  df <- df %>% filter(!is.na(df$date))
  df$dt <- paste(df$date,df$time)
  df$timestamp <- ymd_hms(df$dt)
  # get subject ID from file name
  df$subjectid <- str_sub(basename(files[f]),1,4)
  df <- df %>% select(subjectid,timestamp,dt,sensorglucose)
  alldata <- rbind(alldata,df)
  # all the data are combined, now need to merge in trimester dates by subject ID 
  # then output records based on dates into separate files in cleaned directory
}
alldata2 <- merge(alldata,dates,by="subjectid",all.x = T, all.y = F)
alldata2 <- merge(alldata2,ppdates,by="subjectid",all.x = T, all.y = F)
alldata2$sensorglucose <- as.numeric(alldata2$sensorglucose)
t1data <- alldata2 %>% filter(as.Date(timestamp)>=FirstTri & as.Date(timestamp)<SecondTri)
t1data$trimester <- "T1"
t2data <- alldata2 %>% filter(as.Date(timestamp)>=SecondTri & as.Date(timestamp)<ThirdTri)
t2data$trimester <- "T2"
t3data <- alldata2 %>% filter(as.Date(timestamp)>=ThirdTri & as.Date(timestamp)<as.Date(`L&D Admission Date`))
t3data$trimester <- "T3"
ppdata <- alldata2 %>% filter(as.Date(timestamp)>=v15date)
ppdata$trimester <- "Post-partum"

# now I just need to split the trimester files by ID
split1 <- split(t1data,t1data$subjectid)
for (df in split1) {
  df <- as.data.frame(df)
  df <- df[,c("subjectid","timestamp","sensorglucose")]
  df <- df[order(df$timestamp),]
  filename <- paste0("/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files/",df$subjectid[1],"_T1.csv")
  write.csv(df,file = filename,row.names = F)
}

split2 <- split(t2data,t2data$subjectid)
for (df in split2) {
  df <- as.data.frame(df)
  df <- df[,c("subjectid","timestamp","sensorglucose")]
  df <- df[order(df$timestamp),]
  filename <- paste0("/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files/",df$subjectid[1],"_T2.csv")
  write.csv(df,file = filename,row.names = F)
}

split3 <- split(t3data,t3data$subjectid)
for (df in split3) {
  df <- as.data.frame(df)
  df <- df[,c("subjectid","timestamp","sensorglucose")]
  df <- df[order(df$timestamp),]
  filename <- paste0("/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files/",df$subjectid[3],"_T3.csv")
  write.csv(df,file = filename,row.names = F)
}

splitpp <- split(ppdata,ppdata$subjectid)
for (df in splitpp) {
  df <- as.data.frame(df)
  df <- df[,c("subjectid","timestamp","sensorglucose")]
  df <- df[order(df$timestamp),]
  filename <- paste0("/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files/",df$subjectid[1],"_PP.csv")
  write.csv(df,file = filename,row.names = F)
}

# then run cgmvariables()
cgmvariables(inputdirectory = "/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files/", 
             outputdirectory = "/Volumes/BDC/Projects/Sarit Polsky/PICLS/Data_Clean/Cleaned CGM data", 
             id_filename = T, printname = T,
             customintervals = list(c(0,54),c(0,63),c(63,140),c(140,600),c(0,69)))

# does not appear to be counting excursions correctly, probably because of all the gaps
# when I finalize the dataset, should exclude these variables