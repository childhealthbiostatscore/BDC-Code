library(readxl)
library(dplyr)
library(stringr)

patient_data <-  read_xlsx("/Volumes/BDC/Projects/Todd Alonso/4Ts analysis/Data_raw/Todd_NewOnset_A1C_Comparison_V2_07172023.xlsx",
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

a1c_data <-  read_xlsx("/Volumes/BDC/Projects/Todd Alonso/4Ts analysis/Data_raw/Todd_NewOnset_A1C_Comparison_V2_07172023.xlsx",
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

# set one A1c value at onset to missing
alldata$hba1c_onset <- ifelse(alldata$hba1c_onset==618,NA,alldata$hba1c_onset)
alldata$days_to_cgm <- as.numeric(alldata$days_to_cgm)
alldata$days_to_pump <- as.numeric(alldata$days_to_pump)

# write file
write.csv(alldata,"/Volumes/BDC/Projects/Todd Alonso/4Ts analysis/Data_clean/merged_data.csv", row.names = F)

# checking number of excluded records
dat_excl <- subset(alldata, !(cohort %in% c("hist", "pres")) |
                     (age_at_onset < 0.5 | age_at_onset >= 21) |
                     !(sex %in% c(NA, "Female", "Male")) |
                     !(race_ethnicity %in% c("Non-Hispanic White", "Non-Hispanic Black",
                                             "Hispanic", "Asian or Pacific Islander",
                                             "American Indian or Alaska Native", "Other",
                                             "Unknown / Declined to state")) |
                     !(dka_onset %in% c(NA, 0:1)) |
                     !(insurance_type %in% c(NA, "Private", "Public", "Both", "No Insurance")) |
                     !(language %in% c(NA, "English", "Non-English")) |
                     studyday < 0 |
                     (hba1c_onset < 4 | hba1c_onset > 20) |
                     (hba1c < 4 | hba1c > 20) |
                     !(cgm_initiated %in% 0:1) |
                     !(cgm_initiated_30d %in% c(NA, 0:1)) |             # unavailable at BDC
                     (days_to_cgm < 0 | days_to_cgm > 360) |  # unavailable at BDC
                     !(pump_yesno %in% c(NA, 0:1)) |
                     !(pump_plgs %in% 0:1) |
                     !(pump_open_loop %in% 0:1) |
                     !(pump_hybrid_cl %in% 0:1) |
                     !(pump_adv_hybrid_cl %in% 0:1) |
                     (days_to_pump < 0 | days_to_pump > 360)) # unavailable at BDC

data_exl_cohort <- alldata %>% filter(!(cohort %in% c("hist", "pres")))
data_exl_age <- subset(alldata, (age_at_onset < 0.5 | age_at_onset >= 21) )
data_exl_sex <- subset(alldata, !(sex %in% c(NA, "Female", "Male")))
data_exl_race <- subset(alldata, !(race_ethnicity %in% c("Non-Hispanic White", "Non-Hispanic Black",
                                                           "Hispanic", "Asian or Pacific Islander",
                                                           "American Indian or Alaska Native", "Other",
                                                           "Unknown / Declined to state")))
data_exl_dka <- subset(alldata, !(dka_onset %in% c(NA, 0:1)))
data_exl_ins <- subset(alldata, !(insurance_type %in% c(NA, "Private", "Public", "Both", "No Insurance")))
data_exl_lang <- subset(alldata, !(language %in% c(NA, "English", "Non-English")))
data_exl_studyday <- subset(alldata, studyday < 0)
data_exl_a1conset <- subset(alldata, (hba1c_onset < 4 | hba1c_onset > 20))
data_exl_a1c <- subset(alldata, (hba1c < 4 | hba1c > 20))
data_exl_cgminit <- subset(alldata,  !(cgm_initiated %in% 0:1))
data_exl_cgminit30 <- subset(alldata, !(cgm_initiated_30d %in% c(NA, 0:1)))
data_exl_daystocgm <- subset(alldata, (days_to_cgm < 0 | days_to_cgm > 360))
data_exl_pump <- subset(alldata, !(pump_yesno %in% c(NA, 0:1)))
data_exl_plgs <- subset(alldata, !(pump_plgs %in% 0:1) )
data_exl_open <- subset(alldata, !(pump_open_loop %in% 0:1) )
data_exl_hcl <- subset(alldata, !(pump_hybrid_cl %in% 0:1))
data_exl_advhcl <- subset(alldata, !(pump_adv_hybrid_cl %in% 0:1))
data_exl_daystopump <- subset(alldata, (days_to_pump < 0 | days_to_pump > 360))

# summary of excluded values
# 33 American Indian/Alaska Native
# 1508 days_to_cgm were excluded, until I converted to numeric and then none were
# all values of pump_open_loop are missing
# all values of pump_hybrid_cl are missing
# all values of pump_adv_hybrid_cl are missing
# 584 days_to_pump were excluded until I converted to numeric and then none were