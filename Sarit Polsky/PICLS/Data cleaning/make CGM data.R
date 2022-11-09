library(cgmanalysis)
library(parsedate)
library(cgmanalysis)
library(readxl)
library(dplyr)
library(stringr)

# setup
setwd("B:/Projects/Sarit Polsky/PICLS/Data_Raw/Final raw CGM files for analysis")
outdir <- "B:/Projects/Sarit Polsky/PICLS/Data_Clean/Cleaned CGM data"

# read in file with trimester dates, admission dates, discharge dates
# trimester 3 will end at admission, PP will start at discharge
tri_dates <- read.csv("B:/Projects/Sarit Polsky/PICLS/Data cleaning/CGM Data Check.csv")
tri_dates$FirstTri <- as.Date(tri_dates$FirstTri,format = "%m/%d/%Y")
tri_dates$SecondTri <- as.Date(tri_dates$SecondTri,format = "%m/%d/%Y")
tri_dates$ThirdTri <- as.Date(tri_dates$ThirdTri,format = "%m/%d/%Y")
tri_dates$Delivery.Date <- as.Date(tri_dates$Delivery.Date,format = "%m/%d/%Y")

# read in labor admission dates
labor_dates <- read_xlsx("B:/Projects/Sarit Polsky/PICLS/Data cleaning/L&D Admission Dates for PICLS.xlsx")
labor_dates$pid <- labor_dates$`Study ID`
labor_dates$`Study ID` <- NULL
labor_dates <- labor_dates %>% filter(!is.na(pid))
dates <- merge(tri_dates,labor_dates,by="pid",all.x = T,all.y = T)
dates$subjectid <- dates$pid
dates$pid <- NULL

# get date of visit 15 for restarting PP data
ppdates <- read.csv("B:/Projects/Sarit Polsky/PICLS/Data cleaning/Data files/PICLSStudyHCLVsSAPTI-V15Dates_DATA_2022-11-07_2228.csv")
ppdates <- ppdates %>% filter(redcap_repeat_instrument=="pregnancy_visits")
ppdates$subjectid <- ppdates$pid
ppdates$pid <- NULL
ppdates <- ppdates %>% select(date_preg,subjectid)
colnames(ppdates) <- c("v15date","subjectid")

# combine all the data files into 1
d <- getwd()
files <-list.files(d, full.names = T)
alldata <- NULL
# try f=10,11,12
for (f in 1:length(files)) {
  print(files[f])
  df <- read.csv(files[f], na.strings = "", header = F)
  df <- df[8:nrow(df),]
  df <- as.data.frame(cbind(df[,2],df[,3],df[,5]))
  names(df) <- c("date","time","sensorglucose")
  df$dt <- paste(df$date,df$time)
  df$timestamp <- strptime(df$dt, format = "%Y/%m/%d %H:%M:%S")
  # get subject ID from file name
  df$subjectid <- str_sub(basename(files[f]),1,4)
  df <- df %>% select(subjectid,timestamp,sensorglucose)
  alldata <- rbind(alldata,df)
  # all the data are combined, now need to merge in trimester dates by subject ID 
  # then output records based on dates into separate files in cleaned directory
}
alldata <- alldata %>% filter(!is.na(sensorglucose))
#alldata <- alldata %>% filter(!is.na(sensorglucose) & !is.na(timestamp))
alldata2 <- merge(alldata,dates,by="subjectid",all.x = T, all.y = F)
alldata2 <- merge(alldata2,ppdates,by="subjectid",all.x = T, all.y = F)


t1data <- alldata2 %>% filter(as.Date(timestamp)>=FirstTri & as.Date(timestamp)<SecondTri)
t2data <- alldata2 %>% filter(as.Date(timestamp)>=SecondTri & as.Date(timestamp)<ThirdTri)
t3data <- alldata2 %>% filter(as.Date(timestamp)>=ThirdTri & as.Date(timestamp)<as.Date(`L&D Admission Date`))
ppdata <- alldata2 %>% filter(as.Date(timestamp)>=as.Date(`L&D Admission Date`) & as.Date(timestamp)<v15date)


t2data <- alldata[alldata$timestamp>=alldata$SecondTri & alldata$timestamp<alldata$ThirdTri,]
t3data <- alldata[alldata$timestamp>=alldata$ThirdTri & alldata$timestamp<alldata$`L&D Admission Date`,]
ppdata <- alldata[alldata$timestamp>=alldata$v15date,]

