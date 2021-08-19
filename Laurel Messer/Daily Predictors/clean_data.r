#Read Data
data=read.csv('./Laurel Messer/Daily Predictors/Data_Raw//DailyPredictorsForDi_DATA_2021-08-19_1235.csv',na.strings = "")
#Setting Labels

label(data$record_id)="Record ID"
label(data$redcap_event_name)="Event Name"
label(data$redcap_survey_identifier)="Survey Identifier"
label(data$pt_name)="Participant Name"
label(data$alerts___1)="Where do you receive your alerts? (choice=Pump)"
label(data$alerts___2)="Where do you receive your alerts? (choice=Phone)"
label(data$alerts___3)="Where do you receive your alerts? (choice=Receiver)"
label(data$cgm_downloads___1)="Do you download your CGM at home? If yes, to what software? (choice=Clarity)"
label(data$cgm_downloads___2)="Do you download your CGM at home? If yes, to what software? (choice=Carelink)"
label(data$cgm_downloads___3)="Do you download your CGM at home? If yes, to what software? (choice=T:Connect)"
label(data$cgm_downloads___4)="Do you download your CGM at home? If yes, to what software? (choice=Glooko)"
label(data$cgm_downloads___5)="Do you download your CGM at home? If yes, to what software? (choice=Tidepool)"
label(data$c1)="Reiterate importance of wearing CGM every day, all day, replacing immediately as required"
label(data$c2)="Set high alert to 250 mg/dl (all other alerts optional)"
label(data$c3)="Check time and date on pump (must be within 1 minute of phone time)"
label(data$c4)="Check time and date on CGM (must be within 1 minute of phone time)"
label(data$c5)="Check time and date on smart pen (must be within 1 minute of phone time)"
label(data$c6)="Confirm test survey received"
label(data$c7)="Have participant add study number (720-477-6646) to contacts"
label(data$c8)="Reminder to immediately complete surveys"
label(data$c9)="Reminder to complete all surveys"
label(data$dg1)="Part of this study is to see how well you feel you can meet your diabetes goals each day. Do you currently have a diabetes goal that you strive for each day?"
label(data$dg3)="What would you like your goal to be for the next 2 weeks? "
label(data$enrollment_complete)="Complete?"
label(data$informed_consent_timestamp)="Survey Timestamp"
label(data$icf_datecapture)="Date"
label(data$agreebs1)="Agreement to be in this study and use my dataI have read this paper about the study or it was read to me. I understand the possible risks and benefits of this study. I understand and authorize the access, use and disclosure of my information as stated in this form. I know that being in this study is voluntary. I choose to be in this study: I will get a signed and dated copy of this consent form."
label(data$icf_signeddate)="Date"
label(data$pt_age)="Is participant 18 years or older?"
label(data$icf_pt_name)="Participants first  & last name:"
label(data$icf_pt_sig_18)="Participant Signature (18 years or older)"
label(data$icf_pt_assent)="Participants Signature (children 13-17 years old)"
label(data$icf_parent_name)="Parent First & Last Name"
label(data$icf_parent_sig)="Parent or guardian signature if child < 18 years old  "
label(data$informed_consent_complete)="Complete?"
label(data$demographics_timestamp)="Survey Timestamp"
label(data$pt_fname)="What is your first name?"
label(data$pt_lname)="What is your last name?"
label(data$pt_visit_date)="Date of Visit"
label(data$pt_cell)="Phone number of participant for text messaging. "
label(data$email)="Participant (or parent) email for payment"
label(data$pt_dob)="DOB"
label(data$pt_race___1)="Race (check all that apply) (choice=White)"
label(data$pt_race___2)="Race (check all that apply) (choice=Black or African American)"
label(data$pt_race___3)="Race (check all that apply) (choice=American Indian or Alaskan Native)"
label(data$pt_race___4)="Race (check all that apply) (choice=Asian)"
label(data$pt_race___5)="Race (check all that apply) (choice=Native Hawaiian or Pacific Islander)"
label(data$pt_race___6)="Race (check all that apply) (choice=Other)"
label(data$pt_eth)="What is your ethnicity? "
label(data$pt_gender)="What is your gender?"
label(data$p1_hedu)="Highest Education of Parent 1"
label(data$p2_hedu)="Highest Education of Parent 2"
label(data$demographics_complete)="Complete?"
label(data$diabetes_information_timestamp)="Survey Timestamp"
label(data$dxdate)="When were you diagnosed with diabetes? (If you dont remember the exact day, choose the 1st day of the month and year)"
label(data$pt_baseline1)="Do you currently use an insulin pump to manage your diabetes?"
label(data$pt_baseline2)="How long have you been you been using an insulin pump? "
label(data$pt_baseline3)="Which insulin pump brand do you currently use?"
label(data$pt_baseline3_model)="Which model of pump do you use?"
label(data$pt_baseline3_other)="If you selected other, what insulin pump do you use?"
label(data$pt_baseline4)="Do you use a downloadable insulin pen to give insulin?"
label(data$pt_baseline4_yes)="If YES: What type of pen?"
label(data$inpen_duration)="How long have you been using a downloadable insulin pen? "
label(data$pt_baseline5)="Do you currently use a continuous glucose monitor (i.e. CGM or glucose sensor) for your diabetes management?"
label(data$pt_baseline6)="How long have you been using a CGM for your diabetes management?"
label(data$pt_baseline7)="Which CGM brand do you currently use?"
label(data$pt_baseline7_other)="If Other, what CGM brand do you currently use?"
label(data$pt_baseline7_model)="Which Model of Sensor Do You Use?"
label(data$pt_a1c)="Last Known HbA1c"
label(data$pt_a1c_date)="Last known A1c date"
label(data$diabetes_information_complete)="Complete?"
label(data$twilio_test_survey_timestamp)="Survey Timestamp"
label(data$twiliotest)="Did you receive this survey? "
label(data$twilionumber)="Can you save this number, 720-477-6646 to your phone? "
label(data$twilio_test_survey_complete)="Complete?"
label(data$dmireq)="Were surveys completed, and is DMI form required?"
label(data$dmi_date)="Date"
label(data$cgm_review)="Software for CGM review"
label(data$insulin_review)="Software for insulin review"
label(data$cgmalerton)="Was CGM High Alert On? "
label(data$cgmalertvalue)="What Was CGM High Alert Set To?"
label(data$dmi_sensoryesno)="Was the Participant Wearing Their Sensor?"
label(data$tbr)="Time Below Range < 70mg/dL (%)"
label(data$tir)="Time in Range 70-180mg/dL (%)"
label(data$smg)="Sensor Mean Glucose"
label(data$sd)="Standard Deviation"
label(data$sensor_usage)="Percent Sensor Usage (%)"
label(data$boluses)="Number of User Initiated Boluses Given "
label(data$basal)="Units of Basal Insulin"
label(data$bolus)="Units of Bolus Insulin"
label(data$highs)="Did Patient Have a High Alert This Day?"
label(data$ha1)="High Alert #1 Time"
label(data$hab1)="Was a Bolus Given Within 30 Min of High Alert? "
label(data$bgdrop_ha1)="Did the glucose fall below 200 mg/dl within 2 hours of alert?"
label(data$ha2)="High Alert #2 Time"
label(data$hab2)="Was a Bolus Given Within 30 Min of High Alert?"
label(data$bgdrop_ha2)="Did the glucose fall below 200 mg/dl within 2 hours of alert?"
label(data$ha3)="High Alert #3 Time"
label(data$hab3)="Was a Bolus Given Within 30 Min of High Alert?"
label(data$bgdrop_ha3)="Did the glucose fall below 200 mg/dl within 2 hours of alert?"
label(data$ha4)="High Alert #4 Time"
label(data$hab4)="Was a Bolus Given Within 30 Min of High Alert?"
label(data$bgdrop_ha4)="Did the glucose fall below 200 mg/dl within 2 hours of alert?"
label(data$ha5)="High Alert #5 Time"
label(data$hab5)="Was a Bolus Given Within 30 Min of High Alert?"
label(data$bgdrop_ha5)="Did the glucose fall below 200 mg/dl within 2 hours of alert?"
label(data$ha6)="High Alert #6 Time"
label(data$hab6)="Was a Bolus Given Within 30 Min of High Alert?"
label(data$bgdrop_ha6)="Did the glucose fall below 200 mg/dl within 2 hours of alert?"
label(data$ha7)="High Alert #7 Time"
label(data$hab7)="Was a Bolus Given Within 30 Min of High Alert?"
label(data$bgdrop_ha7)="Did the glucose fall below 200 mg/dl within 2 hours of alert?"
label(data$ha8)="High Alert #8 Time"
label(data$hab8)="Was a Bolus Given Within 30 Min of High Alert?"
label(data$bgdrop_ha8)="Did the glucose fall below 200 mg/dl within 2 hours of alert?"
label(data$ha9)="High Alert #9 Time"
label(data$hab9)="Was a Bolus Given Within 30 Min of High Alert?"
label(data$bgdrop_ha9)="Did the glucose fall below 200 mg/dl within 2 hours of alert?"
label(data$ha10)="High Alert #10 Time"
label(data$hab10)="Was a Bolus Given Within 30 Min of High Alert?"
label(data$bgdrop_ha10)="Did the glucose fall below 200 mg/dl within 2 hours of alert?"
label(data$diabetes_management_indicators_complete)="Complete?"
label(data$morning_engagement_survey_timestamp)="Survey Timestamp"
label(data$es_datetimecapture)="Datetime "
label(data$esq1)="What is your current glucose level on your CGM? "
label(data$esq2)="How many hours of sleep did you get last night? "
label(data$esq3)="I slept well last night"
label(data$esq4)="How happy are you feeling right now?"
label(data$esq5)="How sad are you feeling right now?"
label(data$esq6)="How nervous/stressed are you feeling right now?"
label(data$esq7)="I am planning on managing my diabetes today"
label(data$esq8)="I intend to manage my diabetes today"
label(data$esq9)="I am interested in managing my diabetes today"
label(data$esq10)="I want to manage my diabetes today"
label(data$esq11)="Do you feel that you can control important things?"
label(data$esq12)="Do you feel that you are able to handle difficulties?"
label(data$esq13)="Do you feel like others are willing to be helpful?"
label(data$esq14)="Do you feel accepted and cared for?"
label(data$esq16)="Are you experiencing stress related to school?"
label(data$esq17)="Are you experiencing stress related to family or friends?"
label(data$esq18)="Are you experiencing stress related to too many things to do?"
label(data$esq19)="Are you experiencing stress related to money?"
label(data$esq20)="Are you experiencing stress related to medical care?"
label(data$esq21)="Do you feel like skipping diabetes self-management activities because you feel fine?"
label(data$esq22)="Do you feel too sick to manage your diabetes?"
label(data$esq23)="I feel good about who I am"
label(data$esq24)="I feel good about myself"
label(data$esq25)="In general, would you say your health right now is: "
label(data$esq26)="Do you think you could use some extra support for your diabetes management today? "
label(data$morning_engagement_survey_complete)="Complete?"
label(data$goal_survey_timestamp)="Survey Timestamp"
label(data$gs_datetimecapture)="GS Datetime "
label(data$n_highalerts)="How many high alerts do you think you received today?"
label(data$dm_caretime)="How many minutes do you think you spent caring for your diabetes today?"
label(data$dm_thinktime)="How many minutes do you think you spent thinking about your diabetes today?"
label(data$gsq1)="I tried very hard to make progress toward my T1D goal today"
label(data$gsq2)="I tried not to let other people get in the way of my work on my T1D goal today."
label(data$gsq3)="I was able to meet my diabetes goals today"
label(data$goal_survey_complete)="Complete?"
label(data$evening_engagement_survey_timestamp)="Survey Timestamp"
label(data$es_datetimecapture_eve)="Datetime "
label(data$esq1_eve)="What is your current glucose level on your CGM? "
label(data$esq3_eve)="I slept well last night"
label(data$esq4_eve)="How happy are you feeling right now?"
label(data$esq5_eve)="How sad are you feeling right now?"
label(data$esq6_eve)="How nervous/stressed are you feeling right now?"
label(data$esq7_eve)="I am planning on managing my diabetes today"
label(data$esq8_eve)="I intend to manage my diabetes today"
label(data$esq9_eve)="I am interested in managing my diabetes today"
label(data$esq10_eve)="I want to manage my diabetes today"
label(data$esq11_eve)="Do you feel that you can control important things?"
label(data$esq12_eve)="Do you feel that you are able to handle difficulties?"
label(data$esq13_eve)="Do you feel like others are willing to be helpful?"
label(data$esq14_eve)="Do you feel accepted and cared for?"
label(data$esq16_eve)="Are you experiencing stress related to school?"
label(data$esq17_eve)="Are you experiencing stress related to family or friends?"
label(data$esq18_eve)="Are you experiencing stress related to too many things to do?"
label(data$esq19_eve)="Are you experiencing stress related to money?"
label(data$esq20_eve)="Are you experiencing stress related to medical care?"
label(data$esq21_eve)="Do you feel like skipping diabetes self-management activities because you feel fine?"
label(data$esq22_eve)="Do you feel too sick to manage your diabetes?"
label(data$esq23_eve)="I feel good about who I am"
label(data$esq24_eve)="I feel good about myself"
label(data$esq25_eve)="In general, would you say your health right now is: "
label(data$evening_engagement_survey_complete)="Complete?"
label(data$withdraw)="Did participant withdraw from the study? "
label(data$withdrawal_date)="Withdrawal Date"
label(data$withdrawal_reason)="Reason for Withdrawal  "
label(data$surveystop)="Have Surveys Been Discontinued?"
label(data$withdrawl_complete)="Complete?"
label(data$reminder_to_upload_timestamp)="Survey Timestamp"
label(data$uploadagree)="Can you upload your pump and CGM today or tomorrow so we can pay you for your participation? "
label(data$reminder_to_upload_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("screening__enrollm_arm_1","sd1e_pd1_arm_1","sd2_pd2_arm_1","sd2e_pd2_arm_1","sd3_pd3_arm_1","sd3e_pd3_arm_1","sd4_pd4_arm_1","sd4e_pd4_arm_1","sd5e_pd11_arm_1","sd6_pd12_arm_1","sd6e_pd12_arm_1","sd7_pd13_arm_1","sd7e_pd13_arm_1","sd8_pd14_arm_1","sd8e_pd14_arm_1","screening__enrollm_arm_2","sd1e_pd3_arm_2","sd2_pd4_arm_2","sd2e_pd4_arm_2","sd3_pd5_arm_2","sd3e_pd5_arm_2","sd4_pd6_arm_2","sd4e_pd6_arm_2","sd5e_pd8_arm_2","sd6_pd9_arm_2","sd6e_pd9_arm_2","sd7_pd10_arm_2","sd7e_pd10_arm_2","sd8_pd11_arm_2","sd8e_pd11_arm_2","screening__enrollm_arm_3","sd1e_pd2_arm_3","sd2_pd3_arm_3","sd2e_pd3_arm_3","sd3_pd4_arm_3","sd3e_pd4_arm_3","sd4_pd5_arm_3","sd4e_pd5_arm_3","sd5e_pd11_arm_3","sd6_pd12_arm_3","sd6e_pd12_arm_3","sd7_pd13_arm_3","sd7e_pd13_arm_3","sd8_pd14_arm_3","sd8e_pd14_arm_3","screening__enrollm_arm_4","sd1e_pd1_arm_4","sd2_pd2_arm_4","sd2e_pd2_arm_4","sd3_pd3_arm_4","sd3e_pd3_arm_4","sd4_pd4_arm_4","sd4e_pd4_arm_4","sd5e_pd9_arm_4","sd6_pd10_arm_4","sd6e_pd10_arm_4","sd7_pd11_arm_4","sd7e_pd11_arm_4","sd8_pd12_arm_4","sd8e_pd12_arm_4"))
data$alerts___1.factor = factor(data$alerts___1,levels=c("0","1"))
data$alerts___2.factor = factor(data$alerts___2,levels=c("0","1"))
data$alerts___3.factor = factor(data$alerts___3,levels=c("0","1"))
data$cgm_downloads___1.factor = factor(data$cgm_downloads___1,levels=c("0","1"))
data$cgm_downloads___2.factor = factor(data$cgm_downloads___2,levels=c("0","1"))
data$cgm_downloads___3.factor = factor(data$cgm_downloads___3,levels=c("0","1"))
data$cgm_downloads___4.factor = factor(data$cgm_downloads___4,levels=c("0","1"))
data$cgm_downloads___5.factor = factor(data$cgm_downloads___5,levels=c("0","1"))
data$c1.factor = factor(data$c1,levels=c("1","2"))
data$c2.factor = factor(data$c2,levels=c("1","2"))
data$c3.factor = factor(data$c3,levels=c("1","2"))
data$c4.factor = factor(data$c4,levels=c("1","2"))
data$c5.factor = factor(data$c5,levels=c("1","2"))
data$c6.factor = factor(data$c6,levels=c("1","2"))
data$c7.factor = factor(data$c7,levels=c("1","2"))
data$c8.factor = factor(data$c8,levels=c("1","2"))
data$c9.factor = factor(data$c9,levels=c("1","2"))
data$enrollment_complete.factor = factor(data$enrollment_complete,levels=c("0","1","2"))
data$agreebs1.factor = factor(data$agreebs1,levels=c("1","0"))
data$pt_age.factor = factor(data$pt_age,levels=c("1","0"))
data$informed_consent_complete.factor = factor(data$informed_consent_complete,levels=c("0","1","2"))
data$pt_race___1.factor = factor(data$pt_race___1,levels=c("0","1"))
data$pt_race___2.factor = factor(data$pt_race___2,levels=c("0","1"))
data$pt_race___3.factor = factor(data$pt_race___3,levels=c("0","1"))
data$pt_race___4.factor = factor(data$pt_race___4,levels=c("0","1"))
data$pt_race___5.factor = factor(data$pt_race___5,levels=c("0","1"))
data$pt_race___6.factor = factor(data$pt_race___6,levels=c("0","1"))
data$pt_eth.factor = factor(data$pt_eth,levels=c("1","2"))
data$pt_gender.factor = factor(data$pt_gender,levels=c("1","2","3"))
data$p1_hedu.factor = factor(data$p1_hedu,levels=c("1","2","3","4","5","6","7","8"))
data$p2_hedu.factor = factor(data$p2_hedu,levels=c("1","2","3","4","5","6","7","8"))
data$demographics_complete.factor = factor(data$demographics_complete,levels=c("0","1","2"))
data$pt_baseline1.factor = factor(data$pt_baseline1,levels=c("1","0"))
data$pt_baseline2.factor = factor(data$pt_baseline2,levels=c("1","2","3","4"))
data$pt_baseline3.factor = factor(data$pt_baseline3,levels=c("1","2","3","4","5"))
data$pt_baseline4.factor = factor(data$pt_baseline4,levels=c("1","0"))
data$inpen_duration.factor = factor(data$inpen_duration,levels=c("1","2","3","4"))
data$pt_baseline5.factor = factor(data$pt_baseline5,levels=c("1","0"))
data$pt_baseline6.factor = factor(data$pt_baseline6,levels=c("1","2","3","4"))
data$pt_baseline7.factor = factor(data$pt_baseline7,levels=c("1","2","4"))
data$pt_baseline7_model.factor = factor(data$pt_baseline7_model,levels=c("1","2","3","4","5"))
data$diabetes_information_complete.factor = factor(data$diabetes_information_complete,levels=c("0","1","2"))
data$twiliotest.factor = factor(data$twiliotest,levels=c("1","0"))
data$twilionumber.factor = factor(data$twilionumber,levels=c("1","0"))
data$twilio_test_survey_complete.factor = factor(data$twilio_test_survey_complete,levels=c("0","1","2"))
data$dmireq.factor = factor(data$dmireq,levels=c("1","0"))
data$cgm_review.factor = factor(data$cgm_review,levels=c("1","2","3","4","5"))
data$insulin_review.factor = factor(data$insulin_review,levels=c("2","3","4","5"))
data$cgmalerton.factor = factor(data$cgmalerton,levels=c("1","0"))
data$dmi_sensoryesno.factor = factor(data$dmi_sensoryesno,levels=c("1","0"))
data$highs.factor = factor(data$highs,levels=c("1","0"))
data$hab1.factor = factor(data$hab1,levels=c("1","0"))
data$bgdrop_ha1.factor = factor(data$bgdrop_ha1,levels=c("1","0"))
data$hab2.factor = factor(data$hab2,levels=c("1","0"))
data$bgdrop_ha2.factor = factor(data$bgdrop_ha2,levels=c("1","0"))
data$hab3.factor = factor(data$hab3,levels=c("1","0"))
data$bgdrop_ha3.factor = factor(data$bgdrop_ha3,levels=c("1","0"))
data$hab4.factor = factor(data$hab4,levels=c("1","0"))
data$bgdrop_ha4.factor = factor(data$bgdrop_ha4,levels=c("1","0"))
data$hab5.factor = factor(data$hab5,levels=c("1","0"))
data$bgdrop_ha5.factor = factor(data$bgdrop_ha5,levels=c("1","0"))
data$hab6.factor = factor(data$hab6,levels=c("1","0"))
data$bgdrop_ha6.factor = factor(data$bgdrop_ha6,levels=c("1","0"))
data$hab7.factor = factor(data$hab7,levels=c("1","0"))
data$bgdrop_ha7.factor = factor(data$bgdrop_ha7,levels=c("1","0"))
data$hab8.factor = factor(data$hab8,levels=c("1","0"))
data$bgdrop_ha8.factor = factor(data$bgdrop_ha8,levels=c("1","0"))
data$hab9.factor = factor(data$hab9,levels=c("1","0"))
data$bgdrop_ha9.factor = factor(data$bgdrop_ha9,levels=c("1","0"))
data$hab10.factor = factor(data$hab10,levels=c("1","0"))
data$bgdrop_ha10.factor = factor(data$bgdrop_ha10,levels=c("1","0"))
data$diabetes_management_indicators_complete.factor = factor(data$diabetes_management_indicators_complete,levels=c("0","1","2"))
data$esq3.factor = factor(data$esq3,levels=c("0","1","2","3"))
data$esq4.factor = factor(data$esq4,levels=c("0","1","2","3"))
data$esq5.factor = factor(data$esq5,levels=c("0","1","2","3"))
data$esq6.factor = factor(data$esq6,levels=c("0","1","2","3"))
data$esq7.factor = factor(data$esq7,levels=c("0","1","2","3"))
data$esq8.factor = factor(data$esq8,levels=c("0","1","2","3"))
data$esq9.factor = factor(data$esq9,levels=c("0","1","2","3"))
data$esq10.factor = factor(data$esq10,levels=c("0","1","2","3"))
data$esq11.factor = factor(data$esq11,levels=c("0","1","2","3"))
data$esq12.factor = factor(data$esq12,levels=c("0","1","2","3"))
data$esq13.factor = factor(data$esq13,levels=c("0","1","2","3"))
data$esq14.factor = factor(data$esq14,levels=c("0","1","2","3"))
data$esq16.factor = factor(data$esq16,levels=c("0","1","2","3"))
data$esq17.factor = factor(data$esq17,levels=c("0","1","2","3"))
data$esq18.factor = factor(data$esq18,levels=c("0","1","2","3"))
data$esq19.factor = factor(data$esq19,levels=c("0","1","2","3"))
data$esq20.factor = factor(data$esq20,levels=c("0","1","2","3"))
data$esq21.factor = factor(data$esq21,levels=c("0","1","2","3"))
data$esq22.factor = factor(data$esq22,levels=c("0","1","2","3"))
data$esq23.factor = factor(data$esq23,levels=c("0","1","2","3"))
data$esq24.factor = factor(data$esq24,levels=c("0","1","2","3"))
data$esq25.factor = factor(data$esq25,levels=c("1","2","3","4","5"))
data$esq26.factor = factor(data$esq26,levels=c("0","1","2","3"))
data$morning_engagement_survey_complete.factor = factor(data$morning_engagement_survey_complete,levels=c("0","1","2"))
data$gsq1.factor = factor(data$gsq1,levels=c("1","2","3","4","5"))
data$gsq2.factor = factor(data$gsq2,levels=c("1","2","3","4","5"))
data$gsq3.factor = factor(data$gsq3,levels=c("1","2","3","4","5"))
data$goal_survey_complete.factor = factor(data$goal_survey_complete,levels=c("0","1","2"))
data$esq3_eve.factor = factor(data$esq3_eve,levels=c("0","1","2","3"))
data$esq4_eve.factor = factor(data$esq4_eve,levels=c("0","1","2","3"))
data$esq5_eve.factor = factor(data$esq5_eve,levels=c("0","1","2","3"))
data$esq6_eve.factor = factor(data$esq6_eve,levels=c("0","1","2","3"))
data$esq7_eve.factor = factor(data$esq7_eve,levels=c("0","1","2","3"))
data$esq8_eve.factor = factor(data$esq8_eve,levels=c("0","1","2","3"))
data$esq9_eve.factor = factor(data$esq9_eve,levels=c("0","1","2","3"))
data$esq10_eve.factor = factor(data$esq10_eve,levels=c("0","1","2","3"))
data$esq11_eve.factor = factor(data$esq11_eve,levels=c("0","1","2","3"))
data$esq12_eve.factor = factor(data$esq12_eve,levels=c("0","1","2","3"))
data$esq13_eve.factor = factor(data$esq13_eve,levels=c("0","1","2","3"))
data$esq14_eve.factor = factor(data$esq14_eve,levels=c("0","1","2","3"))
data$esq16_eve.factor = factor(data$esq16_eve,levels=c("0","1","2","3"))
data$esq17_eve.factor = factor(data$esq17_eve,levels=c("0","1","2","3"))
data$esq18_eve.factor = factor(data$esq18_eve,levels=c("0","1","2","3"))
data$esq19_eve.factor = factor(data$esq19_eve,levels=c("0","1","2","3"))
data$esq20_eve.factor = factor(data$esq20_eve,levels=c("0","1","2","3"))
data$esq21_eve.factor = factor(data$esq21_eve,levels=c("0","1","2","3"))
data$esq22_eve.factor = factor(data$esq22_eve,levels=c("0","1","2","3"))
data$esq23_eve.factor = factor(data$esq23_eve,levels=c("0","1","2","3"))
data$esq24_eve.factor = factor(data$esq24_eve,levels=c("0","1","2","3"))
data$esq25_eve.factor = factor(data$esq25_eve,levels=c("1","2","3","4","5"))
data$evening_engagement_survey_complete.factor = factor(data$evening_engagement_survey_complete,levels=c("0","1","2"))
data$withdraw.factor = factor(data$withdraw,levels=c("1","0"))
data$surveystop.factor = factor(data$surveystop,levels=c("1","0"))
data$withdrawl_complete.factor = factor(data$withdrawl_complete,levels=c("0","1","2"))
data$uploadagree.factor = factor(data$uploadagree,levels=c("1","0"))
data$reminder_to_upload_complete.factor = factor(data$reminder_to_upload_complete,levels=c("0","1","2"))

