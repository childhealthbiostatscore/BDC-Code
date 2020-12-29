library(tidyverse)
setwd("/Users/timvigers/Work/bbgd")
# Function to pivot longer
make_long = function(data,out_file = "./long_data.csv"){
  # Convert all columns to character for easier combination
  data = data %>% mutate_all(as.character)
  # Get time dependent variables
  vars = colnames(data)
  vars = colnames(data)[grep(".*_t[0-9]",substr(vars, nchar(vars)-3+1, nchar(vars)))]
  unique_vars = unique(substr(vars,1,nchar(vars)-3))
  # For each variable, add empty columns for missing times
  all_vars <- expand_grid(time = paste0("t", 1:8), value = unique_vars) %>% 
    unite("vars",value,time)
  vars = all_vars$vars
  missing_vars <- setdiff(vars, names(data))
  data[missing_vars] <- NA
  # Pivot longer
  long <- data %>% 
    pivot_longer(all_of(vars),
                 names_to = c(".value","timepoint"),
                 names_pattern = "(.*)_(.*)",
                 values_drop_na = T)
  # Write CSV
  write.csv(long,file = out_file,
            row.names = F,na = '')
}
# Read in files
child = read.csv("./BringBGDownChild_DATA.csv",na.strings = "")
parent = read.csv("./BringBGDownParent_HORIZONTAL.csv",na.strings = "")
# Apply function
make_long(child,"./long_child_data.csv")
make_long(parent,"./long_parent_data.csv")
