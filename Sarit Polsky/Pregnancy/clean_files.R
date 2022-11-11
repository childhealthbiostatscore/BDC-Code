library(parsedate)
library(cgmanalysis)
library(readxl)
library(dplyr)
setwd("/Volumes/som/BDC/SHARED/POLSKY/Triple C/Tim/Rerun")
# Output location
outdir <- paste0(getwd(), "/", "Data_Cleaned/")
# Import dates - remove spaces and characters from names
dates <- read_excel("./Data_Raw/Trimesters_Corrected_Final.xlsx")
dates$`Last name` <- tolower(gsub(" ", "", dates$`Last name`))
dates$`Last name` <- tolower(gsub("[[:punct:]]", "", dates$`Last name`))
dates$`First name` <- tolower(gsub(" ", "", dates$`First name`))
dates$`First name` <- tolower(gsub("[[:punct:]]", "", dates$`First name`))
# List all the directories
dirs <- list.dirs("Data_Raw")
# Loop through directories
for (d in dirs[2:length(dirs)]) {
  # Get name - lowercase and remove special characters
  name <- tolower(sub("_.*", "", basename(d)))
  name <- gsub(" ", "", name)
  last_name <- gsub("[[:punct:]]", "", strsplit(name, ",")[[1]][1])
  first_name <- gsub("[[:punct:]]", "", strsplit(name, ",")[[1]][2])
  # Get dates and MRN
  r <- which(dates$`Last name` == last_name & dates$`First name` == first_name)
  t0 <- dates$`t=0`[r]
  wk14 <- dates$`14 wks`[r]
  wk28 <- dates$`28 wks`[r]
  dd <- dates$Delivery[r]
  id <- dates$MRN[r]
  # List files
  files <- list.files(d, full.names = T)
  # Loop through files, combine into 1
  l <- lapply(files, function(f) {
    print(f)
    df <- read.csv(f, na.strings = "", header = F)
    # Check file type by number of columns
    if (ncol(df) == 14) {
      colnames(df) <- df[1, ]
      df <- df[-1, ]
      df <- df[, grep("timestamp|glucose value", tolower(colnames(df)))]
      colnames(df) <- c("timestamp", "sensorglucose")
      df$timestamp <- sub("T", " ", df$timestamp)
      df$timestamp <- parse_date(df$timestamp, approx = F)
    } else if (ncol(df) >= 48) {
      sensor <- which(df$V3 == "Sensor")
      colnames(df) <- df[sensor[1] + 1, ]
      df <- df[(sensor[1] + 2):nrow(df), ]
      df$timestamp <- parse_date(paste(df$Date, df$Time), approx = F)
      df <- df[, grep("timestamp|sensor glucose", tolower(colnames(df)))]
      colnames(df)[1] <- "sensorglucose"
    } else if (ncol(df) == 19) {
      colnames(df) <- df[3, ]
      df <- df[4:nrow(df), ]
      df <- df[, grep("timestamp|historic glucose", tolower(colnames(df)))]
      colnames(df) <- c("timestamp", "sensorglucose")
      df$timestamp <- parse_date(df$timestamp, approx = F)
    } else if (ncol(df) == 13) {
      colnames(df) <- df[1, ]
      df <- df[2:nrow(df), ]
      df <- df[, grep("datetime|glucoseinternaltime|glucosevalue", tolower(colnames(df)))]
      colnames(df) <- c("timestamp", "sensorglucose")
      df$timestamp <- sub("T", " ", df$timestamp)
      df$timestamp <- parse_date(df$timestamp, approx = F)
    }
    return(df)
  })
  # Bind
  df <- do.call(rbind, l)
  # remove duplicates
  df <- df[!duplicated(df), ]
  df <- df[!is.na(df$timestamp), ]
  # ID
  df$subjectid <- NA
  df <- df[, c("subjectid", "timestamp", "sensorglucose")]
  # Sort by date
  df <- df[order(df$timestamp), ]
  # Split and write CSVs
  t0_wk14 <- df[df$timestamp >= t0 & df$timestamp < wk14, ]
  if (nrow(t0_wk14) > 0 & sum(is.na(t0_wk14$sensorglucose)) < nrow(t0_wk14)) {
    t0_wk14$subjectid[1] <- id
    write.csv(t0_wk14,
      file = paste0(outdir, id, "_t0_wk14.csv"),
      row.names = F, na = ""
    )
  }

  wk14_wk28 <- df[df$timestamp >= wk14 & df$timestamp < wk28, ]
  if (nrow(wk14_wk28) > 0 & sum(is.na(wk14_wk28$sensorglucose)) < nrow(wk14_wk28)) {
    wk14_wk28$subjectid[1] <- id
    write.csv(wk14_wk28,
      file = paste0(outdir, id, "_wk14_wk28.csv"),
      row.names = F, na = ""
    )
  }

  wk28_dd <- df[df$timestamp >= wk28 & df$timestamp < dd, ]
  if (nrow(wk28_dd) > 0 & sum(is.na(wk28_dd$sensorglucose)) < nrow(wk28_dd)) {
    wk28_dd$subjectid[1] <- id
    write.csv(wk28_dd,
      file = paste0(outdir, id, "_wk28_dd.csv"),
      row.names = F, na = ""
    )
  }
  # Set to missing for next loop
  t0 <- NA
  wk14 <- NA
  wk28 <- NA
  dd <- NA
}
# Variables
out <- paste0("polsky_triple_c_cgm_", Sys.Date())
cgmvariables(outdir, "./Reports", id_filename = T, outputname = out)
# Split id column for Janet
cgm <- read.csv(paste0("./Reports/", out, ".csv"))
cgm$timepoint <- sub("\\d*_", "", cgm$subject_id)
cgm$subject_id <- sub("_.*", "", cgm$subject_id)
cgm <- cgm %>% select(
  subject_id, timepoint, everything(),
  -any_of(c("percent_cgm_wear", "num_days"))
)
write.csv(cgm, paste0("./Reports/", out, ".csv"), row.names = F)
