library(tidyverse)
library(tidyfun)
library(haven)
library(hms)
# Import CGM data
cgm <- read_sas("/Users/timvigers/Library/CloudStorage/OneDrive-TheUniversityofColoradoDenver/Vigers/BDC/Andrea Steck/Advanced CGM and OGTT/Data_Raw/rawcgmdata.sas7bdat")
# Round time to nearest minute
cgm$sensordisplaytime <- parse_date_time(cgm$sensordisplaytime,
  orders = c("Ymd HMS", "Ymd")
)
cgm$sensordisplaytime <- round_date(cgm$sensordisplaytime, unit = "5 minutes")
# Separate date and time columns
cgm$Date <- as_date(cgm$sensordisplaytime)
cgm$Time <- as_hms(cgm$sensordisplaytime)
# Convert to a wide format where each row is a participant-date
fda_df <- cgm %>%
  mutate(Time = as.numeric(Time)) %>%
  arrange(Time) %>%
  pivot_wider(
    names_from = Time,
    values_from = SensorValue,
    id_cols = c(ID, Date),
    values_fn = mean
  ) %>%
  arrange(ID, Date) %>%
  tf_gather(`0`:`86100`, key = "Glucose", evaluator = tf_approx_none)
# Import longitudinal data
df <- read.csv("/Users/timvigers/Library/CloudStorage/OneDrive-TheUniversityofColoradoDenver/Vigers/BDC/Andrea Steck/Advanced CGM and OGTT/Data_Clean/Longitudinal CGM data for 165 subjects.csv", na.strings = c("", "."))
# Participant info
df <- df %>%
  select(ID, Date.of.T1D.dx) %>%
  filter(rowSums(!is.na(.)) > 0) %>%
  distinct() %>%
  rename(`Date of Diagnosis` = Date.of.T1D.dx)
df$`Date of Diagnosis` <- mdy(df$`Date of Diagnosis`)
df$Group <- factor(!is.na(df$`Date of Diagnosis`),
  levels = c(F, T), labels = c("No T1D", "T1D")
)
fda_df <- left_join(fda_df, df, by = join_by(ID))
# Save
save(fda_df, file = "/Users/timvigers/Library/CloudStorage/OneDrive-TheUniversityofColoradoDenver/Vigers/BDC/Andrea Steck/Advanced CGM and OGTT/Data_Clean/fda_dataset.RData")
