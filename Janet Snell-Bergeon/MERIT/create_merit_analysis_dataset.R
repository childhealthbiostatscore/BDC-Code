library(redcapAPI)
library(tidyverse)
library(cgmanalysis)
unlockREDCap(c(rcon = "MERIT Study"),
  keyring = "API_KEYs",
  envir = 1,
  url = "https://redcap.ucdenver.edu/api/"
)
tracking <- exportReportsTyped(rcon, report_id = 127037)
