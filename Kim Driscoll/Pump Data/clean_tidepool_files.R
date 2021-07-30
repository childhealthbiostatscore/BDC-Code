library(tidyverse)
library(readxl)
library(tools)
# Original files
indir = "/Users/timvigers/Documents/Work/Tidepool Test/raw"
outdir = "/Users/timvigers/Documents/Work/Tidepool Test/cleaned"
files = list.files(indir,full.names = T)
# Iterate through
for (f in files) {
  id = file_path_sans_ext(basename(f))
  if (file_ext(f) == "csv"){
    df = read.csv(f,stringsAsFactors = F,na.strings = "")
    if (ncol(df) > 25){
      start = which(df[,3]=='Pump')
      colnames(df) = df[start+1,]
      df = df[-c(0:start+1),]
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
  # Write
  write.csv(t[,vars],file = paste0(outdir,"/",id,".csv"),row.names = F,na = "")
}
