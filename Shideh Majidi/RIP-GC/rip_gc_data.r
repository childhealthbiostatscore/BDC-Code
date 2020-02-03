library(tidyverse)
# Read Data
cgm_pump=read.csv('/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Shideh Majidi/RIPGC/Data_Cleaned/pump_cgm.csv',
              na.strings = c("","."))
demographics=read.csv('/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Shideh Majidi/RIPGC/Data_Cleaned/demographics.csv',
                      na.strings = c("","."))
# Find those on pump and CGM at any time
device_use <- cgm_pump %>% group_by(ID) %>%
  summarise(cgm_use = suppressWarnings(max(OnCGM,na.rm = T)),
            pump_use = suppressWarnings(max(OnPump,na.rm = T)))
device_use[device_use == -Inf] <- NA
# Add to demographics
demographics <- left_join(demographics,device_use,by = "ID")
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
demographics$cgm_use = factor(demographics$cgm_use,levels = c(0,1),
                              labels = c("No","Yes"))
demographics$pump_use = factor(demographics$pump_use,levels = c(0,1),
                              labels = c("No","Yes"))

# Other
demographics$Initial_A1c <- 
  suppressWarnings(as.numeric(as.character(demographics$Initial_A1c)))

# Labels
labels(demographics) <- c(RaceEthnicity_combined="Race/Ethnicity",
                          Initial_A1c="Baseline HbA1c",
                          RiskCategory_coded="Risk Category",
                          Hospitalization="Hospitalized",
                          Endorsed_SI="Endorsed S.I.",
                          cgm_use="CGM Use",pump_use="Pump Use")




