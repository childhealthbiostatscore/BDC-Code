library(redcapAPI)
unlockREDCap(c(rcon = "MERIT Exercise Randomization"),
             keyring = "API_KEYs",
             envir = 1,
             url = "https://redcap.ucdenver.edu/api/"
)
exportBulkRecords(list(db = rcon), envir = 1)
