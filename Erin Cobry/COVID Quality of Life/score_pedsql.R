# read in data from children ages 5-7
data57 <- read.csv("Y:\\COVID Quality of Life\\Data_Raw\\HealthRelatedQuality-PedsQLAges57_DATA_2021-07-15_1431.csv",na.strings = c("",NA))

# read in data from children ages 8-17
data817 <- read.csv("Y:\\COVID Quality of Life\\Data_Raw\\HealthRelatedQuality-PedsQLAges817_DATA_2021-07-15_1433.csv",na.strings = c("",NA))

# read in parent data for ages 5-17
dataparent <- read.csv("Y:\\COVID Quality of Life\\Data_Raw\\HealthRelatedQuality-PedsQLParentProxyAge_DATA_2021-07-15_1451.csv",na.strings = c("",NA))