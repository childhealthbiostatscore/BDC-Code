# Working directory
setwd("~/Documents")
dir.create("./Data_Cleaned/cgm",showWarnings = F)
# Set days 
days <- c(7,14,30,60,90)
# Set output directory
outdir <- "./Data_Cleaned/cgm"
# Iterate through CGM data, format, and name
files <- list.files("./Data_Raw/Patient 90 days",full.names = T)
ids = vector()
length(ids) = length(files)
for (f in 1:length(files)) {
  ext <- tools::file_ext(files[f])
  if(grepl("xls",ext)){
    dat <- readxl::read_excel(files[f],col_types = "text")
    dat <- as.data.frame(dat)
  } else if (ext == "csv"){
    dat <- read.csv(files[f],na.strings = "")
  }
  name <- sub(" *\\ ","",tolower(paste0(dat[1,5],dat[2,5])))
  name <- gsub("[[:digit:]]","",name)
  name <- gsub(" ","",name)
  date <- 
    lubridate::mdy(subjects$MostRecentVisitDate[
      match(name,subjects$name)])
  if(is.na(date)){stop(paste("No date:",files[f]))}
  ids[f] = name
  # Format data
  calibration <- which(dat[,3]=="Calibration")
  if (length(calibration)>0){dat <- dat[-calibration,]}
  colnames(dat)[grep("glucose",tolower(colnames(dat)))] <- "sensorglucose"
  colnames(dat)[grep("timestamp",tolower(colnames(dat)))] <- "timestamp"
  dat$timestamp <- lubridate::ymd_hms(sub("T"," ",dat$timestamp))
  dat <- dat[-c(1:min(which(!is.na(dat$timestamp)))),]
  dat$subjectid <- name
  dat <- dat[,c("subjectid","timestamp","sensorglucose")]
  dat <- dat[-which(dat$sensorglucose=="Low"),]
  dat$sensorglucose <- suppressWarnings(as.numeric(dat$sensorglucose))
  
  for(d in days){
    dat_name <- paste0("day",d)
    # Create new dataframe
    dir <- paste0(outdir,"/day",d)
    assign(dat_name,dat[dat$timestamp <= date & 
                          dat$timestamp >= (date-d),])
    # Make new directory
    dir.create(dir,showWarnings = F)
    # Write
    if (nrow(get(dat_name)) > 0){
      write.csv(get(dat_name),paste0(dir,"/",name,dat_name,".csv"),
                na = "",row.names = F)
    }
  }
}
# GRI for each folder
l = lapply(days, function(d){
  files = list.files(paste0(outdir,"/",paste0("day",d)),full.names = T)
  gris = unlist(lapply(files, function(f){
    dat = read.csv(f)
    # Percent times
    vlow = mean(dat$sensorglucose < 54,na.rm = T)*100
    low = mean(dat$sensorglucose < 70,na.rm = T)*100
    high = mean(dat$sensorglucose > 180,na.rm = T)*100
    vhigh = mean(dat$sensorglucose > 250,na.rm = T)*100
    # GRI
    gri = (3.0 * vlow) + (2.4 * low) + (1.6 * vhigh) + (0.8 * high)
  }))
  df = data.frame(sub("day\\d.*","",basename(files)),gris)
  colnames(df) = c("id",paste0("day",d,"_gri"))
  return(df)
})
df = l %>% reduce(full_join,by = "id") %>% arrange(id)
write.csv(df,"./Data_Cleaned/gri.csv",row.names = F,na = "")
