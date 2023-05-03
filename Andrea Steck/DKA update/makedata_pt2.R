library(sas7bdat)
library(readxl)
library(RODBC)

# read in data file that I created in SAS
data1 <- read.sas7bdat("/Volumes/BDC/Projects/Andrea Steck/Morgan Sooy DKA update/Data_raw/alldata.sas7bdat")
data1$`Study ID` <- NA
data1$Study <- NA
data1$DOB <- as.Date(data1$DOB, origin = "1960-01-01")
data1$OnsetDate <- as.Date(data1$OnsetDate, origin = "1960-01-01")
data1$Last_research_study_visit_date <- as.Date(data1$Last_research_study_visit_date, origin = "1960-01-01")
data1$LastA1C_Date <- as.Date(data1$LastA1C_Date, origin = "1960-01-01")
data1$LastVisitDate <- as.Date(data1$LastVisitDate, origin = "1960-01-01")
data1$Initial_research_study_visit_dat <- as.Date(data1$Initial_research_study_visit_dat, origin = "1960-01-01")
data1$Sample_ID <- NULL

# read in new file of research participants diagnosed 2005-2016 seen at the BDC for follow-up
data0516 <- read_xlsx("/Volumes/BDC/Projects/Andrea Steck/Morgan Sooy DKA update/Data_raw/Combined_TN_TDA_2005-2016_without names.xlsx")
data0516$MRN <- ifelse(!is.na(data0516$`EPIC MRN`),data0516$`EPIC MRN`,data0516$PP3_Patnum)
data0516$`EPIC MRN` <- NULL
data0516$PP3_Patnum <- NULL
data0516$`Initial study visit` <- as.Date(data0516$`Initial study visit`)
data0516$Initial_research_study_visit_dat <- data0516$`Initial study visit`
data0516$`Initial study visit` <- NULL
data0516$`Max study visit` <- as.Date(data0516$`Max study visit`)
data0516$Last_research_study_visit_date <- data0516$`Max study visit`
data0516$`Max study visit` <- NULL
data0516$DOB <- as.Date(data0516$DOB)
data0516$OnsetDate <- as.Date(data0516$`Date of Diagnosis`)
data0516$`Date of Diagnosis` <- NULL
data0516$`Dual?` <- NULL
data0516$instudy <- 1
# code race_eth
data0516[(!is.na(data0516$Race) & data0516$Race=="White") & (!is.na(data0516$Ethnicity) & data0516$Ethnicity=="No"),]$race_eth <- "Non-Hispanic White"
data0516[data0516$Race=="Black or African American" & data0516$Ethnicity=="No",]$race_eth <- "Non-Hispanic Black"
data0516[data0516$Ethnicity=="Spanish/Hispanic" | data0516$Ethnicity=="Yes",]$race_eth <- "Hispanic"
data0516[is.na(data0516$race_eth) & !(is.na(data0516$Race) | is.na(data0516$Ethnicity)),] <- "Other"
data0516[is.na(data0516$Race) & is.na(data0516$Ethnicity),] <- NA

# code fup_prior_dx
# code fup_prior_dx_mo
# code ge6moprior
# code last_visit_to_dx
# code seen_12mo_prior

# read in Marian's access database
marian_data <- read.csv("/Volumes/BDC/Projects/Andrea Steck/Morgan Sooy DKA update/Data_raw/JAMA 2005-2012 T1D and DKA known.txt")
