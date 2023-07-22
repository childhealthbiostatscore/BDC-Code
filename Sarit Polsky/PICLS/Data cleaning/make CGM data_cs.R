library(cgmanalysis)
library(parsedate)
library(cgmanalysis)
library(readxl)
library(dplyr)
library(stringr)
library(lubridate)
library(chron)
library(data.table)
# setup

setwd("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Final raw CGM files for analysis")
outdir <- "S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Clean/Cleaned CGM data"

# read in file with trimester dates, admission dates, discharge dates
# trimester 3 will end at admission, PP will start at discharge
tri_dates <- read.csv("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data cleaning/CGM Data Check_6.8.23.csv")
tri_dates$FirstTri <- as.Date(tri_dates$FirstTri,format = "%m/%d/%Y")
tri_dates$SecondTri <- as.Date(tri_dates$SecondTri,format = "%m/%d/%Y")
tri_dates$ThirdTri <- as.Date(tri_dates$ThirdTri,format = "%m/%d/%Y")
tri_dates$Delivery.Date <- as.Date(tri_dates$Delivery.Date,format = "%m/%d/%Y")
tri_dates$Run.in.Start <- as.Date(tri_dates$Run.in.Start, format = "%m/%d/%Y")
tri_dates$Run.in.End <- as.Date(tri_dates$Run.in.End, format = "%m/%d/%Y")

# read in labor admission dates
labor_dates <- read_xlsx("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data cleaning/L&D Admission Dates for PICLS.xlsx")
labor_dates$pid <- labor_dates$`Study ID`
labor_dates$`Study ID` <- NULL
labor_dates <- labor_dates %>% filter(!is.na(pid))
dates <- merge(tri_dates,labor_dates,by="pid",all.x = T,all.y = T)
dates$subjectid <- dates$pid
dates$pid <- NULL

# get date of visit 15 for restarting PP data
ppdates <- read.csv("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data cleaning/Data files/PICLSStudyHCLVsSAPTI-V15Dates_DATA_2022-11-07_2228.csv")
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

# merge in acetaminophen data and delete any data within X hours of acetaminophen
acetaminophen <- read.csv("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Acetaminophen/PICLSStudyHCLVsSAPTI-Acetaminophen_DATA_2023-07-09_1639.csv",
                          na.strings = c("NA",""," "))
acetaminophen$subjectid <- acetaminophen$pid
acetaminophen <- acetaminophen %>% select(subjectid,acet_date,acet_time)

###################################
# casey workspace
############################

# not sure the most efficient way to delete the data during acetaminophen use
# make a wide dataset of acetaminophen and merge into alldata, then delete if between start and stop?
# some people have up to 75 instances
# also need to treat people with missing times different than those who listed specific times - if no time, delete the whole day

# looks like this will be out of 586,735 rows
test = alldata2$subjectid %in% unique(acetaminophen$subjectid)
sum(test);rm(test)


# make reference datetimes 
acetaminophen = acetaminophen %>% mutate(delete_whole_day = ifelse(is.na(acet_time),1,0),
                                    acet_dt1 = case_when(!is.na(acet_time) ~ ymd_hm(paste(acet_date, acet_time)),
                                                         TRUE ~ ymd_hm(paste(acet_date, "00:00"))) )
# if the time was missing delete the whole day, else 9 hours after
acetaminophen = acetaminophen %>% mutate(acet_dt2 = case_when(delete_whole_day == 1 ~ acet_dt1 + lubridate::days(1),
                                                    TRUE ~ acet_dt1 + lubridate::hours(8)))
# just need the intervals and subid
acetaminophen2 = acetaminophen %>% select(subjectid, acet_dt1, acet_dt2)


# row wise function solution
acet_check = function(x){
  if(x[1] %in% acetaminophen2$subjectid){
    b = acetaminophen2 %>% filter(subjectid == x[1]) %>% mutate(check = case_when(((ymd_hms(x[2]) >= acet_dt1) & (ymd_hms(x[2]) < acet_dt2)) ~ 1,
                                                                                TRUE ~ 0))
    if(sum(b$check) > 0){return(1)}else{return(0)}
  }else{return(0)}
}

# SANITY CHECKER
# test = alldata2 %>% filter(subjectid == "114A") %>% select(-X)
# test_include = apply(test, 1, acet_check)
# test = cbind(test,ti = test_include)
# test = test %>% select(timestamp, ti, include)
# test = test %>% filter(ti != include)

include = apply(alldata2,1,acet_check)
alldata2 = cbind(alldata2, include = include)
sum(include) # 15606 

