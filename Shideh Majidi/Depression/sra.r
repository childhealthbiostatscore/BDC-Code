library(Hmisc) 
#Read Data
data=read.csv('Z:/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Shideh Majidi/Depression/Data_Cleaned/sra.csv')
#Setting Labels
label(data$record_id)="Record ID"
label(data$redcap_survey_identifier)="Survey Identifier"
label(data$screen_date)="Screen Date"
label(data$time_since_screen)="Time Since Screening (in days)"
label(data$phq9_pos)="Positive PHQ-9 Score?"
label(data$si_pos)="Positive Suicidal Ideation Score?"
label(data$followupphq9)="Follow up PHQ9 positive?"
label(data$followupscore)="Score of Follow Up PHQ9?"
label(data$followupsi)="Follow up SI positive?"
label(data$remember)="Remembers Screen?"
label(data$charttreatafter)="In the Medical Chart, is there evidence of psychological treatment after the screen?"
label(data$charttreatbefore)="In the Medical Chart, is there evidence of psychological treatment BEFORE the screen?"
label(data$mrn)="MRN"
label(data$firstname)="First Name"
label(data$lastname)="Last Name"
label(data$dob)="DOB"
label(data$age)="Age at screening"
label(data$current_age)="Age on June 23, 2017"
label(data$diabetes_dx)="Diabetes Diagnosis Type"
label(data$dx_date)="Date of Diagnosis"
label(data$diabetes_duration)="Diabetes Duration"
label(data$sex)="Sex"
label(data$race)="Race"
label(data$ethnicity)="Ethnicity"
label(data$insurance)="Insurance"
label(data$other_insurance)="Other Insurance"
label(data$a1c_1yearbefore)="A1c one year before"
label(data$a1c)="A1c at time of screening"
label(data$a1c_1yearafter)="A1c one year after "
label(data$insulin_type)="What insulin regimen is the patient on "
label(data$other_regimen)="Other regimen"
label(data$pump_use)="Pump Use?"
label(data$cgm)="CGM?"
label(data$bring_meter)="Did they bring their meter?"
label(data$bring_cgm)="Did they bring their CGM?"
label(data$bg_checks)="Average Number of BG Checks Per Day"
label(data$avg_bg)="Average Blood Glucose Level at time of screening"
label(data$low_bg)="% Hypoglycemia at time of screening"
label(data$ok_bg)="% In Range at time of screening"
label(data$high_bg)="% Hyperglycemia at time of screening"
label(data$low_bg_cgm)="% Hypoglycemia on CGM at time of screening"
label(data$ok_bg_cgm)="% In Range on CGM at time of screening"
label(data$high_bg_cgm)="% Hyperglycemia on CGM at time of screening"
label(data$avg_bg_cgm)="Average Blood Glucose Level from CGM data, if possible at time of screening"
label(data$clinicvisits)="Clinic Visits in the 12 Months Prior to Screening"
label(data$metformin)="Is the Patient on Metformin?"
label(data$dka_onset)="Did the patient have DKA at onset of Diabetes?"
label(data$dka_past)="Diabetic ketoacidosis in the 12 Months Prior to Screening"
label(data$severehypo_12mo)="Severe Hypoglycemia Events in previous 12 months "
label(data$mental_health_dx)="Mental Health Diagnosis at time of screening"
label(data$mh_dx_number)="Number of Mental Health disorders"
label(data$mh_dx_class___1)="Current Mental health Classification (choice=Depression)"
label(data$mh_dx_class___2)="Current Mental health Classification (choice=Anxiety)"
label(data$mh_dx_class___3)="Current Mental health Classification (choice=ADHD)"
label(data$mh_dx_class___4)="Current Mental health Classification (choice=Autism Spectrum Disorder)"
label(data$mh_dx_class___5)="Current Mental health Classification (choice=Eating Disorders)"
label(data$mh_dx_class___6)="Current Mental health Classification (choice=Personality Disorders)"
label(data$mh_dx_class___7)="Current Mental health Classification (choice=Conduct Disorders)"
label(data$mh_dx_class___8)="Current Mental health Classification (choice=Adjustment Disorders)"
label(data$mh_dx_class___9)="Current Mental health Classification (choice=Bipolar Disorder)"
label(data$mh_dx_class___10)="Current Mental health Classification (choice=Alcohol/Substance Abuse)"
label(data$mh_dx_class___11)="Current Mental health Classification (choice=Dyslexia/Learning Disorders)"
label(data$mh_dx_class___12)="Current Mental health Classification (choice=Gender Dysphoria)"
label(data$mh_dx_class___13)="Current Mental health Classification (choice=Psychological Factors Affecting Other Medical Conditions)"
label(data$mentalhealth_type)="Mental Health Diagnoses"
label(data$mentalhealth_type_2)="Mental Health Diagnoses"
label(data$mentalhealth_type_3)="Mental Health Diagnoses"
label(data$mentalhealth_type_4)="Mental Health Diagnoses"
label(data$mentalhealth_type_5)="Mental Health Diagnoses"
label(data$mental_health_dx_before)="Mental Health Diagnosis Before Screening Ever"
label(data$mental_health_dx_before_1)="Mental Health Diagnosis Before Screening Ever"
label(data$mental_health_dx_before_2)="Mental Health Diagnosis Before Screening Ever"
label(data$mental_health_dx_before_3)="Mental Health Diagnosis Before Screening Ever"
label(data$mental_health_dx_before_4)="Mental Health Diagnosis Before Screening Ever"
label(data$mental_health_dx_before_5)="Mental Health Diagnosis Before Screening Ever"
label(data$mentalhealthtx_before)="Mental Health Treatment Before Screen "
label(data$treattype___1)="Mental Health (before) Treatment Type (choice=Therapy)"
label(data$treattype___2)="Mental Health (before) Treatment Type (choice=Medication)"
label(data$treattype___3)="Mental Health (before) Treatment Type (choice=Other)"
label(data$med_type)="Medication Name(s)"
label(data$other_treatment_1)="Other Treatment"
label(data$therapy_type_3___1)="Therapy type(s) (choice=Psychology)"
label(data$therapy_type_3___2)="Therapy type(s) (choice=Psychiatry)"
label(data$therapy_type_3___3)="Therapy type(s) (choice=Counseling/Mental Health Facility/Social Work)"
label(data$therapy_type_3___5)="Therapy type(s) (choice=School Counselor)"
label(data$therapy_type_3___4)="Therapy type(s) (choice=Other)"
label(data$other_therapy_1)="Other Therapy"
label(data$counseling_type)="Counseling Type/Notes"
label(data$mental_health_dx_after)="Mental Health New Diagnosis After Screening until 6/23/2017"
label(data$new_mental_health_dx)="New Mental Health Diagnosis After"
label(data$new_mental_health_dx_2)="New Mental Health Diagnosis After"
label(data$new_mental_health_dx_3)="New Mental Health Diagnosis After"
label(data$new_mental_health_dx_4)="New Mental Health Diagnosis After"
label(data$new_mental_health_dx_5)="New Mental Health Diagnosis After"
label(data$mentalhealthtx_after)="Mental Health Treatment After until 6/23/2017 "
label(data$treattype_3___1)="Mental Health (After) Treatment Type (choice=Therapy)"
label(data$treattype_3___2)="Mental Health (After) Treatment Type (choice=Medication)"
label(data$treattype_3___3)="Mental Health (After) Treatment Type (choice=Other)"
label(data$med_type_2)="Medication Name(s)"
label(data$other_treatment_2)="Other Treatment"
label(data$therapy_type_4___1)="Therapy type(s) (choice=Psychology)"
label(data$therapy_type_4___2)="Therapy type(s) (choice=Psychiatry)"
label(data$therapy_type_4___3)="Therapy type(s) (choice=Counseling/Mental Health Facility/Social Work)"
label(data$therapy_type_4___5)="Therapy type(s) (choice=School Counselor)"
label(data$therapy_type_4___4)="Therapy type(s) (choice=Other)"
label(data$other_therapy_2)="Other Therapy"
label(data$counseling_type_2)="Counseling Type/Notes"
label(data$psychhospital_before)="Psych Hospitalization or ED Visit Before "
label(data$hosp_visit_reason)="Reason for Hospital Visit"
label(data$hosp_psych_dx)="Psych Diagnoses for the this hospital visit"
label(data$psychhospital_after)="Psych Hospitalization After until 6/23/2017 "
label(data$hosp_visit_reason_2)="Reason for Hospital Visit"
label(data$hosp_psych_dx_2)="Psych Diagnoses for the this hospital visit"
label(data$nssi_before)="Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) Ever before the screening"
label(data$nssi_before_2___1)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) before the screening (choice=Head Banging/Hitting Self)"
label(data$nssi_before_2___2)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) before the screening (choice=Cutting)"
label(data$nssi_before_2___3)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) before the screening (choice=Burning/Erasing)"
label(data$nssi_before_2___4)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) before the screening (choice=Insulin Overdose, Non-Suicidal)"
label(data$nssi_before_2___5)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) before the screening (choice=Insulin Manipulation)"
label(data$nssi_before_2___6)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) before the screening (choice=Other)"
label(data$other_nssi_before)="Other type of non-suicidal self injury:"
label(data$nssi_after)="Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) after the screening until 6/23/2017"
label(data$nssi_after_2___1)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) After the screening (choice=Head Banging/Hitting Self)"
label(data$nssi_after_2___2)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) After the screening (choice=Cutting)"
label(data$nssi_after_2___3)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) After the screening (choice=Burning/Erasing)"
label(data$nssi_after_2___4)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) After the screening (choice=Insulin Overdose, Non-Suicidal)"
label(data$nssi_after_2___5)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) After the screening (choice=Insulin Manipulation)"
label(data$nssi_after_2___6)="Type of Non-Suicidal Self Injury (i.e. Insulin Manipulation, Cutting, etc.) After the screening (choice=Other)"
label(data$other_nssi_after)="Other type of non-suicidal self injury:"
label(data$suicideideation_before)="Suicide Ideation History Before "
label(data$si_num_before)="Number of Suicidal Ideations Recorded Before Screening "
label(data$suicideideation_before_3)="Suicide Ideation History Before screening: Date Recorded"
label(data$suicideideation_before_4)="Suicide Ideation History Before: Description "
label(data$suicideideation_after)="Suicide Ideation History After until 6/23/2017 "
label(data$si_after_num)="Number of Suicidal Ideations Recorded After Screening "
label(data$suicideideation_before_6)="Suicide Ideation History After Screening: Date Recorded"
label(data$suicideideation_before_5)="Suicide Ideation History After: Description "
label(data$suicideattempt_before)="Suicide Attempt History Ever Before "
label(data$suicideattempts_before_num)="Number of Suicide Attempts Recorded Before Screening"
label(data$suicideattempt_before_date)="When Suicide Attempt History was Recorded"
label(data$suicideattempt_before_date_2)="When Suicide Attempt Happened"
label(data$suicideattempt_after)="Suicide Attempt After the Screening until 6/23/2017"
label(data$suicideattemtps_after_num)="Number of Suicide Attempts Recorded After Screening"
label(data$suicideattempt_before_date_3)="When Suicide Attempt History was Recorded"
label(data$suicideattempt_after_date)="Suicide Attempt After Date(s) "
label(data$demographics_complete)="Complete?"
label(data$date)="Date"
label(data$phq2)="Was the patients PHQ-2 score negative?"
label(data$phq9_1)="Little interest or pleasure in doing things"
label(data$phq9_2)="Feeling down, depressed, or hopeless"
label(data$phq9_3)="Trouble falling or staying asleep, or sleeping too much"
label(data$phq9_4)="Feeling tired or having little energy"
label(data$phq9_5)="Poor appetite or overeating "
label(data$phq9_6)="Feeling bad about yourself-- or that you are a failure or have let yourself or your family down"
label(data$phq9_7)="Trouble concentrating on things, such as reading the newspaper or watching television"
label(data$phq9_8)="Moving or speaking so slowly that other people could have noticed? Or the opposite-- being so fidgety or restless that you have been moving around a lot more than usual"
label(data$phq9_9)="Thoughts that you would be better off dead or of hurting yourself in some way"
label(data$phq9_complete)="Complete?"
label(data$tot_calc_score)="Total Calculated PHQ-9 Score "
label(data$difficulty_phq9)="If you checked off any problems, how difficult have these problems made it for you to do your work, take care of things at home, or get along with other people?"
label(data$total_score_epic)="PHQ Total Score (EPIC)"
label(data$actual_score)="Actual Score"
label(data$phq9_classification)="Level of Depressive Symptoms "
label(data$total_score_complete)="Complete?"
label(data$sri_ideations_suicide)="Have you been having thoughts of suicide? ...of killing yourself?   "
label(data$sri_ideations_lastoccur)="When did last thoughts occur? "
label(data$sri_ideations_frequency)="How often do thoughts occur? "
label(data$sri_ideations_length)="How long do thoughts last? "
label(data$sri_ideations_trigger)="What triggered the thoughts? "
label(data$sri_ideations_death)="Do you think about wanting to be dead?  "
label(data$sri_ideations_death_freq)="How often do you think about wanting to be dead?  "
label(data$sri_ideations_death_length)="How long do the thoughts about wanting to be dead last?  "
label(data$sri_selfharm)="History of self-harm? "
label(data$sri_selfharm_type)="Type of self-harm "
label(data$sri_selfharm_lastoccur)="When did self-harm last occur? "
label(data$sri_suicide_pastattempt)="Have you ever attempted suicide? "
label(data$sri_suicide_past_thought)="Have you ever thought about attempting suicide? "
label(data$sri_suicide_pastattempt_thoughtabout)="Have you ever thought about attempting suicide? "
label(data$sri_suicide_pastattempt_times)="How many times have you attempted suicide? "
label(data$sri_suicide_pastattempt_type)="What method was used for attempting suicide? "
label(data$sri_suicide_pastintent_type)="Past intent to attempt suicide? "
label(data$sri_intent_current)="Current intent to attempt suicide? "
label(data$sri_intent_rating)="How strong is intent to kill yourself? "
label(data$sri_plans_past)="Have you ever had a plan to kill yourself? "
label(data$sri_plans_past_type)="What was your plan to kill yourself in the past? "
label(data$sri_plans_attempt_past_outcome)="What happened when you attempted suicide? "
label(data$sri_plans_current)="Do you have any plans to kill yourself now? "
label(data$sri_plans_type_current)="What is your plan right now to kill yourself? "
label(data$sri_means)="Do you have any means to kill yourself? "
label(data$sri_means_type)="What type of means do you have? "
label(data$sri_preparations)="Have you made any preparations for a suicide attempt? "
label(data$sri_preparations_type)="What preparations have been made? "
label(data$sri_suicide_familyhx)="Any family history of suicide? "
label(data$sri_mh_familyhx)="Any family history of mental health disorders?"
label(data$sri_suicide_familyhx_relation)="What relative died by suicide? "
label(data$sri_suicide_selfinjury)="Any family history of self-injury/harm? "
label(data$sri_confidence_rating)="How confident are you that you could attempt suicide? "
label(data$sri_feardeath_rating)="Do you feel afraid to die? "
label(data$sri_connected)="Do you feel connected to other people? Have friends? "
label(data$sri_betteroffdead)="Do you think that the people in my life would be better off if I was gone? "
label(data$sri_hopefulness_rating)="Do you feel hopeless? "
label(data$sri_stress)="Has anything stressful happened to you recently? "
label(data$sri_stress_type)="Types of stressful events "
label(data$sri_coping)="When you are feeling badly, what do you do to cope? "
label(data$sri_psychtx_psychologist_current)="Are you currently seeing a psychologist, social worker, mental health provider? "
label(data$sri_psychtx_psychologist_past)="Have you seen a psychologist, social worker, mental health provider in the past? "
label(data$sri_psychtx_psychiatrist)="Are you currently seeing a psychiatrist? "
label(data$sri_psychmeds)="Are you taking in psychiatric medications? "
label(data$sri_psychmeds_type)="Type of psychiatric medication"
label(data$sri_acuterisk_agitation)="Did patient appear agitated? "
label(data$sri_acuterisk_socialwithdrawal)="Has patient socially withdrawn? "
label(data$sri_acuterisk_insomnianightmares)="Is patient having insomnia or nightmares? "
label(data$sri_acuterisk_markedirritability)="Did patient appear markedly irritable? "
label(data$sri_acuterisk_incoherentlackclarity)="Were patients thoughts incoherent or lacking in clarity? "
label(data$sri_acuterisk_significantweightloss)="Has patient lost a significant amount of weight? "
label(data$sri_otherriskfactor_capability)="Does patient have the capability for suicide? "
label(data$sri_otherriskfactor_thwarted)="Does patient feel like s/he does not belong? "
label(data$sri_otherriskfactor_burden)="Does patient feel that s/he is a burden to others? "
label(data$sri_otherriskfactor_familyhx)="Is there a family history of suicide? "
label(data$sri_otherriskfactor_stress)="Has the patient experienced a significant amount of stress? "
label(data$sri_otherriskfactor_impulsive)="Does the patient seem/appear to be impulsive?"
label(data$suiciderisk)="Suicide Risk Classification "
label(data$actionstaken___1)="Actions Taken (choice=Will continue to monitor regularly)"
label(data$actionstaken___2)="Actions Taken (choice=Given emergency numbers)"
label(data$actionstaken___3)="Actions Taken (choice=Scheduled mid-week phone check-in)"
label(data$actionstaken___4)="Actions Taken (choice=Means restriction for any form of self-injury)"
label(data$actionstaken___5)="Actions Taken (choice=Provided info about adjunctive treatment)"
label(data$actionstaken___6)="Actions Taken (choice=safety plan)"
label(data$actionstaken___7)="Actions Taken (choice=Consulted supervisor)"
label(data$actionstaken___8)="Actions Taken (choice=Other)"
label(data$actionstaken_other)="Other"
label(data$suicide_risk_assessment_complete)="Complete?"
label(data$resource_use_survey_timestamp)="Survey Timestamp"
label(data$meeting)="After completing the depression screen, did you and/or your child meet with a provider, psychologist, social worker, or other care member to discuss the results of the screening?"
label(data$meeting_person)="Who did you meet with?"
label(data$provide_resources)="Did this person provide psychological resources (i.e. list of counselors or psychologists in Colorado)?"
label(data$provide_resources_text)="What resources were provided? "
label(data$utilize_resources)="Did you (your child) utilize any of the resources given?"
label(data$dxdepression_prior)="Were you (your child) diagnosed with depression prior to the diabetes clinic appointment and depression screen?"
label(data$therapy_prior)="Were you (your child) utilizing psychological therapy of any type prior to the diabetes clinic appointment and depression screen?"
label(data$therapy_after)="Did you (your child) start or continue therapy after the diabetes clinic appointment and depression screen? "
label(data$continuetherapy)="Are you (your child) still utilizing therapy?"
label(data$therapyfrequency_prior)="Frequency of therapy prior to the diabetes clinic appointment and positive depression screen:"
label(data$therapyduration_prior)="Duration of therapy prior to positive depression screen:"
label(data$therapyduration_after)="Duration of therapy after positive depression screen:"
label(data$therapyfrequency_after)="Frequency of therapy after the diabetes clinic appointment and positive depression screen:"
label(data$psychiatrist_prior)="Did you (your child) see a psychiatrist prior to the diabetes clinic appointment and depression screen?"
label(data$psychiatrist_after)="Did you (your child) start or continue to see a psychiatrist after the diabetes clinic appointment and depression screen?"
label(data$meds_prior)="Were you (your child) prescribed psychological medications prior to the diabetes clinic appointment and depression screen?"
label(data$meds_after)="Were you (your child) prescribed psychological medications after the diabetes clinic appointment and depression screen?"
label(data$inpatient_prior)="Did you (your child) receive in-patient psychological treatment prior to the diabetes clinic appointment and depression screen? (e.g. psych hospitalizations, eating disorder centers)"
label(data$inpatient_after)="Did you (your child) receive in-patient psychological treatment after the diabetes clinic appointment and depression screen?"
label(data$other_treatment)="Did you (your child) receive any psychological condition treatment not mentioned?"
label(data$other_treat_description)="Please describe the treatment:"
label(data$prior_freq_1)="Utilize therapy with a social worker, therapist, or counselor"
label(data$prior_freq_2)="Utilize therapy with a psychologist"
label(data$prior_freq_3)="Visit a psychiatrist"
label(data$prior_freq_4)="Take medications for psychological conditions (i.e. depression)"
label(data$prior_freq_5)="Have a hospitalization or in-patient care for psychological conditions"
label(data$prior_freq_6)="Use other resources for treatment of depression"
label(data$prior_duration_1)="Utilize therapy with a social worker, therapist, or counselor"
label(data$prior_duration_2)="Utilize therapy with a psychologist"
label(data$prior_duration_3)="Visit a psychiatrist"
label(data$prior_duration_4)="Take medications for psychological conditions (i.e. depression)"
label(data$prior_duration_5)="Have a hospitalization or in-patient care for psychological conditions"
label(data$prior_duration_6)="Use other resources for treatment of depression"
label(data$after_freq_1)="Utilize therapy with a social worker, therapist, or counselor"
label(data$after_freq_2)="Utilize therapy with a psychologist"
label(data$after_freq_3)="Visit a psychiatrist"
label(data$after_freq_4)="Take medications for psychological conditions (i.e. depression)"
label(data$after_freq_5)="Have a hospitalization or in-patient care for psychological conditions"
label(data$after_freq_6)="Use other resources for treatment of depression"
label(data$after_dur_1)="Utilize therapy with a social worker, therapist, or counselor"
label(data$after_dur_2)="Utilize therapy with a psychologist"
label(data$after_dur_3)="Visit a psychiatrist"
label(data$after_dur_4)="Take medications for psychological conditions (i.e. depression)"
label(data$after_dur_5)="Have a hospitalization or in-patient care for psychological conditions"
label(data$after_dur_6)="Use other resources for treatment of depression"
label(data$resource_use_survey_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$phq9_pos.factor = factor(data$phq9_pos,levels=c("1","0"))
data$si_pos.factor = factor(data$si_pos,levels=c("1","0"))
data$followupphq9.factor = factor(data$followupphq9,levels=c("1","0"))
data$remember.factor = factor(data$remember,levels=c("1","0"))
data$charttreatafter.factor = factor(data$charttreatafter,levels=c("1","0"))
data$charttreatbefore.factor = factor(data$charttreatbefore,levels=c("1","0"))
data$diabetes_dx.factor = factor(data$diabetes_dx,levels=c("1","2","3","4","5"))
data$sex.factor = factor(data$sex,levels=c("0","1","2","3"))
data$race.factor = factor(data$race,levels=c("1","2","3","4","5","6","7","8"))
data$ethnicity.factor = factor(data$ethnicity,levels=c("0","1","2"))
data$insurance.factor = factor(data$insurance,levels=c("1","2","3","4","6","7","5"))
data$insulin_type.factor = factor(data$insulin_type,levels=c("1","2","3","4","5","6","99"))
data$pump_use.factor = factor(data$pump_use,levels=c("1","0","2","99"))
data$cgm.factor = factor(data$cgm,levels=c("1","0","2","99"))
data$bring_meter.factor = factor(data$bring_meter,levels=c("1","0","2","99"))
data$bring_cgm.factor = factor(data$bring_cgm,levels=c("1","0","2"))
data$metformin.factor = factor(data$metformin,levels=c("1","0","2","99"))
data$dka_onset.factor = factor(data$dka_onset,levels=c("1","0"))
data$mental_health_dx.factor = factor(data$mental_health_dx,levels=c("1","0"))
data$mh_dx_class___1.factor = factor(data$mh_dx_class___1,levels=c("0","1"))
data$mh_dx_class___2.factor = factor(data$mh_dx_class___2,levels=c("0","1"))
data$mh_dx_class___3.factor = factor(data$mh_dx_class___3,levels=c("0","1"))
data$mh_dx_class___4.factor = factor(data$mh_dx_class___4,levels=c("0","1"))
data$mh_dx_class___5.factor = factor(data$mh_dx_class___5,levels=c("0","1"))
data$mh_dx_class___6.factor = factor(data$mh_dx_class___6,levels=c("0","1"))
data$mh_dx_class___7.factor = factor(data$mh_dx_class___7,levels=c("0","1"))
data$mh_dx_class___8.factor = factor(data$mh_dx_class___8,levels=c("0","1"))
data$mh_dx_class___9.factor = factor(data$mh_dx_class___9,levels=c("0","1"))
data$mh_dx_class___10.factor = factor(data$mh_dx_class___10,levels=c("0","1"))
data$mh_dx_class___11.factor = factor(data$mh_dx_class___11,levels=c("0","1"))
data$mh_dx_class___12.factor = factor(data$mh_dx_class___12,levels=c("0","1"))
data$mh_dx_class___13.factor = factor(data$mh_dx_class___13,levels=c("0","1"))
data$mental_health_dx_before.factor = factor(data$mental_health_dx_before,levels=c("1","0"))
data$mentalhealthtx_before.factor = factor(data$mentalhealthtx_before,levels=c("1","0"))
data$treattype___1.factor = factor(data$treattype___1,levels=c("0","1"))
data$treattype___2.factor = factor(data$treattype___2,levels=c("0","1"))
data$treattype___3.factor = factor(data$treattype___3,levels=c("0","1"))
data$therapy_type_3___1.factor = factor(data$therapy_type_3___1,levels=c("0","1"))
data$therapy_type_3___2.factor = factor(data$therapy_type_3___2,levels=c("0","1"))
data$therapy_type_3___3.factor = factor(data$therapy_type_3___3,levels=c("0","1"))
data$therapy_type_3___5.factor = factor(data$therapy_type_3___5,levels=c("0","1"))
data$therapy_type_3___4.factor = factor(data$therapy_type_3___4,levels=c("0","1"))
data$mental_health_dx_after.factor = factor(data$mental_health_dx_after,levels=c("1","0"))
data$mentalhealthtx_after.factor = factor(data$mentalhealthtx_after,levels=c("1","0"))
data$treattype_3___1.factor = factor(data$treattype_3___1,levels=c("0","1"))
data$treattype_3___2.factor = factor(data$treattype_3___2,levels=c("0","1"))
data$treattype_3___3.factor = factor(data$treattype_3___3,levels=c("0","1"))
data$therapy_type_4___1.factor = factor(data$therapy_type_4___1,levels=c("0","1"))
data$therapy_type_4___2.factor = factor(data$therapy_type_4___2,levels=c("0","1"))
data$therapy_type_4___3.factor = factor(data$therapy_type_4___3,levels=c("0","1"))
data$therapy_type_4___5.factor = factor(data$therapy_type_4___5,levels=c("0","1"))
data$therapy_type_4___4.factor = factor(data$therapy_type_4___4,levels=c("0","1"))
data$psychhospital_before.factor = factor(data$psychhospital_before,levels=c("1","0"))
data$psychhospital_after.factor = factor(data$psychhospital_after,levels=c("1","0"))
data$nssi_before.factor = factor(data$nssi_before,levels=c("1","0"))
data$nssi_before_2___1.factor = factor(data$nssi_before_2___1,levels=c("0","1"))
data$nssi_before_2___2.factor = factor(data$nssi_before_2___2,levels=c("0","1"))
data$nssi_before_2___3.factor = factor(data$nssi_before_2___3,levels=c("0","1"))
data$nssi_before_2___4.factor = factor(data$nssi_before_2___4,levels=c("0","1"))
data$nssi_before_2___5.factor = factor(data$nssi_before_2___5,levels=c("0","1"))
data$nssi_before_2___6.factor = factor(data$nssi_before_2___6,levels=c("0","1"))
data$nssi_after.factor = factor(data$nssi_after,levels=c("1","0"))
data$nssi_after_2___1.factor = factor(data$nssi_after_2___1,levels=c("0","1"))
data$nssi_after_2___2.factor = factor(data$nssi_after_2___2,levels=c("0","1"))
data$nssi_after_2___3.factor = factor(data$nssi_after_2___3,levels=c("0","1"))
data$nssi_after_2___4.factor = factor(data$nssi_after_2___4,levels=c("0","1"))
data$nssi_after_2___5.factor = factor(data$nssi_after_2___5,levels=c("0","1"))
data$nssi_after_2___6.factor = factor(data$nssi_after_2___6,levels=c("0","1"))
data$suicideideation_before.factor = factor(data$suicideideation_before,levels=c("1","0"))
data$suicideideation_after.factor = factor(data$suicideideation_after,levels=c("1","0"))
data$suicideattempt_before.factor = factor(data$suicideattempt_before,levels=c("1","0"))
data$suicideattempt_after.factor = factor(data$suicideattempt_after,levels=c("1","0"))
data$demographics_complete.factor = factor(data$demographics_complete,levels=c("0","1","2"))
data$phq2.factor = factor(data$phq2,levels=c("1","2","3"))
data$phq9_1.factor = factor(data$phq9_1,levels=c("0","1","2","3","00"))
data$phq9_2.factor = factor(data$phq9_2,levels=c("0","1","2","3","00"))
data$phq9_3.factor = factor(data$phq9_3,levels=c("0","1","2","3","00"))
data$phq9_4.factor = factor(data$phq9_4,levels=c("0","1","2","3","00"))
data$phq9_5.factor = factor(data$phq9_5,levels=c("0","1","2","3","00"))
data$phq9_6.factor = factor(data$phq9_6,levels=c("0","1","2","3","00"))
data$phq9_7.factor = factor(data$phq9_7,levels=c("0","1","2","3","00"))
data$phq9_8.factor = factor(data$phq9_8,levels=c("0","1","2","3","00"))
data$phq9_9.factor = factor(data$phq9_9,levels=c("0","1","2","3","00"))
data$phq9_complete.factor = factor(data$phq9_complete,levels=c("0","1","2"))
data$difficulty_phq9.factor = factor(data$difficulty_phq9,levels=c("0","1","2","3","4"))
data$phq9_classification.factor = factor(data$phq9_classification,levels=c("1","2","3","4"))
data$total_score_complete.factor = factor(data$total_score_complete,levels=c("0","1","2"))
data$sri_ideations_suicide.factor = factor(data$sri_ideations_suicide,levels=c("0","1","2"))
data$sri_ideations_death.factor = factor(data$sri_ideations_death,levels=c("0","1","2"))
data$sri_selfharm.factor = factor(data$sri_selfharm,levels=c("0","1","2"))
data$sri_suicide_pastattempt.factor = factor(data$sri_suicide_pastattempt,levels=c("0","1","2"))
data$sri_suicide_past_thought.factor = factor(data$sri_suicide_past_thought,levels=c("0","1","2"))
data$sri_suicide_pastattempt_thoughtabout.factor = factor(data$sri_suicide_pastattempt_thoughtabout,levels=c("0","1","2"))
data$sri_intent_rating.factor = factor(data$sri_intent_rating,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
data$sri_plans_past.factor = factor(data$sri_plans_past,levels=c("0","1","2"))
data$sri_plans_current.factor = factor(data$sri_plans_current,levels=c("0","1","2"))
data$sri_means.factor = factor(data$sri_means,levels=c("0","1","2"))
data$sri_preparations.factor = factor(data$sri_preparations,levels=c("1","0"))
data$sri_suicide_familyhx.factor = factor(data$sri_suicide_familyhx,levels=c("1","0"))
data$sri_mh_familyhx.factor = factor(data$sri_mh_familyhx,levels=c("1","0"))
data$sri_suicide_selfinjury.factor = factor(data$sri_suicide_selfinjury,levels=c("1","0"))
data$sri_confidence_rating.factor = factor(data$sri_confidence_rating,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
data$sri_feardeath_rating.factor = factor(data$sri_feardeath_rating,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
data$sri_betteroffdead.factor = factor(data$sri_betteroffdead,levels=c("1","0"))
data$sri_hopefulness_rating.factor = factor(data$sri_hopefulness_rating,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
data$sri_stress.factor = factor(data$sri_stress,levels=c("1","0"))
data$sri_psychtx_psychologist_current.factor = factor(data$sri_psychtx_psychologist_current,levels=c("1","0"))
data$sri_psychtx_psychologist_past.factor = factor(data$sri_psychtx_psychologist_past,levels=c("1","0"))
data$sri_psychtx_psychiatrist.factor = factor(data$sri_psychtx_psychiatrist,levels=c("1","0"))
data$sri_psychmeds.factor = factor(data$sri_psychmeds,levels=c("1","0"))
data$sri_acuterisk_agitation.factor = factor(data$sri_acuterisk_agitation,levels=c("1","0"))
data$sri_acuterisk_socialwithdrawal.factor = factor(data$sri_acuterisk_socialwithdrawal,levels=c("1","0"))
data$sri_acuterisk_insomnianightmares.factor = factor(data$sri_acuterisk_insomnianightmares,levels=c("1","0"))
data$sri_acuterisk_markedirritability.factor = factor(data$sri_acuterisk_markedirritability,levels=c("1","0"))
data$sri_acuterisk_incoherentlackclarity.factor = factor(data$sri_acuterisk_incoherentlackclarity,levels=c("1","0"))
data$sri_acuterisk_significantweightloss.factor = factor(data$sri_acuterisk_significantweightloss,levels=c("1","0"))
data$sri_otherriskfactor_capability.factor = factor(data$sri_otherriskfactor_capability,levels=c("1","0"))
data$sri_otherriskfactor_thwarted.factor = factor(data$sri_otherriskfactor_thwarted,levels=c("1","0"))
data$sri_otherriskfactor_burden.factor = factor(data$sri_otherriskfactor_burden,levels=c("1","0"))
data$sri_otherriskfactor_familyhx.factor = factor(data$sri_otherriskfactor_familyhx,levels=c("1","0"))
data$sri_otherriskfactor_stress.factor = factor(data$sri_otherriskfactor_stress,levels=c("1","0"))
data$sri_otherriskfactor_impulsive.factor = factor(data$sri_otherriskfactor_impulsive,levels=c("1","0"))
data$suiciderisk.factor = factor(data$suiciderisk,levels=c("1","2","3","4"))
data$actionstaken___1.factor = factor(data$actionstaken___1,levels=c("0","1"))
data$actionstaken___2.factor = factor(data$actionstaken___2,levels=c("0","1"))
data$actionstaken___3.factor = factor(data$actionstaken___3,levels=c("0","1"))
data$actionstaken___4.factor = factor(data$actionstaken___4,levels=c("0","1"))
data$actionstaken___5.factor = factor(data$actionstaken___5,levels=c("0","1"))
data$actionstaken___6.factor = factor(data$actionstaken___6,levels=c("0","1"))
data$actionstaken___7.factor = factor(data$actionstaken___7,levels=c("0","1"))
data$actionstaken___8.factor = factor(data$actionstaken___8,levels=c("0","1"))
data$suicide_risk_assessment_complete.factor = factor(data$suicide_risk_assessment_complete,levels=c("0","1","2"))
data$meeting.factor = factor(data$meeting,levels=c("1","0"))
data$meeting_person.factor = factor(data$meeting_person,levels=c("1","2","3","4","5","6","99"))
data$provide_resources.factor = factor(data$provide_resources,levels=c("1","0"))
data$utilize_resources.factor = factor(data$utilize_resources,levels=c("1","0"))
data$dxdepression_prior.factor = factor(data$dxdepression_prior,levels=c("1","0"))
data$therapy_prior.factor = factor(data$therapy_prior,levels=c("1","0"))
data$therapy_after.factor = factor(data$therapy_after,levels=c("1","0"))
data$continuetherapy.factor = factor(data$continuetherapy,levels=c("1","0"))
data$therapyfrequency_prior.factor = factor(data$therapyfrequency_prior,levels=c("1","2","3","4","5"))
data$therapyduration_prior.factor = factor(data$therapyduration_prior,levels=c("1","2","3","4","5","6"))
data$therapyduration_after.factor = factor(data$therapyduration_after,levels=c("1","2","3","4","5","6"))
data$therapyfrequency_after.factor = factor(data$therapyfrequency_after,levels=c("1","2","3","4","5"))
data$psychiatrist_prior.factor = factor(data$psychiatrist_prior,levels=c("1","0"))
data$psychiatrist_after.factor = factor(data$psychiatrist_after,levels=c("1","0"))
data$meds_prior.factor = factor(data$meds_prior,levels=c("1","0"))
data$meds_after.factor = factor(data$meds_after,levels=c("1","0"))
data$inpatient_prior.factor = factor(data$inpatient_prior,levels=c("1","0"))
data$inpatient_after.factor = factor(data$inpatient_after,levels=c("1","0"))
data$other_treatment.factor = factor(data$other_treatment,levels=c("1","0"))
data$prior_freq_1.factor = factor(data$prior_freq_1,levels=c("0","1","2","3","4","5"))
data$prior_freq_2.factor = factor(data$prior_freq_2,levels=c("0","1","2","3","4","5"))
data$prior_freq_3.factor = factor(data$prior_freq_3,levels=c("0","1","2","3","4","5"))
data$prior_freq_4.factor = factor(data$prior_freq_4,levels=c("0","1","2","3","4","5"))
data$prior_freq_5.factor = factor(data$prior_freq_5,levels=c("0","1","2","3","4","5"))
data$prior_freq_6.factor = factor(data$prior_freq_6,levels=c("0","1","2","3","4","5"))
data$prior_duration_1.factor = factor(data$prior_duration_1,levels=c("0","1","2","3","4","5","6"))
data$prior_duration_2.factor = factor(data$prior_duration_2,levels=c("0","1","2","3","4","5","6"))
data$prior_duration_3.factor = factor(data$prior_duration_3,levels=c("0","1","2","3","4","5","6"))
data$prior_duration_4.factor = factor(data$prior_duration_4,levels=c("0","1","2","3","4","5","6"))
data$prior_duration_5.factor = factor(data$prior_duration_5,levels=c("0","1","2","3","4","5","6"))
data$prior_duration_6.factor = factor(data$prior_duration_6,levels=c("0","1","2","3","4","5","6"))
data$after_freq_1.factor = factor(data$after_freq_1,levels=c("0","1","2","3","4","5"))
data$after_freq_2.factor = factor(data$after_freq_2,levels=c("0","1","2","3","4","5"))
data$after_freq_3.factor = factor(data$after_freq_3,levels=c("0","1","2","3","4","5"))
data$after_freq_4.factor = factor(data$after_freq_4,levels=c("0","1","2","3","4","5"))
data$after_freq_5.factor = factor(data$after_freq_5,levels=c("0","1","2","3","4","5"))
data$after_freq_6.factor = factor(data$after_freq_6,levels=c("0","1","2","3","4","5"))
data$after_dur_1.factor = factor(data$after_dur_1,levels=c("0","1","2","3","4","5","6"))
data$after_dur_2.factor = factor(data$after_dur_2,levels=c("0","1","2","3","4","5","6"))
data$after_dur_3.factor = factor(data$after_dur_3,levels=c("0","1","2","3","4","5","6"))
data$after_dur_4.factor = factor(data$after_dur_4,levels=c("0","1","2","3","4","5","6"))
data$after_dur_5.factor = factor(data$after_dur_5,levels=c("0","1","2","3","4","5","6"))
data$after_dur_6.factor = factor(data$after_dur_6,levels=c("0","1","2","3","4","5","6"))
data$resource_use_survey_complete.factor = factor(data$resource_use_survey_complete,levels=c("0","1","2"))
data$followupsi <- factor(data$followupsi,levels=c(0,1))

levels(data$phq9_pos.factor)=c("Yes","No")
levels(data$si_pos.factor)=c("Yes","No")
levels(data$followupphq9.factor)=c("Yes","No")
levels(data$remember.factor)=c("Yes","No")
levels(data$charttreatafter.factor)=c("Yes","No")
levels(data$charttreatbefore.factor)=c("Yes","No")
levels(data$diabetes_dx.factor)=c("Type 1 Diabetes","Type 2 Diabetes","MODY","Cystic Fibrosis with Diabetes","Other")
levels(data$sex.factor)=c("Female","Male","Transgender Male","Transgender Female")
levels(data$race.factor)=c("White","Black/African American","Asian","American Indian/Alaskan Native","Other","More than one Race","Unknown/Not Reported","Native Hawaiian/Other Pacific Islander")
levels(data$ethnicity.factor)=c("Non-Hispanic","Hispanic or Latino","Unknown/Not Reported")
levels(data$insurance.factor)=c("Public","Private","Tricare","No insurance","Private + Public","Other","Unknown")
levels(data$insulin_type.factor)=c("MDI","MDI+CGM","Pump","Pump+CGM","NPH","Other","No visit on this date")
levels(data$pump_use.factor)=c("Yes","No","Unknown","No visit on this date")
levels(data$cgm.factor)=c("Yes","No","Unknown","No visit on this date")
levels(data$bring_meter.factor)=c("Yes","No","Unknown","No visit on this date")
levels(data$bring_cgm.factor)=c("Yes","No","Unknown")
levels(data$metformin.factor)=c("Yes","No","Unknown","No visit on this date")
levels(data$dka_onset.factor)=c("Yes","No")
levels(data$mental_health_dx.factor)=c("Yes","No")
levels(data$mh_dx_class___1.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___2.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___3.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___4.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___5.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___6.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___7.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___8.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___9.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___10.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___11.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___12.factor)=c("Unchecked","Checked")
levels(data$mh_dx_class___13.factor)=c("Unchecked","Checked")
levels(data$mental_health_dx_before.factor)=c("Yes","No")
levels(data$mentalhealthtx_before.factor)=c("Yes","No")
levels(data$treattype___1.factor)=c("Unchecked","Checked")
levels(data$treattype___2.factor)=c("Unchecked","Checked")
levels(data$treattype___3.factor)=c("Unchecked","Checked")
levels(data$therapy_type_3___1.factor)=c("Unchecked","Checked")
levels(data$therapy_type_3___2.factor)=c("Unchecked","Checked")
levels(data$therapy_type_3___3.factor)=c("Unchecked","Checked")
levels(data$therapy_type_3___5.factor)=c("Unchecked","Checked")
levels(data$therapy_type_3___4.factor)=c("Unchecked","Checked")
levels(data$mental_health_dx_after.factor)=c("Yes","No")
levels(data$mentalhealthtx_after.factor)=c("Yes","No")
levels(data$treattype_3___1.factor)=c("Unchecked","Checked")
levels(data$treattype_3___2.factor)=c("Unchecked","Checked")
levels(data$treattype_3___3.factor)=c("Unchecked","Checked")
levels(data$therapy_type_4___1.factor)=c("Unchecked","Checked")
levels(data$therapy_type_4___2.factor)=c("Unchecked","Checked")
levels(data$therapy_type_4___3.factor)=c("Unchecked","Checked")
levels(data$therapy_type_4___5.factor)=c("Unchecked","Checked")
levels(data$therapy_type_4___4.factor)=c("Unchecked","Checked")
levels(data$psychhospital_before.factor)=c("Yes","No")
levels(data$psychhospital_after.factor)=c("Yes","No")
levels(data$nssi_before.factor)=c("Yes","No")
levels(data$nssi_before_2___1.factor)=c("Unchecked","Checked")
levels(data$nssi_before_2___2.factor)=c("Unchecked","Checked")
levels(data$nssi_before_2___3.factor)=c("Unchecked","Checked")
levels(data$nssi_before_2___4.factor)=c("Unchecked","Checked")
levels(data$nssi_before_2___5.factor)=c("Unchecked","Checked")
levels(data$nssi_before_2___6.factor)=c("Unchecked","Checked")
levels(data$nssi_after.factor)=c("Yes","No")
levels(data$nssi_after_2___1.factor)=c("Unchecked","Checked")
levels(data$nssi_after_2___2.factor)=c("Unchecked","Checked")
levels(data$nssi_after_2___3.factor)=c("Unchecked","Checked")
levels(data$nssi_after_2___4.factor)=c("Unchecked","Checked")
levels(data$nssi_after_2___5.factor)=c("Unchecked","Checked")
levels(data$nssi_after_2___6.factor)=c("Unchecked","Checked")
levels(data$suicideideation_before.factor)=c("Yes","No")
levels(data$suicideideation_after.factor)=c("Yes","No")
levels(data$suicideattempt_before.factor)=c("Yes","No")
levels(data$suicideattempt_after.factor)=c("Yes","No")
levels(data$demographics_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$phq2.factor)=c("Negative PHQ-2 score","Positive PHQ-2 score","Did not take PHQ-2")
levels(data$phq9_1.factor)=c("Not at all","Several days","More than half the days","Nearly every day","Did not Answer")
levels(data$phq9_2.factor)=c("Not at all","Several days","More than half the days","Nearly every day","Did not Answer")
levels(data$phq9_3.factor)=c("Not at all","Several days","More than half the days","Nearly every day","Did not Answer")
levels(data$phq9_4.factor)=c("Not at all","Several days","More than half the days","Nearly every day","Did not Answer")
levels(data$phq9_5.factor)=c("Not at all","Several days","More than half the days","Nearly every day","Did not Answer")
levels(data$phq9_6.factor)=c("Not at all","Several days","More than half the days","Nearly every day","Did not Answer")
levels(data$phq9_7.factor)=c("Not at all","Several days","More than half the days","Nearly every day","Did not Answer")
levels(data$phq9_8.factor)=c("Not at all","Several days","More than half the days","Nearly every day","Did not Answer")
levels(data$phq9_9.factor)=c("Not at all","Several days","More than half the days","Nearly every day","Did not Answer")
levels(data$phq9_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$difficulty_phq9.factor)=c("Not difficult at all","Somewhat difficult","Very difficult","Extremely difficult","Did not answer")
levels(data$phq9_classification.factor)=c("Minimal","Mild","Moderately Severe","Severe")
levels(data$total_score_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$sri_ideations_suicide.factor)=c("No","Yes","Unknown")
levels(data$sri_ideations_death.factor)=c("No","Yes","Unknown")
levels(data$sri_selfharm.factor)=c("No","Yes","Unknown")
levels(data$sri_suicide_pastattempt.factor)=c("No","Yes","Unknown")
levels(data$sri_suicide_past_thought.factor)=c("No","Yes","Unknown")
levels(data$sri_suicide_pastattempt_thoughtabout.factor)=c("No","Yes","Unknown")
levels(data$sri_intent_rating.factor)=c("0 No Intent","1","2","3","4","5","6","7","8","9","10 Very Strong Intent")
levels(data$sri_plans_past.factor)=c("No","Yes","Unknown")
levels(data$sri_plans_current.factor)=c("No","Yes","Unknown")
levels(data$sri_means.factor)=c("No","Yes","Unknown")
levels(data$sri_preparations.factor)=c("Yes","No")
levels(data$sri_suicide_familyhx.factor)=c("Yes","No")
levels(data$sri_mh_familyhx.factor)=c("Yes","No")
levels(data$sri_suicide_selfinjury.factor)=c("Yes","No")
levels(data$sri_confidence_rating.factor)=c("0 Not at all Confident","1","2","3","4","5","6","7","8","9","10 Very Confident")
levels(data$sri_feardeath_rating.factor)=c("0 Not at all Afraid","1","2","3","4","5","6","7","8","9","10 Very Afraid")
levels(data$sri_betteroffdead.factor)=c("Yes","No")
levels(data$sri_hopefulness_rating.factor)=c("0 Very Hopeless","1","2","3","4","5","6","7","8","9","10 Very Hopeful")
levels(data$sri_stress.factor)=c("Yes","No")
levels(data$sri_psychtx_psychologist_current.factor)=c("Yes","No")
levels(data$sri_psychtx_psychologist_past.factor)=c("Yes","No")
levels(data$sri_psychtx_psychiatrist.factor)=c("Yes","No")
levels(data$sri_psychmeds.factor)=c("Yes","No")
levels(data$sri_acuterisk_agitation.factor)=c("Yes","No")
levels(data$sri_acuterisk_socialwithdrawal.factor)=c("Yes","No")
levels(data$sri_acuterisk_insomnianightmares.factor)=c("Yes","No")
levels(data$sri_acuterisk_markedirritability.factor)=c("Yes","No")
levels(data$sri_acuterisk_incoherentlackclarity.factor)=c("Yes","No")
levels(data$sri_acuterisk_significantweightloss.factor)=c("Yes","No")
levels(data$sri_otherriskfactor_capability.factor)=c("Yes","No")
levels(data$sri_otherriskfactor_thwarted.factor)=c("Yes","No")
levels(data$sri_otherriskfactor_burden.factor)=c("Yes","No")
levels(data$sri_otherriskfactor_familyhx.factor)=c("Yes","No")
levels(data$sri_otherriskfactor_stress.factor)=c("Yes","No")
levels(data$sri_otherriskfactor_impulsive.factor)=c("Yes","No")
levels(data$suiciderisk.factor)=c("Low","Moderate","Severe","Extreme")
levels(data$actionstaken___1.factor)=c("Unchecked","Checked")
levels(data$actionstaken___2.factor)=c("Unchecked","Checked")
levels(data$actionstaken___3.factor)=c("Unchecked","Checked")
levels(data$actionstaken___4.factor)=c("Unchecked","Checked")
levels(data$actionstaken___5.factor)=c("Unchecked","Checked")
levels(data$actionstaken___6.factor)=c("Unchecked","Checked")
levels(data$actionstaken___7.factor)=c("Unchecked","Checked")
levels(data$actionstaken___8.factor)=c("Unchecked","Checked")
levels(data$suicide_risk_assessment_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$meeting.factor)=c("Yes","No")
levels(data$meeting_person.factor)=c("Physician","Nurse Practitioner (NP)","Physician Assistant (PA)","Psychologist","Psychology Intern","Social Worker","Dont remember/Didnt see anyone")
levels(data$provide_resources.factor)=c("Yes","No")
levels(data$utilize_resources.factor)=c("Yes","No")
levels(data$dxdepression_prior.factor)=c("Yes","No")
levels(data$therapy_prior.factor)=c("Yes","No")
levels(data$therapy_after.factor)=c("Yes","No")
levels(data$continuetherapy.factor)=c("Yes","No")
levels(data$therapyfrequency_prior.factor)=c("Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$therapyduration_prior.factor)=c("< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$therapyduration_after.factor)=c("< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$therapyfrequency_after.factor)=c("Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$psychiatrist_prior.factor)=c("Yes","No")
levels(data$psychiatrist_after.factor)=c("Yes","No")
levels(data$meds_prior.factor)=c("Yes","No")
levels(data$meds_after.factor)=c("Yes","No")
levels(data$inpatient_prior.factor)=c("Yes","No")
levels(data$inpatient_after.factor)=c("Yes","No")
levels(data$other_treatment.factor)=c("Yes","No")
levels(data$prior_freq_1.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$prior_freq_2.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$prior_freq_3.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$prior_freq_4.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$prior_freq_5.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$prior_freq_6.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$prior_duration_1.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$prior_duration_2.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$prior_duration_3.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$prior_duration_4.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$prior_duration_5.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$prior_duration_6.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$after_freq_1.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$after_freq_2.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$after_freq_3.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$after_freq_4.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$after_freq_5.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$after_freq_6.factor)=c("Never","Inconsistently (as needed)","Less than once/month","Once/Month to less often than once a week","Once/week","More than once/week")
levels(data$after_dur_1.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$after_dur_2.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$after_dur_3.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$after_dur_4.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$after_dur_5.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$after_dur_6.factor)=c("Never","< 1 month","1 to < 3 months","3 to < 6 Months","6 months to < 1 year","1 year to < 5 years",">5 years")
levels(data$resource_use_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$followupsi)=c("No","Yes")
# Drop levels
data$race.factor <- droplevels(data$race.factor)
data$sex.factor <- droplevels(data$sex.factor)
data$insurace.factor <- droplevels(data$insurance.factor)
data$pump_use.factor <- droplevels(data$pump_use.factor)
data$cgm.factor <- droplevels(data$cgm.factor)
# Collapse race, ethnicity, and insurance levels
levels(data$race.factor) <- c("White","Non-white","Non-white",
                              "Non-white","Non-white","Non-white")
levels(data$ethnicity.factor) <- c("Non-Hispanic/Unknown","Hispanic or Latino","Non-Hispanic/Unknown")
levels(data$insurance.factor) <- c("Other","Private","Other","Other","Other","Other","Other")
