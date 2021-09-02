library(tidyverse)
library(readxl)
library(tools)
library(lubridate)
# Original files
indir = "C:/Users/Tim Vigers/Desktop/T1 Device Data"
outdir = "C:/Users/Tim Vigers/Desktop/T1 Device Data Cleaned"
files = list.files(indir,full.names = T,recursive = T)
dates = read_excel("C:/Users/Tim Vigers/Desktop/T1Visit Dates.xlsx")
dates$id = sub("HRTM_","",dates$record_id)
# Iterate through
for (f in files) {
  if (!(file_ext(f) %in% c("csv","xls","xlsx"))){next}
  file_id = file_path_sans_ext(basename(f))
  print(file_id)
  if (file_ext(f) == "csv"){
    df = read.csv(f,stringsAsFactors = F,na.strings = "")
    if (ncol(df) > 25){
      start = which(df[,3]=='Pump')
      colnames(df) = df[start+1,]
      df = df[-c(0:start+1),]
      # Remove micro boluses
      micro = which(df$`Bolus Source` == "CLOSED_LOOP_MICRO_BOLUS")
      if (length(micro)>0){
        df = df[-c(micro),]
      }
      df$datetime = lubridate::mdy_hms(paste(df$Date,df$Time))
      t = df %>% arrange(datetime)
    } else if (ncol(df) == 2){
      start = which(df[,1]=='Time')
      colnames(df) = df[start,]
      df = df[-c(0:start),]
      df$Date = sapply(strsplit(df$Time," "),"[[",1)
      df$Time = sub(".* ","",df$Time)
      t = df %>% rename(bg = `mg/dl`)
    }
  } else {
    # Read tab names
    tabs = excel_sheets(f)
    if ("Insulin use and carbs" %in% tabs) {
      t = suppressWarnings(read_excel(f,"Insulin use and carbs"))
      t = t %>% rename(`Bolus Volume Delivered (U)` = `Bolus Volume (U)`,
                       `BWZ Carb Input (grams)` = `Carbs(g)`)
      smbg = suppressWarnings(read_excel(f,"Name and glucose"))
      start = which(smbg[,1]=="Time")
      colnames(smbg) = smbg[start,]
      smbg = smbg[-c(0:start+1),]
      colnames(smbg)[tolower(colnames(smbg)) == "mg/dl"] = 'bg'
      if (nrow(t) > 0) {
        t = full_join(t,smbg[,c("Time","bg")],by = "Time")
      } else {
        t = smbg
      }
      t$Date = sapply(strsplit(t$Time," "),"[[",1)
      t$Time = sub(".* ","",t$Time)
    } else {
      # BG checks
      if ("SMBG" %in% tabs) {
        smbg = suppressWarnings(read_excel(f,"SMBG"))
        smbg = smbg %>% select(`Local Time`,Value)
        colnames(smbg) = c("datetime","bg")
        smbg$bg = round(as.numeric(smbg$bg))
        smbg = as.data.frame(smbg)
      } else {
        smbg = matrix(nrow = 1,ncol = 2)
      }
      # Boluses
      if (any(grepl("bolus",tolower(tabs)))){
        bolus = suppressWarnings(read_excel(f,"Bolus"))
        if ("Extended" %in% colnames(bolus)){
          bolus = bolus %>% select(`Local Time`,`Sub Type`,Extended,Normal)
          bolus$Normal[!is.na(bolus$Extended)] = bolus$Normal[!is.na(bolus$Extended)] +
            bolus$Extended[!is.na(bolus$Extended)]
          bolus$Extended = NULL
        } else {
          bolus = bolus %>% select(`Local Time`,`Sub Type`,Normal)
        }
      } else {
        bolus = matrix(nrow = 1,ncol = 3)
      }
      colnames(bolus) = c("datetime","Bolus Type","Bolus Volume Delivered (U)")
      bolus = as.data.frame(bolus)
      # Carbs and bolus recommendation if available
      if ("Bolus Calculator" %in% tabs) {
        carbs = suppressWarnings(read_excel(f,"Bolus Calculator"))
        carbs = carbs %>% select(`Local Time`,`Carb Input`,`Recommended Net`)
      } else {
        carbs = matrix(nrow = 1,ncol = 3)
      }
      colnames(carbs) = c("datetime","BWZ Carb Input (grams)","BWZ Estimate (U)")
      carbs = as.data.frame(carbs)
      # Merge
      t = full_join(smbg,bolus,by = "datetime")
      t = full_join(t,carbs,by = "datetime")
      t$Date = lubridate::date(t$datetime)
      t$Time = sub(".* ","",t$datetime)
      t = t %>% arrange(datetime)
    }
  }
  vars = c("Date","Time","bg","BG Reading (mg/dL)","Sensor Calibration BG (mg/dL)",
           "BWZ Carb Input (grams)","BWZ Estimate (U)",
           "Bolus Volume Delivered (U)","Bolus Type")
  missing = vars[which(!(vars %in% colnames(t)))]
  t[,missing] = NA
  t$Date = parse_date_time(t$Date,orders = c("mdy","ymd"))
  # Get dates
  id = strsplit(file_id,"_")[[1]][2]
  completed = dates$V1_Completed[match(id,dates$id)]
  start = min(t$Date,na.rm = T)+60*60*24
  t = t[t$Date >= start & t$Date < completed,]
  # Write
  write.csv(t[,vars],file = paste0(outdir,"/",file_id,".csv"),row.names = F,na = "")
}
