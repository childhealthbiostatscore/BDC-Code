library(pdftools)
library(tidyverse)
# List files
indir <- "/Users/timvigers/Desktop/670G_PDFs"
files <- list.files(indir,pattern = "*pdf",full.names = T)
# Summary dataframe
pdf_summary <- data.frame()
# Iterate through files
for (f in 1:length(files)) {
  # Read PDF into list
  pdf <- pdf_data(files[f])
  # Page 1 as a dataframe, sort by x and y values
  df <- as.data.frame(pdf[[1]])
  df <- df %>% arrange(x,y)
  # Get statistics
  percs <- sub("%","",df[which(df$x == 618),"text"])
  exits <- df[which(df$x == 356),"text"]
  # Check type of PDF for average and sd
  if ("Low" %in% df[which(df$x == 462),"text"] &
      "/" %in% df[which(df$x == 478),"text"] &
      "High" %in% df[which(df$x == 482),"text"]) {
    avg <- df[which(df$x == 609),"text"]
    sd <- df[which(df$x == 631),"text"]
  } else {
    avg <- df[which(df$x == 609 & df$y == 393),"text"]
    sd <- df[which(df$x == 631 & df$y == 393),"text"]
  }
  # Add to summary df
  pdf_summary[f,"file"] <- basename(files[f])
  pdf_summary[f,"am_use"] <- percs[1]
  pdf_summary[f,"manual"] <- percs[2]
  pdf_summary[f,"sensor_wear"] <- percs[3]
  pdf_summary[f,"avg_sensor"] <- avg
  pdf_summary[f,"sd_sensor"] <- sd
  pdf_summary[f,c("no_calib_exit","high_sg_exit","max_deliv_exit",
                  "min_deliv_exit","bg_req_exit","algorithm_underread_exit",
                  "sensor_updating_exit","no_sg_exit","expired_exit",
                  "user_disabled_exit","alarms_exit","suspend_exit",
                  "warm_up_exit","other_exit")] <- exits
  # Convert to numeric
  pdf_summary[,2:ncol(pdf_summary)] <- 
    lapply(pdf_summary[,2:ncol(pdf_summary)],as.numeric)
}
# Write summary
write.csv(pdf_summary,file = "/Users/timvigers/Desktop/670G_PDFs/summary.csv",
          row.names = F)