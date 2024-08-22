library(tidyverse)
library(readxl)
library(redcapAPI)
library(fastDummies)
setwd("/home/tim/OneDrive/Vigers/BDC/Janet Snell-Bergeon/PROMISE")
# Import FFQ data from REDCap
unlockREDCap(c(rcon = "The PROMISE Study"),
  keyring = "API_KEYs",
  envir = 1,
  url = "https://redcap.ucdenver.edu/api/"
)
ffqs <- exportReportsTyped(rcon, report_id = 119506)
# Import nutrient tables
cereal <- read_excel("./Data_Raw/CEREAL-NUTRIENT-TABLE-2022_Updated.xlsx")
food <- read_excel("./Data_Raw/Nutrient Tables/FOOD-NUTRIENT-TABLE-2022.xlsx")
marg <- read_excel("./Data_Raw/Nutrient Tables/Margarine-Nutrient-Table-2022.xlsx")
oil <- read_excel("./Data_Raw/Oil-Nutrient-Table-2022_Updated.xlsx")
oxalates <- read_excel("./Data_Raw/Nutrient Tables/OXALATE-TABLE.xlsx")
vitamins <- read_excel("./Data_Raw/Nutrient Tables/VITAMIN-NUTRIENT-TABLE-2022.xlsx")
#-------------------------------------------------------------------------------
# Vitamins
#-------------------------------------------------------------------------------

# Prepare the numeric columns
levels(ffqs$how_many_multi_vitamins_do) <- c(1 / 7, 4 / 7, 7.5 / 7, 10 / 7)
ffqs$how_many_multi_vitamins_do <-
  as.numeric(as.character(ffqs$how_many_multi_vitamins_do))
ffqs$how_many_multi_vitamins_do[is.na(ffqs$how_many_multi_vitamins_do)] = 0
# I can't think of a more efficient way to do this, so for now it'll have to 
# an apply statement

