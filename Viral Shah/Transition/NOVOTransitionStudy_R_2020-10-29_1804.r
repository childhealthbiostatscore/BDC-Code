#Read Data
data=read.csv('./Data_Raw/NOVOTransitionStudy_DATA_2020-11-25_0951.csv')
#Setting Labels

label(data$record_id)="Record ID"
label(data$subject_id)="Subject ID"
label(data$date_of_visit_screening)="Date of visit"
label(data$i01)="Informed consent obtained before any trial-related activities. Trial-related activities are any procedures that are carried out as part of the trial, including activities to determine suitability for the trial."
label(data$i02)="Male or female, age ≥18 years and ≤ 65 years."
label(data$i03)="Patient with Type 1 Diabetes for at least 12 months"
label(data$i04)="Point-of-care HbA1c levels between ≥6.5% and ≤ 8.5%"
label(data$i05)="Patients on CSII (any insulin pump) for at least past 6 months"
label(data$i06)="Willing and able to wear a blinded CGM during the time of study period"
label(data$i07)="Willing to perform self-monitoring of blood glucose (SMBG) at least 4 times a day"
label(data$i08)="Ability to provide informed consent before any trial-related activities"
label(data$i09)="Not willing to or plan any travel out of Colorado during the 3 weeks of study period"
label(data$i10)="Willing to use insulin degludec in the morning once a day"
label(data$e01)="Age < 18 years >65 Years"
label(data$e02)="HbA1C>8.5% at screening"
label(data$e03)="Less than 12 months of insulin treatment"
label(data$e04)="Patients on 670G (Medtronic Hybrid Closed-loop system) and not willing to use manual mode during the study period"
label(data$e05)="Patients with T1D using any glucose lowering medications other than insulin"
label(data$e06)="Pregnancy, breast feeding, and positive pregnancy test during screening"
label(data$e07)="Women of childbearing age wanting to become pregnant or not using adequate contraceptive measures"
label(data$e08)="Current or recent (< 2 weeks prior to visit 1) use of any steroidal medication, or anticipated steroidal treatment, during the study period"
label(data$e09)="eGFR below 45 ml/min/1.73 m^2 using MDRD formula"
label(data$e10)="History of severe hypoglycemia in the previous 3 months"
label(data$e11)="History of diabetic ketoacidosis (DKA) requiring hospitalization in the past 3 months"
label(data$e12)="History of allergy to any form of insulin or its excipients"
label(data$e13)="History of allergy to adhesives"
label(data$e14)="Unwilling to use blinded CGM during the study period"
label(data$e15)="Unwilling to perform SMPG at least 4 times a day"
label(data$e16)="Known history of alcohol abuse or illicit drug use within 6 months prior to screening"
label(data$e17)="Use of investigational drugs within 5 half-lives prior to screening"
label(data$e18)="Participation to other study trials during the study period"
label(data$e19)="Elevated liver enzymes (AST and ALT) 3 times the upper limit of normal"
label(data$e20)="Hypoglycemia unawareness defined as GOLD score ≥4"
label(data$e21)="Any comorbidities or medical conditions that make a person unfit for the study at the discretion of the investigators"
label(data$e22)="Anticipated travel across different time zones (difference greater than 4 hours) or anticipated change in physical activities or diet at the discretion of the investigators."
label(data$a1c)="HbA1C point of care value:"
label(data$date_and_time)="Date and Time of measurement:"
label(data$date_time_of_sample)="Date and Time of sample collection for CMP"
label(data$urine_date_time)="If the subject is a WOCBP, Urine sample collection date and time:"
label(data$pregnancy)="Pregnancy test result"
label(data$weight)="Weight:"
label(data$heigh)="Height:"
label(data$bmi)="BMI:"
label(data$systolic)="Systolic Pressure:"
label(data$diastolic)="Diastolic Pressure:"
label(data$pulse)="Pulse:"
label(data$g6_receiver_serial_number)="Dexcom G6 receiver serial number:"
label(data$sensor_number_v1)="Sensor number:"
label(data$transmitter_number_v1)="Transmitter number"
label(data$cgm_activation)="Activation date and time:"
label(data$visit_1_screening_complete)="Complete?"
label(data$idss_complicated)="1. Is too complicated."
label(data$idss_good_control)="2. Helps me to have good blood glucose control."
label(data$idss_embarrassing)="3. Is often embarrassing to use when I am in public."
label(data$idss_hassle_to_use)="4. Is too much of a hassle to use."
label(data$idss_control)="5. Helps me to feel more in control of my diabetes."
label(data$idss_works_well)="6. Works well when I need it."
label(data$idss_expensive)="7. Is too expensive."
label(data$idss_spontaneous)="8. Makes it difficult to be as spontaneous as Id like to be."
label(data$idss_many_pieces)="9. Has too many pieces and parts to manage."
label(data$idss_benefit)="10. Doesnt really benefit me much."
label(data$idss_inconvinient)="11. Is inconvenient to use when I am away from home."
label(data$idss_time)="12. Takes too much time to use."
label(data$idss_hassle_to_carry)="13. Is a hassle to carry around."
label(data$idss_future)="14. Helps me feel more positive about the future."
label(data$cgm_satisfaction)="1. Helps me feel more satisfied with how things are going with my diabetes."
label(data$cgm_think_more)="2. Makes me think about diabetes more than I want to."
label(data$cgm_too_much_time)="3. Takes too much time to use."
label(data$cgm_accurate)="4. Doesnt seem to be as accurate as I would like it to be."
label(data$cgm_worry)="5. Make me worry a lot."
label(data$cgm_hassle)="6. Is too much of a hassle to use"
label(data$cgm_trust)="7. Gives me numbers that I dont entirely trust."
label(data$cgm_restriction)="8. Helps me feel less restricted by diabetes."
label(data$cgm_frustration)="9. Makes me feel more frustrated with my diabetes."
label(data$cgm_spontaneous)="10. Helps me be more spontaneous in my life."
label(data$cgm_bruises)="11. Causes too many skin irritations or bruises."
label(data$cgm_no_sense)="12. Often gives me results that dont make sense."
label(data$cgm_depressed)="13. Makes me feel more down and depressed."
label(data$cgm_experiences)="14. Helps me be more open to new experiences in life."
label(data$cgm_painful)="15. Is too painful to use."
label(data$v1_insulin_delivery_satisfaction_survey_complete)="Complete?"
label(data$wpai_employed)="1. Are you currently employed (working for pay)?"
label(data$wpai_missed_work)="2. During the past seven days, how many hours did you miss from work because of problems associated with your PROBLEM? Include hours you missed on sick days, times you went in late, left early, etc., because of your PROBLEM. DO not include time you missed to participate in this study. "
label(data$wpai_time_off)="3. During the past seven days, how many hours did you miss from work because of any other reason, such as vacation, holidays, time off to participate in this study?"
label(data$wpai_productivity)="4. During the past seven days, how many hours did you actually work?"
label(data$wpai_productivity_while_work)="5. During the past seven days, how much did your PROBLEM affect your productivity while you were working?  Think about days  you were limited in the amount or kind of work you could do, days you accomplished less than you would like, or days you could not do your work as carefully as usual. If PROBLEM affected your work only a little, choose a low number. Choose a high number if PROBLEM affected your work a great deal.   Consider only how much PROBLEM affected productivity while you were working."
label(data$wpai_regular_activity)="6. During the past seven days, how much did your PROBLEM affect your ability to do your regular daily activities, other than work at a job?  By regular activities, we mean the usual activities you do, such as work around the house, shopping, childcare, exercising, studying,etc. Think about times you were limited in the amount or kind of activities you could do and times you accomplished less than you would like.  If PROBLEM affected your activities only a little, choose a low number. Choose a high number if PROBLEM affected your work a great deal.   Consider only how much PROBLEM affected your ability to do your regular daily activities, other than work at a job."
label(data$v1_work_productivity_and_activity_impairment_quest_complete)="Complete?"
label(data$gold_score)="Do you know when your hypos are commencing?"
label(data$v1_gold_questionnaire_complete)="Complete?"
label(data$name)="Name:"
label(data$gender)="Gender:"
label(data$age)="Age"
label(data$diabetes_duration)="Diabetes duration:"
label(data$address)="Address:"
label(data$city)="City:"
label(data$state)="State:"
label(data$zip_code)="Zip code:"
label(data$phone1)="Phone 1:"
label(data$phone2)="Phone 2:"
label(data$email)="Email address:"
label(data$name2)="Name:"
label(data$phone3)="Phone:"
label(data$relationship)="Relationship:"
label(data$martial_status)="1. Which one of the following applies to you currently?"
label(data$education)="2. What is the highest grade or year of school that you have completed? (Regular school, not vocational school) (Code GED as 12)"
label(data$employment_status)="3. Which of the following best describes your employment status? "
label(data$employment_other)="If employment status is Other, complete the following:"
label(data$insurance_private)="1. Currently have private medical insurance (Through my employer or state health insurance exchanges, HMO, PPO or other insurance plan)"
label(data$insurance_medicare)="2. Currently have Medicare"
label(data$insurance_medicaid)="3. Currently have Medicaid, CHP or other government plan"
label(data$insurance_medical)="4. Currently do not have medical insurance"
label(data$insurance_no_answer)="5. No answer/ dont know/ refused"
label(data$kaiser_id)="If private medical insurance is Kaiser, enter Kaiser Id. "
label(data$pcp)="5. Do you have a Primary Care Provider?"
label(data$pcp_name)="Name of PCP:"
label(data$pcp_city)="CIty:"
label(data$pcp_state)="State:"
label(data$pcp_years)="6. How long have they been your PCP?"
label(data$household_people)="7. How many people are now living in your household, including yourself?"
label(data$adults_over_18)="8. How many of these people are adults, 18 or older?"
label(data$household_income)="9. What was your total family income, before taxes, of all your family members living in your house, from all sources, last year? (Do not include income received by boarders, or family members not currently living in the house.)"
label(data$t1d_date)="When were you diagnosed with Type 1 Diabetes?"
label(data$family_diabetes)="Does anyone in your immediate family have diabetes (like parents, siblings)? "
label(data$insulin_pump)="What is your method of insulin delivery?"
label(data$other_insulin)="If other, specify"
label(data$diabetes_meds)="Do you take other diabetes medications besides insulin?"
label(data$specific_diab_meds)="If yes, specify"
label(data$cgm)="Do you currently use a continuous glucose monitor?"
label(data$cgm_type)="If yes, what CGM (Continuous Glucose Monitor) system do you currently use?"
label(data$diab_conditions___1)="Do you have any of the following diabetic medical conditions? Select all that apply. (choice=Diabetic Retinopathy (eye disease from diabetes))"
label(data$diab_conditions___2)="Do you have any of the following diabetic medical conditions? Select all that apply. (choice=Diabetic neuropathy)"
label(data$diab_conditions___3)="Do you have any of the following diabetic medical conditions? Select all that apply. (choice=Diabetic kidney problems (including micro-albumin))"
label(data$diab_conditions___4)="Do you have any of the following diabetic medical conditions? Select all that apply. (choice=High Cholestrol)"
label(data$diab_conditions___5)="Do you have any of the following diabetic medical conditions? Select all that apply. (choice=High Blood Pressure)"
label(data$v1_baseline_demographic_questionnaire_complete)="Complete?"
label(data$name_pre_existing)="1. Medical/Surgical History"
label(data$start_date_pre_existing)="Start date"
label(data$ongoing_pre_existing)="Condition ongoing?"
label(data$stop_date_pre_existing)="Stop date"
label(data$name_2_pre_existing)="2. Medical/Surgical History"
label(data$start_date_2_pre_existing)="Start date"
label(data$ongoing_2_pre_existing)="Condition ongoing?"
label(data$stop_date_2_pre_existing)="Stop date"
label(data$name_3_pre_existing)="3. Medical/Surgical History"
label(data$start_date_3_pre_existing)="Start date"
label(data$ongoing_3_pre_existing)="Condition ongoing?"
label(data$stop_date_3_pre_existing)="Stop date"
label(data$name_4_pre_existing)="4. Medical/Surgical History"
label(data$start_date_4_pre_existing)="Start date"
label(data$ongoing_4_pre_existing)="Condition ongoing?"
label(data$stop_date_4_pre_existing)="Stop date"
label(data$name_5_pre_existing)="5. Medical/Surgical History"
label(data$start_date_5_pre_existing)="Start date"
label(data$ongoing_5_pre_existing)="Condition ongoing?"
label(data$stop_date_5_pre_existing)="Stop date"
label(data$name_6_pre_existing)="6. Medical/Surgical History"
label(data$start_date_6_pre_existing)="Start date"
label(data$ongoing_6_pre_existing)="Condition ongoing?"
label(data$stop_date_6_pre_existing)="Stop date"
label(data$name_7_pre_existing)="7. Medical/Surgical History"
label(data$start_date_7_pre_existing)="Start date"
label(data$ongoing_7_pre_existing)="Condition ongoing?"
label(data$stop_date_7_pre_existing)="Stop date"
label(data$name_8_pre_existing)="8. Medical/Surgical History"
label(data$start_date_8_pre_existing)="Start date"
label(data$ongoing_8_pre_existing)="Condition ongoing?"
label(data$stop_date_8_pre_existing)="Stop date"
label(data$name_9_pre_existing)="9. Medical/Surgical History"
label(data$start_date_9_pre_existing)="Start date"
label(data$ongoing_9_pre_existing)="Condition ongoing?"
label(data$stop_date_9_pre_existing)="Stop date"
label(data$name_10_pre_existing)="10. Medical/Surgical History"
label(data$start_date_10_pre_existing)="Start date"
label(data$ongoing_10_pre_existing)="Condition ongoing?"
label(data$stop_date_10_pre_existing)="Stop date"
label(data$name_11_pre_existing)="11. Medical/Surgical History"
label(data$start_date_11_pre_existing)="Start date"
label(data$ongoing_11_pre_existing)="Condition ongoing?"
label(data$stop_date_11_pre_existing)="Stop date"
label(data$name_12_pre_existing)="12. Medical/Surgical History"
label(data$start_date_12_pre_existing)="Start date"
label(data$ongoing_12_pre_existing)="Condition ongoing?"
label(data$stop_date_12_pre_existing)="Stop date"
label(data$name_13_pre_existing)="13. Medical/Surgical History"
label(data$start_date_13_pre_existing)="Start date"
label(data$ongoing_13_pre_existing)="Condition ongoing?"
label(data$stop_date_13_pre_existing)="Stop date"
label(data$preexisting_condition_complete)="Complete?"
label(data$med_name)="1. Medication name"
label(data$med_dose)="Total daily dose"
label(data$med_unit)="Dose unit"
label(data$start_date)="Start date"
label(data$med_ongoing)="Medication ongoing?"
label(data$med_reason)="Reason"
label(data$med_stop_date)="Stop date"
label(data$med_name_2)="2. Medication name"
label(data$med_dose_2)="Total daily dose"
label(data$med_unit_2)="Dose unit"
label(data$start_date_2)="Start date"
label(data$med_ongoing_2)="Medication ongoing?"
label(data$med_stop_date_2)="Stop date"
label(data$med_reason_2)="Reason"
label(data$med_name_3)="3. Medication name"
label(data$med_dose_3)="Total daily dose"
label(data$med_unit_3)="Dose unit"
label(data$start_date_3)="Start date"
label(data$med_ongoing_3)="Medication ongoing?"
label(data$med_stop_date_3)="Stop date"
label(data$med_reason_3)="Reason"
label(data$med_name_4)="4. Medication name"
label(data$med_dose_4)="Total daily dose"
label(data$med_unit_4)="Dose unit"
label(data$med_start_date_4)="Start date"
label(data$med_ongoing_4)="Medication ongoing?"
label(data$med_stop_date_4)="Stop date"
label(data$med_reason_4)="Reason"
label(data$med_name_5)="5. Medication name"
label(data$med_dose_5)="Total daily dose"
label(data$med_unit_5)="Dose unit"
label(data$med_start_date_5)="Start date"
label(data$med_ongoing_5)="Med ongoing?"
label(data$stop_date_5)="Stop date"
label(data$med_reason_5)="Reason"
label(data$med_name_6)="6. Medication name"
label(data$med_dose_6)="Total daily dose"
label(data$med_unit_6)="Dose unit"
label(data$med_start_date_6)="Start date"
label(data$med_ongoing_6)="Med ongoing?"
label(data$stop_date_6)="Stop date"
label(data$med_reason_6)="Reason"
label(data$med_name_7)="7. Medication name"
label(data$med_dose_7)="Total daily dose"
label(data$med_unit_7)="Dose unit"
label(data$med_start_date_7)="Start date"
label(data$med_ongoing_7)="Med ongoing?"
label(data$stop_date_7)="Stop date"
label(data$med_reason_7)="Reason"
label(data$med_name_8)="8. Medication name"
label(data$med_dose_8)="Total daily dose"
label(data$med_unit_8)="Dose unit"
label(data$med_start_date_8)="Start date"
label(data$med_ongoing_8)="Med ongoing?"
label(data$stop_date_8)="Stop date"
label(data$med_reason_8)="Reason"
label(data$med_name_9)="9. Medication name"
label(data$med_dose_9)="Total daily dose"
label(data$med_unit_9)="Dose unit"
label(data$med_start_date_9)="Start date"
label(data$med_ongoing_9)="Med ongoing?"
label(data$stop_date_9)="Stop date"
label(data$med_reason_9)="Reason"
label(data$med_name_10)="10. Medication name"
label(data$med_dose_10)="Total daily dose"
label(data$med_unit_10)="Dose unit"
label(data$med_start_date_10)="Start date"
label(data$med_ongoing_10)="Med ongoing?"
label(data$stop_date_10)="Stop date"
label(data$med_reason_10)="Reason"
label(data$med_name_11)="11. Medication name"
label(data$med_dose_11)="Total daily dose"
label(data$med_unit_11)="Dose unit"
label(data$med_start_date_11)="Start date"
label(data$med_ongoing_11)="Med ongoing?"
label(data$stop_date_11)="Stop date"
label(data$med_reason_11)="Reason"
label(data$med_name_12)="12. Medication name"
label(data$med_dose_12)="Total daily dose"
label(data$med_unit_12)="Dose unit"
label(data$med_start_date_12)="Start date"
label(data$med_ongoing_12)="Med ongoing?"
label(data$stop_date_12)="Stop date"
label(data$med_reason_12)="Reason"
label(data$med_name_13)="13. Medication name"
label(data$med_dose_13)="Total daily dose"
label(data$med_unit_13)="Dose unit"
label(data$med_start_date_13)="Start date"
label(data$med_ongoing_13)="Med ongoing?"
label(data$stop_date_13)="Stop date"
label(data$med_reason_13)="Reason"
label(data$concomitant_medication_complete)="Complete?"
label(data$date_randomization)="Date of visit"
label(data$which_exclusion_has_been_m___1)="Which exclusion has been meet (choice=E1)"
label(data$which_exclusion_has_been_m___2)="Which exclusion has been meet (choice=E2)"
label(data$which_exclusion_has_been_m___3)="Which exclusion has been meet (choice=E3)"
label(data$which_exclusion_has_been_m___4)="Which exclusion has been meet (choice=E4)"
label(data$which_exclusion_has_been_m___5)="Which exclusion has been meet (choice=E5)"
label(data$which_exclusion_has_been_m___6)="Which exclusion has been meet (choice=E6)"
label(data$which_exclusion_has_been_m___7)="Which exclusion has been meet (choice=E7)"
label(data$which_exclusion_has_been_m___8)="Which exclusion has been meet (choice=E8)"
label(data$which_exclusion_has_been_m___9)="Which exclusion has been meet (choice=E9)"
label(data$which_exclusion_has_been_m___10)="Which exclusion has been meet (choice=E10)"
label(data$which_exclusion_has_been_m___11)="Which exclusion has been meet (choice=E11)"
label(data$which_exclusion_has_been_m___12)="Which exclusion has been meet (choice=E12)"
label(data$which_exclusion_has_been_m___13)="Which exclusion has been meet (choice=E13)"
label(data$which_exclusion_has_been_m___14)="Which exclusion has been meet (choice=E14)"
label(data$which_exclusion_has_been_m___15)="Which exclusion has been meet (choice=E15)"
label(data$which_exclusion_has_been_m___16)="Which exclusion has been meet (choice=E16)"
label(data$which_exclusion_has_been_m___17)="Which exclusion has been meet (choice=E17)"
label(data$which_exclusion_has_been_m___18)="Which exclusion has been meet (choice=E18)"
label(data$which_exclusion_has_been_m___19)="Which exclusion has been meet (choice=E19)"
label(data$which_exclusion_has_been_m___20)="Which exclusion has been meet (choice=E20)"
label(data$which_exclusion_has_been_m___21)="Which exclusion has been meet (choice=E21)"
label(data$which_exclusion_has_been_m___22)="Which exclusion has been meet (choice=E22)"
label(data$randomization_group)="Randomization Group"
label(data$second_blinded_cgm)="Second blinded CGM has been inserted?"
label(data$receiver_number)="Receiver number"
label(data$sensor_number)="Sensor number:"
label(data$transmitter_number)="Transmitter number:"
label(data$glucometer_and_smpg_have_b)="GLucometer and SMPG have been reviewed?"
label(data$cmp_lab_result_has_been_re)="CMP lab result has been reviewed?"
label(data$subject_has_been_assessed)="Subject has been assessed for skin reactions?"
label(data$comment)="Comment"
label(data$has_idss_and_wpai_been_adm)="Has IDSS and WPAI been administered?"
label(data$tresiba_insulin_dose)="Tresiba insulin dose:"
label(data$insulin_aspart_dose)="Insulin aspart dose:"
label(data$visit_2_randomization_complete)="Complete?"
label(data$idss_complicated_randomization_v2)="1. Is too complicated."
label(data$idss_good_control_randomization_v2)="2. Helps me to have good blood glucose control."
label(data$idss_embarrassing_randomization_v2)="3. Is often embarrassing to use when I am in public."
label(data$idss_hassle_to_use_randomization_v2)="4. Is too much of a hassle to use."
label(data$idss_control_randomization_v2)="5. Helps me to feel more in control of my diabetes."
label(data$idss_works_well_randomization_v2)="6. Works well when I need it."
label(data$idss_expensive_randomization_v2)="7. Is too expensive."
label(data$idss_spontaneous_randomization_v2)="8. Makes it difficult to be as spontaneous as Id like to be."
label(data$idss_many_pieces_randomization_v2)="9. Has too many pieces and parts to manage."
label(data$idss_benefit_randomization_v2)="10. Doesnt really benefit me much."
label(data$idss_inconvinient_randomization_v2)="11. Is inconvenient to use when I am away from home."
label(data$idss_time_randomization_v2)="12. Takes too much time to use."
label(data$idss_hassle_to_carry_randomization_v2)="13. Is a hassle to carry around."
label(data$idss_future_randomization_v2)="14. Helps me feel more positive about the future."
label(data$cgm_satisfaction_randomization_v2)="1. Helps me feel more satisfied with how things are going with my diabetes."
label(data$cgm_think_more_randomization_v2)="2. Makes me think about diabetes more than I want to."
label(data$cgm_too_much_time_randomization_v2)="3. Takes too much time to use."
label(data$cgm_accurate_randomization_v2)="4. Doesnt seem to be as accurate as I would like it to be."
label(data$cgm_worry_randomization_v2)="5. Make me worry a lot."
label(data$cgm_hassle_randomization_v2)="6. Is too much of a hassle to use"
label(data$cgm_trust_randomization_v2)="7. Gives me numbers that I dont entirely trust."
label(data$cgm_restriction_randomization_v2)="8. Helps me feel less restricted by diabetes."
label(data$cgm_frustration_randomization_v2)="9. Makes me feel more frustrated with my diabetes."
label(data$cgm_spontaneous_randomization_v2)="10. Helps me be more spontaneous in my life."
label(data$cgm_bruises_randomization_v2)="11. Causes too many skin irritations or bruises."
label(data$cgm_no_sense_randomization_v2)="12. Often gives me results that dont make sense."
label(data$cgm_depressed_randomization_v2)="13. Makes me feel more down and depressed."
label(data$cgm_experiences_randomization_v2)="14. Helps me be more open to new experiences in life."
label(data$cgm_painful_randomization_v2)="15. Is too painful to use."
label(data$v2_randomization_insulin_delivery_satisfaction_sur_complete)="Complete?"
label(data$wpai_employed_v2)="1. Are you currently employed (working for pay)?"
label(data$wpai_missed_work_v2)="2. During the past seven days, how many hours did you miss from work because of problems associated with your PROBLEM? Include hours you missed on sick days, times you went in late, left early, etc., because of your PROBLEM. DO not include time you missed to participate in this study. "
label(data$wpai_time_off_v2)="3. During the past seven days, how many hours did you miss from work because of any other reason, such as vacation, holidays, time off to participate in this study?"
label(data$wpai_productivity_v2)="4. During the past seven days, how much did your PROBLEM affect your productivity while you were working?"
label(data$wpai_productivity_while_work_v2)="5. During the past seven days, how much did your PROBLEM affect your productivity while you were working?  Think about days  you were limited in the amount or kind of work you could do, days you accomplished less than you would like, or days you could not do your work as carefully as usual. If PROBLEM affected your work only a little, choose a low number. Choose a high number if PROBLEM affected your work a great deal.   Consider only how much PROBLEM affected productivity while you were working."
label(data$wpai_productivity_regular_activity_v2)="5. During the past seven days, how much did your PROBLEM affect your ability to do your regular daily activities, other than work at a job?  By regular activities, we mean the usual activities you do, such as work around the house, shopping, childcare, exercising, studying,etc. Think about times you were limited in the amount or kind of activities you could do and times you accomplished less than you would like.  If PROBLEM affected your activities only a little, choose a low number. Choose a high number if PROBLEM affected your work a great deal.   Consider only how much PROBLEM affected your ability to do your regular daily activities, other than work at a job."
label(data$v2_randomization_work_productivity_and_activity_im_complete)="Complete?"
label(data$date_and_time_of_phone_cal_p1)="Date and time of phone call"
label(data$any_cases_of_severe_hyperg_p1)="Any cases of severe hyperglycemia?"
label(data$comment_hyperglycemia_p1)="Comment:"
label(data$any_cases_of_severe_hypogl_p1)="Any cases of severe hypoglycemia?"
label(data$comment_hypoglycemia_p1)="Comment:"
label(data$any_cases_of_skin_reaction_p1)="Any cases of skin reactions around CGM site?"
label(data$comment_skin_reaction_p1)="Comment"
label(data$reassessment_of_insulin_do_p1)="Reassessment of insulin dose and administration:"
label(data$for_group_2_patient_has_be_p1)="For group 2, basal rate has been changed to 75%."
label(data$comment_csii_p1)="Comment"
label(data$phone_call_1_complete)="Complete?"
label(data$date_and_time_of_phone_cal_p2)="Date and time of phone call"
label(data$any_cases_of_severe_hyperg_p2)="Any cases of severe hyperglycemia?"
label(data$comment_hyperglycemia_p2)="Comment:"
label(data$any_cases_of_severe_hypogl_p2)="Any cases of severe hypoglycemia?"
label(data$comment_hypoglycemia_p2)="Comment:"
label(data$any_cases_of_skin_reaction_p2)="Any cases of skin reactions around CGM site?"
label(data$comment_skin_reaction_p2)="Comment"
label(data$reassessment_of_insulin_do_p2)="Reassessment of insulin dose and administration:"
label(data$for_group_2_patient_has_be)="For group 2, patient has been instructed to discontinue CSII and initiate insulin aspart based on carb ratio and correction factor."
label(data$comment_csii)="Comment"
label(data$phone_call_2_complete)="Complete?"
label(data$date_of_visit)="Date of visit:"
label(data$download_blinded_cgm_v3)="Has CGM been downloaded?"
label(data$glucometer_and_smpg_have_b_v3)="GLucometer and SMPG have been reviewed?"
label(data$cmp_lab_result_has_been_re_v3)="Blood has been collected for CMP?"
label(data$date_and_time_of_collectio)="Date and time of collection:"
label(data$is_subject_a_wocbp)="Is subject a WOCBP?"
label(data$date_and_time_of_collection_urine)="Date and time of collection:"
label(data$pregnancy_test_result)="Pregnancy test result"
label(data$subject_has_been_assessed_v3)="Subject has been assessed for skin reactions?"
label(data$comment_v3)="Comment"
label(data$has_idss_and_wpai_been_adm_v3)="Has IDSS and WPAI been administered?"
label(data$insulin_preclinical_use_v3)="Has subject been successfully transitioned back to preclinical CSII use?"
label(data$visit_3_complete)="Complete?"
label(data$wpai_employed_v3)="1. Are you currently employed (working for pay)?"
label(data$wpai_missed_work_v3)="2. During the past seven days, how many hours did you miss from work because of problems associated with your PROBLEM? Include hours you missed on sick days, times you went in late, left early, etc., because of your PROBLEM. DO not include time you missed to participate in this study. "
label(data$wpai_time_off_v3)="3. During the past seven days, how many hours did you miss from work because of any other reason, such as vacation, holidays, time off to participate in this study?"
label(data$wpai_productivity_v3)="4. During the past seven days, how much did your PROBLEM affect your productivity while you were working?"
label(data$wpai_productivity_while_work_v3)="5. During the past seven days, how much did your PROBLEM affect your productivity while you were working?  Think about days  you were limited in the amount or kind of work you could do, days you accomplished less than you would like, or days you could not do your work as carefully as usual. If PROBLEM affected your work only a little, choose a low number. Choose a high number if PROBLEM affected your work a great deal.   Consider only how much PROBLEM affected productivity while you were working."
label(data$wpai_productivity_regular_activity_v3)="5. During the past seven days, how much did your PROBLEM affect your ability to do your regular daily activities, other than work at a job?  By regular activities, we mean the usual activities you do, such as work around the house, shopping, childcare, exercising, studying,etc. Think about times you were limited in the amount or kind of activities you could do and times you accomplished less than you would like.  If PROBLEM affected your activities only a little, choose a low number. Choose a high number if PROBLEM affected your work a great deal.   Consider only how much PROBLEM affected your ability to do your regular daily activities, other than work at a job."
label(data$v3_work_productivity_and_activity_impairment_quest_complete)="Complete?"
label(data$idss_complicated_v3)="1. Is too complicated."
label(data$idss_good_control_v3)="2. Helps me to have good blood glucose control."
label(data$idss_embarrassing_v3)="3. Is often embarrassing to use when I am in public."
label(data$idss_hassle_to_use_v3)="4. Is too much of a hassle to use."
label(data$idss_control_v3)="5. Helps me to feel more in control of my diabetes."
label(data$idss_works_well_v3)="6. Works well when I need it."
label(data$idss_expensive_v3)="7. Is too expensive."
label(data$idss_spontaneous_v3)="8. Makes it difficult to be as spontaneous as Id like to be."
label(data$idss_many_pieces_v3)="9. Has too many pieces and parts to manage."
label(data$idss_benefit_v3)="10. Doesnt really benefit me much."
label(data$idss_inconvinient_v3)="11. Is inconvenient to use when I am away from home."
label(data$idss_time_v3)="12. Takes too much time to use."
label(data$idss_hassle_to_carry_v3)="13. Is a hassle to carry around."
label(data$idss_future_v3)="14. Helps me feel more positive about the future."
label(data$cgm_satisfaction_v3)="1. Helps me feel more satisfied with how things are going with my diabetes."
label(data$cgm_think_more_v3)="2. Makes me think about diabetes more than I want to."
label(data$cgm_too_much_time_v3)="3. Takes too much time to use."
label(data$cgm_accurate_v3)="4. Doesnt seem to be as accurate as I would like it to be."
label(data$cgm_worry_v3)="5. Make me worry a lot."
label(data$cgm_hassle_v3)="6. Is too much of a hassle to use"
label(data$cgm_trust_v3)="7. Gives me numbers that I dont entirely trust."
label(data$cgm_restriction_v3)="8. Helps me feel less restricted by diabetes."
label(data$cgm_frustration_v3)="9. Makes me feel more frustrated with my diabetes."
label(data$cgm_spontaneous_v3)="10. Helps me be more spontaneous in my life."
label(data$cgm_bruises_v3)="11. Causes too many skin irritations or bruises."
label(data$cgm_no_sense_v3)="12. Often gives me results that dont make sense."
label(data$cgm_depressed_v3)="13. Makes me feel more down and depressed."
label(data$cgm_experiences_v3)="14. Helps me be more open to new experiences in life."
label(data$cgm_painful_v3)="15. Is too painful to use."
label(data$v3_insulin_delivery_satisfaction_survey_complete)="Complete?"
label(data$date_and_time_of_phone_cal)="Date and time of phone call"
label(data$any_cases_of_severe_hyperg)="Any cases of severe hyperglycemia?"
label(data$comment_hyperglycemia)="Comment:"
label(data$any_cases_of_severe_hypogl)="Any cases of severe hypoglycemia?"
label(data$comment_hypoglycemia)="Comment:"
label(data$any_cases_of_skin_reaction)="Any cases of skin reactions around CGM site?"
label(data$comment_skin_reaction)="Comment"
label(data$reassessment_of_insulin_do)="Reassessment of insulin dose and administration:"
label(data$phone_call_3_complete)="Complete?"
label(data$ae)="AE "
label(data$start_date_ae)="Start date and time"
label(data$end_date_and_time)="End date and time"
label(data$severity)="Severity"
label(data$relationship_to_blinded_de)="Relationship to Blinded Dexcom G6"
label(data$relationship_to_insulin_as)="Relationship to Insulin Aspart"
label(data$action_taken_with_blinded)="Action taken with blinded Dexcom G6"
label(data$action_taken_with_insulin)="Action taken with insulin aspart"
label(data$action_taken_with_degludec)="Action taken with insulin Degludec"
label(data$assessment_of_outcome)="Assessment of Outcome"
label(data$is_the_ae_serious)="Is the AE serious?"
label(data$ae_narrative)="AE Narrative"
label(data$ae_is_serious_due_to_check___1)="AE is serious due to (Check all that apply) (choice=Death)"
label(data$ae_is_serious_due_to_check___2)="AE is serious due to (Check all that apply) (choice=Life threatening)"
label(data$ae_is_serious_due_to_check___3)="AE is serious due to (Check all that apply) (choice=New/Prolonged in-patient hospitalization)"
label(data$ae_is_serious_due_to_check___4)="AE is serious due to (Check all that apply) (choice=Persistent or Significantly disability)"
label(data$ae_is_serious_due_to_check___5)="AE is serious due to (Check all that apply) (choice=Congenital Anomaly/Birth defect)"
label(data$ae_is_serious_due_to_check___6)="AE is serious due to (Check all that apply) (choice=Is an important medical event)"
label(data$concomitant_treatment_ther___1)="Concomitant treatment/therapy introduced? (choice=Yes)"
label(data$concomitant_treatment_ther___2)="Concomitant treatment/therapy introduced? (choice=No)"
label(data$did_this_lead_to_study_ter___1)="Did this lead to study termination? (choice=Yes)"
label(data$did_this_lead_to_study_ter___2)="Did this lead to study termination? (choice=No)"
label(data$sae_narrative)="SAE Narrative"
label(data$adverse_event_form_complete)="Complete?"
label(data$ae_description)="1. AE description"
label(data$ae_log_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$i01.factor = factor(data$i01,levels=c("1","2"))
data$i02.factor = factor(data$i02,levels=c("1","2"))
data$i03.factor = factor(data$i03,levels=c("1","2"))
data$i04.factor = factor(data$i04,levels=c("1","2"))
data$i05.factor = factor(data$i05,levels=c("1","2"))
data$i06.factor = factor(data$i06,levels=c("1","2"))
data$i07.factor = factor(data$i07,levels=c("1","2"))
data$i08.factor = factor(data$i08,levels=c("1","2"))
data$i09.factor = factor(data$i09,levels=c("1","2"))
data$i10.factor = factor(data$i10,levels=c("1","2"))
data$e01.factor = factor(data$e01,levels=c("1","2"))
data$e02.factor = factor(data$e02,levels=c("1","2"))
data$e03.factor = factor(data$e03,levels=c("1","2"))
data$e04.factor = factor(data$e04,levels=c("1","2"))
data$e05.factor = factor(data$e05,levels=c("1","2"))
data$e06.factor = factor(data$e06,levels=c("1","2"))
data$e07.factor = factor(data$e07,levels=c("1","2"))
data$e08.factor = factor(data$e08,levels=c("1","2"))
data$e09.factor = factor(data$e09,levels=c("1","2"))
data$e10.factor = factor(data$e10,levels=c("1","2"))
data$e11.factor = factor(data$e11,levels=c("1","2"))
data$e12.factor = factor(data$e12,levels=c("1","2"))
data$e13.factor = factor(data$e13,levels=c("1","2"))
data$e14.factor = factor(data$e14,levels=c("1","2"))
data$e15.factor = factor(data$e15,levels=c("1","2"))
data$e16.factor = factor(data$e16,levels=c("1","2"))
data$e17.factor = factor(data$e17,levels=c("1","2"))
data$e18.factor = factor(data$e18,levels=c("1","2"))
data$e19.factor = factor(data$e19,levels=c("1","2"))
data$e20.factor = factor(data$e20,levels=c("1","2"))
data$e21.factor = factor(data$e21,levels=c("1","2"))
data$e22.factor = factor(data$e22,levels=c("1","2"))
data$pregnancy.factor = factor(data$pregnancy,levels=c("1","2"))
data$visit_1_screening_complete.factor = factor(data$visit_1_screening_complete,levels=c("0","1","2"))
data$idss_complicated.factor = factor(data$idss_complicated,levels=c("1","2","3","4","5"))
data$idss_good_control.factor = factor(data$idss_good_control,levels=c("1","2","3","4","5"))
data$idss_embarrassing.factor = factor(data$idss_embarrassing,levels=c("1","2","3","4","5"))
data$idss_hassle_to_use.factor = factor(data$idss_hassle_to_use,levels=c("1","2","3","4","5"))
data$idss_control.factor = factor(data$idss_control,levels=c("1","2","3","4","5"))
data$idss_works_well.factor = factor(data$idss_works_well,levels=c("1","2","3","4","5"))
data$idss_expensive.factor = factor(data$idss_expensive,levels=c("1","2","3","4","5"))
data$idss_spontaneous.factor = factor(data$idss_spontaneous,levels=c("1","2","3","4","5"))
data$idss_many_pieces.factor = factor(data$idss_many_pieces,levels=c("1","2","3","4","5"))
data$idss_benefit.factor = factor(data$idss_benefit,levels=c("1","2","3","4","5"))
data$idss_inconvinient.factor = factor(data$idss_inconvinient,levels=c("1","2","3","4","5"))
data$idss_time.factor = factor(data$idss_time,levels=c("1","2","3","4","5"))
data$idss_hassle_to_carry.factor = factor(data$idss_hassle_to_carry,levels=c("1","2","3","4","5"))
data$idss_future.factor = factor(data$idss_future,levels=c("1","2","3","4","5"))
data$cgm_satisfaction.factor = factor(data$cgm_satisfaction,levels=c("1","2","3","4","5"))
data$cgm_think_more.factor = factor(data$cgm_think_more,levels=c("1","2","3","4","5"))
data$cgm_too_much_time.factor = factor(data$cgm_too_much_time,levels=c("1","2","3","4","5"))
data$cgm_accurate.factor = factor(data$cgm_accurate,levels=c("1","2","3","4","5"))
data$cgm_worry.factor = factor(data$cgm_worry,levels=c("1","2","3","4","5"))
data$cgm_hassle.factor = factor(data$cgm_hassle,levels=c("1","2","3","4","5"))
data$cgm_trust.factor = factor(data$cgm_trust,levels=c("1","2","3","4","5"))
data$cgm_restriction.factor = factor(data$cgm_restriction,levels=c("1","2","3","4","5"))
data$cgm_frustration.factor = factor(data$cgm_frustration,levels=c("1","2","3","4","5"))
data$cgm_spontaneous.factor = factor(data$cgm_spontaneous,levels=c("1","2","3","4","5"))
data$cgm_bruises.factor = factor(data$cgm_bruises,levels=c("1","2","3","4","5"))
data$cgm_no_sense.factor = factor(data$cgm_no_sense,levels=c("1","2","3","4","5"))
data$cgm_depressed.factor = factor(data$cgm_depressed,levels=c("1","2","3","4","5"))
data$cgm_experiences.factor = factor(data$cgm_experiences,levels=c("1","2","3","4","5"))
data$cgm_painful.factor = factor(data$cgm_painful,levels=c("1","2","3","4","5"))
data$v1_insulin_delivery_satisfaction_survey_complete.factor = factor(data$v1_insulin_delivery_satisfaction_survey_complete,levels=c("0","1","2"))
data$wpai_employed.factor = factor(data$wpai_employed,levels=c("1","2"))
data$wpai_productivity_while_work.factor = factor(data$wpai_productivity_while_work,levels=c("1","2","3","4","5","6","7","8","9","10","11"))
data$wpai_regular_activity.factor = factor(data$wpai_regular_activity,levels=c("1","2","3","4","5","6","7","8","9","10","11"))
data$v1_work_productivity_and_activity_impairment_quest_complete.factor = factor(data$v1_work_productivity_and_activity_impairment_quest_complete,levels=c("0","1","2"))
data$gold_score.factor = factor(data$gold_score,levels=c("1","2","3","4","5","6","7"))
data$v1_gold_questionnaire_complete.factor = factor(data$v1_gold_questionnaire_complete,levels=c("0","1","2"))
data$gender.factor = factor(data$gender,levels=c("1","2","3"))
data$martial_status.factor = factor(data$martial_status,levels=c("1","2","3","4","5","6","7"))
data$education.factor = factor(data$education,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"))
data$employment_status.factor = factor(data$employment_status,levels=c("1","2","3","4","5","6","7"))
data$insurance_private.factor = factor(data$insurance_private,levels=c("1","2"))
data$insurance_medicare.factor = factor(data$insurance_medicare,levels=c("1","2"))
data$insurance_medicaid.factor = factor(data$insurance_medicaid,levels=c("1","2"))
data$insurance_medical.factor = factor(data$insurance_medical,levels=c("1","2"))
data$insurance_no_answer.factor = factor(data$insurance_no_answer,levels=c("1","2"))
data$pcp.factor = factor(data$pcp,levels=c("1","0"))
data$household_income.factor = factor(data$household_income,levels=c("1","2","3","4","5","6","7","8","9","10","11"))
data$family_diabetes.factor = factor(data$family_diabetes,levels=c("1","0"))
data$insulin_pump.factor = factor(data$insulin_pump,levels=c("1","2","3","4","5"))
data$diabetes_meds.factor = factor(data$diabetes_meds,levels=c("1","0"))
data$cgm.factor = factor(data$cgm,levels=c("1","0"))
data$cgm_type.factor = factor(data$cgm_type,levels=c("1","2","3","4","5","6"))
data$diab_conditions___1.factor = factor(data$diab_conditions___1,levels=c("0","1"))
data$diab_conditions___2.factor = factor(data$diab_conditions___2,levels=c("0","1"))
data$diab_conditions___3.factor = factor(data$diab_conditions___3,levels=c("0","1"))
data$diab_conditions___4.factor = factor(data$diab_conditions___4,levels=c("0","1"))
data$diab_conditions___5.factor = factor(data$diab_conditions___5,levels=c("0","1"))
data$v1_baseline_demographic_questionnaire_complete.factor = factor(data$v1_baseline_demographic_questionnaire_complete,levels=c("0","1","2"))
data$ongoing_pre_existing.factor = factor(data$ongoing_pre_existing,levels=c("1","2"))
data$ongoing_2_pre_existing.factor = factor(data$ongoing_2_pre_existing,levels=c("1","2"))
data$ongoing_3_pre_existing.factor = factor(data$ongoing_3_pre_existing,levels=c("1","2"))
data$ongoing_4_pre_existing.factor = factor(data$ongoing_4_pre_existing,levels=c("1","2"))
data$ongoing_5_pre_existing.factor = factor(data$ongoing_5_pre_existing,levels=c("1","2"))
data$ongoing_6_pre_existing.factor = factor(data$ongoing_6_pre_existing,levels=c("1","2"))
data$ongoing_7_pre_existing.factor = factor(data$ongoing_7_pre_existing,levels=c("1","2"))
data$ongoing_8_pre_existing.factor = factor(data$ongoing_8_pre_existing,levels=c("1","2"))
data$ongoing_9_pre_existing.factor = factor(data$ongoing_9_pre_existing,levels=c("1","2"))
data$ongoing_10_pre_existing.factor = factor(data$ongoing_10_pre_existing,levels=c("1","2"))
data$ongoing_11_pre_existing.factor = factor(data$ongoing_11_pre_existing,levels=c("1","2"))
data$ongoing_12_pre_existing.factor = factor(data$ongoing_12_pre_existing,levels=c("1","2"))
data$ongoing_13_pre_existing.factor = factor(data$ongoing_13_pre_existing,levels=c("1","2"))
data$preexisting_condition_complete.factor = factor(data$preexisting_condition_complete,levels=c("0","1","2"))
data$med_ongoing.factor = factor(data$med_ongoing,levels=c("1","2"))
data$med_ongoing_2.factor = factor(data$med_ongoing_2,levels=c("1","2"))
data$med_ongoing_3.factor = factor(data$med_ongoing_3,levels=c("1","2"))
data$med_ongoing_4.factor = factor(data$med_ongoing_4,levels=c("1","2"))
data$med_ongoing_5.factor = factor(data$med_ongoing_5,levels=c("1","2"))
data$med_ongoing_6.factor = factor(data$med_ongoing_6,levels=c("1","2"))
data$med_ongoing_7.factor = factor(data$med_ongoing_7,levels=c("1","2"))
data$med_ongoing_8.factor = factor(data$med_ongoing_8,levels=c("1","2"))
data$med_ongoing_9.factor = factor(data$med_ongoing_9,levels=c("1","2"))
data$med_ongoing_10.factor = factor(data$med_ongoing_10,levels=c("1","2"))
data$med_ongoing_11.factor = factor(data$med_ongoing_11,levels=c("1","2"))
data$med_ongoing_12.factor = factor(data$med_ongoing_12,levels=c("1","2"))
data$med_ongoing_13.factor = factor(data$med_ongoing_13,levels=c("1","2"))
data$concomitant_medication_complete.factor = factor(data$concomitant_medication_complete,levels=c("0","1","2"))
data$which_exclusion_has_been_m___1.factor = factor(data$which_exclusion_has_been_m___1,levels=c("0","1"))
data$which_exclusion_has_been_m___2.factor = factor(data$which_exclusion_has_been_m___2,levels=c("0","1"))
data$which_exclusion_has_been_m___3.factor = factor(data$which_exclusion_has_been_m___3,levels=c("0","1"))
data$which_exclusion_has_been_m___4.factor = factor(data$which_exclusion_has_been_m___4,levels=c("0","1"))
data$which_exclusion_has_been_m___5.factor = factor(data$which_exclusion_has_been_m___5,levels=c("0","1"))
data$which_exclusion_has_been_m___6.factor = factor(data$which_exclusion_has_been_m___6,levels=c("0","1"))
data$which_exclusion_has_been_m___7.factor = factor(data$which_exclusion_has_been_m___7,levels=c("0","1"))
data$which_exclusion_has_been_m___8.factor = factor(data$which_exclusion_has_been_m___8,levels=c("0","1"))
data$which_exclusion_has_been_m___9.factor = factor(data$which_exclusion_has_been_m___9,levels=c("0","1"))
data$which_exclusion_has_been_m___10.factor = factor(data$which_exclusion_has_been_m___10,levels=c("0","1"))
data$which_exclusion_has_been_m___11.factor = factor(data$which_exclusion_has_been_m___11,levels=c("0","1"))
data$which_exclusion_has_been_m___12.factor = factor(data$which_exclusion_has_been_m___12,levels=c("0","1"))
data$which_exclusion_has_been_m___13.factor = factor(data$which_exclusion_has_been_m___13,levels=c("0","1"))
data$which_exclusion_has_been_m___14.factor = factor(data$which_exclusion_has_been_m___14,levels=c("0","1"))
data$which_exclusion_has_been_m___15.factor = factor(data$which_exclusion_has_been_m___15,levels=c("0","1"))
data$which_exclusion_has_been_m___16.factor = factor(data$which_exclusion_has_been_m___16,levels=c("0","1"))
data$which_exclusion_has_been_m___17.factor = factor(data$which_exclusion_has_been_m___17,levels=c("0","1"))
data$which_exclusion_has_been_m___18.factor = factor(data$which_exclusion_has_been_m___18,levels=c("0","1"))
data$which_exclusion_has_been_m___19.factor = factor(data$which_exclusion_has_been_m___19,levels=c("0","1"))
data$which_exclusion_has_been_m___20.factor = factor(data$which_exclusion_has_been_m___20,levels=c("0","1"))
data$which_exclusion_has_been_m___21.factor = factor(data$which_exclusion_has_been_m___21,levels=c("0","1"))
data$which_exclusion_has_been_m___22.factor = factor(data$which_exclusion_has_been_m___22,levels=c("0","1"))
data$randomization_group.factor = factor(data$randomization_group,levels=c("1","2"))
data$second_blinded_cgm.factor = factor(data$second_blinded_cgm,levels=c("1","0"))
data$glucometer_and_smpg_have_b.factor = factor(data$glucometer_and_smpg_have_b,levels=c("1","0"))
data$cmp_lab_result_has_been_re.factor = factor(data$cmp_lab_result_has_been_re,levels=c("1","0"))
data$subject_has_been_assessed.factor = factor(data$subject_has_been_assessed,levels=c("1","0"))
data$has_idss_and_wpai_been_adm.factor = factor(data$has_idss_and_wpai_been_adm,levels=c("1","0"))
data$visit_2_randomization_complete.factor = factor(data$visit_2_randomization_complete,levels=c("0","1","2"))
data$idss_complicated_randomization_v2.factor = factor(data$idss_complicated_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_good_control_randomization_v2.factor = factor(data$idss_good_control_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_embarrassing_randomization_v2.factor = factor(data$idss_embarrassing_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_hassle_to_use_randomization_v2.factor = factor(data$idss_hassle_to_use_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_control_randomization_v2.factor = factor(data$idss_control_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_works_well_randomization_v2.factor = factor(data$idss_works_well_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_expensive_randomization_v2.factor = factor(data$idss_expensive_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_spontaneous_randomization_v2.factor = factor(data$idss_spontaneous_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_many_pieces_randomization_v2.factor = factor(data$idss_many_pieces_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_benefit_randomization_v2.factor = factor(data$idss_benefit_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_inconvinient_randomization_v2.factor = factor(data$idss_inconvinient_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_time_randomization_v2.factor = factor(data$idss_time_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_hassle_to_carry_randomization_v2.factor = factor(data$idss_hassle_to_carry_randomization_v2,levels=c("1","2","3","4","5"))
data$idss_future_randomization_v2.factor = factor(data$idss_future_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_satisfaction_randomization_v2.factor = factor(data$cgm_satisfaction_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_think_more_randomization_v2.factor = factor(data$cgm_think_more_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_too_much_time_randomization_v2.factor = factor(data$cgm_too_much_time_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_accurate_randomization_v2.factor = factor(data$cgm_accurate_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_worry_randomization_v2.factor = factor(data$cgm_worry_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_hassle_randomization_v2.factor = factor(data$cgm_hassle_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_trust_randomization_v2.factor = factor(data$cgm_trust_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_restriction_randomization_v2.factor = factor(data$cgm_restriction_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_frustration_randomization_v2.factor = factor(data$cgm_frustration_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_spontaneous_randomization_v2.factor = factor(data$cgm_spontaneous_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_bruises_randomization_v2.factor = factor(data$cgm_bruises_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_no_sense_randomization_v2.factor = factor(data$cgm_no_sense_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_depressed_randomization_v2.factor = factor(data$cgm_depressed_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_experiences_randomization_v2.factor = factor(data$cgm_experiences_randomization_v2,levels=c("1","2","3","4","5"))
data$cgm_painful_randomization_v2.factor = factor(data$cgm_painful_randomization_v2,levels=c("1","2","3","4","5"))
data$v2_randomization_insulin_delivery_satisfaction_sur_complete.factor = factor(data$v2_randomization_insulin_delivery_satisfaction_sur_complete,levels=c("0","1","2"))
data$wpai_employed_v2.factor = factor(data$wpai_employed_v2,levels=c("1","2"))
data$wpai_productivity_while_work_v2.factor = factor(data$wpai_productivity_while_work_v2,levels=c("1","2","3","4","5","6","7","8","9","10","11"))
data$wpai_productivity_regular_activity_v2.factor = factor(data$wpai_productivity_regular_activity_v2,levels=c("1","2","3","4","5","6","7","8","9","10","11"))
data$v2_randomization_work_productivity_and_activity_im_complete.factor = factor(data$v2_randomization_work_productivity_and_activity_im_complete,levels=c("0","1","2"))
data$any_cases_of_severe_hyperg_p1.factor = factor(data$any_cases_of_severe_hyperg_p1,levels=c("1","0"))
data$comment_hyperglycemia_p1.factor = factor(data$comment_hyperglycemia_p1,levels=c("1","0"))
data$any_cases_of_severe_hypogl_p1.factor = factor(data$any_cases_of_severe_hypogl_p1,levels=c("1","0"))
data$comment_hypoglycemia_p1.factor = factor(data$comment_hypoglycemia_p1,levels=c("1","0"))
data$any_cases_of_skin_reaction_p1.factor = factor(data$any_cases_of_skin_reaction_p1,levels=c("1","0"))
data$comment_skin_reaction_p1.factor = factor(data$comment_skin_reaction_p1,levels=c("1","0"))
data$for_group_2_patient_has_be_p1.factor = factor(data$for_group_2_patient_has_be_p1,levels=c("1","0"))
data$comment_csii_p1.factor = factor(data$comment_csii_p1,levels=c("1","0"))
data$phone_call_1_complete.factor = factor(data$phone_call_1_complete,levels=c("0","1","2"))
data$any_cases_of_severe_hyperg_p2.factor = factor(data$any_cases_of_severe_hyperg_p2,levels=c("1","0"))
data$comment_hyperglycemia_p2.factor = factor(data$comment_hyperglycemia_p2,levels=c("1","0"))
data$any_cases_of_severe_hypogl_p2.factor = factor(data$any_cases_of_severe_hypogl_p2,levels=c("1","0"))
data$comment_hypoglycemia_p2.factor = factor(data$comment_hypoglycemia_p2,levels=c("1","0"))
data$any_cases_of_skin_reaction_p2.factor = factor(data$any_cases_of_skin_reaction_p2,levels=c("1","0"))
data$comment_skin_reaction_p2.factor = factor(data$comment_skin_reaction_p2,levels=c("1","0"))
data$for_group_2_patient_has_be.factor = factor(data$for_group_2_patient_has_be,levels=c("1","0"))
data$comment_csii.factor = factor(data$comment_csii,levels=c("1","0"))
data$phone_call_2_complete.factor = factor(data$phone_call_2_complete,levels=c("0","1","2"))
data$download_blinded_cgm_v3.factor = factor(data$download_blinded_cgm_v3,levels=c("1","0"))
data$glucometer_and_smpg_have_b_v3.factor = factor(data$glucometer_and_smpg_have_b_v3,levels=c("1","0"))
data$cmp_lab_result_has_been_re_v3.factor = factor(data$cmp_lab_result_has_been_re_v3,levels=c("1","0"))
data$is_subject_a_wocbp.factor = factor(data$is_subject_a_wocbp,levels=c("1","0"))
data$pregnancy_test_result.factor = factor(data$pregnancy_test_result,levels=c("1","2"))
data$subject_has_been_assessed_v3.factor = factor(data$subject_has_been_assessed_v3,levels=c("1","0"))
data$has_idss_and_wpai_been_adm_v3.factor = factor(data$has_idss_and_wpai_been_adm_v3,levels=c("1","0"))
data$insulin_preclinical_use_v3.factor = factor(data$insulin_preclinical_use_v3,levels=c("1","0"))
data$visit_3_complete.factor = factor(data$visit_3_complete,levels=c("0","1","2"))
data$wpai_employed_v3.factor = factor(data$wpai_employed_v3,levels=c("1","2"))
data$wpai_productivity_while_work_v3.factor = factor(data$wpai_productivity_while_work_v3,levels=c("1","2","3","4","5","6","7","8","9","10","11"))
data$wpai_productivity_regular_activity_v3.factor = factor(data$wpai_productivity_regular_activity_v3,levels=c("1","2","3","4","5","6","7","8","9","10","11"))
data$v3_work_productivity_and_activity_impairment_quest_complete.factor = factor(data$v3_work_productivity_and_activity_impairment_quest_complete,levels=c("0","1","2"))
data$idss_complicated_v3.factor = factor(data$idss_complicated_v3,levels=c("1","2","3","4","5"))
data$idss_good_control_v3.factor = factor(data$idss_good_control_v3,levels=c("1","2","3","4","5"))
data$idss_embarrassing_v3.factor = factor(data$idss_embarrassing_v3,levels=c("1","2","3","4","5"))
data$idss_hassle_to_use_v3.factor = factor(data$idss_hassle_to_use_v3,levels=c("1","2","3","4","5"))
data$idss_control_v3.factor = factor(data$idss_control_v3,levels=c("1","2","3","4","5"))
data$idss_works_well_v3.factor = factor(data$idss_works_well_v3,levels=c("1","2","3","4","5"))
data$idss_expensive_v3.factor = factor(data$idss_expensive_v3,levels=c("1","2","3","4","5"))
data$idss_spontaneous_v3.factor = factor(data$idss_spontaneous_v3,levels=c("1","2","3","4","5"))
data$idss_many_pieces_v3.factor = factor(data$idss_many_pieces_v3,levels=c("1","2","3","4","5"))
data$idss_benefit_v3.factor = factor(data$idss_benefit_v3,levels=c("1","2","3","4","5"))
data$idss_inconvinient_v3.factor = factor(data$idss_inconvinient_v3,levels=c("1","2","3","4","5"))
data$idss_time_v3.factor = factor(data$idss_time_v3,levels=c("1","2","3","4","5"))
data$idss_hassle_to_carry_v3.factor = factor(data$idss_hassle_to_carry_v3,levels=c("1","2","3","4","5"))
data$idss_future_v3.factor = factor(data$idss_future_v3,levels=c("1","2","3","4","5"))
data$cgm_satisfaction_v3.factor = factor(data$cgm_satisfaction_v3,levels=c("1","2","3","4","5"))
data$cgm_think_more_v3.factor = factor(data$cgm_think_more_v3,levels=c("1","2","3","4","5"))
data$cgm_too_much_time_v3.factor = factor(data$cgm_too_much_time_v3,levels=c("1","2","3","4","5"))
data$cgm_accurate_v3.factor = factor(data$cgm_accurate_v3,levels=c("1","2","3","4","5"))
data$cgm_worry_v3.factor = factor(data$cgm_worry_v3,levels=c("1","2","3","4","5"))
data$cgm_hassle_v3.factor = factor(data$cgm_hassle_v3,levels=c("1","2","3","4","5"))
data$cgm_trust_v3.factor = factor(data$cgm_trust_v3,levels=c("1","2","3","4","5"))
data$cgm_restriction_v3.factor = factor(data$cgm_restriction_v3,levels=c("1","2","3","4","5"))
data$cgm_frustration_v3.factor = factor(data$cgm_frustration_v3,levels=c("1","2","3","4","5"))
data$cgm_spontaneous_v3.factor = factor(data$cgm_spontaneous_v3,levels=c("1","2","3","4","5"))
data$cgm_bruises_v3.factor = factor(data$cgm_bruises_v3,levels=c("1","2","3","4","5"))
data$cgm_no_sense_v3.factor = factor(data$cgm_no_sense_v3,levels=c("1","2","3","4","5"))
data$cgm_depressed_v3.factor = factor(data$cgm_depressed_v3,levels=c("1","2","3","4","5"))
data$cgm_experiences_v3.factor = factor(data$cgm_experiences_v3,levels=c("1","2","3","4","5"))
data$cgm_painful_v3.factor = factor(data$cgm_painful_v3,levels=c("1","2","3","4","5"))
data$v3_insulin_delivery_satisfaction_survey_complete.factor = factor(data$v3_insulin_delivery_satisfaction_survey_complete,levels=c("0","1","2"))
data$any_cases_of_severe_hyperg.factor = factor(data$any_cases_of_severe_hyperg,levels=c("1","0"))
data$comment_hyperglycemia.factor = factor(data$comment_hyperglycemia,levels=c("1","0"))
data$any_cases_of_severe_hypogl.factor = factor(data$any_cases_of_severe_hypogl,levels=c("1","0"))
data$comment_hypoglycemia.factor = factor(data$comment_hypoglycemia,levels=c("1","0"))
data$any_cases_of_skin_reaction.factor = factor(data$any_cases_of_skin_reaction,levels=c("1","0"))
data$comment_skin_reaction.factor = factor(data$comment_skin_reaction,levels=c("1","0"))
data$phone_call_3_complete.factor = factor(data$phone_call_3_complete,levels=c("0","1","2"))
data$severity.factor = factor(data$severity,levels=c("1","2","3"))
data$relationship_to_blinded_de.factor = factor(data$relationship_to_blinded_de,levels=c("1","2","3","4","5"))
data$relationship_to_insulin_as.factor = factor(data$relationship_to_insulin_as,levels=c("1","2","3","4","5"))
data$action_taken_with_blinded.factor = factor(data$action_taken_with_blinded,levels=c("1","2","3","4","5"))
data$action_taken_with_insulin.factor = factor(data$action_taken_with_insulin,levels=c("1","2","3","4","5","6","7"))
data$action_taken_with_degludec.factor = factor(data$action_taken_with_degludec,levels=c("1","2","3","4","5","6","7"))
data$assessment_of_outcome.factor = factor(data$assessment_of_outcome,levels=c("1","2","3","4","5","6","7"))
data$is_the_ae_serious.factor = factor(data$is_the_ae_serious,levels=c("1","2"))
data$ae_is_serious_due_to_check___1.factor = factor(data$ae_is_serious_due_to_check___1,levels=c("0","1"))
data$ae_is_serious_due_to_check___2.factor = factor(data$ae_is_serious_due_to_check___2,levels=c("0","1"))
data$ae_is_serious_due_to_check___3.factor = factor(data$ae_is_serious_due_to_check___3,levels=c("0","1"))
data$ae_is_serious_due_to_check___4.factor = factor(data$ae_is_serious_due_to_check___4,levels=c("0","1"))
data$ae_is_serious_due_to_check___5.factor = factor(data$ae_is_serious_due_to_check___5,levels=c("0","1"))
data$ae_is_serious_due_to_check___6.factor = factor(data$ae_is_serious_due_to_check___6,levels=c("0","1"))
data$concomitant_treatment_ther___1.factor = factor(data$concomitant_treatment_ther___1,levels=c("0","1"))
data$concomitant_treatment_ther___2.factor = factor(data$concomitant_treatment_ther___2,levels=c("0","1"))
data$did_this_lead_to_study_ter___1.factor = factor(data$did_this_lead_to_study_ter___1,levels=c("0","1"))
data$did_this_lead_to_study_ter___2.factor = factor(data$did_this_lead_to_study_ter___2,levels=c("0","1"))
data$adverse_event_form_complete.factor = factor(data$adverse_event_form_complete,levels=c("0","1","2"))
data$ae_log_complete.factor = factor(data$ae_log_complete,levels=c("0","1","2"))

levels(data$i01.factor)=c("Yes","No")
levels(data$i02.factor)=c("Yes","No")
levels(data$i03.factor)=c("Yes","No")
levels(data$i04.factor)=c("Yes","No")
levels(data$i05.factor)=c("Yes","No")
levels(data$i06.factor)=c("Yes","No")
levels(data$i07.factor)=c("Yes","No")
levels(data$i08.factor)=c("Yes","No")
levels(data$i09.factor)=c("Yes","No")
levels(data$i10.factor)=c("Yes","No")
levels(data$e01.factor)=c("Yes","No")
levels(data$e02.factor)=c("Yes","No")
levels(data$e03.factor)=c("Yes","No")
levels(data$e04.factor)=c("Yes","No")
levels(data$e05.factor)=c("Yes","No")
levels(data$e06.factor)=c("Yes","No")
levels(data$e07.factor)=c("Yes","No")
levels(data$e08.factor)=c("Yes","No")
levels(data$e09.factor)=c("Yes","No")
levels(data$e10.factor)=c("Yes","No")
levels(data$e11.factor)=c("Yes","No")
levels(data$e12.factor)=c("Yes","No")
levels(data$e13.factor)=c("Yes","No")
levels(data$e14.factor)=c("Yes","No")
levels(data$e15.factor)=c("Yes","No")
levels(data$e16.factor)=c("Yes","No")
levels(data$e17.factor)=c("Yes","No")
levels(data$e18.factor)=c("Yes","No")
levels(data$e19.factor)=c("Yes","No")
levels(data$e20.factor)=c("Yes","No")
levels(data$e21.factor)=c("Yes","No")
levels(data$e22.factor)=c("Yes","No")
levels(data$pregnancy.factor)=c("Positive","Negative")
levels(data$visit_1_screening_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$idss_complicated.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_good_control.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_embarrassing.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_hassle_to_use.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_control.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_works_well.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_expensive.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_spontaneous.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_many_pieces.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_benefit.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_inconvinient.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_time.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_hassle_to_carry.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_future.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$cgm_satisfaction.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_think_more.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_too_much_time.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_accurate.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_worry.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_hassle.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_trust.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_restriction.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_frustration.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_spontaneous.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_bruises.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_no_sense.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_depressed.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_experiences.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_painful.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$v1_insulin_delivery_satisfaction_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$wpai_employed.factor)=c("Yes","No")
levels(data$wpai_productivity_while_work.factor)=c("0 (PROBLEM had no effect on my work)","1","2","3","4","5","6","7","8","9","10 (PROBLEM completely prevented me from working)")
levels(data$wpai_regular_activity.factor)=c("0 (PROBLEM had no effect on my work)","1","2","3","4","5","6","7","8","9","10 (PROBLEM completely prevented me from working)")
levels(data$v1_work_productivity_and_activity_impairment_quest_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$gold_score.factor)=c("1 (Always aware)","2","3","4","5","6","7 (Never aware)")
levels(data$v1_gold_questionnaire_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$gender.factor)=c("Male","Female","Other")
levels(data$martial_status.factor)=c("Never Married","Living together","Married","Separated","Divorced","Widowed","No answer")
levels(data$education.factor)=c("No Schooling 01","Less than or equal to 06","07","08","09 (High school)","10","11","12","13 (College)","14","15","16","17 (Graduate school)","18","19","20+","No answer")
levels(data$employment_status.factor)=c("Currently employed full or past-time","Currently retired","Currently full-time homemaker","Currently not employed","Other (student, disabled)","Never worked","No answer")
levels(data$insurance_private.factor)=c("Yes","No")
levels(data$insurance_medicare.factor)=c("Yes","No")
levels(data$insurance_medicaid.factor)=c("Yes","No")
levels(data$insurance_medical.factor)=c("Yes","No")
levels(data$insurance_no_answer.factor)=c("Yes","No")
levels(data$pcp.factor)=c("Yes","No")
levels(data$household_income.factor)=c("Less than $10,000",">$10,000-$20,000",">$20,000-$30,000",">$30,000-$40,000",">$40,000-$50,000",">$50,000-$75,000",">$75,000-$100,000",">$100,000-$150,000",">$150,000","Refused","Dont know")
levels(data$family_diabetes.factor)=c("Yes","No")
levels(data$insulin_pump.factor)=c("Medtronic insulin pump","Tandem insulin pump","Omnipod","Animas insulin pump","Other insulin pump")
levels(data$diabetes_meds.factor)=c("Yes","No")
levels(data$cgm.factor)=c("Yes","No")
levels(data$cgm_type.factor)=c("Medtronic sensor (Enlite)","Medtronic sensor (Guardian)","Flash Libre","Dexcom G4","Dexcom G5","Dexcom G6")
levels(data$diab_conditions___1.factor)=c("No","Yes")
levels(data$diab_conditions___2.factor)=c("No","Yes")
levels(data$diab_conditions___3.factor)=c("No","Yes")
levels(data$diab_conditions___4.factor)=c("No","Yes")
levels(data$diab_conditions___5.factor)=c("No","Yes")
levels(data$v1_baseline_demographic_questionnaire_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$ongoing_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_2_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_3_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_4_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_5_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_6_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_7_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_8_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_9_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_10_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_11_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_12_pre_existing.factor)=c("Yes","No")
levels(data$ongoing_13_pre_existing.factor)=c("Yes","No")
levels(data$preexisting_condition_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$med_ongoing.factor)=c("Yes","No")
levels(data$med_ongoing_2.factor)=c("Yes","No")
levels(data$med_ongoing_3.factor)=c("Yes","No")
levels(data$med_ongoing_4.factor)=c("Yes","No")
levels(data$med_ongoing_5.factor)=c("Yes","No")
levels(data$med_ongoing_6.factor)=c("Yes","No")
levels(data$med_ongoing_7.factor)=c("Yes","No")
levels(data$med_ongoing_8.factor)=c("Yes","No")
levels(data$med_ongoing_9.factor)=c("Yes","No")
levels(data$med_ongoing_10.factor)=c("Yes","No")
levels(data$med_ongoing_11.factor)=c("Yes","No")
levels(data$med_ongoing_12.factor)=c("Yes","No")
levels(data$med_ongoing_13.factor)=c("Yes","No")
levels(data$concomitant_medication_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$which_exclusion_has_been_m___1.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___2.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___3.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___4.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___5.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___6.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___7.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___8.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___9.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___10.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___11.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___12.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___13.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___14.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___15.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___16.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___17.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___18.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___19.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___20.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___21.factor)=c("Unchecked","Checked")
levels(data$which_exclusion_has_been_m___22.factor)=c("Unchecked","Checked")
levels(data$randomization_group.factor)=c("SOC","OLP")
levels(data$second_blinded_cgm.factor)=c("Yes","No")
levels(data$glucometer_and_smpg_have_b.factor)=c("Yes","No")
levels(data$cmp_lab_result_has_been_re.factor)=c("Yes","No")
levels(data$subject_has_been_assessed.factor)=c("Yes","No")
levels(data$has_idss_and_wpai_been_adm.factor)=c("Yes","No")
levels(data$visit_2_randomization_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$idss_complicated_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_good_control_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_embarrassing_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_hassle_to_use_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_control_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_works_well_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_expensive_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_spontaneous_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_many_pieces_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_benefit_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_inconvinient_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_time_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_hassle_to_carry_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_future_randomization_v2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$cgm_satisfaction_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_think_more_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_too_much_time_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_accurate_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_worry_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_hassle_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_trust_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_restriction_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_frustration_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_spontaneous_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_bruises_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_no_sense_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_depressed_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_experiences_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_painful_randomization_v2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$v2_randomization_insulin_delivery_satisfaction_sur_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$wpai_employed_v2.factor)=c("Yes","No")
levels(data$wpai_productivity_while_work_v2.factor)=c("0 (PROBLEM had no effect on my work)","1","2","3","4","5","6","7","8","9","10 (PROBLEM completely prevented me from working)")
levels(data$wpai_productivity_regular_activity_v2.factor)=c("0 (PROBLEM had no effect on my work)","1","2","3","4","5","6","7","8","9","10 (PROBLEM completely prevented me from working)")
levels(data$v2_randomization_work_productivity_and_activity_im_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$any_cases_of_severe_hyperg_p1.factor)=c("Yes","No")
levels(data$comment_hyperglycemia_p1.factor)=c("Yes","No")
levels(data$any_cases_of_severe_hypogl_p1.factor)=c("Yes","No")
levels(data$comment_hypoglycemia_p1.factor)=c("Yes","No")
levels(data$any_cases_of_skin_reaction_p1.factor)=c("Yes","No")
levels(data$comment_skin_reaction_p1.factor)=c("Yes","No")
levels(data$for_group_2_patient_has_be_p1.factor)=c("Yes","No")
levels(data$comment_csii_p1.factor)=c("Yes","No")
levels(data$phone_call_1_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$any_cases_of_severe_hyperg_p2.factor)=c("Yes","No")
levels(data$comment_hyperglycemia_p2.factor)=c("Yes","No")
levels(data$any_cases_of_severe_hypogl_p2.factor)=c("Yes","No")
levels(data$comment_hypoglycemia_p2.factor)=c("Yes","No")
levels(data$any_cases_of_skin_reaction_p2.factor)=c("Yes","No")
levels(data$comment_skin_reaction_p2.factor)=c("Yes","No")
levels(data$for_group_2_patient_has_be.factor)=c("Yes","No")
levels(data$comment_csii.factor)=c("Yes","No")
levels(data$phone_call_2_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$download_blinded_cgm_v3.factor)=c("Yes","No")
levels(data$glucometer_and_smpg_have_b_v3.factor)=c("Yes","No")
levels(data$cmp_lab_result_has_been_re_v3.factor)=c("Yes","No")
levels(data$is_subject_a_wocbp.factor)=c("Yes","No")
levels(data$pregnancy_test_result.factor)=c("Positive","Negative")
levels(data$subject_has_been_assessed_v3.factor)=c("Yes","No")
levels(data$has_idss_and_wpai_been_adm_v3.factor)=c("Yes","No")
levels(data$insulin_preclinical_use_v3.factor)=c("Yes","No")
levels(data$visit_3_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$wpai_employed_v3.factor)=c("Yes","No")
levels(data$wpai_productivity_while_work_v3.factor)=c("0 (PROBLEM had no effect on my work)","1","2","3","4","5","6","7","8","9","10 (PROBLEM completely prevented me from working)")
levels(data$wpai_productivity_regular_activity_v3.factor)=c("0 (PROBLEM had no effect on my work)","1","2","3","4","5","6","7","8","9","10 (PROBLEM completely prevented me from working)")
levels(data$v3_work_productivity_and_activity_impairment_quest_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$idss_complicated_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_good_control_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_embarrassing_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_hassle_to_use_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_control_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_works_well_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_expensive_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_spontaneous_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_many_pieces_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_benefit_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_inconvinient_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_time_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_hassle_to_carry_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$idss_future_v3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(data$cgm_satisfaction_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_think_more_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_too_much_time_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_accurate_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_worry_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_hassle_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_trust_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_restriction_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_frustration_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_spontaneous_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_bruises_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_no_sense_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_depressed_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_experiences_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$cgm_painful_v3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$v3_insulin_delivery_satisfaction_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$any_cases_of_severe_hyperg.factor)=c("Yes","No")
levels(data$comment_hyperglycemia.factor)=c("Yes","No")
levels(data$any_cases_of_severe_hypogl.factor)=c("Yes","No")
levels(data$comment_hypoglycemia.factor)=c("Yes","No")
levels(data$any_cases_of_skin_reaction.factor)=c("Yes","No")
levels(data$comment_skin_reaction.factor)=c("Yes","No")
levels(data$phone_call_3_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$severity.factor)=c("Severe","Moderate","Mild")
levels(data$relationship_to_blinded_de.factor)=c("Definitely","Probably","Possibly","Unlikely","Unrelated/Not related")
levels(data$relationship_to_insulin_as.factor)=c("Definitely","Probably","Possibly","Unlikely","Unrelated/Not related")
levels(data$action_taken_with_blinded.factor)=c("Treatment interrupted","Treatment withdrawn","No action taken","Unknown","Not applicable")
levels(data$action_taken_with_insulin.factor)=c("Dose reduced","Dose increased","Treatment interrupted","Treatment withdrawn","No action taken","Unknown","Not applicable")
levels(data$action_taken_with_degludec.factor)=c("Dose reduced","Dose increased","Treatment interrupted","Treatment withdrawn","No action taken","Unknown","Not applicable")
levels(data$assessment_of_outcome.factor)=c("Recovered","Recovering","Not recovered","Not resolved","Resolved with sequelae","Unknown","Fatal")
levels(data$is_the_ae_serious.factor)=c("Yes","No")
levels(data$ae_is_serious_due_to_check___1.factor)=c("Unchecked","Checked")
levels(data$ae_is_serious_due_to_check___2.factor)=c("Unchecked","Checked")
levels(data$ae_is_serious_due_to_check___3.factor)=c("Unchecked","Checked")
levels(data$ae_is_serious_due_to_check___4.factor)=c("Unchecked","Checked")
levels(data$ae_is_serious_due_to_check___5.factor)=c("Unchecked","Checked")
levels(data$ae_is_serious_due_to_check___6.factor)=c("Unchecked","Checked")
levels(data$concomitant_treatment_ther___1.factor)=c("Unchecked","Checked")
levels(data$concomitant_treatment_ther___2.factor)=c("Unchecked","Checked")
levels(data$did_this_lead_to_study_ter___1.factor)=c("Unchecked","Checked")
levels(data$did_this_lead_to_study_ter___2.factor)=c("Unchecked","Checked")
levels(data$adverse_event_form_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$ae_log_complete.factor)=c("Incomplete","Unverified","Complete")