# write.csv(alldata2, file = "S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/acetincludedata.csv")
# ill be using thtis file, as it took ages to run
# alldata2 <- read.csv("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/acetincludedata.csv", sep=";")
# alldata2 = alldata2 %>% filter(subjectid == "114A") %>% select(-X)
#####################################

# acetaminophen_notime <- acetaminophen %>% filter(is.na(acet_time))
# acetaminophen_notime$delete <- 1
# alldata2$acet_date <- as.Date(alldata2$timestamp)
# alldata2 <- merge(alldata2,acetaminophen_notime,by=c("subjectid","acet_date"),all.x = T, all.y = T)
# alldata2 <- alldata2 %>% filter(is.na(delete))
# alldata2$acet_date <- NULL
# alldata2$acet_time <- NULL
# alldata2$delete <- NULL
# # now acetaminophen records with time
# acetaminophen_time <- acetaminophen %>% filter(!is.na(acet_time))
# acetaminophen_time$acet_date <- as.Date(acetaminophen_time$acet_date)
# # reformat start time of acetaminophen
# # THIS IS NOT PASTING PROPERLY
# acetaminophen_time$acet_date_time <- as.POSIXct(paste(acetaminophen_time$acet_date,acetaminophen_time$acet_time), format="%Y-%m-%d %H:%M:%S")
# # add stop time 8 hours later
# acetaminophen_time$stop_time <- acetaminophen_time$acet_time

#filter out the acet include == 1
alldata3 = alldata2 %>% filter(include == 0)

# divide by trimester/time period
t1data <- alldata3 %>% filter(as.Date(timestamp)>=Run.in.End & as.Date(timestamp)<SecondTri)
t1data$trimester <- "T1"
t2data <- alldata3 %>% filter(as.Date(timestamp)>=SecondTri & as.Date(timestamp)<ThirdTri)
t2data$trimester <- "T2"
t3data <- alldata3 %>% filter(as.Date(timestamp)>=ThirdTri & as.Date(timestamp)<as.Date(`L&D Admission Date`))
t3data$trimester <- "T3"
ppdata <- alldata2 %>% filter(as.Date(timestamp)>=v15date)
ppdata$trimester <- "Post-partum"
runindata <- alldata3 %>% filter(as.Date(timestamp)>=Run.in.Start & as.Date(timestamp)<Run.in.End)
runindata$trimester <- "Run-in"

# now I just need to split the trimester files by ID
split1 <- split(t1data,t1data$subjectid)
for (df in split1) {
  df <- as.data.frame(df)
  df <- df[,c("subjectid","timestamp","sensorglucose")]
  df <- df[order(df$timestamp),]
  filename <- paste0("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files CS/",df$subjectid[1],"_T1.csv")
  write.csv(df,file = filename,row.names = F)
}

split2 <- split(t2data,t2data$subjectid)
for (df in split2) {
  df <- as.data.frame(df)
  df <- df[,c("subjectid","timestamp","sensorglucose")]
  df <- df[order(df$timestamp),]
  filename <- paste0("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files CS/",df$subjectid[1],"_T2.csv")
  write.csv(df,file = filename,row.names = F)
}

split3 <- split(t3data,t3data$subjectid)
for (df in split3) {
  df <- as.data.frame(df)
  df <- df[,c("subjectid","timestamp","sensorglucose")]
  df <- df[order(df$timestamp),]
  filename <- paste0("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files CS/",df$subjectid[3],"_T3.csv")
  write.csv(df,file = filename,row.names = F)
}

splitpp <- split(ppdata,ppdata$subjectid)
for (df in splitpp) {
  df <- as.data.frame(df)
  df <- df[,c("subjectid","timestamp","sensorglucose")]
  df <- df[order(df$timestamp),]
  filename <- paste0("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files CS/",df$subjectid[1],"_PP.csv")
  write.csv(df,file = filename,row.names = F)
}

splitrunin <- split(runindata,runindata$subjectid)
for (df in splitrunin) {
  df <- as.data.frame(df)
  df <- df[,c("subjectid","timestamp","sensorglucose")]
  df <- df[order(df$timestamp),]
  filename <- paste0("S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files CS/",df$subjectid[1],"_Runin.csv")
  write.csv(df,file = filename,row.names = F)
}

# then run cgmvariables()
cgmvariables(inputdirectory = "S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/Cleaned CGM files CS/", 
             outputdirectory = "S:/Laura/BDC/Projects/Sarit Polsky/PICLS/Data_Raw/", 
             outputname = "cleanedcgm_noacet",
             id_filename = T, printname = T,
             customintervals = list(c(0,54),c(0,63),c(63,140),c(140,600),c(0,69)))

# does not appear to be counting excursions correctly, probably because of all the gaps
# when I finalize the dataset, should exclude these variables