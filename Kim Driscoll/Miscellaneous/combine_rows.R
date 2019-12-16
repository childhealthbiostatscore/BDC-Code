library(dplyr)
df <- read.csv("/Users/timvigers/Desktop/demographics.csv",na.strings = "")
# Combine first and na.omit in one function
get_first <- function(x) {
  first(na.omit(x))
}
# Get first row with value not NA
temp <- df %>% group_by(record_id) %>%
  mutate_at(vars(-group_cols()),get_first) %>%
  slice(1)
# Write CSV
write.csv(temp,file = "/Users/timvigers/Desktop/demographics_single_row.csv",
          row.names = F,na = "")