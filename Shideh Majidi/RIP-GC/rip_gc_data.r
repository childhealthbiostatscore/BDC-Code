# Read Data
cgm_pump=read.csv('/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Shideh Majidi/RIPGC/Data_Cleaned/pump_cgm.csv',
              na.strings = c("","."))
demographics=read.csv('/Volumes/som/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Shideh Majidi/RIPGC/Data_Cleaned/demographics.csv',
                      na.strings = c("","."))

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
demographics$ComorbidPsych = factor(demographics$ComorbidPsych,levels = c(0,1),
                                    labels = c("No","Yes"))
demographics$Endorsed_SI[is.na(demographics$Endorsed_SI)] <- 2
demographics$Endorsed_SI = factor(demographics$Endorsed_SI,levels = c(0:2),
                                  labels = c("No","Yes","Not Assessed"))

levels(demographics$Hospitalization) = c("No","No","Yes","Yes")
levels(demographics$DKA) = c("No","No","Yes","Yes")

# Other
demographics$Initial_A1c <- 
  suppressWarnings(as.numeric(as.character(demographics$Initial_A1c)))

# Labels
labels(demographics) <- c(RaceEthnicity_combined="Race/Ethnicity",
                          Initial_A1c="Baseline HbA1c",
                          RiskCategory_coded="Risk Category",
                          Hospitalization="Hospitalized",
                          Endorsed_SI="Endorsed S.I.")




