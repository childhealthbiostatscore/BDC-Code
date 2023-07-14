library(readxl)
library(dplyr)
library(stringr)

patient_data <-  read_xlsx("/Volumes/BDC/Projects/Todd Alonso/4Ts analysis/Data_raw/Todd_NewOnset_A1C_Comparison_06192023.xlsx",
                           sheet = "PatientLevel", na = "NULL")
patient_data <- patient_data %>% select(-c("studyday","hba1c"))
patient_data$hba1c_onset <- ifelse(patient_data$hba1c_onset %in% c(">14",">14%"),14,
                                   ifelse(patient_data$hba1c_onset==">15.5", 15.5,
                                          ifelse(patient_data$hba1c_onset==".",NA,patient_data$hba1c_onset)))
patient_data$record_id <- str_sub(patient_data$record_id, 7, length(patient_data$record_id))
patient_data$cgm_initiated_30d <- NA
patient_data$pump_hybrid_cl <- NA
patient_data$pump_adv_hybrid_cl <- NA
patient_data$pump_open_loop <- NA
patient_data$days_to_cgm <- ifelse(patient_data$days_to_cgm=="NA",NA,patient_data$days_to_cgm)
patient_data$days_to_pump <- ifelse(patient_data$days_to_pump=="NA",NA,patient_data$days_to_pump)

a1c_data <-  read_xlsx("/Volumes/BDC/Projects/Todd Alonso/4Ts analysis/Data_raw/Todd_NewOnset_A1C_Comparison_06192023.xlsx",
                           sheet = "HbA1c")
a1c_data <- a1c_data %>% select("MRN","studyday","A1C_ResultDate","hba1c")

#a1c_dup_data <- read_xlsx("/Volumes/BDC/Projects/Todd Alonso/4Ts analysis/Data_raw/Todd_NewOnset_A1C_Comparison_06192023.xlsx",
#                                           sheet = "PatientsWith2A1cs")
#a1c_dup_data <- a1c_dup_data %>% group_by(MRN, A1C_ResultDate) %>% slice(n())
# a1c_data <- rbind(a1c_data, a1c_dup_data)
# dup data doesn't have study day or other needed vars so I will exclude for now

# merge patient and A1c data
alldata <- merge(a1c_data, patient_data, by="MRN", all.x = F, all.y = F)

# drop PHI
alldata <- alldata %>% select(-c("MRN","DOB","Gender","Language_EPIC","OnsetDate","Age_at_onset_month","FirstBDCVisitDate_Peds","NumOfDays_OnsetDateToFirstVisit",
                                 "Race_EPIC","Ethnicity_EPIC","Race_Ethnicity_BDC","InsuranceName_EPIC","InsuranceType_BDC","FirstVisit_CGM_Date","FirstVisit_CGM_CGMType",
                                 "FirstVisit_InsulinRegimen_InsulinPump_Date", "FirstVisit_InsulinRegimen_InsulinPumpBrand", "FirstVisit_PLGS_Date","FirstVisit_PLGS_PumpBrand",
                                 "FirstVisit_PLGS_CGMType","CC_InsulinPumpStart_VisitDate","CC_SalinePumpStart_VisitDate","A1C_ResultDate"))

# write file
write.csv(alldata,"/Volumes/BDC/Projects/Todd Alonso/4Ts analysis/Data_clean/merged_data.csv", row.names = F)
