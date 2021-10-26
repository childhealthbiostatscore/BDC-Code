#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('./Data_Raw/ClinicalObservationC_DATA_2021-10-26_0946.csv',
              na.strings = "")
#Setting Labels
label(data$record_id)="Record ID"
label(data$redcap_event_name)="Event Name"
label(data$redcap_survey_identifier)="Survey Identifier"
label(data$demographics_timestamp)="Survey Timestamp"
label(data$child_ya)="Child or Adult?"
label(data$demographics_hcl)="Hybrid Closed Loop System"
label(data$demographics_consent)="Date of Consent Signed:"
label(data$demographics_initals)="Subject Initials (FML)"
label(data$demographics_dob)="Date of Birth"
label(data$demographics_age)="Age (years)"
label(data$demographics_ethnicity)="Ethnicity"
label(data$demographics_race)="Race"
label(data$demographics_sex)="Gender"
label(data$demographics_insurance)="Insurance"
label(data$demographics_insother)="If other insurance, define:"
label(data$demographics_pumphx)="History of pump use"
label(data$demographics_cgmhx)="History of CGM use"
label(data$demographics_diabetesdx)="Date of diabetes diagnosis"
label(data$demographics_t1d_duration)="Duration of diabetes at enrollment"
label(data$automode_start)="Date of Closed Loop (CL) Start"
label(data$demographics_complete)="Complete?"
label(data$gyl_timepoint)="Time Point"
label(data$hba1c)="HbA1c "
label(data$hba1c_date)="Date of HbA1c"
label(data$date_visit)="Date of Clinic Visit "
label(data$time_am)="Time in Closed Loop (CL) (%)"
label(data$time_mm)="Time in Manual Mode (%)"
label(data$sensor_wear)="Sensor wear (%)"
label(data$sensor_u54)="% time under 54 mg/dL"
label(data$sensor_54_69)="% time sensor values 54-69 mg/dL"
label(data$sensor_70_180)="% time sensor values 70-180 mg/dL"
label(data$sensor_181_250)="% time sensor values 181-250 mg/dL"
label(data$sensor_g250)="% time sensor values > 250 mg/dL"
label(data$sensor_mean)="Average sensor glucose value  "
label(data$sensor_sd)="Standard deviation of sensor glucose values "
label(data$tdd)="Total Daily Dose"
label(data$tdd_basal)="Average % of total daily dose delivered as basal "
label(data$tdd_bolus)="Average % of total daily dose delivered as bolus "
label(data$dailybolus)="Total # of boluses per day"
label(data$dailymealbolus)="# of MEAL boluses per day"
label(data$sleep)="Daily Sleep (hours)"
label(data$exercise)="Exercise Events"
label(data$bg_checks)="Average # of BG checks per day "
label(data$calibrations)="Average # of calibrations per day "
label(data$amexits)="Total # of auto mode exits "
label(data$amexits_day)="Average # of auto mode exits per day "
label(data$amexit_hyper)="# of auto mode exits related to hyperglycemia  "
label(data$amexit_hypo)="# of auto mode exits related to hypoglycemia"
label(data$amexit_manual)="# of exits due to patient manually disabling auto mode"
label(data$amexits_other)="All auto mode exits other than hyper, hypo and manual"
label(data$glycemic_data_2d4b_complete)="Complete?"
label(data$baseline_surveys_timestamp)="Survey Timestamp"
label(data$name_first)="What is your first name?"
label(data$name_last)="What is your last name?"
label(data$date)="Date"
label(data$timepoint)="Time Point"
label(data$baseline_surveys_complete)="Complete?"
label(data$diabetes_technology_survey_timestamp)="Survey Timestamp"
label(data$tech1)="Diabetes technology has made my life better"
label(data$tech2)="Diabetes technology has made my life easier"
label(data$tech3)="Diabetes technology has made my health better"
label(data$tech4)="Diabetes technology does more good than bad"
label(data$tech5)="Diabetes technology takes more time and work than it is worth"
label(data$diabetes_technology_survey_complete)="Complete?"
label(data$inspire_youth_baseline_timestamp)="Survey Timestamp"
label(data$inspire_b1)="I will be more hopeful about my future with use of automated insulin delivery (AID)."
label(data$inspire_b2)="I will worry less about diabetes with AID."
label(data$inspire_b3)="AID will reduce my familys concerns about my diabetes."
label(data$inspire_b4)="AID will make it easier for me to do the things I want to do without diabetes getting in the way."
label(data$inspire_b5)="AID will decrease how often I have low glucose levels."
label(data$inspire_b6)="AID will decrease how often I have high glucose levels."
label(data$inspire_b7)="AID will help me stay in my target glucose range more often."
label(data$inspire_b8)="AID will improve my A1c to target level."
label(data$inspire_b9)="AID will make it easy to eat when I want."
label(data$inspire_b10)="AID will make it easy to exercise when I want."
label(data$inspire_b11)="AID will make managing diabetes easy when I am at school or work."
label(data$inspire_b12)="AID will make managing diabetes easy when I am with my friends."
label(data$inspire_b13)="AID will help me manage sick days."
label(data$inspire_b14)="AID will help me sleep better."
label(data$inspire_b15)="I believe that I will have fewer lows during the night with AID."
label(data$inspire_b16)="AID will improve my overall quality of life."
label(data$inspire_b17)="AID will improve my familys overall quality of life."
label(data$inspire_youth_baseline_complete)="Complete?"
label(data$inspire_youth_follow_up_timestamp)="Survey Timestamp"
label(data$inspire_f1)="I was more hopeful about my future when using the automated insulin delivery (AID)"
label(data$inspire_f2)="I worried less about diabetes with the AID."
label(data$inspire_f3)="AID reduced my familys concerns about my diabetes."
label(data$inspire_f4)="AID made it easier for me do the things that I wanted to do without diabetes getting in the way."
label(data$inspire_f5)="AID decreased how often I had low glucose levels."
label(data$inspire_f6)="AID decreased how often I had high glucose levels."
label(data$inspire_f7)="AID helped me stay in my target glucose range more often."
label(data$inspire_f8)="AID improved my A1c to target level."
label(data$inspire_f9)="AID made it easier to eat when I wanted to."
label(data$inspire_f10)="AID made it easier to exercise when I wanted to."
label(data$inspire_f11)="AID made managing diabetes easier when I was at work or school."
label(data$inspire_f12)="AID made managing diabetes easier when it came to my social life/being with friends."
label(data$inspire_f13)="AID helped me manage sick days."
label(data$inspire_f14)="AID helped me sleep better."
label(data$inspire_f15)="I had fewer lows during the night with AID."
label(data$inspire_f16)="AID improved my overall quality of life."
label(data$inspire_f17)="AID improved my familys overall quality of life."
label(data$inspire_youth_follow_up_complete)="Complete?"
label(data$ya_baseline_survey_timestamp)="Survey Timestamp"
label(data$ya_baseline1)="What was the total household income in the past year for the childs primary residence?"
label(data$ya_baseline2)="Which of these best describes parent 1s highest level of education?"
label(data$ya_baseline3)="Which of these best describes parent 2s highest level of education?"
label(data$ya_baseline4)="Do you currently use an insulin pump to manage your (your childs) diabetes?"
label(data$ya_baseline5)="When did you first start using an insulin pump?"
label(data$ya_baseline6)="Which insulin pump brand do you currently use? "
label(data$ya_baseline6_other)="Other"
label(data$ya_baseline7)="Do you currently use a continuous glucose monitor (i.e. CGM or glucose sensor) for your diabetes management?"
label(data$ya_baseline8)="When did you first start using a CGM for your diabetes management?"
label(data$ya_baseline9)="Which CGM brand do you currently use? "
label(data$ya_baseline9_other)="Other"
label(data$ya_baseline_survey_complete)="Complete?"
label(data$ya_paid_survey_timestamp)="Survey Timestamp"
label(data$ya_paid1)="Not having clear and concrete goals for your diabetes care"
label(data$ya_paid2)="Feeling discouraged with your diabetes treatment plan"
label(data$ya_paid3)="Feeling scared when you think about living with diabetes"
label(data$ya_paid4)="Uncomfortable social situations related to your diabetes care (e.g., people telling you what to eat)"
label(data$ya_paid5)="Feeling deprived regarding food and meals"
label(data$ya_paid6)="Feeling depressed when you think about living with diabetes"
label(data$ya_paid7)="Not knowing if your mood or feelings are related to your diabetes"
label(data$ya_paid8)="Feeling overwhelmed by your diabetes"
label(data$ya_paid9)="Worrying about low blood sugar reactions"
label(data$ya_paid10)="Feeling angry when you think about living with diabetes"
label(data$ya_paid11)="Feeling constantly concerned about food and eating"
label(data$ya_paid12)="Worrying about the future and the possibility of serious complications"
label(data$ya_paid13)="Feelings of guilt or anxiety when you get off track with your diabetes management"
label(data$ya_paid14)="Not accepting your diabetes"
label(data$ya_paid15)="Feeling unsatisfied with your diabetes physician"
label(data$ya_paid16)="Feeling that diabetes is taking up to much of your mental and physical energy every day"
label(data$ya_paid17)="Feeling alone with your diabets"
label(data$ya_paid18)="Feeling that your friends and family are not supportive of your diabetes management efforts"
label(data$ya_paid19)="Coping with complications of diabetes"
label(data$ya_paid20)="Feeling burned out by the constant effort needed to manage diabetes"
label(data$ya_paid_survey_complete)="Complete?"
label(data$ya_hfs_baseline_survey_timestamp)="Survey Timestamp"
label(data$ya_hfs_b_behave1)="Eat large snacks"
label(data$ya_hfs_b_behave2)="Try to keep my blood sugar above 150"
label(data$ya_hfs_b_behave3)="Reduce my insulin when my blood sugar is low"
label(data$ya_hfs_b_behave4)="Measure my blood sugar six or more times a day"
label(data$ya_hfs_b_behave5)="Make sure I have someone with me when I go out"
label(data$ya_hfs_b_behave6)="Limit my out of town travel"
label(data$ya_hfs_b_behave7)="Limit my driving (car, truck or bicycle)"
label(data$ya_hfs_b_behave8)="Avoid visiting friends"
label(data$ya_hfs_b_behave9)="Stay at home more than I liked"
label(data$ya_hfs_b_behave10)="Limit my exercise/physical activity"
label(data$ya_hfs_b_behave11)="Make sure there were other people around"
label(data$ya_hfs_b_behave12)="Avoid sex"
label(data$ya_hfs_b_behave13)="Keep my blood sugar higher than usual in social situations"
label(data$ya_hfs_b_behave14)="Keep my blood sugar higher than usual when doing important tasks"
label(data$ya_hfs_b_behave15)="Have people check on me several times during the day or night"
label(data$ya_hfs_b_worry16)="Not recognizing/realizing I am having low blood sugar"
label(data$ya_hfs_b_worry17)="Not having food, fruit, or juice available"
label(data$ya_hfs_b_worry18)="Passing out in public"
label(data$ya_hfs_b_worry19)="Embarrassing myself or my friends in a social situation"
label(data$ya_hfs_b_worry20)="Having a hypoglycemic episode while alone"
label(data$ya_hfs_b_worry21)="Appearing stupid or drunk"
label(data$ya_hfs_b_worry22)="Losing control"
label(data$ya_hfs_b_worry23)="No one being around to help me during a hypoglycemic episode"
label(data$ya_hfs_b_worry24)="Having a hypoglycemic episode while driving"
label(data$ya_hfs_b_worry25)="Making a mistake or having an accident"
label(data$ya_hfs_b_worry26)="Getting a bad evaluation or being criticized"
label(data$ya_hfs_b_worry27)="Difficulty thinking clearly when responsible for others"
label(data$ya_hfs_b_worry28)="Feeling lightheaded or dizzy"
label(data$ya_hfs_b_worry29)="Accidentally injuring myself or others"
label(data$ya_hfs_b_worry30)="Permanent injury or damage to my health or body"
label(data$ya_hfs_b_worry31)="Low blood sugar interfering with important things I am doing"
label(data$ya_hfs_b_worry32)="Becoming hypoglycemic during sleep"
label(data$ya_hfs_b_worry33)="Getting emotionally upset and difficult to deal with"
label(data$ya_hfs__b_hypo_sev)="In the PAST 12 MONTHS, how many times have you experienced episodes of SEVERE HYPOGLYCEMIA?  (Hypoglycemic episodes when your blood sugar was so low that you were unable to treat yourself due to mental confusion or unconsciousness.)  "
label(data$ya_hfs_b_hypo_sev_upset)="In the PAST 12 MONTHS, how upsetting was your worst episode of SEVERE HYPOGLYCEMIA? Please circle the number below that best describes your worst episode of severe hypoglycemia"
label(data$ya_hfs_b_hypo_mod)="In the PAST 3 MONTHS, how many times have you experienced episodes of MODERATE HYPOGLYCEMIA? (Hypoglycemic episodes when you could treat yourself but your blood sugar was so low that it interfered with what you were doing and you had to wait a while to recover.)  "
label(data$ya_hfs_b_hypo_mod_upset)=" In the PAST 3 MONTHS, how upsetting was your worst episode of MODERATE HYPOGLYCEMIA?  Please circle the number below that best describes your worst episode of moderate hypoglycemia."
label(data$ya_hfs_b_hypo_mild)=" In the PAST MONTH, how many times have you experience episodes of MILD HYPOGLYCEMIA?  (Hypoglycemic episodes that caused symptoms but these went away quickly after you ate or drank something and did not interfere with your ability to function.)  "
label(data$ya_hfs_b_hypo_mild_upset)="In the PAST MONTH, how upsetting was your worst episode of MILD HYPOGLYCEMIA?  Please circle the number that best describes your worst episode of mild hypoglycemia."
label(data$ya_hfs_b_bg_tar_low)="I try not to let my blood sugar get BELOW"
label(data$ya_hfs_b_bg_tar_above)="I try not to let my blood sugar get ABOVE "
label(data$ya_hfs_baseline_survey_complete)="Complete?"
label(data$ya_hfs_follow_up_survey_timestamp)="Survey Timestamp"
label(data$ya_hfs_f_behave1)="Eat large snacks"
label(data$ya_hfs_f_behave2)="Try to keep my blood sugar above 150"
label(data$ya_hfs_f_behave3)="Reduce my insulin when my blood sugar is low"
label(data$ya_hfs_f_behave4)="Measure my blood sugar six or more times a day"
label(data$ya_hfs_f_behave5)="Make sure I have someone with me when I go out"
label(data$ya_hfs_f_behave6)="Limit my out of town travel"
label(data$ya_hfs_f_behave7)="Limit my driving (car, truck or bicycle)"
label(data$ya_hfs_f_behave8)="Avoid visiting friends"
label(data$ya_hfs_f_behave9)="Stay at home more than I liked"
label(data$ya_hfs_f_behave10)="Limit my exercise/physical activity"
label(data$ya_hfs_f_behave11)="Make sure there were other people around"
label(data$ya_hfs_f_behave12)="Avoid sex"
label(data$ya_hfs_f_behave13)="Keep my blood sugar higher than usual in social situations"
label(data$ya_hfs_f_behave14)="Keep my blood sugar higher than usual when doing important tasks"
label(data$ya_hfs_f_behave15)="Have people check on me several times during the day or night"
label(data$ya_hfs_f_worry16)="Not recognizing/realizing I am having low blood sugar"
label(data$ya_hfs_f_worry17)="Not having food, fruit, or juice available"
label(data$ya_hfs_f_worry18)="Passing out in public"
label(data$ya_hfs_f_worry19)="Embarrassing myself or my friends in a social situation"
label(data$ya_hfs_f_worry20)="Having a hypoglycemic episode while alone"
label(data$ya_hfs_f_worry21)="Appearing stupid or drunk"
label(data$ya_hfs_f_worry22)="Losing control"
label(data$ya_hfs_f_worry23)="No one being around to help me during a hypoglycemic episode"
label(data$ya_hfs_f_worry24)="Having a hypoglycemic episode while driving"
label(data$ya_hfs_f_worry25)="Making a mistake or having an accident"
label(data$ya_hfs_f_worry26)="Getting a bad evaluation or being criticized"
label(data$ya_hfs_f_worry27)="Difficulty thinking clearly when responsible for others"
label(data$ya_hfs_f_worry28)="Feeling lightheaded or dizzy"
label(data$ya_hfs_f_worry29)="Accidentally injuring myself or others"
label(data$ya_hfs_f_worry30)="Permanent injury or damage to my health or body"
label(data$ya_hfs_f_worry31)="Low blood sugar interfering with important things I am doing"
label(data$ya_hfs_f_worry32)="Becoming hypoglycemic during sleep"
label(data$ya_hfs_f_worry33)="Getting emotionally upset and difficult to deal with"
label(data$ya_hfs_f_hypo_sev)="In the PAST 3 MONTHS, how many times have you experienced episodes of SEVERE HYPOGLYCEMIA?  (Hypoglycemic episodes when your blood sugar was so low that you were unable to treat yourself due to mental confusion or unconsciousness.)  "
label(data$ya_hfs_f_hypo_sev_upset)="In the PAST 3 MONTHS, how upsetting was your worst episode of SEVERE HYPOGLYCEMIA? Please select the one best describes your worst episode of severe hypoglycemia"
label(data$ya_hfs_f_hypo_mod)="In the PAST 3 MONTHS, how many times have you experienced episodes of MODERATE HYPOGLYCEMIA? (Hypoglycemic episodes when you could treat yourself but your blood sugar was so low that it interfered with what you were doing and you had to wait a while to recover.)  "
label(data$ya_hfs_f_hypo_mod_upset)=" In the PAST 3 MONTHS, how upsetting was your worst episode of MODERATE HYPOGLYCEMIA?  Please select the one that best describes your worst episode of moderate hypoglycemia."
label(data$ya_hfs_f_hypo_mild)=" In the PAST MONTH, how many times have you experience episodes of MILD HYPOGLYCEMIA?  (Hypoglycemic episodes that caused symptoms but these went away quickly after you ate or drank something and did not interfere with your ability to function.)  "
label(data$ya_hfs_f_hypo_mild_upset)="In the PAST MONTH, how upsetting was your worst episode of MILD HYPOGLYCEMIA?  Please select the one that best describes your worst episode of mild hypoglycemia."
label(data$ya_hfs_f_bg_tar_low)="I try not to let my blood sugar get BELOW"
label(data$ya_hfs_f_bg_tar_above)="I try not to let my blood sugar get ABOVE "
label(data$ya_hfs_follow_up_survey_complete)="Complete?"
label(data$child_hfs_survey_timestamp)="Survey Timestamp"
label(data$c_hfs_behave1)="Eat large snacks at bedtime"
label(data$c_hfs_behave2)="Try not to be by myself when my blood sugar is likely to be low"
label(data$c_hfs_behave3)="Keep blood sugars a little high to be on the safe side"
label(data$c_hfs_behave4)="Keep blood sugar higher when I will be alone for awhile"
label(data$c_hfs_behave5)="Eat something as soon as I feel the first sign of low blood sugar"
label(data$c_hfs_behave6)="Take less insulin when I think my blood sugar might get too low"
label(data$c_hfs_behave7)="Keep my blood sugar higher when I am going to be away from home"
label(data$c_hfs_behave8)="Carry some kind of sugar, drink or food with me"
label(data$c_hfs_behave9)="Try not to do a lot of exercise when I think my sugar is low"
label(data$c_hfs_behave10)="Check my blood sugar often when I go away from home"
label(data$c_hfs_worry11)="Not recognizing that my blood sugar is low"
label(data$c_hfs_worry12)="Not having food, fruit, or juice with me when my blood sugar gets low"
label(data$c_hfs_worry13)="Feeling dizzy or passing out in public because of a low blood sugar"
label(data$c_hfs_worry14)="Having a low blood sugar while asleep"
label(data$c_hfs_worry15)="Embarrassing myself because of a low blood sugar"
label(data$c_hfs_worry16)="Having a low blood sugar while I am by myself"
label(data$c_hfs_worry17)="Looking stupid or clumsy in front of other people"
label(data$c_hfs_worry18)="Losing control because of a low blood sugar"
label(data$c_hfs_worry19)="No one being around to help me during a low"
label(data$c_hfs_worry20)="Making a mistake or having an accident at school due to low blood sugar"
label(data$c_hfs_worry21)="Getting in trouble at school because of something that happens when my sugar is low"
label(data$c_hfs_worry22)="Having seizures"
label(data$c_hfs_worry23)="Getting long term complications from low blood sugar"
label(data$c_hfs_worry24)="Feeling dizzy or woozy when my blood sugar is low"
label(data$c_hfs_worry25)="Having a low blood sugar"
label(data$child_hfs_survey_complete)="Complete?"
label(data$child_paid_survey_timestamp)="Survey Timestamp"
label(data$c_paid1)="I feel sad a lot when I think about having diabetes"
label(data$c_paid2)="I feel like diabetes has taken over my life"
label(data$c_paid3)="I feel like it is my fault when my blood sugars are out of range"
label(data$c_paid4)="It bothers me to think so much about what I eat"
label(data$c_paid5)="I worry all the time about how diabetes will affect me when I am older"
label(data$c_paid6)="I feel upset when my blood sugar is out of range"
label(data$c_paid7)="I am too tired of having diabetes to take care of it"
label(data$c_paid8)="I feel left out when I cant eat things other teens are eating"
label(data$c_paid9)="I am annoyed when I have to stop what I am doing to check my blood sugar"
label(data$c_paid10)="I am tired of trying to figure out my insulin dose at every meal"
label(data$c_paid11)="I feel embarassed about having diabetes"
label(data$c_paid12)="My friends and family act like the diabetes police (for example, always reminding me to eat right, check my blood sugars, or take insulin)"
label(data$c_paid13)="I am tired of remembering to give insulin shots or to bolus"
label(data$c_paid14)="It seems like no matter how hard I try, my blood sugars are out of control"
label(data$c_paid15)="I feel like I dont fit in with other teens my age because of my diabetes"
label(data$c_paid16)="I am annoyed by having to rotate injection sites or pump infusion sites"
label(data$c_paid17)="I feel angry a lot when I think about having diabetes"
label(data$c_paid18)="My friends and family do not understand what it is like to have diabetes"
label(data$c_paid19)="I worry about going low, especially during physical activites (for example, sports, playing outside, dance class)"
label(data$c_paid20)="My parents worry about me and my diabetes too much"
label(data$child_paid_survey_complete)="Complete?"
label(data$inspire_adult_baseline_timestamp)="Survey Timestamp"
label(data$inspire_b1_adult)="I will be more hopeful about my future with use of automated insulin delivery (AID)."
label(data$inspire_b2_adult)="I will worry less about diabetes with AID."
label(data$inspire_b3_adult)="AID will reduce my familys concerns about my diabetes."
label(data$inspire_b4_adult)="AID will make it easier for me to do the things I want to do without diabetes getting in the way."
label(data$inspire_b5_adult)="AID will decrease how often I have low glucose levels."
label(data$inspire_b6_adult)="AID will decrease how often I have high glucose levels."
label(data$inspire_b7_adult)="AID will help me stay in my target glucose range more often."
label(data$inspire_b8_adult)="AID will improve my A1c to target level."
label(data$inspire_b9_adult)="AID will make it easy to eat when I want."
label(data$inspire_b10_adult)="AID will make it easy to exercise when I want."
label(data$inspire_b11_adult)="AID will make managing diabetes easy when I am at school or work."
label(data$inspire_b12_adult)="AID will make managing diabetes easy when I am with my friends."
label(data$inspire_b13_adult)="AID will help me manage sick days."
label(data$inspire_b14_adult)="AID will help me sleep better."
label(data$inspire_b15_adult)="I believe that I will have fewer lows during the night with AID."
label(data$inspire_b16_adult)="AID will improve my overall quality of life."
label(data$inspire_b17_adult)="AID will improve my familys overall quality of life."
label(data$inspire_b18_adult)="AID will make managing diabetes easy when driving (for those who drive) or when traveling."
label(data$inspire_b19_adult)="AID will help me manage diabetes when it comes to my sex life."
label(data$inspire_b20_adult)="AID will help me manage diabetes when I choose to drink alcohol."
label(data$inspire_b21_adult)="AID will help me if I am pregnant."
label(data$inspire_b22_adult)="AID will reduce my risk of long term complications."
label(data$inspire_adult_baseline_complete)="Complete?"
label(data$inspire_adult_follow_up_timestamp)="Survey Timestamp"
label(data$inspire_f1_adult)="I was more hopeful about my future when using the automated insulin delivery (AID)"
label(data$inspire_f2_adult)="I worried less about diabetes with the AID."
label(data$inspire_f3_adult)="AID reduced my familys concerns about my diabetes."
label(data$inspire_f4_adult)="AID made it easier for me do the things that I wanted to do without diabetes getting in the way."
label(data$inspire_f5_adult)="AID decreased how often I had low glucose levels."
label(data$inspire_f6_adult)="AID decreased how often I had high glucose levels."
label(data$inspire_f7_adult)="AID helped me stay in my target glucose range more often."
label(data$inspire_f8_adult)="AID improved my A1c to target level."
label(data$inspire_f9_adult)="AID made it easier to eat when I wanted to."
label(data$inspire_f10_adult)="AID made it easier to exercise when I wanted to."
label(data$inspire_f11_adult)="AID made managing diabetes easier when I was at work or school."
label(data$inspire_f12_adult)="AID made managing diabetes easier when it came to my social life/being with friends."
label(data$inspire_f13_adult)="AID helped me manage sick days."
label(data$inspire_f14_adult)="AID helped me sleep better."
label(data$inspire_f15_adult)="I had fewer lows during the night with AID."
label(data$inspire_f16_adult)="AID improved my overall quality of life."
label(data$inspire_f17_adult)="AID improved my familys overall quality of life."
label(data$inspire_f18_adult)="AID made managing diabetes easier when driving (for those who drive) or when travelling"
label(data$inspire_f19_adult)="AID helped me manage diabetes when it came to my sex life"
label(data$inspire_f20_adult)="AID helped me manage my diabetes when I drank alcohol"
label(data$inspire_f21_adult)="AID helped me when I was pregnant"
label(data$inspire_f22_adult)="AID reduced my risk of long-term complications."
label(data$inspire_adult_follow_up_complete)="Complete?"
label(data$adult_baseline_survey_timestamp)="Survey Timestamp"
label(data$a_baseline1)="What was the total household income in the past year?"
label(data$a_baseline2)="Which of these best describes your highest level of education?"
label(data$a_baseline3)="Do you currently use an insulin pump to manage your diabetes?"
label(data$a_baseline4)="When did you first start using an insulin pump?"
label(data$a_baseline5)="Which insulin pump brand do you currently use? "
label(data$a_baseline5_other)="Other"
label(data$a_baseline6)="Do you currently use a continuous glucose monitor (i.e. CGM or glucose sensor) for your diabetes management?"
label(data$a_baseline7)="When did you first start using a CGM for your diabetes management?"
label(data$a_baseline8)="Which CGM brand do you currently use? "
label(data$a_baseline8_other)="Other"
label(data$adult_baseline_survey_complete)="Complete?"
label(data$diabetes_treatmentrelated_burden_child_timestamp)="Survey Timestamp"
label(data$dtbchi_freq1)="1. Check to see what your glucose level is"
label(data$dtbchi_freq2)="2. Think about going low"
label(data$dtbchi_freq3)="3. Treat a low glucose"
label(data$dtbchi_freq4)="4. Think about going high"
label(data$dtbchi_freq5)="5. Treat a high glucose"
label(data$dtbchi_freq6)="6. Rearrange how your diabetes devices are positioned (tubing, clips, clothing placement, etc.)"
label(data$dtbchi_freq7)="7. Think about what to eat and how much insulin to give for it"
label(data$dtbchi_freq8)="8. Give yourself a dose (bolus) of insulin"
label(data$dtbchi_freq9)="9. Check to see if your diabetes devices are working"
label(data$dtbchi_freq10)="10. Troubleshoot a diabetes device issue"
label(data$dtbchi_freq11)="11. Think about how to manage diabetes during activities (school, sports, exercise, etc.)"
label(data$dtbchi_freq12)="12. Program special settings into your diabetes device (temporary settings, event markers, etc.)"
label(data$dtbchi_freq13)="13. Respond to (or silence) a diabetes device alarm"
label(data$dtbchi_freq_14)="14. Replace infusion sets or glucose sensors"
label(data$dtbchi_freq15)="15. Wake up in the middle of the night thinking about diabetes"
label(data$dtbchi_freq16)="16. Wake up in the middle of the night to treat a low or high glucose level"
label(data$dtbchi_freq17)="17. Wake up in the middle of the night to troubleshoot a diabetes device issue"
label(data$dtbchi_freq18)="18. Get interrupted in other ways due to diabetes/diabetes devices"
label(data$dtbchi_freq19)="19. Think about your diabetes or diabetes devices for any other reason"
label(data$dtbchi_length1)="1. Check to see what your glucose level is"
label(data$dtbchi_length2)="2. Think about going low"
label(data$dtbchi_length3)="3. Treat a low glucose"
label(data$dtbchi_length4)="4. Think about going high"
label(data$dtbchi_length5)="5. Treat a high glucose"
label(data$dtbchi_length6)="6. Rearrange how your diabetes devices are positioned (tubing, clips, clothing placement, etc.)"
label(data$dtbchi_length7)="7. Think about what to eat and how much insulin to give for it"
label(data$dtbchi_length8)="8. Give yourself a dose (bolus) of insulin"
label(data$dtbchi_length9)="9. Check to see if your diabetes devices are working"
label(data$dtbchi_length10)="10. Troubleshoot a diabetes device issue"
label(data$dtbchi_length11)="11. Think about how to manage diabetes during activities (school, sports, exercise, etc.)"
label(data$dtbchi_length12)="12. Program special settings into your diabetes device (temporary settings, event markers, etc.)"
label(data$dtbchi_length13)="13. Respond to (or silence) a diabetes device alarm"
label(data$dtbchi_length14)="14. Remove or replace infusion sets or glucose sensors"
label(data$dtbchi_length15)="15. Wake up in the middle of the night thinking about diabetes"
label(data$dtbchi_length16)="16. Wake up in the middle of the night to treat a low or high glucose level"
label(data$dtbchi_length17)="17. Wake up in the middle of the night to troubleshoot a diabetes device issue"
label(data$dtbchi_length18)="18. Get interrupted in other ways due to diabetes/diabetes devices"
label(data$dtbchi_length19)="19. Think about your diabetes/diabetes devices for any other reason"
label(data$dtbchi_upset1)="1. Check to see what your glucose level is"
label(data$dtbchi_upset2)="2. Think about going low"
label(data$dtbchi_upset3)="3. Treat a low glucose"
label(data$dtbchi_upset4)="4. Think about going high"
label(data$dtbchi_upset5)="5. Treat a high glucose"
label(data$dtbchi_upset6)="6. Rearrange how your diabetes devices are positioned (tubing, clips, clothing placement, etc.)"
label(data$dtbchi_upset7)="7. Think about what to eat and how much insulin to give for it"
label(data$dtbchi_upset8)="8. Give yourself a dose (bolus) of insulin"
label(data$dtbchi_upset9)="9. Check to see if your diabetes devices are working"
label(data$dtbchi_upset10)="10. Troubleshoot a diabetes device issue"
label(data$dtbchi_upset11)="11. Think about how to manage diabetes during activities (school, sports, exercise, etc.)"
label(data$dtbchi_upset12)="12. Program special settings into your diabetes device (temporary settings, event markers, etc.)"
label(data$dtbchi_upset13)="13. Respond to (or silence) a diabetes device alarm"
label(data$dtbchi_upset14)="14. Remove or replace infusion sets or glucose sensors"
label(data$dtbchi_upset15)="15. Wake up in the middle of the night thinking about diabetes"
label(data$dtbchi_upset16)="16. Wake up in the middle of the night to treat a low or high glucose level"
label(data$dtbchi_upset17)="17. Wake up in the middle of the night to troubleshoot a diabetes device issue"
label(data$dtbchi_upset18)="18. Get interrupted in other ways due to diabetes/diabetes devices"
label(data$dtbchi_upset19)="19. Think about your diabetes/diabetes devices for any other reason"
label(data$diabetes_treatmentrelated_burden_child_complete)="Complete?"
#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("baseline_arm_1","1_arm_1","2_arm_1","3_arm_1","4_arm_1","5_arm_1","6_arm_1","baseline_arm_2","1_arm_2","2_arm_2","3_arm_2","4_arm_2","5_arm_2","6_arm_2","baseline_arm_3","1_arm_3","2_arm_3","3_arm_3","4_arm_3","5_arm_3"))
data$child_ya.factor = factor(data$child_ya,levels=c("1","2"))
data$demographics_hcl.factor = factor(data$demographics_hcl,levels=c("0","1"))
data$demographics_ethnicity.factor = factor(data$demographics_ethnicity,levels=c("0","1","2"))
data$demographics_race.factor = factor(data$demographics_race,levels=c("0","1","2","3","4","5","6"))
data$demographics_sex.factor = factor(data$demographics_sex,levels=c("0","1"))
data$demographics_insurance.factor = factor(data$demographics_insurance,levels=c("1","2","3","4"))
data$demographics_pumphx.factor = factor(data$demographics_pumphx,levels=c("1","2","3","4","5","6","7"))
data$demographics_cgmhx.factor = factor(data$demographics_cgmhx,levels=c("1","2","3","4","5","6","7"))
data$demographics_complete.factor = factor(data$demographics_complete,levels=c("0","1","2"))
data$gyl_timepoint.factor = factor(data$gyl_timepoint,levels=c("0","1","2","3","4","5"))
data$glycemic_data_2d4b_complete.factor = factor(data$glycemic_data_2d4b_complete,levels=c("0","1","2"))
data$timepoint.factor = factor(data$timepoint,levels=c("0","1","2","3","4","5"))
data$baseline_surveys_complete.factor = factor(data$baseline_surveys_complete,levels=c("0","1","2"))
data$tech1.factor = factor(data$tech1,levels=c("0","1","2","3","4"))
data$tech2.factor = factor(data$tech2,levels=c("0","1","2","3","4"))
data$tech3.factor = factor(data$tech3,levels=c("0","1","2","3","4"))
data$tech4.factor = factor(data$tech4,levels=c("0","1","2","3","4"))
data$tech5.factor = factor(data$tech5,levels=c("0","1","2","3","4"))
data$diabetes_technology_survey_complete.factor = factor(data$diabetes_technology_survey_complete,levels=c("0","1","2"))
data$inspire_b1.factor = factor(data$inspire_b1,levels=c("0","1","2","3","4","5"))
data$inspire_b2.factor = factor(data$inspire_b2,levels=c("0","1","2","3","4","5"))
data$inspire_b3.factor = factor(data$inspire_b3,levels=c("0","1","2","3","4","5"))
data$inspire_b4.factor = factor(data$inspire_b4,levels=c("0","1","2","3","4","5"))
data$inspire_b5.factor = factor(data$inspire_b5,levels=c("0","1","2","3","4","5"))
data$inspire_b6.factor = factor(data$inspire_b6,levels=c("0","1","2","3","4","5"))
data$inspire_b7.factor = factor(data$inspire_b7,levels=c("0","1","2","3","4","5"))
data$inspire_b8.factor = factor(data$inspire_b8,levels=c("0","1","2","3","4","5"))
data$inspire_b9.factor = factor(data$inspire_b9,levels=c("0","1","2","3","4","5"))
data$inspire_b10.factor = factor(data$inspire_b10,levels=c("0","1","2","3","4","5"))
data$inspire_b11.factor = factor(data$inspire_b11,levels=c("0","1","2","3","4","5"))
data$inspire_b12.factor = factor(data$inspire_b12,levels=c("0","1","2","3","4","5"))
data$inspire_b13.factor = factor(data$inspire_b13,levels=c("0","1","2","3","4","5"))
data$inspire_b14.factor = factor(data$inspire_b14,levels=c("0","1","2","3","4","5"))
data$inspire_b15.factor = factor(data$inspire_b15,levels=c("0","1","2","3","4","5"))
data$inspire_b16.factor = factor(data$inspire_b16,levels=c("0","1","2","3","4","5"))
data$inspire_b17.factor = factor(data$inspire_b17,levels=c("0","1","2","3","4","5"))
data$inspire_youth_baseline_complete.factor = factor(data$inspire_youth_baseline_complete,levels=c("0","1","2"))
data$inspire_f1.factor = factor(data$inspire_f1,levels=c("0","1","2","3","4","5"))
data$inspire_f2.factor = factor(data$inspire_f2,levels=c("0","1","2","3","4","5"))
data$inspire_f3.factor = factor(data$inspire_f3,levels=c("0","1","2","3","4","5"))
data$inspire_f4.factor = factor(data$inspire_f4,levels=c("0","1","2","3","4","5"))
data$inspire_f5.factor = factor(data$inspire_f5,levels=c("0","1","2","3","4","5"))
data$inspire_f6.factor = factor(data$inspire_f6,levels=c("0","1","2","3","4","5"))
data$inspire_f7.factor = factor(data$inspire_f7,levels=c("0","1","2","3","4","5"))
data$inspire_f8.factor = factor(data$inspire_f8,levels=c("0","1","2","3","4","5"))
data$inspire_f9.factor = factor(data$inspire_f9,levels=c("0","1","2","3","4","5"))
data$inspire_f10.factor = factor(data$inspire_f10,levels=c("0","1","2","3","4","5"))
data$inspire_f11.factor = factor(data$inspire_f11,levels=c("0","1","2","3","4","5"))
data$inspire_f12.factor = factor(data$inspire_f12,levels=c("0","1","2","3","4","5"))
data$inspire_f13.factor = factor(data$inspire_f13,levels=c("0","1","2","3","4","5"))
data$inspire_f14.factor = factor(data$inspire_f14,levels=c("0","1","2","3","4","5"))
data$inspire_f15.factor = factor(data$inspire_f15,levels=c("0","1","2","3","4","5"))
data$inspire_f16.factor = factor(data$inspire_f16,levels=c("0","1","2","3","4","5"))
data$inspire_f17.factor = factor(data$inspire_f17,levels=c("0","1","2","3","4","5"))
data$inspire_youth_follow_up_complete.factor = factor(data$inspire_youth_follow_up_complete,levels=c("0","1","2"))
data$ya_baseline1.factor = factor(data$ya_baseline1,levels=c("1","2","3","4","5","6","7"))
data$ya_baseline2.factor = factor(data$ya_baseline2,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$ya_baseline3.factor = factor(data$ya_baseline3,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$ya_baseline4.factor = factor(data$ya_baseline4,levels=c("1","2"))
data$ya_baseline6.factor = factor(data$ya_baseline6,levels=c("1","2","3","4","5"))
data$ya_baseline7.factor = factor(data$ya_baseline7,levels=c("1","2"))
data$ya_baseline9.factor = factor(data$ya_baseline9,levels=c("1","2","3","4"))
data$ya_baseline_survey_complete.factor = factor(data$ya_baseline_survey_complete,levels=c("0","1","2"))
data$ya_paid1.factor = factor(data$ya_paid1,levels=c("0","1","2","3","4"))
data$ya_paid2.factor = factor(data$ya_paid2,levels=c("0","1","2","3","4"))
data$ya_paid3.factor = factor(data$ya_paid3,levels=c("0","1","2","3","4"))
data$ya_paid4.factor = factor(data$ya_paid4,levels=c("0","1","2","3","4"))
data$ya_paid5.factor = factor(data$ya_paid5,levels=c("0","1","2","3","4"))
data$ya_paid6.factor = factor(data$ya_paid6,levels=c("0","1","2","3","4"))
data$ya_paid7.factor = factor(data$ya_paid7,levels=c("0","1","2","3","4"))
data$ya_paid8.factor = factor(data$ya_paid8,levels=c("0","1","2","3","4"))
data$ya_paid9.factor = factor(data$ya_paid9,levels=c("0","1","2","3","4"))
data$ya_paid10.factor = factor(data$ya_paid10,levels=c("0","1","2","3","4"))
data$ya_paid11.factor = factor(data$ya_paid11,levels=c("0","1","2","3","4"))
data$ya_paid12.factor = factor(data$ya_paid12,levels=c("0","1","2","3","4"))
data$ya_paid13.factor = factor(data$ya_paid13,levels=c("0","1","2","3","4"))
data$ya_paid14.factor = factor(data$ya_paid14,levels=c("0","1","2","3","4"))
data$ya_paid15.factor = factor(data$ya_paid15,levels=c("0","1","2","3","4"))
data$ya_paid16.factor = factor(data$ya_paid16,levels=c("0","1","2","3","4"))
data$ya_paid17.factor = factor(data$ya_paid17,levels=c("0","1","2","3","4"))
data$ya_paid18.factor = factor(data$ya_paid18,levels=c("0","1","2","3","4"))
data$ya_paid19.factor = factor(data$ya_paid19,levels=c("0","1","2","3","4"))
data$ya_paid20.factor = factor(data$ya_paid20,levels=c("0","1","2","3","4"))
data$ya_paid_survey_complete.factor = factor(data$ya_paid_survey_complete,levels=c("0","1","2"))
data$ya_hfs_b_behave1.factor = factor(data$ya_hfs_b_behave1,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave2.factor = factor(data$ya_hfs_b_behave2,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave3.factor = factor(data$ya_hfs_b_behave3,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave4.factor = factor(data$ya_hfs_b_behave4,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave5.factor = factor(data$ya_hfs_b_behave5,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave6.factor = factor(data$ya_hfs_b_behave6,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave7.factor = factor(data$ya_hfs_b_behave7,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave8.factor = factor(data$ya_hfs_b_behave8,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave9.factor = factor(data$ya_hfs_b_behave9,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave10.factor = factor(data$ya_hfs_b_behave10,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave11.factor = factor(data$ya_hfs_b_behave11,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave12.factor = factor(data$ya_hfs_b_behave12,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave13.factor = factor(data$ya_hfs_b_behave13,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave14.factor = factor(data$ya_hfs_b_behave14,levels=c("0","1","2","3","4"))
data$ya_hfs_b_behave15.factor = factor(data$ya_hfs_b_behave15,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry16.factor = factor(data$ya_hfs_b_worry16,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry17.factor = factor(data$ya_hfs_b_worry17,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry18.factor = factor(data$ya_hfs_b_worry18,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry19.factor = factor(data$ya_hfs_b_worry19,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry20.factor = factor(data$ya_hfs_b_worry20,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry21.factor = factor(data$ya_hfs_b_worry21,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry22.factor = factor(data$ya_hfs_b_worry22,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry23.factor = factor(data$ya_hfs_b_worry23,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry24.factor = factor(data$ya_hfs_b_worry24,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry25.factor = factor(data$ya_hfs_b_worry25,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry26.factor = factor(data$ya_hfs_b_worry26,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry27.factor = factor(data$ya_hfs_b_worry27,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry28.factor = factor(data$ya_hfs_b_worry28,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry29.factor = factor(data$ya_hfs_b_worry29,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry30.factor = factor(data$ya_hfs_b_worry30,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry31.factor = factor(data$ya_hfs_b_worry31,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry32.factor = factor(data$ya_hfs_b_worry32,levels=c("0","1","2","3","4"))
data$ya_hfs_b_worry33.factor = factor(data$ya_hfs_b_worry33,levels=c("0","1","2","3","4"))
data$ya_hfs__b_hypo_sev.factor = factor(data$ya_hfs__b_hypo_sev,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$ya_hfs_b_hypo_sev_upset.factor = factor(data$ya_hfs_b_hypo_sev_upset,levels=c("1","2","3","4","5"))
data$ya_hfs_b_hypo_mod.factor = factor(data$ya_hfs_b_hypo_mod,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$ya_hfs_b_hypo_mod_upset.factor = factor(data$ya_hfs_b_hypo_mod_upset,levels=c("0","1","2","3","4"))
data$ya_hfs_b_hypo_mild.factor = factor(data$ya_hfs_b_hypo_mild,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$ya_hfs_b_hypo_mild_upset.factor = factor(data$ya_hfs_b_hypo_mild_upset,levels=c("0","1","2","3","4"))
data$ya_hfs_baseline_survey_complete.factor = factor(data$ya_hfs_baseline_survey_complete,levels=c("0","1","2"))
data$ya_hfs_f_behave1.factor = factor(data$ya_hfs_f_behave1,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave2.factor = factor(data$ya_hfs_f_behave2,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave3.factor = factor(data$ya_hfs_f_behave3,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave4.factor = factor(data$ya_hfs_f_behave4,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave5.factor = factor(data$ya_hfs_f_behave5,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave6.factor = factor(data$ya_hfs_f_behave6,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave7.factor = factor(data$ya_hfs_f_behave7,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave8.factor = factor(data$ya_hfs_f_behave8,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave9.factor = factor(data$ya_hfs_f_behave9,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave10.factor = factor(data$ya_hfs_f_behave10,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave11.factor = factor(data$ya_hfs_f_behave11,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave12.factor = factor(data$ya_hfs_f_behave12,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave13.factor = factor(data$ya_hfs_f_behave13,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave14.factor = factor(data$ya_hfs_f_behave14,levels=c("0","1","2","3","4"))
data$ya_hfs_f_behave15.factor = factor(data$ya_hfs_f_behave15,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry16.factor = factor(data$ya_hfs_f_worry16,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry17.factor = factor(data$ya_hfs_f_worry17,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry18.factor = factor(data$ya_hfs_f_worry18,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry19.factor = factor(data$ya_hfs_f_worry19,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry20.factor = factor(data$ya_hfs_f_worry20,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry21.factor = factor(data$ya_hfs_f_worry21,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry22.factor = factor(data$ya_hfs_f_worry22,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry23.factor = factor(data$ya_hfs_f_worry23,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry24.factor = factor(data$ya_hfs_f_worry24,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry25.factor = factor(data$ya_hfs_f_worry25,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry26.factor = factor(data$ya_hfs_f_worry26,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry27.factor = factor(data$ya_hfs_f_worry27,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry28.factor = factor(data$ya_hfs_f_worry28,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry29.factor = factor(data$ya_hfs_f_worry29,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry30.factor = factor(data$ya_hfs_f_worry30,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry31.factor = factor(data$ya_hfs_f_worry31,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry32.factor = factor(data$ya_hfs_f_worry32,levels=c("0","1","2","3","4"))
data$ya_hfs_f_worry33.factor = factor(data$ya_hfs_f_worry33,levels=c("0","1","2","3","4"))
data$ya_hfs_f_hypo_sev.factor = factor(data$ya_hfs_f_hypo_sev,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$ya_hfs_f_hypo_sev_upset.factor = factor(data$ya_hfs_f_hypo_sev_upset,levels=c("1","2","3","4","5"))
data$ya_hfs_f_hypo_mod.factor = factor(data$ya_hfs_f_hypo_mod,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$ya_hfs_f_hypo_mod_upset.factor = factor(data$ya_hfs_f_hypo_mod_upset,levels=c("0","1","2","3","4"))
data$ya_hfs_f_hypo_mild.factor = factor(data$ya_hfs_f_hypo_mild,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$ya_hfs_f_hypo_mild_upset.factor = factor(data$ya_hfs_f_hypo_mild_upset,levels=c("0","1","2","3","4"))
data$ya_hfs_follow_up_survey_complete.factor = factor(data$ya_hfs_follow_up_survey_complete,levels=c("0","1","2"))
data$c_hfs_behave1.factor = factor(data$c_hfs_behave1,levels=c("0","1","2","3","4"))
data$c_hfs_behave2.factor = factor(data$c_hfs_behave2,levels=c("0","1","2","3","4"))
data$c_hfs_behave3.factor = factor(data$c_hfs_behave3,levels=c("0","1","2","3","4"))
data$c_hfs_behave4.factor = factor(data$c_hfs_behave4,levels=c("0","1","2","3","4"))
data$c_hfs_behave5.factor = factor(data$c_hfs_behave5,levels=c("0","1","2","3","4"))
data$c_hfs_behave6.factor = factor(data$c_hfs_behave6,levels=c("0","1","2","3","4"))
data$c_hfs_behave7.factor = factor(data$c_hfs_behave7,levels=c("0","1","2","3","4"))
data$c_hfs_behave8.factor = factor(data$c_hfs_behave8,levels=c("0","1","2","3","4"))
data$c_hfs_behave9.factor = factor(data$c_hfs_behave9,levels=c("0","1","2","3","4"))
data$c_hfs_behave10.factor = factor(data$c_hfs_behave10,levels=c("0","1","2","3","4"))
data$c_hfs_worry11.factor = factor(data$c_hfs_worry11,levels=c("0","1","2","3","4"))
data$c_hfs_worry12.factor = factor(data$c_hfs_worry12,levels=c("0","1","2","3","4"))
data$c_hfs_worry13.factor = factor(data$c_hfs_worry13,levels=c("0","1","2","3","4"))
data$c_hfs_worry14.factor = factor(data$c_hfs_worry14,levels=c("0","1","2","3","4"))
data$c_hfs_worry15.factor = factor(data$c_hfs_worry15,levels=c("0","1","2","3","4"))
data$c_hfs_worry16.factor = factor(data$c_hfs_worry16,levels=c("0","1","2","3","4"))
data$c_hfs_worry17.factor = factor(data$c_hfs_worry17,levels=c("0","1","2","3","4"))
data$c_hfs_worry18.factor = factor(data$c_hfs_worry18,levels=c("0","1","2","3","4"))
data$c_hfs_worry19.factor = factor(data$c_hfs_worry19,levels=c("0","1","2","3","4"))
data$c_hfs_worry20.factor = factor(data$c_hfs_worry20,levels=c("0","1","2","3","4"))
data$c_hfs_worry21.factor = factor(data$c_hfs_worry21,levels=c("0","1","2","3","4"))
data$c_hfs_worry22.factor = factor(data$c_hfs_worry22,levels=c("0","1","2","3","4"))
data$c_hfs_worry23.factor = factor(data$c_hfs_worry23,levels=c("0","1","2","3","4"))
data$c_hfs_worry24.factor = factor(data$c_hfs_worry24,levels=c("0","1","2","3","4"))
data$c_hfs_worry25.factor = factor(data$c_hfs_worry25,levels=c("0","1","2","3","4"))
data$child_hfs_survey_complete.factor = factor(data$child_hfs_survey_complete,levels=c("0","1","2"))
data$c_paid1.factor = factor(data$c_paid1,levels=c("1","2","3","4","5"))
data$c_paid2.factor = factor(data$c_paid2,levels=c("1","2","3","4","5"))
data$c_paid3.factor = factor(data$c_paid3,levels=c("1","2","3","4","5"))
data$c_paid4.factor = factor(data$c_paid4,levels=c("1","2","3","4","5"))
data$c_paid5.factor = factor(data$c_paid5,levels=c("1","2","3","4","5"))
data$c_paid6.factor = factor(data$c_paid6,levels=c("1","2","3","4","5"))
data$c_paid7.factor = factor(data$c_paid7,levels=c("1","2","3","4","5"))
data$c_paid8.factor = factor(data$c_paid8,levels=c("1","2","3","4","5"))
data$c_paid9.factor = factor(data$c_paid9,levels=c("1","2","3","4","5"))
data$c_paid10.factor = factor(data$c_paid10,levels=c("1","2","3","4","5"))
data$c_paid11.factor = factor(data$c_paid11,levels=c("1","2","3","4","5"))
data$c_paid12.factor = factor(data$c_paid12,levels=c("1","2","3","4","5"))
data$c_paid13.factor = factor(data$c_paid13,levels=c("1","2","3","4","5"))
data$c_paid14.factor = factor(data$c_paid14,levels=c("1","2","3","4","5"))
data$c_paid15.factor = factor(data$c_paid15,levels=c("1","2","3","4","5"))
data$c_paid16.factor = factor(data$c_paid16,levels=c("1","2","3","4","5"))
data$c_paid17.factor = factor(data$c_paid17,levels=c("1","2","3","4","5"))
data$c_paid18.factor = factor(data$c_paid18,levels=c("1","2","3","4","5"))
data$c_paid19.factor = factor(data$c_paid19,levels=c("1","2","3","4","5"))
data$c_paid20.factor = factor(data$c_paid20,levels=c("1","2","3","4","5"))
data$child_paid_survey_complete.factor = factor(data$child_paid_survey_complete,levels=c("0","1","2"))
data$inspire_b1_adult.factor = factor(data$inspire_b1_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b2_adult.factor = factor(data$inspire_b2_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b3_adult.factor = factor(data$inspire_b3_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b4_adult.factor = factor(data$inspire_b4_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b5_adult.factor = factor(data$inspire_b5_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b6_adult.factor = factor(data$inspire_b6_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b7_adult.factor = factor(data$inspire_b7_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b8_adult.factor = factor(data$inspire_b8_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b9_adult.factor = factor(data$inspire_b9_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b10_adult.factor = factor(data$inspire_b10_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b11_adult.factor = factor(data$inspire_b11_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b12_adult.factor = factor(data$inspire_b12_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b13_adult.factor = factor(data$inspire_b13_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b14_adult.factor = factor(data$inspire_b14_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b15_adult.factor = factor(data$inspire_b15_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b16_adult.factor = factor(data$inspire_b16_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b17_adult.factor = factor(data$inspire_b17_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b18_adult.factor = factor(data$inspire_b18_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b19_adult.factor = factor(data$inspire_b19_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b20_adult.factor = factor(data$inspire_b20_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b21_adult.factor = factor(data$inspire_b21_adult,levels=c("0","1","2","3","4","5"))
data$inspire_b22_adult.factor = factor(data$inspire_b22_adult,levels=c("0","1","2","3","4","5"))
data$inspire_adult_baseline_complete.factor = factor(data$inspire_adult_baseline_complete,levels=c("0","1","2"))
data$inspire_f1_adult.factor = factor(data$inspire_f1_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f2_adult.factor = factor(data$inspire_f2_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f3_adult.factor = factor(data$inspire_f3_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f4_adult.factor = factor(data$inspire_f4_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f5_adult.factor = factor(data$inspire_f5_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f6_adult.factor = factor(data$inspire_f6_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f7_adult.factor = factor(data$inspire_f7_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f8_adult.factor = factor(data$inspire_f8_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f9_adult.factor = factor(data$inspire_f9_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f10_adult.factor = factor(data$inspire_f10_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f11_adult.factor = factor(data$inspire_f11_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f12_adult.factor = factor(data$inspire_f12_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f13_adult.factor = factor(data$inspire_f13_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f14_adult.factor = factor(data$inspire_f14_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f15_adult.factor = factor(data$inspire_f15_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f16_adult.factor = factor(data$inspire_f16_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f17_adult.factor = factor(data$inspire_f17_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f18_adult.factor = factor(data$inspire_f18_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f19_adult.factor = factor(data$inspire_f19_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f20_adult.factor = factor(data$inspire_f20_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f21_adult.factor = factor(data$inspire_f21_adult,levels=c("0","1","2","3","4","5"))
data$inspire_f22_adult.factor = factor(data$inspire_f22_adult,levels=c("0","1","2","3","4","5"))
data$inspire_adult_follow_up_complete.factor = factor(data$inspire_adult_follow_up_complete,levels=c("0","1","2"))
data$a_baseline1.factor = factor(data$a_baseline1,levels=c("1","2","3","4","5","6","7"))
data$a_baseline2.factor = factor(data$a_baseline2,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$a_baseline3.factor = factor(data$a_baseline3,levels=c("1","2"))
data$a_baseline5.factor = factor(data$a_baseline5,levels=c("1","2","3","4","5"))
data$a_baseline6.factor = factor(data$a_baseline6,levels=c("1","2"))
data$a_baseline8.factor = factor(data$a_baseline8,levels=c("1","2","3","4"))
data$adult_baseline_survey_complete.factor = factor(data$adult_baseline_survey_complete,levels=c("0","1","2"))
data$dtbchi_freq1.factor = factor(data$dtbchi_freq1,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq2.factor = factor(data$dtbchi_freq2,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq3.factor = factor(data$dtbchi_freq3,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq4.factor = factor(data$dtbchi_freq4,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq5.factor = factor(data$dtbchi_freq5,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq6.factor = factor(data$dtbchi_freq6,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq7.factor = factor(data$dtbchi_freq7,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq8.factor = factor(data$dtbchi_freq8,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq9.factor = factor(data$dtbchi_freq9,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq10.factor = factor(data$dtbchi_freq10,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq11.factor = factor(data$dtbchi_freq11,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq12.factor = factor(data$dtbchi_freq12,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq13.factor = factor(data$dtbchi_freq13,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq_14.factor = factor(data$dtbchi_freq_14,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq15.factor = factor(data$dtbchi_freq15,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq16.factor = factor(data$dtbchi_freq16,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq17.factor = factor(data$dtbchi_freq17,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq18.factor = factor(data$dtbchi_freq18,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_freq19.factor = factor(data$dtbchi_freq19,levels=c("0","1","2","3","4","5","6","7"))
data$dtbchi_length1.factor = factor(data$dtbchi_length1,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length2.factor = factor(data$dtbchi_length2,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length3.factor = factor(data$dtbchi_length3,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length4.factor = factor(data$dtbchi_length4,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length5.factor = factor(data$dtbchi_length5,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length6.factor = factor(data$dtbchi_length6,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length7.factor = factor(data$dtbchi_length7,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length8.factor = factor(data$dtbchi_length8,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length9.factor = factor(data$dtbchi_length9,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length10.factor = factor(data$dtbchi_length10,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length11.factor = factor(data$dtbchi_length11,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length12.factor = factor(data$dtbchi_length12,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length13.factor = factor(data$dtbchi_length13,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length14.factor = factor(data$dtbchi_length14,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length15.factor = factor(data$dtbchi_length15,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length16.factor = factor(data$dtbchi_length16,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length17.factor = factor(data$dtbchi_length17,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length18.factor = factor(data$dtbchi_length18,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_length19.factor = factor(data$dtbchi_length19,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset1.factor = factor(data$dtbchi_upset1,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset2.factor = factor(data$dtbchi_upset2,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset3.factor = factor(data$dtbchi_upset3,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset4.factor = factor(data$dtbchi_upset4,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset5.factor = factor(data$dtbchi_upset5,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset6.factor = factor(data$dtbchi_upset6,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset7.factor = factor(data$dtbchi_upset7,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset8.factor = factor(data$dtbchi_upset8,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset9.factor = factor(data$dtbchi_upset9,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset10.factor = factor(data$dtbchi_upset10,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset11.factor = factor(data$dtbchi_upset11,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset12.factor = factor(data$dtbchi_upset12,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset13.factor = factor(data$dtbchi_upset13,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset14.factor = factor(data$dtbchi_upset14,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset15.factor = factor(data$dtbchi_upset15,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset16.factor = factor(data$dtbchi_upset16,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset17.factor = factor(data$dtbchi_upset17,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset18.factor = factor(data$dtbchi_upset18,levels=c("0","1","2","3","4","5","6"))
data$dtbchi_upset19.factor = factor(data$dtbchi_upset19,levels=c("0","1","2","3","4","5","6"))
data$diabetes_treatmentrelated_burden_child_complete.factor = factor(data$diabetes_treatmentrelated_burden_child_complete,levels=c("0","1","2"))

levels(data$redcap_event_name.factor)=c("Baseline (Arm 1: Child)","1 (Arm 1: Child)","2 (Arm 1: Child)","3 (Arm 1: Child)","4 (Arm 1: Child)","5 (Arm 1: Child)","6 (Arm 1: Child)","Baseline (Arm 2: Young Adult )","1 (Arm 2: Young Adult )","2 (Arm 2: Young Adult )","3 (Arm 2: Young Adult )","4 (Arm 2: Young Adult )","5 (Arm 2: Young Adult )","6 (Arm 2: Young Adult )","Baseline (Arm 3: Adult)","1 (Arm 3: Adult)","2 (Arm 3: Adult)","3 (Arm 3: Adult)","4 (Arm 3: Adult)","5 (Arm 3: Adult)")
levels(data$child_ya.factor)=c("Child (0-17 years)","Adult (18+ years)")
levels(data$demographics_hcl.factor)=c("670G","Control IQ")
levels(data$demographics_ethnicity.factor)=c("Hispanic or Latino","NOT Hispanic or Latino","Unknown / Not Reported")
levels(data$demographics_race.factor)=c("American Indian/Alaska Native","Asian","Native Hawaiian or Other Pacific Islander","Black or African American","White","More Than One Race","Unknown / Not Reported")
levels(data$demographics_sex.factor)=c("Female","Male")
levels(data$demographics_insurance.factor)=c("Public","Private","Other","Uninsured")
levels(data$demographics_pumphx.factor)=c("< 1 month","1-6 months","6 mnths - 1 yr","1-3 years","3-5 years",">5 years","None")
levels(data$demographics_cgmhx.factor)=c("< 1 month","1-6 months","6 mnths - 1 yr","1-3 years","3-5 years",">5 years","None")
levels(data$demographics_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$gyl_timepoint.factor)=c("Baseline","Month 1/ Training F/U","3 Months","6 Months","9 Months","12 Months")
levels(data$glycemic_data_2d4b_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$timepoint.factor)=c("Baseline","Month 1/ Training F/U","3 Months","6 Months","9 Months","12 Months")
levels(data$baseline_surveys_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$tech1.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$tech2.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$tech3.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$tech4.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$tech5.factor)=c("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(data$diabetes_technology_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$inspire_b1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b6.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b7.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b8.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b9.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b10.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b11.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b12.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b13.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b14.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b15.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b16.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b17.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_youth_baseline_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$inspire_f1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f6.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f7.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f8.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f9.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f10.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f11.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f12.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f13.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f14.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f15.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f16.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f17.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_youth_follow_up_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$ya_baseline1.factor)=c("< $25,000 per year","$25,000 to less than $35,000 per year","$35,000 to less than $50,000 per year","$50,000 to less than $75,000 per year","$75,000 to less than $100,000 per year","$100,000 or more per year","Decline to answer")
levels(data$ya_baseline2.factor)=c("Not Known/ Decline to answer","< 7th grade","Junior High School","Partial High School (10th or 11th grade)","High School Graduate/GED","Partial College","Associates Degree","Bachelors Degree","Masters Degree","Doctorate Degree")
levels(data$ya_baseline3.factor)=c("Not Known/ Decline to answer","< 7th grade","Junior High School","Partial High School (10th or 11th grade)","High School Graduate/GED","Partial College","Associates Degree","Bachelors Degree","Masters Degree","Doctorate Degree")
levels(data$ya_baseline4.factor)=c("Yes","No")
levels(data$ya_baseline6.factor)=c("Animas (One Touch Ping or Vibe)","Medtronic (530G, 630G)","Tandem (t:slim x2)","Omnipod (Omnipod system or Omnipod dash system)","Other")
levels(data$ya_baseline7.factor)=c("Yes","No")
levels(data$ya_baseline9.factor)=c("Medtronic (Guardian 3 or Enlite)","Dexcom (Dexcom G4, G5 or G6)","Freestyle Libre","Other")
levels(data$ya_baseline_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$ya_paid1.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid2.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid3.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid4.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid5.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid6.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid7.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid8.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid9.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid10.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid11.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid12.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid13.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid14.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid15.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid16.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid17.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid18.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid19.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid20.factor)=c("Not a problem","Minor problem","Moderate problem","Somewhat serious problem","Serious Problem")
levels(data$ya_paid_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$ya_hfs_b_behave1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave6.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave7.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave8.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave9.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave10.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave11.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave12.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave13.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave14.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_behave15.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry16.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry17.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry18.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry19.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry20.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry21.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry22.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry23.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry24.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry25.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry26.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry27.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry28.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry29.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry30.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry31.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry32.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_b_worry33.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs__b_hypo_sev.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(data$ya_hfs_b_hypo_sev_upset.factor)=c("0 Not Upsetting at all","1","2 Somewhat upsettin","3","4 Extremely upsetting")
levels(data$ya_hfs_b_hypo_mod.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(data$ya_hfs_b_hypo_mod_upset.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely Upsetting")
levels(data$ya_hfs_b_hypo_mild.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(data$ya_hfs_b_hypo_mild_upset.factor)=c("0 Not at all Upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(data$ya_hfs_baseline_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$ya_hfs_f_behave1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave6.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave7.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave8.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave9.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave10.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave11.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave12.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave13.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave14.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_behave15.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry16.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry17.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry18.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry19.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry20.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry21.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry22.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry23.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry24.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry25.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry26.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry27.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry28.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry29.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry30.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry31.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry32.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_worry33.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$ya_hfs_f_hypo_sev.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(data$ya_hfs_f_hypo_sev_upset.factor)=c("0 Not Upsetting at all","1","2 Somewhat upsettin","3","4 Extremely upsetting")
levels(data$ya_hfs_f_hypo_mod.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(data$ya_hfs_f_hypo_mod_upset.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely Upsetting")
levels(data$ya_hfs_f_hypo_mild.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(data$ya_hfs_f_hypo_mild_upset.factor)=c("0 Not at all Upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(data$ya_hfs_follow_up_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$c_hfs_behave1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_behave2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_behave3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_behave4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_behave5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_behave6.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_behave7.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_behave8.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_behave9.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_behave10.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry11.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry12.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry13.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry14.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry15.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry16.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry17.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry18.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry19.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry20.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry21.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry22.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry23.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry24.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$c_hfs_worry25.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(data$child_hfs_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$c_paid1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid6.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid7.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid8.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid9.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid10.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid11.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid12.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid13.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid14.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid15.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid16.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid17.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid18.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid19.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$c_paid20.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(data$child_paid_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$inspire_b1_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b2_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b3_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b4_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b5_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b6_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b7_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b8_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b9_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b10_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b11_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b12_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b13_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b14_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b15_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b16_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b17_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b18_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b19_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b20_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b21_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_b22_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_adult_baseline_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$inspire_f1_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f2_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f3_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f4_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f5_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f6_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f7_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f8_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f9_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f10_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f11_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f12_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f13_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f14_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f15_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f16_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f17_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f18_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f19_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f20_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f21_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_f22_adult.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(data$inspire_adult_follow_up_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$a_baseline1.factor)=c("< $25,000 per year","$25,000 to less than $35,000 per year","$35,000 to less than $50,000 per year","$50,000 to less than $75,000 per year","$75,000 to less than $100,000 per year","$100,000 or more per year","Decline to answer")
levels(data$a_baseline2.factor)=c("Not Known/ Decline to answer","< 7th grade","Junior High School","Partial High School (10th or 11th grade)","High School Graduate/GED","Partial College","Associates Degree","Bachelors Degree","Masters Degree","Doctorate Degree")
levels(data$a_baseline3.factor)=c("Yes","No")
levels(data$a_baseline5.factor)=c("Animas (One Touch Ping or Vibe)","Medtronic (530G, 630G)","Tandem (t:slim x2)","Omnipod (Omnipod system or Omnipod dash system)","Other")
levels(data$a_baseline6.factor)=c("Yes","No")
levels(data$a_baseline8.factor)=c("Medtronic (Guardian 3 or Enlite)","Dexcom (Dexcom G4, G5 or G6)","Freestyle Libre","Other")
levels(data$adult_baseline_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$dtbchi_freq1.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq2.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq3.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq4.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq5.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq6.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq7.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq8.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq9.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq10.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq11.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq12.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq13.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq_14.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq15.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq16.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq17.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq18.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_freq19.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week","Almost never")
levels(data$dtbchi_length1.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length2.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length3.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length4.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length5.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length6.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length7.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length8.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length9.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length10.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length11.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length12.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length13.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length14.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length15.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length16.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length17.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length18.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_length19.factor)=c("5 seconds","10 seconds","30 seconds","1 minute","5 minutes","15 minutes","1 hour")
levels(data$dtbchi_upset1.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset2.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset3.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset4.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset5.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset6.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset7.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset8.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset9.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset10.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset11.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset12.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset13.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset14.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset15.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset16.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset17.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset18.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$dtbchi_upset19.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(data$diabetes_treatmentrelated_burden_child_complete.factor)=c("Incomplete","Unverified","Complete")
