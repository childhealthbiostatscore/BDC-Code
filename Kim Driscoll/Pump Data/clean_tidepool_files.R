library(tidyverse)
library(readxl)
library(tools)
# Original files
indir = "/Users/timvigers/T1 Device Data"
outdir = "/Users/timvigers/tidepool_test"
files = list.files(indir,full.names = T)
# T1 dates
t1 = read_excel("/Users/timvigers/T1Visit Dates.xlsx")
t1$V1_Completed = lubridate::ymd(t1$V1_Completed)
# Iterate through
for (f in files) {
  id = file_path_sans_ext(basename(f))
  # Check extension
  ext = file_ext(f)
  if(grepl("dexcom",tolower(f)) | grepl("clarity",tolower(f)) | ext == "pdf"){next}
  if(grepl("tidepool",tolower(f))){
    # Read tab names
    tabs = excel_sheets(f)
    # Boluses
    if (all(!grepl("bolus",tolower(tabs)))){next}
    bolus = read_excel(f,"Bolus")
    if ("Extended" %in% colnames(bolus)){
      bolus = bolus %>% select(`Local Time`,`Sub Type`,Extended,Normal)
      bolus$Normal[!is.na(bolus$Extended)] = bolus$Normal[!is.na(bolus$Extended)] +
        bolus$Extended[!is.na(bolus$Extended)]
      bolus$Extended = NULL
    } else {
      bolus = bolus %>% select(`Local Time`,`Sub Type`,Normal)
    }
    colnames(bolus) = c("datetime","Bolus Type","Bolus Volume Delivered (U)")
    bolus = as.data.frame(bolus)
    # BG checks
    smbg = read_excel(f,"SMBG")
    smbg = smbg %>% select(`Local Time`,Value)
    colnames(smbg) = c("datetime","bg")
    smbg = as.data.frame(smbg)
    # Carbs and bolus recommendation if available
    if ("Bolus Calculator" %in% tabs) {
      carbs = read_excel(f,"Bolus Calculator")
      carbs = carbs %>% select(`Local Time`,`Carb Input`,`Recommended Correction`)
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
    t$datetime = NULL
  } else if (grepl("diasend",tolower(f))){
    # Read tab names
    tabs = excel_sheets(f)
    if (all(!grepl("insulin",tolower(tabs)))){next}
    t = read_excel(f,"Insulin use and carbs")
    t = t %>% rename("BWZ Carb Input (grams)" = `Carbs(g)`, "Bolus Volume Delivered (U)" = `Bolus Volume (U)`)
    t$bg = NA
    t$Time = lubridate::mdy_hm(t$Time)
    t$Date = lubridate::date(t$Time)
    t$Time = sub(".* ","",t$Time)
    t$datetime = NULL
    t$`BWZ Estimate (U)` = NA
  } else if (grepl("medtronic",tolower(f)) | grepl("carelink",tolower(f))){
    t <- read.csv(f,stringsAsFactors = F,na="",check.names = F)
    end <- which(t[,3] == "Sensor")
    if (length(end )> 0) {
      t <- t[-c((end-1):nrow(t)),]
    }
    start <- which(t[,1] == "Index")
    if (length(start) > 0) {
      colnames(t) <- t[start[1],]
      t <- t[-c(1:(start[1]+2)),]
    }
    t$Date = lubridate::mdy(t$Date)
  }
  # Get correct dates
  date = t1$V1_Completed[match(strsplit(id,"_")[[1]][2],sub(".*_","",t1$record_id))]
  t = t[t$Date <= date & t$Date >= (date - 89),]
  # Write
  write.csv(t,file = paste0(outdir,"/",id,".csv"),row.names = F,na = "")
}