levels(data$redcap_event_name.factor)=c("Screening & Enrollment (Arm 1: Sequence 1)","SD1E_PD1 (Arm 1: Sequence 1)","SD2_PD2 (Arm 1: Sequence 1)","SD2E_PD2 (Arm 1: Sequence 1)","SD3_PD3 (Arm 1: Sequence 1)","SD3E_PD3 (Arm 1: Sequence 1)","SD4_PD4 (Arm 1: Sequence 1)","SD4E_PD4 (Arm 1: Sequence 1)","SD5E_PD11 (Arm 1: Sequence 1)","SD6_PD12 (Arm 1: Sequence 1)","SD6E_PD12 (Arm 1: Sequence 1)","SD7_PD13 (Arm 1: Sequence 1)","SD7E_PD13 (Arm 1: Sequence 1)","SD8_PD14 (Arm 1: Sequence 1)","SD8E_PD14 (Arm 1: Sequence 1)","Screening & Enrollment (Arm 2: Sequence 2)","SD1E_PD3 (Arm 2: Sequence 2)","SD2_PD4 (Arm 2: Sequence 2)","SD2E_PD4 (Arm 2: Sequence 2)","SD3_PD5 (Arm 2: Sequence 2)","SD3E_PD5 (Arm 2: Sequence 2)","SD4_PD6 (Arm 2: Sequence 2)","SD4E_PD6 (Arm 2: Sequence 2)","SD5E_PD8 (Arm 2: Sequence 2)","SD6_PD9 (Arm 2: Sequence 2)","SD6E_PD9 (Arm 2: Sequence 2)","SD7_PD10 (Arm 2: Sequence 2)","SD7E_PD10 (Arm 2: Sequence 2)","SD8_PD11 (Arm 2: Sequence 2)","SD8E_PD11 (Arm 2: Sequence 2)","Screening & Enrollment (Arm 3: Sequence 3)","SD1E_PD2 (Arm 3: Sequence 3)","SD2_PD3 (Arm 3: Sequence 3)","SD2E_PD3 (Arm 3: Sequence 3)","SD3_PD4 (Arm 3: Sequence 3)","SD3E_PD4 (Arm 3: Sequence 3)","SD4_PD5 (Arm 3: Sequence 3)","SD4E_PD5 (Arm 3: Sequence 3)","SD5E_PD11 (Arm 3: Sequence 3)","SD6_PD12 (Arm 3: Sequence 3)","SD6E_PD12 (Arm 3: Sequence 3)","SD7_PD13 (Arm 3: Sequence 3)","SD7E_PD13 (Arm 3: Sequence 3)","SD8_PD14 (Arm 3: Sequence 3)","SD8E_PD14 (Arm 3: Sequence 3)","Screening & Enrollment (Arm 4: Sequence 4)","SD1E_PD1 (Arm 4: Sequence 4)","SD2_PD2 (Arm 4: Sequence 4)","SD2E_PD2 (Arm 4: Sequence 4)","SD3_PD3 (Arm 4: Sequence 4)","SD3E_PD3 (Arm 4: Sequence 4)","SD4_PD4 (Arm 4: Sequence 4)","SD4E_PD4 (Arm 4: Sequence 4)","SD5E_PD9 (Arm 4: Sequence 4)","SD6_PD10 (Arm 4: Sequence 4)","SD6E_PD10 (Arm 4: Sequence 4)","SD7_PD11 (Arm 4: Sequence 4)","SD7E_PD11 (Arm 4: Sequence 4)","SD8_PD12 (Arm 4: Sequence 4)","SD8E_PD12 (Arm 4: Sequence 4)")
levels(data$alerts___1.factor)=c("Unchecked","Checked")
levels(data$alerts___2.factor)=c("Unchecked","Checked")
levels(data$alerts___3.factor)=c("Unchecked","Checked")
levels(data$cgm_downloads___1.factor)=c("Unchecked","Checked")
levels(data$cgm_downloads___2.factor)=c("Unchecked","Checked")
levels(data$cgm_downloads___3.factor)=c("Unchecked","Checked")
levels(data$cgm_downloads___4.factor)=c("Unchecked","Checked")
levels(data$cgm_downloads___5.factor)=c("Unchecked","Checked")
levels(data$c1.factor)=c("Yes","Not Applicable")
levels(data$c2.factor)=c("Yes","Not Applicable")
levels(data$c3.factor)=c("Yes","Not Applicable")
levels(data$c4.factor)=c("Yes","Not Applicable")
levels(data$c5.factor)=c("Yes","Not Applicable")
levels(data$c6.factor)=c("Yes","Not Applicable")
levels(data$c7.factor)=c("Yes","Not Applicable")
levels(data$c8.factor)=c("Yes","Not Applicable")
levels(data$c9.factor)=c("Yes","Not Applicable")
levels(data$enrollment_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$agreebs1.factor)=c("Yes, I agree to participate","No, I do not wish to participate")
levels(data$pt_age.factor)=c("Yes","No")
levels(data$informed_consent_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$pt_race___1.factor)=c("Unchecked","Checked")
levels(data$pt_race___2.factor)=c("Unchecked","Checked")
levels(data$pt_race___3.factor)=c("Unchecked","Checked")
levels(data$pt_race___4.factor)=c("Unchecked","Checked")
levels(data$pt_race___5.factor)=c("Unchecked","Checked")
levels(data$pt_race___6.factor)=c("Unchecked","Checked")
levels(data$pt_eth.factor)=c("Hispanic or Latino/a","Not Hispanic or Latino/a")
levels(data$pt_gender.factor)=c("Male","Female","Other")
levels(data$p1_hedu.factor)=c("No Degree","High school or GED","Some College","Associates Degree","Vocational School","Bachelors Degree","Masters Degree","Doctorate Level")
levels(data$p2_hedu.factor)=c("No Degree","High school or GED","Some College","Associates Degree","Vocational School","Bachelors Degree","Masters Degree","Doctorate Level")
levels(data$demographics_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$pt_baseline1.factor)=c("Yes","No")
levels(data$pt_baseline2.factor)=c("< 1 year","1 - 5 years","5-10 years","10+ Years")
levels(data$pt_baseline3.factor)=c("Animas","Medtronic","Tandem","Omnipod","Other")
levels(data$pt_baseline4.factor)=c("Yes","No")
levels(data$inpen_duration.factor)=c("< 1 year","1 - 5 years","5-10 years","10+ Years")
levels(data$pt_baseline5.factor)=c("Yes","No")
levels(data$pt_baseline6.factor)=c("< 1 year","1 - 5 years","5-10 years","10+ Years")
levels(data$pt_baseline7.factor)=c("Medtronic","Dexcom","Other")
levels(data$pt_baseline7_model.factor)=c("Guardian","G4","G5","G6","Other")
levels(data$diabetes_information_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$twiliotest.factor)=c("Yes","No")
levels(data$twilionumber.factor)=c("Yes","No")
levels(data$twilio_test_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$dmireq.factor)=c("Yes","No")
levels(data$cgm_review.factor)=c("Clarity","Carelink","T:Connect","Glooko","Tidepool")
levels(data$insulin_review.factor)=c("Carelink","T:Connect","Glooko","Tidepool")
levels(data$cgmalerton.factor)=c("Yes","No")
levels(data$dmi_sensoryesno.factor)=c("Yes","No")
levels(data$highs.factor)=c("Yes","No")
levels(data$hab1.factor)=c("Yes","No")
levels(data$bgdrop_ha1.factor)=c("Yes","No")
levels(data$hab2.factor)=c("Yes","No")
levels(data$bgdrop_ha2.factor)=c("Yes","No")
levels(data$hab3.factor)=c("Yes","No")
levels(data$bgdrop_ha3.factor)=c("Yes","No")
levels(data$hab4.factor)=c("Yes","No")
levels(data$bgdrop_ha4.factor)=c("Yes","No")
levels(data$hab5.factor)=c("Yes","No")
levels(data$bgdrop_ha5.factor)=c("Yes","No")
levels(data$hab6.factor)=c("Yes","No")
levels(data$bgdrop_ha6.factor)=c("Yes","No")
levels(data$hab7.factor)=c("Yes","No")
levels(data$bgdrop_ha7.factor)=c("Yes","No")
levels(data$hab8.factor)=c("Yes","No")
levels(data$bgdrop_ha8.factor)=c("Yes","No")
levels(data$hab9.factor)=c("Yes","No")
levels(data$bgdrop_ha9.factor)=c("Yes","No")
levels(data$hab10.factor)=c("Yes","No")
levels(data$bgdrop_ha10.factor)=c("Yes","No")
levels(data$diabetes_management_indicators_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$esq3.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq4.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq5.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq6.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq7.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq8.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq9.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq10.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq11.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq12.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq13.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq14.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq16.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq17.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq18.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq19.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq20.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq21.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq22.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq23.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq24.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq25.factor)=c("Poor","Fair","Good","Very Good","Excellent")
levels(data$esq26.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$morning_engagement_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$gsq1.factor)=c("1","2","3","4","5")
levels(data$gsq2.factor)=c("1","2","3","4","5")
levels(data$gsq3.factor)=c("1","2","3","4","5")
levels(data$goal_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$esq3_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq4_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq5_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq6_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq7_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq8_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq9_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq10_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq11_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq12_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq13_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq14_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq16_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq17_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq18_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq19_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq20_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq21_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq22_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq23_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq24_eve.factor)=c("NO!!","no??","yes??","YES!!")
levels(data$esq25_eve.factor)=c("Poor","Fair","Good","Very Good","Excellent")
levels(data$evening_engagement_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$withdraw.factor)=c("Yes","No")
levels(data$surveystop.factor)=c("Yes","No")
levels(data$withdrawl_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$uploadagree.factor)=c("Yes","No")
levels(data$reminder_to_upload_complete.factor)=c("Incomplete","Unverified","Complete")
