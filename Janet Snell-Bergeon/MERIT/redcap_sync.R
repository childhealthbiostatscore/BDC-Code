library(tidyverse)
library(redcapAPI)
# Unlock both REDCap databases
unlockREDCap(
  c(
    exercise = "MERIT Excercise (Tim Test)",
    merit = "MERIT (Tim Test)"
  ),
  keyring = "API_KEYs",
  envir = 1,
  url = "https://redcap.ucdenver.edu/api/"
)
# Pull data from the exercise database
exportBulkRecords(list(db = exercise), envir = 1)
# Recast for import
db_randomization_of_exercise <- db_randomization_of_exercise %>%
  rename(participant_id = record_id) %>%
  select(participant_id, exercise_order)
# Import into MERIT database
importRecords(rcon = merit, data = castForImport(db_randomization_of_exercise,merit))
