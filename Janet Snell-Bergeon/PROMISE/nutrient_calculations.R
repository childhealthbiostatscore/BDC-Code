library(tidyverse)
library(readxl)
library(redcapAPI)
setwd("/home/tim/OneDrive/Vigers/BDC/Janet Snell-Bergeon/PROMISE")
# Import FFQ data from REDCap
unlockREDCap(c(rcon = "The PROMISE Study"),
             keyring = "API_KEYs",
             envir = 1,
             url = "https://redcap.ucdenver.edu/api/"
)
ffqs = exportReportsTyped(rcon, report_id = 119506)
# Import nutrient tables
cereal <- read_excel("./Data_Raw/CEREAL-NUTRIENT-TABLE-2022_Updated.xlsx")
food <- read_excel("./Data_Raw/Nutrient Tables/FOOD-NUTRIENT-TABLE-2022.xlsx")
marg <- read_excel("./Data_Raw/Nutrient Tables/Margarine-Nutrient-Table-2022.xlsx")
oil <- read_excel("./Data_Raw/Oil-Nutrient-Table-2022_Updated.xlsx")
oxalates <- read_excel("./Data_Raw/Nutrient Tables/OXALATE-TABLE.xlsx")
vitamins <- read_excel("./Data_Raw/Nutrient Tables/VITAMIN-NUTRIENT-TABLE-2022.xlsx")
# Unfortunately we may have to go section by section and apply different rules

# Merge
nutrients <- full_join(food, marg)
nutrients <- full_join(nutrients, oil)
