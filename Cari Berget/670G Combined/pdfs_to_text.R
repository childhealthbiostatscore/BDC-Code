library(pdftools)
library(tidyverse)
# List files
dir = "/home/tim/Desktop/combined670g/Data_Raw/ClinicVisit_PDFs"
files = list.files(dir,pattern = "*pdf",full.names = T)
# Summary dataframe
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
  # Page as a dataframe, sort by x and y values
  df = as.data.frame(pdf[[page]])
  df = df %>% arrange(x,y)
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
  # Add to summary df
  pdf_summary[f,"file"] = basename(files[f])
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
  # Convert to numeric    
  pdf_summary[,2:ncol(pdf_summary)] = 
    lapply(pdf_summary[,2:ncol(pdf_summary)],as.numeric)
}
# Write summary
write.csv(pdf_summary,file = "/home/tim/Desktop/combined670g/Data_Cleaned/pdf_summary.csv",
          row.names = F,na = "")