library(pdftools)
library(tidyverse)
# Function
pdf_cgm_data = function(indir){
  # List files 
  files = list.files(indir,pattern = "*pdf",full.names = T)
  # Summary data frame
  pdf_summary = data.frame()
  # Iterate through files
  for (f in 1:length(files)) {
    # Read PDF into list
    pdf = pdf_data(files[f])
    # Find correct page
    page = NULL
    for (p in 1:min(2,length(pdf))) {
      if (dim(pdf[[p]])[1] %in% 240:365) {page = p}
    }
    if (is.null(page)){next}
    # Page as a dataframe, sort by x and y values
    df = as.data.frame(pdf[[page]])
    df = df %>% arrange(x,y)
    # Get name
    name = paste(gsub('[[:punct:]]','',df$text[which(df$x > 300 & df$y ==35)]),
                 gsub('[[:punct:]]','',df$text[which(df$x == 289 & df$y ==35)]))
    name = tolower(name)
    # Dates
    dates = df[which(df$y == 51),"text"]
    start = lubridate::mdy(dates[1])
    end = lubridate::mdy(dates[3])
    days = as.numeric(difftime(end,start))
    # BG checks per day
    ys = df$y[which(df$text=="Calibration")]
    y = ys[which(ys %in% df$y[which(df$text=="(per")])]
    bg = df[which(df$y == y & df$x > 600),"text"]
    bg = suppressWarnings(as.numeric(bg))
    bg = bg[which(!is.na(bg))[1]]
    # Get statistics - x column changes depending on length of text
    percs = df[which((df$y == 349 | df$y == 364 | df$y == 378) & df$x > 200),"text"]
    gperc = grep("%",percs)
    percs = percs[gperc]
    ys = df$y[which((df$y == 349 | df$y == 364 | df$y == 378) & df$x > 200)]
    ys = ys[gperc]
    percs = percs[1:3]
    percs = percs[order(ys[1:3])]
    # Remove % symbol
    percs = as.numeric(gsub("%","",percs))
    # Get reasons for AM exits
    exits = df[which(df$x == 356 & df$y > 100),"text"]
    ys = df[which(df$x == 356 & df$y > 100),"y"]
    if (length(exits) < 1) {
      exits = df[which(df$x == 342 & df$y > 100),"text"]
      ys = df[which(df$x == 342 & df$y > 100),"y"]
    }
    if (length(exits) < 10) {
      exits = df[which(df$x == 342 & df$y > 100),"text"]
      ys = df[which(df$x == 342 & df$y > 100),"y"]
    }
    if (length(exits) < 14) {
      exits = c(exits,df[which(df$x == 354 & df$y > 100),"text"])
      ys = c(ys,df[which(df$x == 354 & df$y > 100),"y"])
    }
    if (length(exits) < 14) {
      exits = c(exits,df[which(df$x == 339 & df$y > 100),"text"])
      ys = c(ys,df[which(df$x == 339 & df$y > 100),"y"])
    }
    if (length(exits) < 14) {stop("Something is wrong with the exits.")}
    # Order exits
    exits = exits[order(ys)]
    # Average and SD
    avg_sd = df[which(df$x > 500 & df$y == 393),"text"]
    avg_sd = suppressWarnings(as.numeric(avg_sd))
    avg_sd = avg_sd[!is.na(avg_sd)]
    if (length(avg_sd) == 0){
      avg = NA
      sd = NA
    }
    avg = avg_sd[1]
    sd= avg_sd[2]
    # Time in range
    tirs = df[which((df$y %in% c(300:530)) & (df$x %in% c(41:46))),"text"]
    if(length(tirs)==0){next}
    ys = df[which((df$y %in% c(300:530)) & (df$x %in% c(41:46))),"y"]
    tirs = tirs[order(ys,decreasing = T)]
    tirs = as.numeric(gsub("%","",tirs))
    tir_ind = which.max(tirs)
    tir_70 = sum(tirs[1:(tir_ind-1)])
    if(tir_ind == 1){tir_70 = NA}
    tir_70_180 = tirs[tir_ind]
    tir_180 = sum(tirs[(tir_ind+1):length(tirs)])
    tir_250 = tirs[(tir_ind+2)]
    # Insulin and meal info
    daily_dose = df[which(df$y == unique(df$y[which(df$text == "units")]) & df$x > 620)[1],"text"]
    bolus = df[which(df$y > 455 & df$x > 630),"text"]
    bolus = as.numeric(gsub('[[:punct:]]','',bolus[grep("%",bolus)[1]]))
    basal = 100 - bolus
    meals = df[which(df$y == df$y[grep("Meal",df$text)] & df$x > 640)[1],"text"]
    # Add to summary df
    pdf_summary[f,"first_name"] = strsplit(name," ")[[1]][1]
    pdf_summary[f,"last_name"] = strsplit(name," ")[[1]][2]
    pdf_summary[f,"timepoint"] = 
      paste0("M",sub(".*month","",basename(tools::file_path_sans_ext(files[f]))))
    pdf_summary[f,"cgm_start"] = start
    pdf_summary[f,"days_worn"] = days + 1
    pdf_summary[f,"bg_checks"] = bg
    pdf_summary[f,"am_use"] = percs[1]
    pdf_summary[f,"manual"] = percs[2]
    pdf_summary[f,"sensor_wear"] = percs[3]
    pdf_summary[f,"avg_sensor"] = avg
    pdf_summary[f,"sd_sensor"] = sd
    pdf_summary[f,c("no_calib_exit","high_sg_exit","max_deliv_exit",
                    "min_deliv_exit","bg_req_exit","algorithm_underread_exit",
                    "sensor_updating_exit","no_sg_exit","expired_exit",
                    "user_disabled_exit","alarms_exit","suspend_exit",
                    "warm_up_exit","other_exit")] = exits
    pdf_summary[f,"tir_under_70"] = tir_70
    pdf_summary[f,"tir_70_180"] = tir_70_180
    pdf_summary[f,"tir_over_180"] = tir_180
    pdf_summary[f,"tir_over_250"] = tir_250
    pdf_summary[f,"daily_dose"] = daily_dose
    pdf_summary[f,"bolus_perc"] = bolus
    pdf_summary[f,"basal_perc"] = basal
    pdf_summary[f,"meals_per_day"] = meals
    # Convert to numeric    
    pdf_summary[,5:ncol(pdf_summary)] = 
      suppressWarnings(lapply(pdf_summary[,5:ncol(pdf_summary)],as.numeric))
  }
  # Remove rows with all NAs
  pdf_summary = pdf_summary[rowSums(is.na(pdf_summary)) != ncol(pdf_summary),]
  return(pdf_summary)
}
# Write summaries
pdf_summary = pdf_cgm_data("/Users/timvigers/ClinicVisit_PDFs")
write.csv(pdf_summary,file = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Cari Berget/670G Combined/Data_Cleaned/pdf_summary.csv",
          row.names = F,na = "")

