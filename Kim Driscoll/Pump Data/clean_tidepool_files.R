library(tidyverse)
library(readxl)
library(tools)
# Original files
indir = "/Users/timvigers/Dropbox/Work/Tidepool Test/raw"
outdir = "/Users/timvigers/Dropbox/Work/Tidepool Test/cleaned"
files = list.files(indir,full.names = T)
# Iterate through
for (f in files) {
  id = file_path_sans_ext(basename(f))
  # Read tab names
  tabs = excel_sheets(f)
  # BG checks
  smbg = suppressWarnings(read_excel(f,"SMBG"))
  smbg = smbg %>% select(`Local Time`,Value)
  colnames(smbg) = c("datetime","bg")
  smbg$bg = round(as.numeric(smbg$bg))
  smbg = as.data.frame(smbg)
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
  t$datetime = NULL
  # Get correct dates (full days only)
  t = t %>% arrange(Date,Time)
  # Write
  write.csv(t,file = paste0(outdir,"/",id,".csv"),row.names = F,na = "")
}
