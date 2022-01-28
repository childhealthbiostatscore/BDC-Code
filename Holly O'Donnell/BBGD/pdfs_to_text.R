library(pdftools)
library(tidyverse)
# Function
# Skip: argument must be numeric and refer to indices of files list
indir = "/Users/timvigers/Dropbox/Mac/Documents/PDFs"
pdf_cgm_data = function(indir,skip = NULL){
  # List files 
  files = list.files(indir,pattern = "*pdf",full.names = T)
  # Summary data frame
  pdf_summary = data.frame()
  # Iterate through files
  for (f in 1:length(files)) {
    # Skip if relevant
    if (f %in% skip){next}
    # Read PDF into list
    pdf = pdf_data(files[f])
    # First page
    # Page as a dataframe, sort by x and y values
    df = as.data.frame(pdf[[1]])
    df = df %>% arrange(x,y)
    # Get name
    name = paste(gsub('[[:punct:]]','',df$text[which(df$x == 46 & df$y ==3)]),
                 gsub('[[:punct:]]','',df$text[which(df$x == 85 & df$y ==3)]))
    # Average and readings
    avg_bg = as.numeric(df$text[which(df$x == 107 & df$y == 186)])
    readings = as.numeric(df$text[which(df$x == 107 & df$y == 206)])
    # Insulin and diet
    basal = as.numeric(df$text[which(df$x == 374 & df$y == 116)])
    # Add to summary df
    pdf_summary[f,"first_name"] = strsplit(name," ")[[1]][1]
    pdf_summary[f,"last_name"] = strsplit(name," ")[[1]][2]
    pdf_summary[f,"average_bg"] = avg_bg
    pdf_summary[f,"readings_per_day"] = readings
  }
  return(pdf_summary)
}
