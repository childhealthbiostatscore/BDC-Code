library(tidyverse)
# Read Data
cgm_pump=read.csv('/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Shideh Majidi/RIPGC/Data_Cleaned/pump_cgm.csv',
              na.strings = c("",".","#N/A","N/A","*No day 2 - brother has T1D 10 yrs, well informed"))
demographics=read.csv('/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Shideh Majidi/RIPGC/Data_Cleaned/demographics.csv',
                      na.strings = c("","."))
a1cs=read.csv('/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Shideh Majidi/RIPGC/Data_Cleaned/a1cs.csv')
# Summarise across all visits
roc_data <- cgm_pump %>% group_by(ID) %>%
  summarise(cgm_use = suppressWarnings(max(OnCGM,na.rm = T)),
            pump_use = suppressWarnings(max(OnPump,na.rm = T)),
            bg_high = mean(BGHigh.,na.rm = T),
            bg_ok = mean(BDOK.,na.rm = T),
            bg_low = mean(BGLow.,na.rm = T),
            cgm_high = mean(CGMHigh.,na.rm = T),
            cgm_ok = mean(CGMOK.,na.rm = T),
            cgm_low = mean(CGMLow.,na.rm = T),
            ripgc = suppressWarnings(max(RIPGC_total_score,na.rm = T)))
# Summarise HbA1c
roc_data <- left_join(roc_data,
                      a1cs %>% group_by(ID) %>% 
                        summarise(a1c = mean(OrderValue,na.rm = T)),by = "ID")
# NaN and -Inf to NA
roc_data[is.na(roc_data)] <- NA
roc_data[roc_data == -Inf] <- NA
# Factors
demographics$Sex = factor(demographics$Sex,levels=c(1,0),
                          labels = c("Male","Female"))
demographics$Race = factor(demographics$Race,levels=c(0:7),
                           labels = c("White","Black/African American","Asian",
                                      "American Indian/Alaskan Native","Other",
                                      "More than one Race","Unknown/Not Reported",
                                      "Native Hawaiian/Other Pacific Islander"))
demographics$Ethnicity = factor(demographics$Ethnicity,levels = c(0:2),
                                labels = c("Non-Hispanic","Hispanic or Latino",
                                           "Unknown/Not Reported"))
demographics$RaceEthnicity_combined = factor(demographics$RaceEthnicity_combined,
                                             levels = c(0:3),
                                             labels = c("White Non-Hispanic",
                                                        "Hispanic or Latino",
                                                        "Other","Unknown"))
demographics$Insurance = factor(demographics$Insurance,levels = c(0:2),
                                labels = c("Public","Private","None/Self Pay"))
demographics$RiskCategory_coded = factor(demographics$RiskCategory_coded,
                                         levels = c(0:2),
                                         labels = c("Low","Moderate","High"))
levels(demographics$DKA) = c("No","No","Yes","Yes")

roc_data$cgm_use = factor(roc_data$cgm_use,levels = c(0,1),
                          labels = c("No","Yes"))

roc_data$pump_use = factor(roc_data$pump_use,levels = c(0,1),
                          labels = c("No","Yes"))

demographics <- left_join(demographics,roc_data[,c("ID","cgm_use","pump_use")],
                          by = "ID")

# Other
demographics$Initial_A1c <- 
  suppressWarnings(as.numeric(as.character(demographics$Initial_A1c)))

cgm_pump$VisitDate <- lubridate::mdy(cgm_pump$VisitDate)

# DKA
roc_data <- left_join(roc_data,demographics[,c("ID","DKA")],by = "ID")

# Labels
labels(demographics) <- c(RaceEthnicity_combined="Race/Ethnicity",
                          Initial_A1c="Baseline HbA1c",
                          RiskCategory_coded="Risk Category",
                          Hospitalization="Hospitalized",
                          Endorsed_SI="Endorsed S.I.",
                          cgm_use="CGM Use",pump_use="Pump Use")