pdf_summary = pdf_cgm_data("Z:/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Cari Berget/670G Combined/Data_Raw/670G adult files_1")
write.csv(pdf_summary,file = "Z:/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Cari Berget/670G Combined/Data_Cleaned/pdf_summary_additional_1.csv",
          row.names = F,na = "")

pdf_summary = pdf_cgm_data("Z:/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Cari Berget/670G Combined/Data_Raw/670G adult files_2")
write.csv(pdf_summary,file = "Z:/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Cari Berget/670G Combined/Data_Cleaned/pdf_summary_additional_2.csv",
          row.names = F,na = "")

# Check glycemic ranges
check_cgm_ranges = function(indir){
  # List files 
  files = list.files(indir,pattern = "*pdf",full.names = T)
  # Summary data frame
  pdf_summary = data.frame()
  # Iterate through files
  for (f in 1:length(files)) {
    # Read PDF into list
    pdf = pdf_data(files[f])
    # Find correct page
    page = NULL
    for (p in 1:min(2,length(pdf))) {
      if (dim(pdf[[p]])[1] %in% 240:365) {page = p}
    }
    if (is.null(page)){next}
    # Page as a dataframe, sort by x and y values
    df = as.data.frame(pdf[[page]])
    df = df %>% arrange(x,y)
    # Get name
    name = paste(gsub('[[:punct:]]','',df$text[which(df$x > 300 & df$y ==35)]),
                 gsub('[[:punct:]]','',df$text[which(df$x == 289 & df$y ==35)]))
    name = tolower(name)
    # Ranges
    y = max(df$y[which(df$text == "mg/dL")])
    ranges = df[which(df$y == y),"text"]
    ranges = suppressWarnings(as.numeric(ranges))
    ranges = ranges[!is.na(ranges)]
    # Add to summary df
    pdf_summary[f,"first_name"] = strsplit(name," ")[[1]][1]
    pdf_summary[f,"last_name"] = strsplit(name," ")[[1]][2]
    pdf_summary[,3:(2+length(ranges))] = ranges
  }
  # Remove rows with all NAs
  pdf_summary = pdf_summary[rowSums(is.na(pdf_summary)) != ncol(pdf_summary),]
  return(pdf_summary)
}

check_kaan = check_cgm_ranges("/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Cari Berget/670G Combined/Data_Raw/ClinicVisit_PDFs")
