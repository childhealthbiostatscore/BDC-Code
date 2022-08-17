#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('B:/Projects/Sarit Polsky/PICLS/Data cleaning/Data files/PICLSStudyHCLVsSAPTI-BaselineDemographics_DATA_2022-08-16_1707.csv')
#Setting Labels

label(data$pid)="Participant ID"
label(data$redcap_event_name)="Event Name"
label(data$redcap_repeat_instrument)="Repeat Instrument"
label(data$redcap_repeat_instance)="Repeat Instance"
label(data$location_code)="Select the study location"
label(data$date_demo)="Date of study visit"
label(data$bmi_baseline)="BMI"
label(data$dos)="Date of Screening"
label(data$demo_dob)="Date of birth"
label(data$demo_race)="Race: please select only one"
label(data$demo_ethnicity)="Ethnicity: Please select only one"
label(data$demo_date_diagnosis)="Date of Type 1 Diabetes Diagnosis (month/day/year)"
label(data$consent)="Consented  (or had consent waived)"
label(data$lmp)="First day of last menstrual period (LMP)"
label(data$edd_lmp)="Estimated due date (EDD) based on LMP"
label(data$edd_us)="EDD based on ultrasound"
label(data$edd_final)="Final EDD"
label(data$screen_failure)="Screen Failure?"
label(data$completion_status)="Completion Status of Screening/Run-In Phase"
label(data$status_cont)="Status of continuation phase"
label(data$completion_status_cont)="What is the reason the subject was withdrawn or dropped out?"
label(data$drop_date_continuation)="Date of withdrawal/drop out in continuation phase"
label(data$dow_run_in)="Date of Withdrawal"
label(data$gest_wk_drop)="Gestational age at withdrawal/drop out (weeks)"
label(data$gest_d_drop)="Gestational age at withdrawal/drop out (days)"
label(data$w_reason_continuation)="Reason for withdrawal in continuation phase"
label(data$demo_age)="Age at baseline visit"
label(data$fname)="First name"
label(data$lname)="Last name"
label(data$phone1)="Primary phone number"
label(data$phone2)="Other phone number"
label(data$email)="E-mail address"
label(data$email_inactive)="E-mail address for inactive subjects"
label(data$address)="Street Address"
label(data$city)="City"
label(data$state)="State"
label(data$zipcode)="Zipcode"
label(data$height)="Height (centimeters)"
label(data$height_m)="Height (meters)"
label(data$weight)="Weight (kilograms)"
label(data$demo_concep)="Is the date of conception known?"
label(data$demo_concep_how)="How is the date of conception known?"
label(data$demo_concep_other)="If other, please specify"
label(data$demo_concep_edd)="EDD based on known date of conception"
label(data$mrn)="Medical Record Number"
label(data$date_consent)="Date Informed Consent Signed"
label(data$consent_type)="Type of consent visit"
label(data$w_reason_run_in___1)="Reason for withdrawal (choice=Device wearing < 80% of the time)"
label(data$w_reason_run_in___2)="Reason for withdrawal (choice=Non-compliance with changing infusion sets)"
label(data$w_reason_run_in___3)="Reason for withdrawal (choice=Finger-stick checks < 2 times per day)"
label(data$w_reason_run_in___4)="Reason for withdrawal (choice=Filled out < 80% of log sheet data)"
label(data$w_reason_run_in___5)="Reason for withdrawal (choice=Unsuccessful uploading of CGM data for remote monitoring)"
label(data$w_reason_run_in___6)="Reason for withdrawal (choice=Did not communicate with study team during the run-in phase)"
label(data$w_reason_run_in___7)="Reason for withdrawal (choice=Did not return after run-in phase)"
label(data$w_reason_run_in___8)="Reason for withdrawal (choice=Subject is unable to demonstrate safe use of the study CGM, as judged by investigator)"
label(data$w_reason_run_in___9)="Reason for withdrawal (choice=Other)"
label(data$other_w_reason)="If other, please specify"
label(data$doc)="Date of Completion of Run-In Phase"
label(data$compl_fetal_loss)="What kind of pregnancy/fetal loss was it?"
label(data$compl_status_cont_other)="If other, please specify"
label(data$completion_drop_out)="What was the reason? Please provide details (for example, moved away, did not want to use study device, deceased)"
label(data$demographics_and_study_status_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("preconception_arm_1","adverse_event_arm_1","exemption_waiver_arm_1","labs_arm_1","visit_0_arm_1","visit_1_baseline_arm_1","visit_2_end_of_run_arm_1","visit_3_sapt_train_arm_1","visit_4_68_weeks_arm_1","visit_5_1st_trimes_arm_1","visit_6_randomizat_arm_1","postrandomization_arm_1","visit_7_1820_weeks_arm_1","visit_8_2nd_trimes_arm_1","visit_9_2nd_trimes_arm_1","visit_10_3032_week_arm_1","visit_11_3rd_trime_arm_1","visit_12_3rd_trime_arm_1","visit_13_3rd_trime_arm_1","visit_14_3rd_trime_arm_1","visit_15_3_days_po_arm_1","visit_16_46_wks_po_arm_1","acetaminophen_use_arm_1","sensor_wear_and_au_arm_1","interim_glucose_ma_arm_1","nutrition_counseli_arm_1","retinopathy_exam_r_arm_1","protocol_deviation_arm_1","hospital_ld_record_arm_1","device_complaintsd_arm_1","quality_of_life_arm_1","econsent_arm_1"))
data$redcap_repeat_instrument.factor = factor(data$redcap_repeat_instrument,levels=c("obstetrics_history","pregnancy_visits","food_log","smbg_questionnaire_run_in","adverse_event","protocol_deviation","interim_glucose_management","acetaminophen","exemption_waiver","device_complaints_and_deficiencies","visit_type","labs"))
data$location_code.factor = factor(data$location_code,levels=c("1","2"))
data$demo_race.factor = factor(data$demo_race,levels=c("0","1","2","3","4","5","6","7"))
data$demo_ethnicity.factor = factor(data$demo_ethnicity,levels=c("0","1","2","3"))
data$consent.factor = factor(data$consent,levels=c("1","2"))
data$screen_failure.factor = factor(data$screen_failure,levels=c("1","0"))
data$completion_status.factor = factor(data$completion_status,levels=c("1","2"))
data$status_cont.factor = factor(data$status_cont,levels=c("1","2","3"))
data$completion_status_cont.factor = factor(data$completion_status_cont,levels=c("1","2","3","4","5"))
data$w_reason_continuation.factor = factor(data$w_reason_continuation,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13"))
data$demo_concep.factor = factor(data$demo_concep,levels=c("1","0"))
data$demo_concep_how.factor = factor(data$demo_concep_how,levels=c("1","2","3","4"))
data$consent_type.factor = factor(data$consent_type,levels=c("0","1","2"))
data$w_reason_run_in___1.factor = factor(data$w_reason_run_in___1,levels=c("0","1"))
data$w_reason_run_in___2.factor = factor(data$w_reason_run_in___2,levels=c("0","1"))
data$w_reason_run_in___3.factor = factor(data$w_reason_run_in___3,levels=c("0","1"))
data$w_reason_run_in___4.factor = factor(data$w_reason_run_in___4,levels=c("0","1"))
data$w_reason_run_in___5.factor = factor(data$w_reason_run_in___5,levels=c("0","1"))
data$w_reason_run_in___6.factor = factor(data$w_reason_run_in___6,levels=c("0","1"))
data$w_reason_run_in___7.factor = factor(data$w_reason_run_in___7,levels=c("0","1"))
data$w_reason_run_in___8.factor = factor(data$w_reason_run_in___8,levels=c("0","1"))
data$w_reason_run_in___9.factor = factor(data$w_reason_run_in___9,levels=c("0","1"))
data$compl_fetal_loss.factor = factor(data$compl_fetal_loss,levels=c("0","1","2","3"))
data$demographics_and_study_status_complete.factor = factor(data$demographics_and_study_status_complete,levels=c("0","1","2"))

levels(data$redcap_event_name.factor)=c("Preconception","Adverse Event","Exemption (waiver)","Labs","Visit 0","Visit 1 (Baseline)","Visit 2 (End of Run-In)","Visit 3 (SAPT Training)","Visit 4 (6-8 Weeks)","Visit 5 (1st Trimester)","Visit 6 (Randomization, 14 Wk)","Post-Randomization Log","Visit 7 (18-20 weeks)","Visit 8 (2nd Trimester)","Visit 9 (2nd Trimester)","Visit 10 (30-32 weeks)","Visit 11 (3rd Trimester)","Visit 12 (3rd Trimester)","Visit 13 (3rd Trimester)","Visit 14 (3rd Trimester)","Visit 15 (3 Days Post-Partum)","Visit 16 (4-6 Wks Post-partum)","Acetaminophen Use","Sensor Wear and Auto Mode","Interim Glucose Managmenet","Nutrition Counseling","Retinopathy Exam Results","Protocol Deviation","Hospital L&D Records","Device Complaints/Deficiencies","Quality of Life","E-consent")
levels(data$redcap_repeat_instrument.factor)=c("Obstetrics History","Pregnancy Visits","Food Log","Smbg Questionnaire Run In","Adverse Event","Protocol Deviation","Interim Glucose Management","Acetaminophen","Exemption (waiver)","Device Complaints And Deficiencies","Visit Type","Labs")
levels(data$location_code.factor)=c("Barbara Davis Center","Ohio State University")
levels(data$demo_race.factor)=c("American Indian or Alaska Native","Asian","Black/African American","Native Hawaiian/Other Pacific Islander","White","Other (No further clarification required)","Subject refused","Not reportable per local laws or regulation")
levels(data$demo_ethnicity.factor)=c("Hispanic/Latino","Non-Hispanic/Non-Latino","Subject refused","Not reportable per local laws or regulation")
levels(data$consent.factor)=c("Yes","No")
levels(data$screen_failure.factor)=c("Yes","No")
levels(data$completion_status.factor)=c("Withdrawn","Completed")
levels(data$status_cont.factor)=c("Active","Completed","Withdrawn/dropped out of study")
levels(data$completion_status_cont.factor)=c("Subject withdrew consent (dropped out)","Subject was lost to follow-up","Subject was withdrawn by investigator","Subject ended continuation phase early due to fetal loss","Other")
levels(data$w_reason_continuation.factor)=c("Significant protocol violation or non-compliance","Any severe hypoglycemic event related to the use of the HCL system","Three severe hypoglycemic events from any cause","DKA unrelated to infusion site failure and related to the use of the HCL system","Two episodes of DKA regardless of the cause","Four pump occlusions","Decision by the investigator that termination of study participation is in the subjects best medical interest","Decision by the sponsor that termination of study participation is in the subjects best medical interest","Decision by the DSMB that termination of study participation is in the subjects best medical interest","Decision by the FDA that termination of study participation is in the subjects best medical interest","Allergic reaction to insulin","Severe allergic reaction to adhesive surface of the infusion set that prohibits further use of the HCL system","Severe allergic reaction to adhesive surface of the glucose sensor that prohibits further use of the HCL system")
levels(data$demo_concep.factor)=c("Yes","No")
levels(data$demo_concep_how.factor)=c("Intrauterine insemination (IUI)","In-Vitro Fertilization (IVF)","Only one sexual encounter around time of ovulation","Other")
levels(data$consent_type.factor)=c("In person","Phone","Video conference")
levels(data$w_reason_run_in___1.factor)=c("Unchecked","Checked")
levels(data$w_reason_run_in___2.factor)=c("Unchecked","Checked")
levels(data$w_reason_run_in___3.factor)=c("Unchecked","Checked")
levels(data$w_reason_run_in___4.factor)=c("Unchecked","Checked")
levels(data$w_reason_run_in___5.factor)=c("Unchecked","Checked")
levels(data$w_reason_run_in___6.factor)=c("Unchecked","Checked")
levels(data$w_reason_run_in___7.factor)=c("Unchecked","Checked")
levels(data$w_reason_run_in___8.factor)=c("Unchecked","Checked")
levels(data$w_reason_run_in___9.factor)=c("Unchecked","Checked")
levels(data$compl_fetal_loss.factor)=c("Chemical pregnancy loss","Pre-viable pregnancy loss","Intrauterine fetal death","Stillbirth")
levels(data$demographics_and_study_status_complete.factor)=c("Incomplete","Unverified","Complete")
