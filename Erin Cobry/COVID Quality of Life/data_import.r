#Read Data
data=read.csv('./Erin Cobry/COVID Quality of Life/Data_Raw/HealthRelatedQuality_DATA_2021-07-13_1006.csv',na.strings = "")
#Setting Labels
label(data$record_id)="Record ID"
label(data$redcap_event_name)="Event Name"
label(data$redcap_survey_identifier)="Survey Identifier"
label(data$covid_t1d_study_econsent_and_assent_timestamp)="Survey Timestamp"
label(data$first_name)="Parent First Name"
label(data$last_name)="Parent Last Name"
label(data$date)="Todays Date"
label(data$child_first_name)="Childs First Name"
label(data$child_last_name)="Childs Last Name"
label(data$email)="Best email address"
label(data$phone)="Best Phone Number"
label(data$phone_type)="Phone Type"
label(data$study_goal)="What is the goal of the study?"
label(data$start)="You will be asked to complete surveys on several occasions over the next 12 months. "
label(data$duration)="How long will the study last?"
label(data$signature)="Parent or Guardian Signature"
label(data$signature_date)="Date of Signature"
label(data$child_consent_agreement)="Is the Child between the ages of 13 and 17?"
label(data$child_consent_signature)="Child (13-17 years) Signature"
label(data$child_consent_date)="Date of Signature"
label(data$staff_signature)="Signature of Person Obtaining Consent"
label(data$staff_consent_sig_date)="Date of Signature"
label(data$assent_age)="Is the Child between the ages of 7 and 12?"
label(data$assent_agreement)="Do you want to be in the study at this time?"
label(data$assent_signature)="Child (7-12 years) Signature"
label(data$assent_signature_date)="Date of Signature"
label(data$staff_assent_signature)="Signature of Person Obtaining Assent"
label(data$staff_assent_signature_date)="Date of Signature"
label(data$covid_t1d_study_econsent_and_assent_complete)="Complete?"
label(data$covid_t1d_study_econsent_and_assent_if_needed_timestamp)="Survey Timestamp"
label(data$first_name_v2)="Parent First Name"
label(data$last_name_v2)="Parent Last Name"
label(data$date_v2)="Todays Date"
label(data$child_first_name_v2)="Childs First Name"
label(data$child_last_name_v2)="Childs Last Name"
label(data$email_v2)="Best email address (if you prefer to use a different email from parent email already listed)"
label(data$study_goal_v2)="What is the goal of the study?"
label(data$start_v2)="You will be asked to complete surveys on several occasions over the next 12 months. "
label(data$duration_v2)="How long will the study last?"
label(data$signature_v2)="Participant/Parent or Guardian Signature"
label(data$signature_date_v2)="Date of Signature"
label(data$child_consent_agreement_v2)="Is the Child between the ages of 13 and 17?"
label(data$child_consent_signature_v2)="Child (13-17 years) Signature"
label(data$child_consent_date_v2)="Date of Signature"
label(data$staff_signature_v2)="Signature of Person Obtaining Consent"
label(data$staff_consent_sig_date_v2)="Date of Signature"
label(data$assent_age_v2)="Is the child between the ages of 7 and 12?"
label(data$assent_agreement_v2)="Do you want to be in the study at this time?"
label(data$assent_signature_v2)="Child (7-12 years) Signature"
label(data$assent_signature_date_v2)="Date of Signature"
label(data$staff_assent_signature_v2)="Signature of Person Obtaining Assent"
label(data$staff_assent_signature_date_v2)="Date of Signature"
label(data$covid_t1d_study_econsent_and_assent_if_needed_complete)="Complete?"
label(data$consent_date)="Consent date"
label(data$child_dob)="Child date of birth"
label(data$child_age)="Child age"
label(data$t1d_dx)="Date of T1D diagnosis"
label(data$t1d_duration)="Duration of T1D"
label(data$gender)="Gender"
label(data$child_insurance)="Insurance"
label(data$city)="Home address City"
label(data$state)="Home address State"
label(data$zip_code)="Home address zip code"
label(data$race)="Child Race/ethnicity"
label(data$parent_occupation)="Parent Occupation (if available)"
label(data$participant_demographics_complete)="Complete?"
label(data$parent_survey_header_timestamp)="Survey Timestamp"
label(data$parent_first_name)="First Name"
label(data$parent_last_name)="Last Name"
label(data$today_s_date)="Todays date"
label(data$parent_survey_header_complete)="Complete?"
label(data$child_survey_header_timestamp)="Survey Timestamp"
label(data$child_name)="Child First Name"
label(data$childs_last_name)="Child Last Name"
label(data$todays_date)="Todays date"
label(data$child_survey_header_complete)="Complete?"
label(data$promis_child_self_report_ages_517_bee0_timestamp)="Survey Timestamp"
label(data$satisfied)="I was satisfied with my life"
label(data$happy_life)="I was happy with my life"
label(data$good_life)="I had a good life"
label(data$wanted_life)="I had what I wanted in life"
label(data$tired_body)="How many days did you exercise or play so hard that your body got tired?"
label(data$exercise_hard)="How many days did you exercise really hard for 10 minutes or more?"
label(data$exercise_breath)="How many days did you exercise so much that you breathed hard?"
label(data$days_sweated)="How many days were you so physically active that you sweated?"
label(data$child_happy)="I felt happy"
label(data$child_great)="I felt great"
label(data$child_cheerful)="I felt cheerful"
label(data$child_joyful)="I felt joyful"
label(data$child_stressed)="I felt stressed"
label(data$child_piling)="I felt that my problems kept piling up"
label(data$child_felt_overwhelmed)="I felt overwhelmed"
label(data$child_manage)="I felt unable to manage things in my life"
label(data$fed_up)="I felt fed up"
label(data$child_felt_mad)="I felt mad"
label(data$child_felt_upset)="I felt upset"
label(data$child_felt_throwing)="I was so angry I felt like throwing something"
label(data$child_felt_yelling)="I was so angry I felt like yelling at somebody"
label(data$child_happen)="I felt like something awful might happen"
label(data$child_nervous)="I felt nervous"
label(data$child_scared)="I felt scared"
label(data$child_felt_worried)="I felt worried"
label(data$child_worried_home)="I worried when I was at home"
label(data$child_got_scared)="I got scared really easy"
label(data$child_worried_happen)="I worried about what could happen to me"
label(data$child_worried_night)="I worried when I went to bed at night"
label(data$child_feel_sad)="I could not stop feeling sad"
label(data$child_alone)="I felt alone"
label(data$child_wrong)="I felt everything in my life went wrong"
label(data$child_right)="I felt like I couldnt do anything right"
label(data$child_lonely)="I felt lonely"
label(data$child_felt_sad)="I felt sad"
label(data$child_unhappy)="I felt unhappy"
label(data$child_hard_fun)="It was hard for me to have fun"
label(data$accepted)="I felt accepted by other kids my age"
label(data$count)="I was able to count on my friends"
label(data$talk)="I was able to talk about everything with my friends"
label(data$friends)="I was good at making friends"
label(data$help)="My friends and I helped each other out"
label(data$wanted)="Other kids wanted to be my friend"
label(data$wanted_me)="Other kids wanted to be with me"
label(data$talk_to_me)="Other kids wanted to talk to me"
label(data$strong_family)="I felt I had a strong relationship with my family"
label(data$important_family)="I felt really important to my famliy"
label(data$needed_family)="I got all the help I needed from my family"
label(data$fun_together)="My family and I had fun together"
label(data$family_good)="People in my family made me feel good about myself"
label(data$family_fair)="My family treated me fairly"
label(data$parents_listened)="My parents listened to me"
label(data$attention_to_me)="My family paid a lot of attention to me"
label(data$bedtime_routine)="I followed a bedtime routine before falling asleep"
label(data$tv_sleep)="I watched TV shows or videos just before falling asleep"
label(data$child_video_games)="I played video or computer games just before falling asleep"
label(data$same_time)="I tried to fall asleep at about the same time every night"
label(data$someone_with)="I needed someone with me to fall asleep"
label(data$device)="I used a phone, computer, or electronic device just before falling asleep"
label(data$same_time_mornings)="I woke up at about the same time every morning"
label(data$promis_child_sleep1)="What time do you try to fall asleep on weekday nights?"
label(data$promis_child_sleep2)="What time do you wake up on weekdays?"
label(data$promis_child_sleep3)="What time do you try to fall asleep on weekend nights?"
label(data$promis_child_sleep4)="What time do you wake up on weekends?"
label(data$child_falling)="I had difficulty falling asleep"
label(data$child_slept)="I slept through the night"
label(data$child_sleep_problem)="I had a problem with my sleep"
label(data$child_trouble_sleep)="I had trouble sleeping"
label(data$child_sleepy)="I was sleepy during the daytime"
label(data$child_concentrating)="I had a hard time concentrating because I was sleepy"
label(data$child_done)="I had a hard time getting things done because I was sleepy"
label(data$child_problems_day)="I had problems during the day because of poor sleep"
label(data$promis_child_self_report_ages_517_bee0_complete)="Complete?"
label(data$promis_parent_proxy_ages_517_timestamp)="Survey Timestamp"
label(data$child_mad)="My child felt mad"
label(data$child_yelling)="My child was so angry he/she felt like yelling at somebody"
label(data$child_throwing)="My child was so angry he/she felt like throwing something"
label(data$child_upset)="My child felt upset"
label(data$child_stay_mad)="When my child got mad, he/she stayed mad"
label(data$body_tired)="How many days did your child exercise or play so hard that his/her body got tired?"
label(data$minutes)="How many days did your child exercise really hard for 10 minutes or more?"
label(data$breath_hard)="How many days did your child exercise so much that he/she breathed hard?"
label(data$sweat)="How many days was your child so physically active that he/she sweated?"
label(data$happy)="My child felt happy"
label(data$great)="My child felt great"
label(data$cheerful)="My child felt cheerful"
label(data$joyful)="My child felt joyful"
label(data$stressed)="My child felt stressed"
label(data$piling_up)="My child felt that his/her problems kept piling up"
label(data$child_overwhelmed)="My child felt overwhelmed"
label(data$manage)="My child felt unable to manage things in his/her life"
label(data$nervous)="My child felt nervous"
label(data$scared)="My child felt scared"
label(data$child_worried)="My child felt worried"
label(data$awful)="My child felt like something awful might happen"
label(data$worried_home)="My child worried when he/she was at home"
label(data$scared_easy)="My child got scared really easy"
label(data$worried_happen)="My child worried about what could happen to him/her"
label(data$worried_bed)="My child worried when he/she went to bed at night"
label(data$feeling_sad)="My child could not stop feeling sad"
label(data$went_wrong)="My child felt everything in his/her life went wrong"
label(data$anything_right)="My child felt like he/she couldnt do anything right"
label(data$lonely)="My child felt lonely"
label(data$felt_sad)="My child felt sad"
label(data$hard_fun)="It was hard for my child to have fun"
label(data$strong)="My child felt he/she had a strong relationship with our family"
label(data$important)="My child felt he/she was really important to our family"
label(data$needed)="My child felt he/she got all the help he/she needed from our family"
label(data$fun)="Our family and my child had fun together"
label(data$feel_good)="People in our family made my child feel good about himself/herself"
label(data$treated_fair)="My child felt out family treated him/her fairly"
label(data$listened)="We (parents) listened to our child"
label(data$attention)="Our family paid a lot of attention to my child"
label(data$routine)="My child followed a bedtime routine before falling asleep"
label(data$tv)="My child watched TV shows or videos just before falling asleep"
label(data$video_games)="My child played video or computer games just before falling asleep"
label(data$asleep)="My child tried to fall asleep at about the same time every night"
label(data$someone)="My child needed someone with him/her to fall asleep"
label(data$electronic)="My child used a phone, computer, or electronic device just before falling asleep"
label(data$woke)="My child woke up at about the same time every morning"
label(data$promis_proxy_sleep2)="What time does your child try to fall asleep on weekday nights?"
label(data$promis_proxy_sleep3)="What time does your child wake up on weekdays?"
label(data$promis_proxy_sleep4)="What time does your child try to fall asleep on weekend nights?"
label(data$promis_proxy_sleep5)="What time does your child wake up on weekends?"
label(data$diff_sleep)="My child had difficulty falling asleep"
label(data$slept_night)="My child slept through the night"
label(data$prob_sleep)="My child had a problem with his/her sleep"
label(data$troub_sleep)="My child had trouble sleeping"
label(data$sleepy_day)="My child was sleepy during the daytime"
label(data$concent_hard)="My child had a hard time concentrating because he/she was sleepy"
label(data$get_done)="My child had a hard time getting things done because he/she was sleepy"
label(data$probl_day)="My child had problems during the day because of poor sleep"
label(data$promis_parent_proxy_ages_517_complete)="Complete?"
label(data$promis_parent_self_report_all_child_ages_timestamp)="Survey Timestamp"
label(data$fearful)="I felt fearful"
label(data$hard_anxiety)="I found it hard to focus on anything other than my anxiety"
label(data$overwhelmed)="My worries overwhelmed me"
label(data$uneasy)="I fetl uneasy"
label(data$worthless)="I felt worthless"
label(data$helpess)="I felt helpless"
label(data$depressed)="I felt depressed"
label(data$hopeless)="I felt hopeless"
label(data$sleep_quality)="My sleep quality was"
label(data$refreshing)="My sleep was refreshing"
label(data$problem)="I had a problem with my sleep"
label(data$difficulty)="I had difficulty falling asleep"
label(data$hard_time)="I had a hard time getting things done because I was sleepy"
label(data$during_day)="I had problems during the day because of poor sleep"
label(data$concentrating)="I had a hard time concentrating because of poor sleep"
label(data$sleepy)="I was sleep during the daytime"
label(data$promis_parent_self_report_all_child_ages_complete)="Complete?"
label(data$pedsql_child_self_report_ages_57_timestamp)="Survey Timestamp"
label(data$ychild_hungry)="Do you feel hungry"
label(data$ychild_thirsty)="Do you feel thirsty"
label(data$ychild_bathroom)="Do you have to go to the bathroom a lot"
label(data$ychild_stomachache)="Do you have stomachaches"
label(data$ychild_headaches)="Do you have headaches"
label(data$ychild_low)="Do you go low"
label(data$ychild_tired)="Do you feel tired or fatigued"
label(data$ychild_shaky)="Do you get shaky"
label(data$ychild_sweaty)="Do you get sweaty"
label(data$ychild_sleeping)="Do you have trouble sleeping"
label(data$ychild_irritable)="Do you get irritable"
label(data$ychild_finger)="Does it hurt to prick your finger and give insulin shots"
label(data$ychild_embarrassed)="Are you embarrassed about having diabetes"
label(data$ychild_argue)="Do you and your parents argue about diabetes care"
label(data$ychild_plan)="It is hard for you to stick to your diabetes care plan"
label(data$ychild_tests)="It is hard for you to take blood glucose tests"
label(data$ychild_shots)="It is hard for you to take insulin shots"
label(data$ychild_exercise)="It is hard for you to exercise"
label(data$ychild_carb)="Is it hard for you to keep track of carbohydrates or exchanges"
label(data$ychild_id)="Is it hard for you to wear my id bracelet"
label(data$ychild_carry)="Is it hard for you to carry a fast-acting carbohydrate"
label(data$ychild_snacks)="Is it hard for you to eat snacks"
label(data$ychild_go_low)="Do you worry about going low"
label(data$ychild_worry_treat)="Do you worry about whether or not your medical treatment are working"
label(data$ychild_problem)="Do you worry about problem from diabetes"
label(data$ychild_doctors)="Is it hard for you to tell the doctors and nurses how you feel"
label(data$ychild_ask)="Is it hard for you to ask the doctors and nurses questions"
label(data$ychild_explain)="Is it hard for you to explain your illness to other people"
label(data$pedsql_child_self_report_ages_57_complete)="Complete?"
label(data$pedsql_child_self_report_ages_817_timestamp)="Survey Timestamp"
label(data$feel_hungry)="I feel hungry"
label(data$feel_thirsty)="I feel thirsty"
label(data$bathroom_often)="I have to go to the bathroom too often"
label(data$have_stomachaches)="I have stomachaches"
label(data$have_headaches)="I have headaches"
label(data$go_low)="I go low"
label(data$tired_fatigued)="I feel tired or fatigued"
label(data$get_shaky)="I get shaky"
label(data$get_sweaty)="I get sweaty"
label(data$sleeping_trouble)="I have trouble sleeping"
label(data$get_irritable)="I get irritable"
label(data$hurts_shots)="It hurts to prick my finger or give insulin shots"
label(data$embarrasses_diabetes)="I am embarrassed about having diabetes"
label(data$argue_parents)="My parents and I argue about my diabetes care"
label(data$hard_care_plan)="It is hard for me to stick to my diabetes care plan"
label(data$hard_tests)="It is hard for me to take blood glucose tests"
label(data$hard_shots)="It is hard for me to take insulin shots"
label(data$hard_exercise)="It is hard for me to exercise"
label(data$hard_carbohydrates)="It is hard for me to keep track of carbohydrates or exchanges"
label(data$hard_id)="It is hard for me to wear my id bracelet"
label(data$hard_fast_acting)="It is hard for me to carry a fast-acting carbohydrate"
label(data$hard_snacks)="It is hard for me to eat snacks"
label(data$worry_low)="I worry about going low"
label(data$worry_treatments)="I worry about whether or not my medical treatments are working"
label(data$worry_complications)="I worry about long-term complications from diabetes"
label(data$hard_doctors)="It is hard for me to tell the doctors and nurses how I feel"
label(data$hard_ask)="It is hard for me to ask the doctors and nurses questions"
label(data$hard_explain)="It is hard for me to explain my illness to other people"
label(data$pedsql_child_self_report_ages_817_complete)="Complete?"
label(data$pedsql_parent_proxy_all_ages_timestamp)="Survey Timestamp"
label(data$hungry)="Feeling hungry"
label(data$thirsty)="Feeling thirsty"
label(data$bathroom)="Having to go to the bathroom too often"
label(data$stomachaches)="Having stomachaches"
label(data$headaches)="Having headaches"
label(data$low)="Going low"
label(data$tired)="Feeling tired or fatigued"
label(data$shaky)="Getting shaky"
label(data$sweaty)="Getting sweaty"
label(data$trouble_sleeping)="Having trouble sleeping"
label(data$irritable)="Getting irritable"
label(data$pain)="Needle sticks (i.e. injections/blood tests) causing him/her pain"
label(data$arguing)="Arguing with me or my spouse about diabetes care"
label(data$embarrassed)="Getting embarrassed about having diabetes"
label(data$plan)="Sticking to his/her diabetes care plan"
label(data$tests)="It is hard for my child to take blood glucose tests"
label(data$shots)="It is hard for my child to take insulin shots"
label(data$exercise)="It is hard for my child to exercise"
label(data$cho)="It is hard to track carbohydrates or exchanges for my child"
label(data$id)="It is hard for my child to wear his/her id bracelet"
label(data$fast_acting)="It is hard to carry a fast-acting carbohydrate for my child"
label(data$snacks)="It is hard to give my child snacks"
label(data$going_low)="Worrying about going low"
label(data$working)="Worrying about whether or not medical treatments are working"
label(data$complications)="Worrying about long-term complications or diabetes"
label(data$feels)="Telling the doctors and nurses how he/she feels"
label(data$questions)="Asking the doctors or nurses questions"
label(data$explaining)="Explaining his/her illness to other people"
label(data$pedsql_parent_proxy_all_ages_complete)="Complete?"
label(data$parent_covid19_questions_all_child_ages_timestamp)="Survey Timestamp"
label(data$parent_questions)="On Average, how many hours a day has your child spent watching TV/movies/videos over the past month?"
label(data$parent_questions_2)="How does this amount of TV time compare to your usual routine before COVID-19?"
label(data$parent_questions_3)="On average, how many hours a day has your child spent on electronics (not including TV/movies/videos or doing school-related activities) over the past month?"
label(data$parent_questions_4)="How does this amount of electronic time compare to your usual routine before COVID-19?"
label(data$parent_questions_5)="On average, how much time each day has your child engaged in physical activity over the past month?"
label(data$parent_questions_6)="How does this amount of physical activity compare to your usual family routine before COVID-19?"
label(data$parent_questions_7)="How many hours a week did your child spend interacting with other children (who are not in your family) during the past month?"
label(data$parent_questions_8)="What methods did you/your child use MOST to connect with peers?"
label(data$parent_questions_8_other)="If other: "
label(data$parent_questions_9)="How does this amount of peer interaction compare to your childs usual routine before COVID-19?"
label(data$parent_covid19_questions_all_child_ages_complete)="Complete?"
label(data$parent_self_report_cefis_covid_questionnaire_all_c_timestamp)="Survey Timestamp"
label(data$stay_at_home)="We had a stay at home order"
label(data$schools)="Our schools/child care centers were closed"
label(data$education)="Our child/rens education was disrupted"
label(data$family)="We were unable to visit or care for a family member"
label(data$separately)="Our family lived separately for health, safety or job demands"
label(data$moved_in)="Someone moved into (or back into) our home"
label(data$moved_out)="We had to move out of our home"
label(data$work_outside_home)="Someone in the family kept working outside the home (essential personnel)"
label(data$healthcare)="Someone in the family is a healthcare provider/first responder providing direct care"
label(data$food)="We had difficulty getting food"
label(data$medicine)="We had difficulty getting medicine"
label(data$needed_healthcare)="We had difficulty getting health care when we needed it"
label(data$essentials)="We had difficulty getting other essentials"
label(data$self_quarantine)="We self-quarantined due to travel or possible exposure"
label(data$income)="Our family income decreased"
label(data$hours)="A member of the family had to cut back hours at work"
label(data$stop_working)="A member of the family was required to stop working (expect to be called back)"
label(data$lost_job)="A member of the family lost their job permanently"
label(data$insurance)="We lost health insurance/benefits"
label(data$family_event)="We missed an important family event or it was canceled (e.g. wedding, graduation, birth, funeral, travel [including vacation], other)"
label(data$exposed)="Someone in the family was exposed to someone with COVID-19"
label(data$diagnosed)="Someone in the family had symptoms or was diagnosed with COVID-19"
label(data$hospitalized)="Someone in the family was hospitalized for COVID-19"
label(data$icu)="Someone in the family was in the Intensive Care Unit (ICU) for COVID-19"
label(data$died)="Someone in the family died from COVID-19"
label(data$essentials_yes)="You answered Yes to the Question: We had difficulty getting other essentials. Please specify:"
label(data$exposed_who)="You answered Yes to the Question: Someone in the family was exposed to someone with COVID-19.  Please describe who (e.g. Myself, my child, my spouse, my parent, etc)"
label(data$diagnosed_who)="You answered Yes to the Question: Someone in the family had symptoms or was diagnosed with COVID-19.  Please describe Who (e.g. myself, my child, my spouse, my parent, etc):"
label(data$hospitalized_who)="You answered Yes to the Question: Someone in the family was hospitalized for COVID-19.  Please describe Who (e.g. myself, my child, my spouse, my parent, etc):"
label(data$icu_who)="You answered Yes to the Question: Someone in the family was in the Intensive Care Unit (ICU) for COVID-19.  Please describe Who (e.g. myself, my child, my spouse, my parent, etc):"
label(data$died_who)="You answered Yes to the Question: Someone in the family died from COVID-19.  Please describe Who (e.g. myself, my child, my spouse, my parent, etc):"
label(data$parenting)="Parenting"
label(data$get_along)="How family members get along with each other"
label(data$care_for_child)="Ability to care for your child with (add illness/condition)"
label(data$other_children)="Ability to care for other children in your family"
label(data$disabilties)="Ability to care for older adults or people with disabilities in your family"
label(data$wellbeing)="Your physical wellbeing - exercise"
label(data$eating)="Your physical wellbeing - eating"
label(data$sleeping)="Your physical wellbeing - sleeping"
label(data$anxiety)="Your emotional wellbeing - anxiety"
label(data$mood)="Your emotional wellbeing - mood"
label(data$distress)="Overall, how much distress have you experienced related to COVID-19?"
label(data$child_distress)="In general, across all your children, how much distress have your children experienced related to COVID-19?"
label(data$effects_of_covid)="Part 3. Please tell us about other effects of COVID-19 on your child/ren and your family, both negative and/or positive."
label(data$parent_self_report_cefis_covid_questionnaire_all_c_complete)="Complete?"
label(data$brief_infant_sleep_questionnaire_ages_34_timestamp)="Survey Timestamp"
label(data$ready_for_bed)="What time do you usually start your childs bedtime routine (start getting your child ready for bed)?  I start getting my child ready for bed at: ___:___"
label(data$same_routine)="In a typical week, how often does your child have the exact same bedtime routine?"
label(data$where_sleep)="Where does your child usually fall asleep at bedtime?"
label(data$how_sleep)="How does your child usually fall asleep at bedtime?"
label(data$feeding)="At bedtime, does your child usually fall asleep while breastfeeding, bottle feeding, or drinking from a sippy cup?"
label(data$time_bed)="What time do you usually put your child to bed at night (lights out)?  I put my child to bed at:  ____:____"
label(data$difficult)="Typically, how difficult is the bedtime?"
label(data$fall_asleep)="How long does it usually take your child to fall asleep?  ______ (Hours), ________ (Minutes)"
label(data$room)="In what room does your child sleep for most of the night?"
label(data$where_sleep_night)="Where does your child sleep for most of the night?"
label(data$wake_during_night)="How many times does your child usually wake during the night?  _______ times per night"
label(data$when_wakes___1)="When your child wakes up during the night, what do you usually do? (Check all that apply) (choice=Pick up my child and put him/her back down while still awake)"
label(data$when_wakes___2)="When your child wakes up during the night, what do you usually do? (Check all that apply) (choice=Bottle feed or give a sippy cup to put my child back to sleep)"
label(data$when_wakes___3)="When your child wakes up during the night, what do you usually do? (Check all that apply) (choice=Breastfeed/nurse my child back to sleep)"
label(data$when_wakes___4)="When your child wakes up during the night, what do you usually do? (Check all that apply) (choice=Play with my child, watch TV, or use/show smartphone/tablet)"
label(data$when_wakes___5)="When your child wakes up during the night, what do you usually do? (Check all that apply) (choice=None of these)"
label(data$awake_at_night)="How much total time during the NIGHT is your child usually awake (between when your child goes to bed and wakes for the day)?Example: If your child wakes up 2 times and is awake for about 15 minutes each time, your childs total time spent awake is 30 minutes. In that case, write 0 hours, 30 minutes.______ Hours _______ Minutes"
label(data$longest_stretch)="What is the longest stretch of time that your child is asleep during the NIGHT without waking up?________ Hours ________ Minutes"
label(data$wake_up)="What time does your child wake up in the morning?  My child wakes up at: ______:______"
label(data$total_sleep)="How much total time does your child spend sleeping during the NIGHT (between when your child goes to bed and wakes for the day)?Example: If your child sleeps for 3 hours, wakes up, then sleep for 5 hours and 30 minutes more, your child sleeps for 8 hours and 30 minutes total.________ Hours _______ Minutes"
label(data$how_well)="How well does your child usually sleep at night?"
label(data$naps)="On a typical DAY, how many naps does your child take (between when your child wakes for the day and goes to bed at night)?  _______ naps"
label(data$nap_time)="How much total time does your child spend sleeping during the DAY (between when your child wakes for the day and goes to bed at night)?Example: If your child took 2 naps and slept 1 hour each time, your childs total time spent sleeping during the day is 2 hours._______ Hours ________ Minutes"
label(data$sleep_problem)="Do you consider your childs sleep a problem?"
label(data$brief_infant_sleep_questionnaire_ages_34_complete)="Complete?"
label(data$child_covid19_question_timestamp)="Survey Timestamp"
label(data$child_question)="COVID-19 has led to a lot of changes for families. Over the past month, how has the stay-at-home or safer-at -home guidelines affected how you take care of your body and medical conditions (like diabetes)?"
label(data$child_covid19_question_complete)="Complete?"
label(data$diabetes_management_questionnaire_timestamp)="Survey Timestamp"
label(data$adjust___1)="Adjust your food or insulin before long periods of physical activity? (choice=Almost Never)"
label(data$adjust___2)="Adjust your food or insulin before long periods of physical activity? (choice=Sometimes)"
label(data$adjust___3)="Adjust your food or insulin before long periods of physical activity? (choice=Half of the time)"
label(data$adjust___4)="Adjust your food or insulin before long periods of physical activity? (choice=Most of the time)"
label(data$adjust___5)="Adjust your food or insulin before long periods of physical activity? (choice=Almost always)"
label(data$check___1)="Check your blood sugar before physical activity? (choice=Almost Never)"
label(data$check___2)="Check your blood sugar before physical activity? (choice=Sometimes)"
label(data$check___3)="Check your blood sugar before physical activity? (choice=Half of the time)"
label(data$check___4)="Check your blood sugar before physical activity? (choice=Most of the time)"
label(data$check___5)="Check your blood sugar before physical activity? (choice=Almost always)"
label(data$check_hours___1)="Check your blood sugar within 2 to 3 hours after physical activity? (choice=Almost Never)"
label(data$check_hours___2)="Check your blood sugar within 2 to 3 hours after physical activity? (choice=Sometimes)"
label(data$check_hours___3)="Check your blood sugar within 2 to 3 hours after physical activity? (choice=Half of the time)"
label(data$check_hours___4)="Check your blood sugar within 2 to 3 hours after physical activity? (choice=Most of the time)"
label(data$check_hours___5)="Check your blood sugar within 2 to 3 hours after physical activity? (choice=Almost always)"
label(data$sugar___1)="Use a blood sugar result to help decide the amount of insulin to give for a meal? (choice=Almost Never)"
label(data$sugar___2)="Use a blood sugar result to help decide the amount of insulin to give for a meal? (choice=Sometimes)"
label(data$sugar___3)="Use a blood sugar result to help decide the amount of insulin to give for a meal? (choice=Half of the time)"
label(data$sugar___4)="Use a blood sugar result to help decide the amount of insulin to give for a meal? (choice=Most of the time)"
label(data$sugar___5)="Use a blood sugar result to help decide the amount of insulin to give for a meal? (choice=Almost Always)"
label(data$carb___1)="Use the amount of carbohydrate to help decide the amount of insulin to give for a meal? (choice=Almost Never)"
label(data$carb___2)="Use the amount of carbohydrate to help decide the amount of insulin to give for a meal? (choice=Sometimes)"
label(data$carb___3)="Use the amount of carbohydrate to help decide the amount of insulin to give for a meal? (choice=Half of the time)"
label(data$carb___4)="Use the amount of carbohydrate to help decide the amount of insulin to give for a meal? (choice=Most of the time)"
label(data$carb___5)="Use the amount of carbohydrate to help decide the amount of insulin to give for a meal? (choice=Almost Always)"
label(data$labels___1)="Use food labels to help count carbohydrates (when food labels were available)? (choice=Almost Never)"
label(data$labels___2)="Use food labels to help count carbohydrates (when food labels were available)? (choice=Sometimes)"
label(data$labels___3)="Use food labels to help count carbohydrates (when food labels were available)? (choice=Half of the time)"
label(data$labels___4)="Use food labels to help count carbohydrates (when food labels were available)? (choice=Most of the time)"
label(data$labels___5)="Use food labels to help count carbohydrates (when food labels were available)? (choice=Almost Always)"
label(data$weigh___1)="Measure or weight food to help count carbohydrates, when eating at home? (choice=Almost Never)"
label(data$weigh___2)="Measure or weight food to help count carbohydrates, when eating at home? (choice=Sometimes)"
label(data$weigh___3)="Measure or weight food to help count carbohydrates, when eating at home? (choice=Half of the time)"
label(data$weigh___4)="Measure or weight food to help count carbohydrates, when eating at home? (choice=Most of the time)"
label(data$weigh___5)="Measure or weight food to help count carbohydrates, when eating at home? (choice=Almost Always)"
label(data$after___1)="Give all of an insulin dose after you finished eating? (choice=Almost Never)"
label(data$after___2)="Give all of an insulin dose after you finished eating? (choice=Sometimes)"
label(data$after___3)="Give all of an insulin dose after you finished eating? (choice=Half of the time)"
label(data$after___4)="Give all of an insulin dose after you finished eating? (choice=Most of the time)"
label(data$after___5)="Give all of an insulin dose after you finished eating? (choice=Almost Always)"
label(data$without_knowing___1)="Eat meals without knowing the amount of carbohydrate? (choice=Almost Never)"
label(data$without_knowing___2)="Eat meals without knowing the amount of carbohydrate? (choice=Sometimes)"
label(data$without_knowing___3)="Eat meals without knowing the amount of carbohydrate? (choice=Half of the time)"
label(data$without_knowing___4)="Eat meals without knowing the amount of carbohydrate? (choice=Most of the time)"
label(data$without_knowing___5)="Eat meals without knowing the amount of carbohydrate? (choice=Almost Always)"
label(data$without_checking___1)="Eat meals without checking a blood glucose? (choice=Almost Never)"
label(data$without_checking___2)="Eat meals without checking a blood glucose? (choice=Sometimes)"
label(data$without_checking___3)="Eat meals without checking a blood glucose? (choice=Half of the time)"
label(data$without_checking___4)="Eat meals without checking a blood glucose? (choice=Most of the time)"
label(data$without_checking___5)="Eat meals without checking a blood glucose? (choice=Almost Always)"
label(data$two_hours___1)="Check your blood sugar within 2 hours after a meal? (choice=Almost Never)"
label(data$two_hours___2)="Check your blood sugar within 2 hours after a meal? (choice=Sometimes)"
label(data$two_hours___3)="Check your blood sugar within 2 hours after a meal? (choice=Half of the time)"
label(data$two_hours___4)="Check your blood sugar within 2 hours after a meal? (choice=Most of the time)"
label(data$two_hours___5)="Check your blood sugar within 2 hours after a meal? (choice=Almost Always)"
label(data$before___1)="Check your blood sugar BEFORE treating a low blood sugar? (choice=Almost Never)"
label(data$before___2)="Check your blood sugar BEFORE treating a low blood sugar? (choice=Sometimes)"
label(data$before___3)="Check your blood sugar BEFORE treating a low blood sugar? (choice=Half of the time)"
label(data$before___4)="Check your blood sugar BEFORE treating a low blood sugar? (choice=Most of the time)"
label(data$before___5)="Check your blood sugar BEFORE treating a low blood sugar? (choice=Almost Always)"
label(data$after_low___1)="Check your blood sugar AFTER treating a low blood sugar? (choice=Almost Never)"
label(data$after_low___2)="Check your blood sugar AFTER treating a low blood sugar? (choice=Sometimes)"
label(data$after_low___3)="Check your blood sugar AFTER treating a low blood sugar? (choice=Half of the time)"
label(data$after_low___4)="Check your blood sugar AFTER treating a low blood sugar? (choice=Most of the time)"
label(data$after_low___5)="Check your blood sugar AFTER treating a low blood sugar? (choice=Almost Always)"
label(data$more_carbs___1)="Over-treat a low blood sugar with more carbohydrates than were needed? (choice=Almost Never)"
label(data$more_carbs___2)="Over-treat a low blood sugar with more carbohydrates than were needed? (choice=Sometimes)"
label(data$more_carbs___3)="Over-treat a low blood sugar with more carbohydrates than were needed? (choice=Half of the time)"
label(data$more_carbs___4)="Over-treat a low blood sugar with more carbohydrates than were needed? (choice=Most of the time)"
label(data$more_carbs___5)="Over-treat a low blood sugar with more carbohydrates than were needed? (choice=Almost Always)"
label(data$insulin___1)="Give a dose of insulin right away based on a correction/sensitivity factor or sliding scale? (choice=Almost Never)"
label(data$insulin___2)="Give a dose of insulin right away based on a correction/sensitivity factor or sliding scale? (choice=Sometimes)"
label(data$insulin___3)="Give a dose of insulin right away based on a correction/sensitivity factor or sliding scale? (choice=Half of the time)"
label(data$insulin___4)="Give a dose of insulin right away based on a correction/sensitivity factor or sliding scale? (choice=Most of the time)"
label(data$insulin___5)="Give a dose of insulin right away based on a correction/sensitivity factor or sliding scale? (choice=Almost Always)"
label(data$after_high___1)="Re-check your blood sugar about 2 hours after giving insulin for a high blood sugar? (choice=Almost Never)"
label(data$after_high___2)="Re-check your blood sugar about 2 hours after giving insulin for a high blood sugar? (choice=Sometimes)"
label(data$after_high___3)="Re-check your blood sugar about 2 hours after giving insulin for a high blood sugar? (choice=Half of the time)"
label(data$after_high___4)="Re-check your blood sugar about 2 hours after giving insulin for a high blood sugar? (choice=Most of the time)"
label(data$after_high___5)="Re-check your blood sugar about 2 hours after giving insulin for a high blood sugar? (choice=Almost Always)"
label(data$ketones___1)="Check ketones when you had 2 blood sugar results in a row above 250-300? (choice=Almost Never)"
label(data$ketones___2)="Check ketones when you had 2 blood sugar results in a row above 250-300? (choice=Sometimes)"
label(data$ketones___3)="Check ketones when you had 2 blood sugar results in a row above 250-300? (choice=Half of the time)"
label(data$ketones___4)="Check ketones when you had 2 blood sugar results in a row above 250-300? (choice=Most of the time)"
label(data$ketones___5)="Check ketones when you had 2 blood sugar results in a row above 250-300? (choice=Almost Always)"
label(data$eight_hours___1)="Go more than 8 hours without checking your blood sugar, except for overnight? (choice=Almost Never)"
label(data$eight_hours___2)="Go more than 8 hours without checking your blood sugar, except for overnight? (choice=Sometimes)"
label(data$eight_hours___3)="Go more than 8 hours without checking your blood sugar, except for overnight? (choice=Half of the time)"
label(data$eight_hours___4)="Go more than 8 hours without checking your blood sugar, except for overnight? (choice=Most of the time)"
label(data$eight_hours___5)="Go more than 8 hours without checking your blood sugar, except for overnight? (choice=Almost Always)"
label(data$bedtime___1)="Check your blood sugar at bedtime? (choice=Almost Never)"
label(data$bedtime___2)="Check your blood sugar at bedtime? (choice=Sometimes)"
label(data$bedtime___3)="Check your blood sugar at bedtime? (choice=Half of the time)"
label(data$bedtime___4)="Check your blood sugar at bedtime? (choice=Most of the time)"
label(data$bedtime___5)="Check your blood sugar at bedtime? (choice=Almost Always)"
label(data$miss___1)="Miss or forget an insulin dose? (choice=Almost Never)"
label(data$miss___2)="Miss or forget an insulin dose? (choice=Sometimes)"
label(data$miss___3)="Miss or forget an insulin dose? (choice=Half of the time)"
label(data$miss___4)="Miss or forget an insulin dose? (choice=Most of the time)"
label(data$miss___5)="Miss or forget an insulin dose? (choice=Almost Always)"
label(data$diabetes_management_questionnaire_complete)="Complete?"
label(data$visit_date)="Study Visit Date (Date of survey completion)"
label(data$last_clinic)="Last clinic visit date:"
label(data$visit_duration)="Duration from last clinic visit to current study visit (days):"
label(data$long_duration_clinic)="If >3 months, please explain reason for long duration (if known):"
label(data$clinic_study_visit)="Was the last clinic visit before the previous study visit?  - If this is the first study visit, select No.  - If the visit occurred before the last study visit, select Yes and no further information in this section should be entered as it would have been entered in the last study visit"
label(data$clinic_type)="Was the visit done via telemedicine or in-person?"
label(data$other_explain)="If other, please explain:"
label(data$hba1c)="Most recent HbA1c"
label(data$hba1c_date)="HbA1c date"
label(data$hba1c_duration)="Duration since last HbA1c:"
label(data$hba1c_reason)="If >3 months, reason for long duration between HbA1c:"
label(data$bg_data_device)="Glycemic data obtained from:"
label(data$cgm_other)="CGM used, if Other, please describe:"
label(data$bg_checks_daily)="If BG monitor, how many daily BG checks per day (average over last 14 days)"
label(data$bg_log_avg)="If BG log, how many BG checks per day (average over 14 days, if available):"
label(data$avg_glucose)="Average Glucose Level"
label(data$time_in_range)="Most recent download Time in Range"
label(data$time_hypo)="Most recent download Time Hypoglycemic"
label(data$time_hyper)="Most recent download Time Hyperglycemic"
label(data$cgm_used)="CGM used"
label(data$cgm_time)="If yes, percent time worn:"
label(data$pump_used)="Pump used"
label(data$pump_type)="If yes, which pump:"
label(data$pump_other)="If Other:"
label(data$basal_dose)="Total Basal Insulin (MDI - long acting dose, pump - total daily basal)"
label(data$bolus_dose)="Total Daily Bolus Dose (MDI - daily injections if available, pump - daily bolus insulin)"
label(data$number_boluses)="Number of Boluses Per Day (avg over last 14 days) (if available)"
label(data$tdd)="Total Daily Dose (avg over last 14 days)"
label(data$unitperkg)="Insulin Units/Kg/Day"
label(data$canceled_visits)="Since the last study visit (or March for study visit 1), have there been any canceled visits in Epic?"
label(data$canceled_visits_explain)="If 1 or more canceled visits, please explain (Please hit enter after each canceled visit explanation):"
label(data$screening_labs)="Were screening labs obtained at last clinic visit?"
label(data$no_labs___1)="If no, reason for not obtaining labs: (choice=Visit done via telehealth)"
label(data$no_labs___2)="If no, reason for not obtaining labs: (choice=Up to date on labs)"
label(data$no_labs___3)="If no, reason for not obtaining labs: (choice=Pt request/refusal)"
label(data$no_labs___4)="If no, reason for not obtaining labs: (choice=Unknown)"
label(data$supporting_staff___1)="At most recent clinic visit (in-person or telehealth), did the participant see any additional staff? Check all that apply: (choice=Social Work)"
label(data$supporting_staff___2)="At most recent clinic visit (in-person or telehealth), did the participant see any additional staff? Check all that apply: (choice=Nurse)"
label(data$supporting_staff___3)="At most recent clinic visit (in-person or telehealth), did the participant see any additional staff? Check all that apply: (choice=Dietitian)"
label(data$supporting_staff___4)="At most recent clinic visit (in-person or telehealth), did the participant see any additional staff? Check all that apply: (choice=Other)"
label(data$other_staff)="If other, please explain:"
label(data$diabetes_data_collection_complete)="Complete?"
label(data$gift_card_status)="Please select Yes and change the form status to Complete once the gift card for this participant has been mailed out."
label(data$notes)="Please enter any extra notes needed for this participant:"
label(data$gift_card_status_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("baseline_arm_1","3_month_arm_1","6_month_arm_1","9_month_arm_1","12_month_arm_1","baseline_arm_2","3_month_arm_2","6_month_arm_2","9_month_arm_2","12_month_arm_2","baseline_arm_3","3_month_arm_3","6_month_arm_3","9_month_arm_3","12_month_arm_3","baseline_arm_4","3_month_arm_4","6_month_arm_4","9_month_arm_4","12_month_arm_4","baseline_arm_5","3_month_arm_5","6_month_arm_5","9_month_arm_5","12_month_arm_5"))
data$study_goal.factor = factor(data$study_goal,levels=c("1","2","3"))
data$start.factor = factor(data$start,levels=c("1","2"))
data$duration.factor = factor(data$duration,levels=c("1","2","3"))
data$child_consent_agreement.factor = factor(data$child_consent_agreement,levels=c("1","2"))
data$assent_age.factor = factor(data$assent_age,levels=c("1","2"))
data$assent_agreement.factor = factor(data$assent_agreement,levels=c("1","2"))
data$covid_t1d_study_econsent_and_assent_complete.factor = factor(data$covid_t1d_study_econsent_and_assent_complete,levels=c("0","1","2"))
data$study_goal_v2.factor = factor(data$study_goal_v2,levels=c("1","2","3"))
data$start_v2.factor = factor(data$start_v2,levels=c("1","2"))
data$duration_v2.factor = factor(data$duration_v2,levels=c("1","2","3"))
data$child_consent_agreement_v2.factor = factor(data$child_consent_agreement_v2,levels=c("1","2"))
data$assent_age_v2.factor = factor(data$assent_age_v2,levels=c("1","2"))
data$assent_agreement_v2.factor = factor(data$assent_agreement_v2,levels=c("1","2"))
data$covid_t1d_study_econsent_and_assent_if_needed_complete.factor = factor(data$covid_t1d_study_econsent_and_assent_if_needed_complete,levels=c("0","1","2"))
data$gender.factor = factor(data$gender,levels=c("1","2","3"))
data$child_insurance.factor = factor(data$child_insurance,levels=c("1","2","3","4"))
data$race.factor = factor(data$race,levels=c("1","2","3","4","5","6","7","8"))
data$participant_demographics_complete.factor = factor(data$participant_demographics_complete,levels=c("0","1","2"))
data$parent_survey_header_complete.factor = factor(data$parent_survey_header_complete,levels=c("0","1","2"))
data$child_survey_header_complete.factor = factor(data$child_survey_header_complete,levels=c("0","1","2"))
data$satisfied.factor = factor(data$satisfied,levels=c("1","2","3","4","5"))
data$happy_life.factor = factor(data$happy_life,levels=c("1","2","3","4","5"))
data$good_life.factor = factor(data$good_life,levels=c("1","2","3","4","5"))
data$wanted_life.factor = factor(data$wanted_life,levels=c("1","2","3","4","5"))
data$tired_body.factor = factor(data$tired_body,levels=c("1","2","3","4","5"))
data$exercise_hard.factor = factor(data$exercise_hard,levels=c("1","2","3","4","5"))
data$exercise_breath.factor = factor(data$exercise_breath,levels=c("1","2","3","4","5"))
data$days_sweated.factor = factor(data$days_sweated,levels=c("1","2","3","4","5"))
data$child_happy.factor = factor(data$child_happy,levels=c("1","2","3","4","5"))
data$child_great.factor = factor(data$child_great,levels=c("1","2","3","4","5"))
data$child_cheerful.factor = factor(data$child_cheerful,levels=c("1","2","3","4","5"))
data$child_joyful.factor = factor(data$child_joyful,levels=c("1","2","3","4","5"))
data$child_stressed.factor = factor(data$child_stressed,levels=c("1","2","3","4","5"))
data$child_piling.factor = factor(data$child_piling,levels=c("1","2","3","4","5"))
data$child_felt_overwhelmed.factor = factor(data$child_felt_overwhelmed,levels=c("1","2","3","4","5"))
data$child_manage.factor = factor(data$child_manage,levels=c("1","2","3","4","5"))
data$fed_up.factor = factor(data$fed_up,levels=c("1","2","3","4","5"))
data$child_felt_mad.factor = factor(data$child_felt_mad,levels=c("1","2","3","4","5"))
data$child_felt_upset.factor = factor(data$child_felt_upset,levels=c("1","2","3","4","5"))
data$child_felt_throwing.factor = factor(data$child_felt_throwing,levels=c("1","2","3","4","5"))
data$child_felt_yelling.factor = factor(data$child_felt_yelling,levels=c("1","2","3","4","5"))
data$child_happen.factor = factor(data$child_happen,levels=c("1","2","3","4","5"))
data$child_nervous.factor = factor(data$child_nervous,levels=c("1","2","3","4","5"))
data$child_scared.factor = factor(data$child_scared,levels=c("1","2","3","4","5"))
data$child_felt_worried.factor = factor(data$child_felt_worried,levels=c("1","2","3","4","5"))
data$child_worried_home.factor = factor(data$child_worried_home,levels=c("1","2","3","4","5"))
data$child_got_scared.factor = factor(data$child_got_scared,levels=c("1","2","3","4","5"))
data$child_worried_happen.factor = factor(data$child_worried_happen,levels=c("1","2","3","4","5"))
data$child_worried_night.factor = factor(data$child_worried_night,levels=c("1","2","3","4","5"))
data$child_feel_sad.factor = factor(data$child_feel_sad,levels=c("1","2","3","4","5"))
data$child_alone.factor = factor(data$child_alone,levels=c("1","2","3","4","5"))
data$child_wrong.factor = factor(data$child_wrong,levels=c("1","2","3","4","5"))
data$child_right.factor = factor(data$child_right,levels=c("1","2","3","4","5"))
data$child_lonely.factor = factor(data$child_lonely,levels=c("1","2","3","4","5"))
data$child_felt_sad.factor = factor(data$child_felt_sad,levels=c("1","2","3","4","5"))
data$child_unhappy.factor = factor(data$child_unhappy,levels=c("1","2","3","4","5"))
data$child_hard_fun.factor = factor(data$child_hard_fun,levels=c("1","2","3","4","5"))
data$accepted.factor = factor(data$accepted,levels=c("1","2","3","4","5"))
data$count.factor = factor(data$count,levels=c("1","2","3","4","5"))
data$talk.factor = factor(data$talk,levels=c("1","2","3","4","5"))
data$friends.factor = factor(data$friends,levels=c("1","2","3","4","5"))
data$help.factor = factor(data$help,levels=c("1","2","3","4","5"))
data$wanted.factor = factor(data$wanted,levels=c("1","2","3","4","5"))
data$wanted_me.factor = factor(data$wanted_me,levels=c("1","2","3","4","5"))
data$talk_to_me.factor = factor(data$talk_to_me,levels=c("1","2","3","4","5"))
data$strong_family.factor = factor(data$strong_family,levels=c("1","2","3","4","5"))
data$important_family.factor = factor(data$important_family,levels=c("1","2","3","4","5"))
data$needed_family.factor = factor(data$needed_family,levels=c("1","2","3","4","5"))
data$fun_together.factor = factor(data$fun_together,levels=c("1","2","3","4","5"))
data$family_good.factor = factor(data$family_good,levels=c("1","2","3","4","5"))
data$family_fair.factor = factor(data$family_fair,levels=c("1","2","3","4","5"))
data$parents_listened.factor = factor(data$parents_listened,levels=c("1","2","3","4","5"))
data$attention_to_me.factor = factor(data$attention_to_me,levels=c("1","2","3","4","5"))
data$bedtime_routine.factor = factor(data$bedtime_routine,levels=c("1","2","3","4","5"))
data$tv_sleep.factor = factor(data$tv_sleep,levels=c("1","2","3","4","5"))
data$child_video_games.factor = factor(data$child_video_games,levels=c("1","2","3","4","5"))
data$same_time.factor = factor(data$same_time,levels=c("1","2","3","4","5"))
data$someone_with.factor = factor(data$someone_with,levels=c("1","2","3","4","5"))
data$device.factor = factor(data$device,levels=c("1","2","3","4","5"))
data$same_time_mornings.factor = factor(data$same_time_mornings,levels=c("1","2","3","4","5"))
data$promis_child_sleep1.factor = factor(data$promis_child_sleep1,levels=c("1","2","3","4","5","6","7","8","9","10","11","12"))
data$promis_child_sleep2.factor = factor(data$promis_child_sleep2,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"))
data$promis_child_sleep3.factor = factor(data$promis_child_sleep3,levels=c("1","2","3","4","5","6","7","8","9","10","11","12"))
data$promis_child_sleep4.factor = factor(data$promis_child_sleep4,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"))
data$child_falling.factor = factor(data$child_falling,levels=c("1","2","3","4","5"))
data$child_slept.factor = factor(data$child_slept,levels=c("1","2","3","4","5"))
data$child_sleep_problem.factor = factor(data$child_sleep_problem,levels=c("1","2","3","4","5"))
data$child_trouble_sleep.factor = factor(data$child_trouble_sleep,levels=c("1","2","3","4","5"))
data$child_sleepy.factor = factor(data$child_sleepy,levels=c("1","2","3","4","5"))
data$child_concentrating.factor = factor(data$child_concentrating,levels=c("1","2","3","4","5"))
data$child_done.factor = factor(data$child_done,levels=c("1","2","3","4","5"))
data$child_problems_day.factor = factor(data$child_problems_day,levels=c("1","2","3","4","5"))
data$promis_child_self_report_ages_517_bee0_complete.factor = factor(data$promis_child_self_report_ages_517_bee0_complete,levels=c("0","1","2"))
data$child_mad.factor = factor(data$child_mad,levels=c("1","2","3","4","5"))
data$child_yelling.factor = factor(data$child_yelling,levels=c("1","2","3","4","5"))
data$child_throwing.factor = factor(data$child_throwing,levels=c("1","2","3","4","5"))
data$child_upset.factor = factor(data$child_upset,levels=c("1","2","3","4","5"))
data$child_stay_mad.factor = factor(data$child_stay_mad,levels=c("1","2","3","4","5"))
data$body_tired.factor = factor(data$body_tired,levels=c("1","2","3","4","5"))
data$minutes.factor = factor(data$minutes,levels=c("1","2","3","4","5"))
data$breath_hard.factor = factor(data$breath_hard,levels=c("1","2","3","4","5"))
data$sweat.factor = factor(data$sweat,levels=c("1","2","3","4","5"))
data$happy.factor = factor(data$happy,levels=c("1","2","3","4","5"))
data$great.factor = factor(data$great,levels=c("1","2","3","4","5"))
data$cheerful.factor = factor(data$cheerful,levels=c("1","2","3","4","5"))
data$joyful.factor = factor(data$joyful,levels=c("1","2","3","4","5"))
data$stressed.factor = factor(data$stressed,levels=c("1","2","3","4","5"))
data$piling_up.factor = factor(data$piling_up,levels=c("1","2","3","4","5"))
data$child_overwhelmed.factor = factor(data$child_overwhelmed,levels=c("1","2","3","4","5"))
data$manage.factor = factor(data$manage,levels=c("1","2","3","4","5"))
data$nervous.factor = factor(data$nervous,levels=c("1","2","3","4","5"))
data$scared.factor = factor(data$scared,levels=c("1","2","3","4","5"))
data$child_worried.factor = factor(data$child_worried,levels=c("1","2","3","4","5"))
data$awful.factor = factor(data$awful,levels=c("1","2","3","4","5"))
data$worried_home.factor = factor(data$worried_home,levels=c("1","2","3","4","5"))
data$scared_easy.factor = factor(data$scared_easy,levels=c("1","2","3","4","5"))
data$worried_happen.factor = factor(data$worried_happen,levels=c("1","2","3","4","5"))
data$worried_bed.factor = factor(data$worried_bed,levels=c("1","2","3","4","5"))
data$feeling_sad.factor = factor(data$feeling_sad,levels=c("1","2","3","4","5"))
data$went_wrong.factor = factor(data$went_wrong,levels=c("1","2","3","4","5"))
data$anything_right.factor = factor(data$anything_right,levels=c("1","2","3","4","5"))
data$lonely.factor = factor(data$lonely,levels=c("1","2","3","4","5"))
data$felt_sad.factor = factor(data$felt_sad,levels=c("1","2","3","4","5"))
data$hard_fun.factor = factor(data$hard_fun,levels=c("1","2","3","4","5"))
data$strong.factor = factor(data$strong,levels=c("1","2","3","4","5"))
data$important.factor = factor(data$important,levels=c("1","2","3","4","5"))
data$needed.factor = factor(data$needed,levels=c("1","2","3","4","5"))
data$fun.factor = factor(data$fun,levels=c("1","2","3","4","5"))
data$feel_good.factor = factor(data$feel_good,levels=c("1","2","3","4","5"))
data$treated_fair.factor = factor(data$treated_fair,levels=c("1","2","3","4","5"))
data$listened.factor = factor(data$listened,levels=c("1","2","3","4","5"))
data$attention.factor = factor(data$attention,levels=c("1","2","3","4","5"))
data$routine.factor = factor(data$routine,levels=c("1","2","3","4","5"))
data$tv.factor = factor(data$tv,levels=c("1","2","3","4","5"))
data$video_games.factor = factor(data$video_games,levels=c("1","2","3","4","5"))
data$asleep.factor = factor(data$asleep,levels=c("1","2","3","4","5"))
data$someone.factor = factor(data$someone,levels=c("1","2","3","4","5"))
data$electronic.factor = factor(data$electronic,levels=c("1","2","3","4","5"))
data$woke.factor = factor(data$woke,levels=c("1","2","3","4","5"))
data$promis_proxy_sleep2.factor = factor(data$promis_proxy_sleep2,levels=c("1","2","3","4","5","6","7","8","9","10","11","12"))
data$promis_proxy_sleep3.factor = factor(data$promis_proxy_sleep3,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"))
data$promis_proxy_sleep4.factor = factor(data$promis_proxy_sleep4,levels=c("1","2","3","4","5","6","7","8","9","10","11","12"))
data$promis_proxy_sleep5.factor = factor(data$promis_proxy_sleep5,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"))
data$diff_sleep.factor = factor(data$diff_sleep,levels=c("1","2","3","4","5"))
data$slept_night.factor = factor(data$slept_night,levels=c("1","2","3","4","5"))
data$prob_sleep.factor = factor(data$prob_sleep,levels=c("1","2","3","4","5"))
data$troub_sleep.factor = factor(data$troub_sleep,levels=c("1","2","3","4","5"))
data$sleepy_day.factor = factor(data$sleepy_day,levels=c("1","2","3","4","5"))
data$concent_hard.factor = factor(data$concent_hard,levels=c("1","2","3","4","5"))
data$get_done.factor = factor(data$get_done,levels=c("1","2","3","4","5"))
data$probl_day.factor = factor(data$probl_day,levels=c("1","2","3","4","5"))
data$promis_parent_proxy_ages_517_complete.factor = factor(data$promis_parent_proxy_ages_517_complete,levels=c("0","1","2"))
data$fearful.factor = factor(data$fearful,levels=c("1","2","3","4","5"))
data$hard_anxiety.factor = factor(data$hard_anxiety,levels=c("1","2","3","4","5"))
data$overwhelmed.factor = factor(data$overwhelmed,levels=c("1","2","3","4","5"))
data$uneasy.factor = factor(data$uneasy,levels=c("1","2","3","4","5"))
data$worthless.factor = factor(data$worthless,levels=c("1","2","3","4","5"))
data$helpess.factor = factor(data$helpess,levels=c("1","2","3","4","5"))
data$depressed.factor = factor(data$depressed,levels=c("1","2","3","4","5"))
data$hopeless.factor = factor(data$hopeless,levels=c("1","2","3","4","5"))
data$sleep_quality.factor = factor(data$sleep_quality,levels=c("1","2","3","4","5"))
data$refreshing.factor = factor(data$refreshing,levels=c("1","2","3","4","5"))
data$problem.factor = factor(data$problem,levels=c("1","2","3","4","5"))
data$difficulty.factor = factor(data$difficulty,levels=c("1","2","3","4","5"))
data$hard_time.factor = factor(data$hard_time,levels=c("1","2","3","4","5"))
data$during_day.factor = factor(data$during_day,levels=c("1","2","3","4","5"))
data$concentrating.factor = factor(data$concentrating,levels=c("1","2","3","4","5"))
data$sleepy.factor = factor(data$sleepy,levels=c("1","2","3","4","5"))
data$promis_parent_self_report_all_child_ages_complete.factor = factor(data$promis_parent_self_report_all_child_ages_complete,levels=c("0","1","2"))
data$ychild_hungry.factor = factor(data$ychild_hungry,levels=c("1","2","3"))
data$ychild_thirsty.factor = factor(data$ychild_thirsty,levels=c("1","2","3"))
data$ychild_bathroom.factor = factor(data$ychild_bathroom,levels=c("1","2","3"))
data$ychild_stomachache.factor = factor(data$ychild_stomachache,levels=c("1","2","3"))
data$ychild_headaches.factor = factor(data$ychild_headaches,levels=c("1","2","3"))
data$ychild_low.factor = factor(data$ychild_low,levels=c("1","2","3"))
data$ychild_tired.factor = factor(data$ychild_tired,levels=c("1","2","3"))
data$ychild_shaky.factor = factor(data$ychild_shaky,levels=c("1","2","3"))
data$ychild_sweaty.factor = factor(data$ychild_sweaty,levels=c("1","2","3"))
data$ychild_sleeping.factor = factor(data$ychild_sleeping,levels=c("1","2","3"))
data$ychild_irritable.factor = factor(data$ychild_irritable,levels=c("1","2","3"))
data$ychild_finger.factor = factor(data$ychild_finger,levels=c("1","2","3"))
data$ychild_embarrassed.factor = factor(data$ychild_embarrassed,levels=c("1","2","3"))
data$ychild_argue.factor = factor(data$ychild_argue,levels=c("1","2","3"))
data$ychild_plan.factor = factor(data$ychild_plan,levels=c("1","2","3"))
data$ychild_tests.factor = factor(data$ychild_tests,levels=c("1","2","3"))
data$ychild_shots.factor = factor(data$ychild_shots,levels=c("1","2","3"))
data$ychild_exercise.factor = factor(data$ychild_exercise,levels=c("1","2","3"))
data$ychild_carb.factor = factor(data$ychild_carb,levels=c("1","2","3"))
data$ychild_id.factor = factor(data$ychild_id,levels=c("1","2","3"))
data$ychild_carry.factor = factor(data$ychild_carry,levels=c("1","2","3"))
data$ychild_snacks.factor = factor(data$ychild_snacks,levels=c("1","2","3"))
data$ychild_go_low.factor = factor(data$ychild_go_low,levels=c("1","2","3"))
data$ychild_worry_treat.factor = factor(data$ychild_worry_treat,levels=c("1","2","3"))
data$ychild_problem.factor = factor(data$ychild_problem,levels=c("1","2","3"))
data$ychild_doctors.factor = factor(data$ychild_doctors,levels=c("1","2","3"))
data$ychild_ask.factor = factor(data$ychild_ask,levels=c("1","2","3"))
data$ychild_explain.factor = factor(data$ychild_explain,levels=c("1","2","3"))
data$pedsql_child_self_report_ages_57_complete.factor = factor(data$pedsql_child_self_report_ages_57_complete,levels=c("0","1","2"))
data$feel_hungry.factor = factor(data$feel_hungry,levels=c("1","2","3","4","5"))
data$feel_thirsty.factor = factor(data$feel_thirsty,levels=c("1","2","3","4","5"))
data$bathroom_often.factor = factor(data$bathroom_often,levels=c("1","2","3","4","5"))
data$have_stomachaches.factor = factor(data$have_stomachaches,levels=c("1","2","3","4","5"))
data$have_headaches.factor = factor(data$have_headaches,levels=c("1","2","3","4","5"))
data$go_low.factor = factor(data$go_low,levels=c("1","2","3","4","5"))
data$tired_fatigued.factor = factor(data$tired_fatigued,levels=c("1","2","3","4","5"))
data$get_shaky.factor = factor(data$get_shaky,levels=c("1","2","3","4","5"))
data$get_sweaty.factor = factor(data$get_sweaty,levels=c("1","2","3","4","5"))
data$sleeping_trouble.factor = factor(data$sleeping_trouble,levels=c("1","2","3","4","5"))
data$get_irritable.factor = factor(data$get_irritable,levels=c("1","2","3","4","5"))
data$hurts_shots.factor = factor(data$hurts_shots,levels=c("1","2","3","4","5"))
data$embarrasses_diabetes.factor = factor(data$embarrasses_diabetes,levels=c("1","2","3","4","5"))
data$argue_parents.factor = factor(data$argue_parents,levels=c("1","2","3","4","5"))
data$hard_care_plan.factor = factor(data$hard_care_plan,levels=c("1","2","3","4","5"))
data$hard_tests.factor = factor(data$hard_tests,levels=c("1","2","3","4","5"))
data$hard_shots.factor = factor(data$hard_shots,levels=c("1","2","3","4","5"))
data$hard_exercise.factor = factor(data$hard_exercise,levels=c("1","2","3","4","5"))
data$hard_carbohydrates.factor = factor(data$hard_carbohydrates,levels=c("1","2","3","4","5"))
data$hard_id.factor = factor(data$hard_id,levels=c("1","2","3","4","5"))
data$hard_fast_acting.factor = factor(data$hard_fast_acting,levels=c("1","2","3","4","5"))
data$hard_snacks.factor = factor(data$hard_snacks,levels=c("1","2","3","4","5"))
data$worry_low.factor = factor(data$worry_low,levels=c("1","2","3","4","5"))
data$worry_treatments.factor = factor(data$worry_treatments,levels=c("1","2","3","4","5"))
data$worry_complications.factor = factor(data$worry_complications,levels=c("1","2","3","4","5"))
data$hard_doctors.factor = factor(data$hard_doctors,levels=c("1","2","3","4","5"))
data$hard_ask.factor = factor(data$hard_ask,levels=c("1","2","3","4","5"))
data$hard_explain.factor = factor(data$hard_explain,levels=c("1","2","3","4","5"))
data$pedsql_child_self_report_ages_817_complete.factor = factor(data$pedsql_child_self_report_ages_817_complete,levels=c("0","1","2"))
data$hungry.factor = factor(data$hungry,levels=c("1","2","3","4","5"))
data$thirsty.factor = factor(data$thirsty,levels=c("1","2","3","4","5"))
data$bathroom.factor = factor(data$bathroom,levels=c("1","2","3","4","5"))
data$stomachaches.factor = factor(data$stomachaches,levels=c("1","2","3","4","5"))
data$headaches.factor = factor(data$headaches,levels=c("1","2","3","4","5"))
data$low.factor = factor(data$low,levels=c("1","2","3","4","5"))
data$tired.factor = factor(data$tired,levels=c("1","2","3","4","5"))
data$shaky.factor = factor(data$shaky,levels=c("1","2","3","4","5"))
data$sweaty.factor = factor(data$sweaty,levels=c("1","2","3","4","5"))
data$trouble_sleeping.factor = factor(data$trouble_sleeping,levels=c("1","2","3","4","5"))
data$irritable.factor = factor(data$irritable,levels=c("1","2","3","4","5"))
data$pain.factor = factor(data$pain,levels=c("1","2","3","4","5"))
data$arguing.factor = factor(data$arguing,levels=c("1","2","3","4","5"))
data$embarrassed.factor = factor(data$embarrassed,levels=c("1","2","3","4","5"))
data$plan.factor = factor(data$plan,levels=c("1","2","3","4","5"))
data$tests.factor = factor(data$tests,levels=c("1","2","3","4","5"))
data$shots.factor = factor(data$shots,levels=c("1","2","3","4","5"))
data$exercise.factor = factor(data$exercise,levels=c("1","2","3","4","5"))
data$cho.factor = factor(data$cho,levels=c("1","2","3","4","5"))
data$id.factor = factor(data$id,levels=c("1","2","3","4","5"))
data$fast_acting.factor = factor(data$fast_acting,levels=c("1","2","3","4","5"))
data$snacks.factor = factor(data$snacks,levels=c("1","2","3","4","5"))
data$going_low.factor = factor(data$going_low,levels=c("1","2","3","4","5"))
data$working.factor = factor(data$working,levels=c("1","2","3","4","5"))
data$complications.factor = factor(data$complications,levels=c("1","2","3","4","5"))
data$feels.factor = factor(data$feels,levels=c("1","2","3","4","5"))
data$questions.factor = factor(data$questions,levels=c("1","2","3","4","5"))
data$explaining.factor = factor(data$explaining,levels=c("1","2","3","4","5"))
data$pedsql_parent_proxy_all_ages_complete.factor = factor(data$pedsql_parent_proxy_all_ages_complete,levels=c("0","1","2"))
data$parent_questions.factor = factor(data$parent_questions,levels=c("1","2","3","4","5"))
data$parent_questions_2.factor = factor(data$parent_questions_2,levels=c("1","2","3","4","5"))
data$parent_questions_3.factor = factor(data$parent_questions_3,levels=c("1","2","3","4","5"))
data$parent_questions_4.factor = factor(data$parent_questions_4,levels=c("1","2","3","4","5"))
data$parent_questions_5.factor = factor(data$parent_questions_5,levels=c("1","2","3","4","5"))
data$parent_questions_6.factor = factor(data$parent_questions_6,levels=c("1","2","3","4","5"))
data$parent_questions_7.factor = factor(data$parent_questions_7,levels=c("1","2","3","4","5"))
data$parent_questions_8.factor = factor(data$parent_questions_8,levels=c("1","2","3","4","5"))
data$parent_questions_9.factor = factor(data$parent_questions_9,levels=c("1","2","3","4","5"))
data$parent_covid19_questions_all_child_ages_complete.factor = factor(data$parent_covid19_questions_all_child_ages_complete,levels=c("0","1","2"))
data$stay_at_home.factor = factor(data$stay_at_home,levels=c("1","2"))
data$schools.factor = factor(data$schools,levels=c("1","2"))
data$education.factor = factor(data$education,levels=c("1","2"))
data$family.factor = factor(data$family,levels=c("1","2"))
data$separately.factor = factor(data$separately,levels=c("1","2"))
data$moved_in.factor = factor(data$moved_in,levels=c("1","2"))
data$moved_out.factor = factor(data$moved_out,levels=c("1","2"))
data$work_outside_home.factor = factor(data$work_outside_home,levels=c("1","2"))
data$healthcare.factor = factor(data$healthcare,levels=c("1","2"))
data$food.factor = factor(data$food,levels=c("1","2"))
data$medicine.factor = factor(data$medicine,levels=c("1","2"))
data$needed_healthcare.factor = factor(data$needed_healthcare,levels=c("1","2"))
data$essentials.factor = factor(data$essentials,levels=c("1","2"))
data$self_quarantine.factor = factor(data$self_quarantine,levels=c("1","2"))
data$income.factor = factor(data$income,levels=c("1","2"))
data$hours.factor = factor(data$hours,levels=c("1","2"))
data$stop_working.factor = factor(data$stop_working,levels=c("1","2"))
data$lost_job.factor = factor(data$lost_job,levels=c("1","2"))
data$insurance.factor = factor(data$insurance,levels=c("1","2"))
data$family_event.factor = factor(data$family_event,levels=c("1","2"))
data$exposed.factor = factor(data$exposed,levels=c("1","2"))
data$diagnosed.factor = factor(data$diagnosed,levels=c("1","2"))
data$hospitalized.factor = factor(data$hospitalized,levels=c("1","2"))
data$icu.factor = factor(data$icu,levels=c("1","2"))
data$died.factor = factor(data$died,levels=c("1","2"))
data$parenting.factor = factor(data$parenting,levels=c("1","2","3","4","5"))
data$get_along.factor = factor(data$get_along,levels=c("1","2","3","4","5"))
data$care_for_child.factor = factor(data$care_for_child,levels=c("1","2","3","4","5"))
data$other_children.factor = factor(data$other_children,levels=c("1","2","3","4","5"))
data$disabilties.factor = factor(data$disabilties,levels=c("1","2","3","4","5"))
data$wellbeing.factor = factor(data$wellbeing,levels=c("1","2","3","4","5"))
data$eating.factor = factor(data$eating,levels=c("1","2","3","4","5"))
data$sleeping.factor = factor(data$sleeping,levels=c("1","2","3","4","5"))
data$anxiety.factor = factor(data$anxiety,levels=c("1","2","3","4","5"))
data$mood.factor = factor(data$mood,levels=c("1","2","3","4","5"))
data$distress.factor = factor(data$distress,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$child_distress.factor = factor(data$child_distress,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$parent_self_report_cefis_covid_questionnaire_all_c_complete.factor = factor(data$parent_self_report_cefis_covid_questionnaire_all_c_complete,levels=c("0","1","2"))
data$same_routine.factor = factor(data$same_routine,levels=c("0","1","2","3","4","5","6","7"))
data$where_sleep.factor = factor(data$where_sleep,levels=c("1","2","3","4","5","6","7","8"))
data$how_sleep.factor = factor(data$how_sleep,levels=c("1","2","3"))
data$feeding.factor = factor(data$feeding,levels=c("1","0"))
data$difficult.factor = factor(data$difficult,levels=c("1","2","3","4","5"))
data$room.factor = factor(data$room,levels=c("1","2","3","4"))
data$where_sleep_night.factor = factor(data$where_sleep_night,levels=c("1","2","3","4","5","6","7"))
data$when_wakes___1.factor = factor(data$when_wakes___1,levels=c("0","1"))
data$when_wakes___2.factor = factor(data$when_wakes___2,levels=c("0","1"))
data$when_wakes___3.factor = factor(data$when_wakes___3,levels=c("0","1"))
data$when_wakes___4.factor = factor(data$when_wakes___4,levels=c("0","1"))
data$when_wakes___5.factor = factor(data$when_wakes___5,levels=c("0","1"))
data$how_well.factor = factor(data$how_well,levels=c("1","2","3","4","5"))
data$sleep_problem.factor = factor(data$sleep_problem,levels=c("1","2","3","4","5"))
data$brief_infant_sleep_questionnaire_ages_34_complete.factor = factor(data$brief_infant_sleep_questionnaire_ages_34_complete,levels=c("0","1","2"))
data$child_question.factor = factor(data$child_question,levels=c("1","2","3","4","5"))
data$child_covid19_question_complete.factor = factor(data$child_covid19_question_complete,levels=c("0","1","2"))
data$adjust___1.factor = factor(data$adjust___1,levels=c("0","1"))
data$adjust___2.factor = factor(data$adjust___2,levels=c("0","1"))
data$adjust___3.factor = factor(data$adjust___3,levels=c("0","1"))
data$adjust___4.factor = factor(data$adjust___4,levels=c("0","1"))
data$adjust___5.factor = factor(data$adjust___5,levels=c("0","1"))
data$check___1.factor = factor(data$check___1,levels=c("0","1"))
data$check___2.factor = factor(data$check___2,levels=c("0","1"))
data$check___3.factor = factor(data$check___3,levels=c("0","1"))
data$check___4.factor = factor(data$check___4,levels=c("0","1"))
data$check___5.factor = factor(data$check___5,levels=c("0","1"))
data$check_hours___1.factor = factor(data$check_hours___1,levels=c("0","1"))
data$check_hours___2.factor = factor(data$check_hours___2,levels=c("0","1"))
data$check_hours___3.factor = factor(data$check_hours___3,levels=c("0","1"))
data$check_hours___4.factor = factor(data$check_hours___4,levels=c("0","1"))
data$check_hours___5.factor = factor(data$check_hours___5,levels=c("0","1"))
data$sugar___1.factor = factor(data$sugar___1,levels=c("0","1"))
data$sugar___2.factor = factor(data$sugar___2,levels=c("0","1"))
data$sugar___3.factor = factor(data$sugar___3,levels=c("0","1"))
data$sugar___4.factor = factor(data$sugar___4,levels=c("0","1"))
data$sugar___5.factor = factor(data$sugar___5,levels=c("0","1"))
data$carb___1.factor = factor(data$carb___1,levels=c("0","1"))
data$carb___2.factor = factor(data$carb___2,levels=c("0","1"))
data$carb___3.factor = factor(data$carb___3,levels=c("0","1"))
data$carb___4.factor = factor(data$carb___4,levels=c("0","1"))
data$carb___5.factor = factor(data$carb___5,levels=c("0","1"))
data$labels___1.factor = factor(data$labels___1,levels=c("0","1"))
data$labels___2.factor = factor(data$labels___2,levels=c("0","1"))
data$labels___3.factor = factor(data$labels___3,levels=c("0","1"))
data$labels___4.factor = factor(data$labels___4,levels=c("0","1"))
data$labels___5.factor = factor(data$labels___5,levels=c("0","1"))
data$weigh___1.factor = factor(data$weigh___1,levels=c("0","1"))
data$weigh___2.factor = factor(data$weigh___2,levels=c("0","1"))
data$weigh___3.factor = factor(data$weigh___3,levels=c("0","1"))
data$weigh___4.factor = factor(data$weigh___4,levels=c("0","1"))
data$weigh___5.factor = factor(data$weigh___5,levels=c("0","1"))
data$after___1.factor = factor(data$after___1,levels=c("0","1"))
data$after___2.factor = factor(data$after___2,levels=c("0","1"))
data$after___3.factor = factor(data$after___3,levels=c("0","1"))
data$after___4.factor = factor(data$after___4,levels=c("0","1"))
data$after___5.factor = factor(data$after___5,levels=c("0","1"))
data$without_knowing___1.factor = factor(data$without_knowing___1,levels=c("0","1"))
data$without_knowing___2.factor = factor(data$without_knowing___2,levels=c("0","1"))
data$without_knowing___3.factor = factor(data$without_knowing___3,levels=c("0","1"))
data$without_knowing___4.factor = factor(data$without_knowing___4,levels=c("0","1"))
data$without_knowing___5.factor = factor(data$without_knowing___5,levels=c("0","1"))
data$without_checking___1.factor = factor(data$without_checking___1,levels=c("0","1"))
data$without_checking___2.factor = factor(data$without_checking___2,levels=c("0","1"))
data$without_checking___3.factor = factor(data$without_checking___3,levels=c("0","1"))
data$without_checking___4.factor = factor(data$without_checking___4,levels=c("0","1"))
data$without_checking___5.factor = factor(data$without_checking___5,levels=c("0","1"))
data$two_hours___1.factor = factor(data$two_hours___1,levels=c("0","1"))
data$two_hours___2.factor = factor(data$two_hours___2,levels=c("0","1"))
data$two_hours___3.factor = factor(data$two_hours___3,levels=c("0","1"))
data$two_hours___4.factor = factor(data$two_hours___4,levels=c("0","1"))
data$two_hours___5.factor = factor(data$two_hours___5,levels=c("0","1"))
data$before___1.factor = factor(data$before___1,levels=c("0","1"))
data$before___2.factor = factor(data$before___2,levels=c("0","1"))
data$before___3.factor = factor(data$before___3,levels=c("0","1"))
data$before___4.factor = factor(data$before___4,levels=c("0","1"))
data$before___5.factor = factor(data$before___5,levels=c("0","1"))
data$after_low___1.factor = factor(data$after_low___1,levels=c("0","1"))
data$after_low___2.factor = factor(data$after_low___2,levels=c("0","1"))
data$after_low___3.factor = factor(data$after_low___3,levels=c("0","1"))
data$after_low___4.factor = factor(data$after_low___4,levels=c("0","1"))
data$after_low___5.factor = factor(data$after_low___5,levels=c("0","1"))
data$more_carbs___1.factor = factor(data$more_carbs___1,levels=c("0","1"))
data$more_carbs___2.factor = factor(data$more_carbs___2,levels=c("0","1"))
data$more_carbs___3.factor = factor(data$more_carbs___3,levels=c("0","1"))
data$more_carbs___4.factor = factor(data$more_carbs___4,levels=c("0","1"))
data$more_carbs___5.factor = factor(data$more_carbs___5,levels=c("0","1"))
data$insulin___1.factor = factor(data$insulin___1,levels=c("0","1"))
data$insulin___2.factor = factor(data$insulin___2,levels=c("0","1"))
data$insulin___3.factor = factor(data$insulin___3,levels=c("0","1"))
data$insulin___4.factor = factor(data$insulin___4,levels=c("0","1"))
data$insulin___5.factor = factor(data$insulin___5,levels=c("0","1"))
data$after_high___1.factor = factor(data$after_high___1,levels=c("0","1"))
data$after_high___2.factor = factor(data$after_high___2,levels=c("0","1"))
data$after_high___3.factor = factor(data$after_high___3,levels=c("0","1"))
data$after_high___4.factor = factor(data$after_high___4,levels=c("0","1"))
data$after_high___5.factor = factor(data$after_high___5,levels=c("0","1"))
data$ketones___1.factor = factor(data$ketones___1,levels=c("0","1"))
data$ketones___2.factor = factor(data$ketones___2,levels=c("0","1"))
data$ketones___3.factor = factor(data$ketones___3,levels=c("0","1"))
data$ketones___4.factor = factor(data$ketones___4,levels=c("0","1"))
data$ketones___5.factor = factor(data$ketones___5,levels=c("0","1"))
data$eight_hours___1.factor = factor(data$eight_hours___1,levels=c("0","1"))
data$eight_hours___2.factor = factor(data$eight_hours___2,levels=c("0","1"))
data$eight_hours___3.factor = factor(data$eight_hours___3,levels=c("0","1"))
data$eight_hours___4.factor = factor(data$eight_hours___4,levels=c("0","1"))
data$eight_hours___5.factor = factor(data$eight_hours___5,levels=c("0","1"))
data$bedtime___1.factor = factor(data$bedtime___1,levels=c("0","1"))
data$bedtime___2.factor = factor(data$bedtime___2,levels=c("0","1"))
data$bedtime___3.factor = factor(data$bedtime___3,levels=c("0","1"))
data$bedtime___4.factor = factor(data$bedtime___4,levels=c("0","1"))
data$bedtime___5.factor = factor(data$bedtime___5,levels=c("0","1"))
data$miss___1.factor = factor(data$miss___1,levels=c("0","1"))
data$miss___2.factor = factor(data$miss___2,levels=c("0","1"))
data$miss___3.factor = factor(data$miss___3,levels=c("0","1"))
data$miss___4.factor = factor(data$miss___4,levels=c("0","1"))
data$miss___5.factor = factor(data$miss___5,levels=c("0","1"))
data$diabetes_management_questionnaire_complete.factor = factor(data$diabetes_management_questionnaire_complete,levels=c("0","1","2"))
data$clinic_study_visit.factor = factor(data$clinic_study_visit,levels=c("1","0"))
data$clinic_type.factor = factor(data$clinic_type,levels=c("1","2","3"))
data$bg_data_device.factor = factor(data$bg_data_device,levels=c("1","2","3","4","5","6","7"))
data$cgm_used.factor = factor(data$cgm_used,levels=c("1","0"))
data$pump_used.factor = factor(data$pump_used,levels=c("1","0"))
data$pump_type.factor = factor(data$pump_type,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$canceled_visits.factor = factor(data$canceled_visits,levels=c("0","1","2","3","4","5","6","7"))
data$screening_labs.factor = factor(data$screening_labs,levels=c("1","0"))
data$no_labs___1.factor = factor(data$no_labs___1,levels=c("0","1"))
data$no_labs___2.factor = factor(data$no_labs___2,levels=c("0","1"))
data$no_labs___3.factor = factor(data$no_labs___3,levels=c("0","1"))
data$no_labs___4.factor = factor(data$no_labs___4,levels=c("0","1"))
data$supporting_staff___1.factor = factor(data$supporting_staff___1,levels=c("0","1"))
data$supporting_staff___2.factor = factor(data$supporting_staff___2,levels=c("0","1"))
data$supporting_staff___3.factor = factor(data$supporting_staff___3,levels=c("0","1"))
data$supporting_staff___4.factor = factor(data$supporting_staff___4,levels=c("0","1"))
data$diabetes_data_collection_complete.factor = factor(data$diabetes_data_collection_complete,levels=c("0","1","2"))
data$gift_card_status.factor = factor(data$gift_card_status,levels=c("1","0"))
data$gift_card_status_complete.factor = factor(data$gift_card_status_complete,levels=c("0","1","2"))

levels(data$redcap_event_name.factor)=c("Baseline (Arm 1: Parent (Child Age 3-4))","3 Month (Arm 1: Parent (Child Age 3-4))","6 Month (Arm 1: Parent (Child Age 3-4))","9 Month (Arm 1: Parent (Child Age 3-4))","12 Month (Arm 1: Parent (Child Age 3-4))","Baseline (Arm 2: Parent (Child Age 5-17))","3 Month (Arm 2: Parent (Child Age 5-17))","6 Month (Arm 2: Parent (Child Age 5-17))","9 Month (Arm 2: Parent (Child Age 5-17))","12 Month (Arm 2: Parent (Child Age 5-17))","Baseline (Arm 3: Child (Age 5-7))","3 Month (Arm 3: Child (Age 5-7))","6 Month (Arm 3: Child (Age 5-7))","9 Month (Arm 3: Child (Age 5-7))","12 Month (Arm 3: Child (Age 5-7))","Baseline (Arm 4: Child (Age 8-17))","3 Month (Arm 4: Child (Age 8-17))","6 Month (Arm 4: Child (Age 8-17))","9 Month (Arm 4: Child (Age 8-17))","12 Month (Arm 4: Child (Age 8-17))","Baseline (Arm 5: Child (Age 3-4))","3 Month (Arm 5: Child (Age 3-4))","6 Month (Arm 5: Child (Age 3-4))","9 Month (Arm 5: Child (Age 3-4))","12 Month (Arm 5: Child (Age 3-4))")
levels(data$study_goal.factor)=c("Cure diabetes","To learn more about quality of life measures during the pandemic","To collect surveys from families")
levels(data$start.factor)=c("True","False")
levels(data$duration.factor)=c("1 month","6 months","12 months")
levels(data$child_consent_agreement.factor)=c("Yes","No")
levels(data$assent_age.factor)=c("Yes","No")
levels(data$assent_agreement.factor)=c("Yes","No")
levels(data$covid_t1d_study_econsent_and_assent_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$study_goal_v2.factor)=c("Cure diabetes","To learn more about quality of life measures during the pandemic","To collect surveys from families")
levels(data$start_v2.factor)=c("True","False")
levels(data$duration_v2.factor)=c("1 month","6 months","12 months")
levels(data$child_consent_agreement_v2.factor)=c("Yes","No")
levels(data$assent_age_v2.factor)=c("Yes","No")
levels(data$assent_agreement_v2.factor)=c("Yes","No")
levels(data$covid_t1d_study_econsent_and_assent_if_needed_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$gender.factor)=c("Male","Female","Other")
levels(data$child_insurance.factor)=c("Private","Public (ie Medicaid)","Military","Other")
levels(data$race.factor)=c("White","Hispanic/latino","Black or African American","Asian","American Indian or Alaskan Native","Native Hawaiian or Other Pacific Islander","More than one","Other")
levels(data$participant_demographics_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$parent_survey_header_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$child_survey_header_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$satisfied.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$happy_life.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$good_life.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$wanted_life.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$tired_body.factor)=c("No days","1 day","2-3 days","4-5 days","6-7 days")
levels(data$exercise_hard.factor)=c("No days","1 day","2-3 days","4-5 days","6-7 days")
levels(data$exercise_breath.factor)=c("No days","1 day","2-3 days","4-5 days","6-7 days")
levels(data$days_sweated.factor)=c("No days","1 day","2-3 days","4-5 days","6-7 days")
levels(data$child_happy.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$child_great.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$child_cheerful.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$child_joyful.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$child_stressed.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$child_piling.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$child_felt_overwhelmed.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$child_manage.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$fed_up.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_felt_mad.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_felt_upset.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_felt_throwing.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_felt_yelling.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_happen.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_nervous.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_scared.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_felt_worried.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_worried_home.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_got_scared.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_worried_happen.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_worried_night.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_feel_sad.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_alone.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_wrong.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_right.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_lonely.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_felt_sad.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_unhappy.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_hard_fun.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$accepted.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$count.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$talk.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$friends.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$help.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$wanted.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$wanted_me.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$talk_to_me.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$strong_family.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$important_family.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$needed_family.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$fun_together.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$family_good.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$family_fair.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$parents_listened.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$attention_to_me.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$bedtime_routine.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$tv_sleep.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$child_video_games.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$same_time.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$someone_with.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$device.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$same_time_mornings.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$promis_child_sleep1.factor)=c("Before 7:00pm","7:00pm-7:29pm","7:30pm-7:59pm","8:00pm-8:29pm","8:30pm-8:59pm","9:00pm-9:29pm","9:30pm-9:59pm","10:00pm-10:29pm","10:30pm-10:59pm","11:00pm-11:29pm","11:30pm-11:59pm","After Midnight")
levels(data$promis_child_sleep2.factor)=c("Before 5:00am","5:00am-5:29am","5:30am-5:59am","6:00am-6:29am","6:30am-6:59am","7:00am-7:29am","7:30am-7:59am","8:00am-8:29am","8:30am-8:59am","9:00am-9:29am","9:30am-9:59am","10:00am-10:29am","10:30am-10:59am","11:00am-11:29am","11:30-11:59am","After 12:00pm")
levels(data$promis_child_sleep3.factor)=c("Before 7:00pm","7:00pm-7:29pm","7:30pm-7:59pm","8:00pm-8:29pm","8:30pm-8:59pm","9:00pm-9:29pm","9:30pm-9:59pm","10:00pm-10:29pm","10:30pm-10:59pm","11:00pm-11:29pm","11:30pm-11:59pm","After Midnight")
levels(data$promis_child_sleep4.factor)=c("Before 5:00am","5:00am-5:29am","5:30am-5:59am","6:00am-6:29am","6:30am-6:59am","7:00am-7:29am","7:30am-7:59am","8:00am-8:29am","8:30am-8:59am","9:00am-9:29am","9:30am-9:59am","10:00am-10:29am","10:30am-10:59am","11:00am-11:29am","11:30-11:59am","After 12:00pm")
levels(data$child_falling.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$child_slept.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$child_sleep_problem.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$child_trouble_sleep.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$child_sleepy.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$child_concentrating.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$child_done.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$child_problems_day.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$promis_child_self_report_ages_517_bee0_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$child_mad.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_yelling.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_throwing.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_upset.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_stay_mad.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$body_tired.factor)=c("No days","1 day","2-3 days","4-5 days","6-7 days")
levels(data$minutes.factor)=c("No days","1 day","2-3 days","4-5 days","6-7 days")
levels(data$breath_hard.factor)=c("No days","1 day","2-3 days","4-5 days","6-7 days")
levels(data$sweat.factor)=c("No days","1 day","2-3 days","4-5 days","6-7 days")
levels(data$happy.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$great.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$cheerful.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$joyful.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$stressed.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$piling_up.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$child_overwhelmed.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$manage.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$nervous.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$scared.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$child_worried.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$awful.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$worried_home.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$scared_easy.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$worried_happen.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$worried_bed.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$feeling_sad.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$went_wrong.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$anything_right.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$lonely.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$felt_sad.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_fun.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$strong.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$important.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$needed.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$fun.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$feel_good.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$treated_fair.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$listened.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$attention.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$routine.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$tv.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$video_games.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$asleep.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$someone.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$electronic.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$woke.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$promis_proxy_sleep2.factor)=c("Before 7:00pm","7:00pm-7:29pm","7:30pm-7:59pm","8:00pm-8:29pm","8:30pm-8:59pm","9:00pm-9:29pm","9:30pm-9:59pm","10:00pm-10:29pm","10:30pm-10:59pm","11:00pm-11:29pm","11:30pm-11:59pm","After Midnight")
levels(data$promis_proxy_sleep3.factor)=c("Before 5:00am","5:00am-5:29am","5:30am-5:59am","6:00am-6:29am","6:30am-6:59am","7:00am-7:29am","7:30am-7:59am","8:00am-8:29am","8:30am-8:59am","9:00am-9:29am","9:30am-9:59am","10:00am-10:29am","10:30am-10:59am","11:00am-11:29am","11:30-11:59am","After 12:00pm")
levels(data$promis_proxy_sleep4.factor)=c("Before 7:00pm","7:00pm-7:29pm","7:30pm-7:59pm","8:00pm-8:29pm","8:30pm-8:59pm","9:00pm-9:29pm","9:30pm-9:59pm","10:00pm-10:29pm","10:30pm-10:59pm","11:00pm-11:29pm","11:30pm-11:59pm","After Midnight")
levels(data$promis_proxy_sleep5.factor)=c("Before 5:00am","5:00am-5:29am","5:30am-5:59am","6:00am-6:29am","6:30am-6:59am","7:00am-7:29am","7:30am-7:59am","8:00am-8:29am","8:30am-8:59am","9:00am-9:29am","9:30am-9:59am","10:00am-10:29am","10:30am-10:59am","11:00am-11:29am","11:30-11:59am","After 12:00pm")
levels(data$diff_sleep.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$slept_night.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$prob_sleep.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$troub_sleep.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$sleepy_day.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$concent_hard.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$get_done.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$probl_day.factor)=c("Never","Almost never","Sometimes","Almost always","Always")
levels(data$promis_parent_proxy_ages_517_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$fearful.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$hard_anxiety.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$overwhelmed.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$uneasy.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$worthless.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$helpess.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$depressed.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$hopeless.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$sleep_quality.factor)=c("Very poor","Poor","Fair","Good","Very good")
levels(data$refreshing.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$problem.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$difficulty.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$hard_time.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$during_day.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$concentrating.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$sleepy.factor)=c("Not at all","A little bit","Somewhat","Quite a bit","Very much")
levels(data$promis_parent_self_report_all_child_ages_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$ychild_hungry.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_thirsty.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_bathroom.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_stomachache.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_headaches.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_low.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_tired.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_shaky.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_sweaty.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_sleeping.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_irritable.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_finger.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_embarrassed.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_argue.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_plan.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_tests.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_shots.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_exercise.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_carb.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_id.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_carry.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_snacks.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_go_low.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_worry_treat.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_problem.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_doctors.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_ask.factor)=c("Not at all","Sometimes","A lot")
levels(data$ychild_explain.factor)=c("Not at all","Sometimes","A lot")
levels(data$pedsql_child_self_report_ages_57_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$feel_hungry.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$feel_thirsty.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$bathroom_often.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$have_stomachaches.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$have_headaches.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$go_low.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$tired_fatigued.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$get_shaky.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$get_sweaty.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$sleeping_trouble.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$get_irritable.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hurts_shots.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$embarrasses_diabetes.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$argue_parents.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_care_plan.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_tests.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_shots.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_exercise.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_carbohydrates.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_id.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_fast_acting.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_snacks.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$worry_low.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$worry_treatments.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$worry_complications.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_doctors.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_ask.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$hard_explain.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsql_child_self_report_ages_817_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$hungry.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$thirsty.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$bathroom.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$stomachaches.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$headaches.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$low.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$tired.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$shaky.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$sweaty.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$trouble_sleeping.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$irritable.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pain.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$arguing.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$embarrassed.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$plan.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$tests.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$shots.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$exercise.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$cho.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$id.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$fast_acting.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$snacks.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$going_low.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$working.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$complications.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$feels.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$questions.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$explaining.factor)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsql_parent_proxy_all_ages_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$parent_questions.factor)=c("Less than 1 hour","1-2 hours","3-4 hours","5-6 hours","More than 6 hours")
levels(data$parent_questions_2.factor)=c("Much less than before","A little less than before","The same/no change","A little more than before","A lot more than before")
levels(data$parent_questions_3.factor)=c("Less than 1 hour","1-2 hours","3-4 hours","5-6 hours","More than 6 hours")
levels(data$parent_questions_4.factor)=c("Much less than before","A little less than before","The same/no change","A little more than before","A lot more than before")
levels(data$parent_questions_5.factor)=c("Less than 30 minutes","30-60 minutes","1-2 hours","3-4 hours","More than 5 hours")
levels(data$parent_questions_6.factor)=c("Much less than before","A little less than before","The same/no change","A little more than before","A lot more than before")
levels(data$parent_questions_7.factor)=c("Less than 30 minutes","30-60 minutes","1-2 hours","3-4 hours","More than 4 hours")
levels(data$parent_questions_8.factor)=c("Video chat (FaceTime, Zoom, etc)","Texting","Phone calls","Socially distanced play dates","Other")
levels(data$parent_questions_9.factor)=c("Much less than before","A little less than before","The same/no change","A little more than before","A lot more than before")
levels(data$parent_covid19_questions_all_child_ages_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$stay_at_home.factor)=c("Yes","No")
levels(data$schools.factor)=c("Yes","No")
levels(data$education.factor)=c("Yes","No")
levels(data$family.factor)=c("Yes","No")
levels(data$separately.factor)=c("Yes","No")
levels(data$moved_in.factor)=c("Yes","No")
levels(data$moved_out.factor)=c("Yes","No")
levels(data$work_outside_home.factor)=c("Yes","No")
levels(data$healthcare.factor)=c("Yes","No")
levels(data$food.factor)=c("Yes","No")
levels(data$medicine.factor)=c("Yes","No")
levels(data$needed_healthcare.factor)=c("Yes","No")
levels(data$essentials.factor)=c("Yes","No")
levels(data$self_quarantine.factor)=c("Yes","No")
levels(data$income.factor)=c("Yes","No")
levels(data$hours.factor)=c("Yes","No")
levels(data$stop_working.factor)=c("Yes","No")
levels(data$lost_job.factor)=c("Yes","No")
levels(data$insurance.factor)=c("Yes","No")
levels(data$family_event.factor)=c("Yes","No")
levels(data$exposed.factor)=c("Yes","No")
levels(data$diagnosed.factor)=c("Yes","No")
levels(data$hospitalized.factor)=c("Yes","No")
levels(data$icu.factor)=c("Yes","No")
levels(data$died.factor)=c("Yes","No")
levels(data$parenting.factor)=c("Made it a lot better","Made it a little better","Made it a little worse","Made it a lot worse","Not applicable")
levels(data$get_along.factor)=c("Made it a lot better","Made it a little better","Made it a little worse","Made it a lot worse","Not applicable")
levels(data$care_for_child.factor)=c("Made it a lot better","Made it a little better","Made it a little worse","Made it a lot worse","Not applicable")
levels(data$other_children.factor)=c("Made it a lot better","Made it a little better","Made it a little worse","Made it a lot worse","Not applicable")
levels(data$disabilties.factor)=c("Made it a lot better","Made it a little better","Made it a little worse","Made it a lot worse","Not applicable")
levels(data$wellbeing.factor)=c("Made it a lot better","Made it a little better","Made it a little worse","Made it a lot worse","Not applicable")
levels(data$eating.factor)=c("Made it a lot better","Made it a little better","Made it a little worse","Made it a lot worse","Not applicable")
levels(data$sleeping.factor)=c("Made it a lot better","Made it a little better","Made it a little worse","Made it a lot worse","Not applicable")
levels(data$anxiety.factor)=c("Made it a lot better","Made it a little better","Made it a little worse","Made it a lot worse","Not applicable")
levels(data$mood.factor)=c("Made it a lot better","Made it a little better","Made it a little worse","Made it a lot worse","Not applicable")
levels(data$distress.factor)=c("1 - No distress","2","3","4","5","6","7","8","9","10 - Extreme distress")
levels(data$child_distress.factor)=c("1 - No distress","2","3","4","5","6","7","8","9","10 - Extreme distress")
levels(data$parent_self_report_cefis_covid_questionnaire_all_c_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$same_routine.factor)=c("0","1","2","3","4","5","6","7")
levels(data$where_sleep.factor)=c("Crib","Own bed (any size)","Parents bed","Co-sleeper (attached to parents bed)","Bassinet/infant seat","Swing/stroller","Parents/adults arms","Other")
levels(data$how_sleep.factor)=c("While being held or rocked","With an adult in the room, but not being held or rocked","On own (without an adult in the room)")
levels(data$feeding.factor)=c("Yes","No")
levels(data$difficult.factor)=c("Very easy","Somewhat easy","Neither easy nor difficult","Somewhat difficult","Very difficult")
levels(data$room.factor)=c("In his/her own room","In parents room","In siblings or other bedroom","In another room of the house")
levels(data$where_sleep_night.factor)=c("Crib","Own bed (any size)","Parents bed","Co-sleeper (attached to parents bed)","Bassinet/infant seat","Swing/stroller","Other")
levels(data$when_wakes___1.factor)=c("Unchecked","Checked")
levels(data$when_wakes___2.factor)=c("Unchecked","Checked")
levels(data$when_wakes___3.factor)=c("Unchecked","Checked")
levels(data$when_wakes___4.factor)=c("Unchecked","Checked")
levels(data$when_wakes___5.factor)=c("Unchecked","Checked")
levels(data$how_well.factor)=c("Very well","Well","Fairly well","Poorly","Very poorly")
levels(data$sleep_problem.factor)=c("Not a problem at all","A very small problem","A small problem","A moderate problem","A serious problem")
levels(data$brief_infant_sleep_questionnaire_ages_34_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$child_question.factor)=c("Made it a lot better","Made it a little better","Stayed the same; no change","Made it a little worse","Made it a lot worse")
levels(data$child_covid19_question_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$adjust___1.factor)=c("Unchecked","Checked")
levels(data$adjust___2.factor)=c("Unchecked","Checked")
levels(data$adjust___3.factor)=c("Unchecked","Checked")
levels(data$adjust___4.factor)=c("Unchecked","Checked")
levels(data$adjust___5.factor)=c("Unchecked","Checked")
levels(data$check___1.factor)=c("Unchecked","Checked")
levels(data$check___2.factor)=c("Unchecked","Checked")
levels(data$check___3.factor)=c("Unchecked","Checked")
levels(data$check___4.factor)=c("Unchecked","Checked")
levels(data$check___5.factor)=c("Unchecked","Checked")
levels(data$check_hours___1.factor)=c("Unchecked","Checked")
levels(data$check_hours___2.factor)=c("Unchecked","Checked")
levels(data$check_hours___3.factor)=c("Unchecked","Checked")
levels(data$check_hours___4.factor)=c("Unchecked","Checked")
levels(data$check_hours___5.factor)=c("Unchecked","Checked")
levels(data$sugar___1.factor)=c("Unchecked","Checked")
levels(data$sugar___2.factor)=c("Unchecked","Checked")
levels(data$sugar___3.factor)=c("Unchecked","Checked")
levels(data$sugar___4.factor)=c("Unchecked","Checked")
levels(data$sugar___5.factor)=c("Unchecked","Checked")
levels(data$carb___1.factor)=c("Unchecked","Checked")
levels(data$carb___2.factor)=c("Unchecked","Checked")
levels(data$carb___3.factor)=c("Unchecked","Checked")
levels(data$carb___4.factor)=c("Unchecked","Checked")
levels(data$carb___5.factor)=c("Unchecked","Checked")
levels(data$labels___1.factor)=c("Unchecked","Checked")
levels(data$labels___2.factor)=c("Unchecked","Checked")
levels(data$labels___3.factor)=c("Unchecked","Checked")
levels(data$labels___4.factor)=c("Unchecked","Checked")
levels(data$labels___5.factor)=c("Unchecked","Checked")
levels(data$weigh___1.factor)=c("Unchecked","Checked")
levels(data$weigh___2.factor)=c("Unchecked","Checked")
levels(data$weigh___3.factor)=c("Unchecked","Checked")
levels(data$weigh___4.factor)=c("Unchecked","Checked")
levels(data$weigh___5.factor)=c("Unchecked","Checked")
levels(data$after___1.factor)=c("Unchecked","Checked")
levels(data$after___2.factor)=c("Unchecked","Checked")
levels(data$after___3.factor)=c("Unchecked","Checked")
levels(data$after___4.factor)=c("Unchecked","Checked")
levels(data$after___5.factor)=c("Unchecked","Checked")
levels(data$without_knowing___1.factor)=c("Unchecked","Checked")
levels(data$without_knowing___2.factor)=c("Unchecked","Checked")
levels(data$without_knowing___3.factor)=c("Unchecked","Checked")
levels(data$without_knowing___4.factor)=c("Unchecked","Checked")
levels(data$without_knowing___5.factor)=c("Unchecked","Checked")
levels(data$without_checking___1.factor)=c("Unchecked","Checked")
levels(data$without_checking___2.factor)=c("Unchecked","Checked")
levels(data$without_checking___3.factor)=c("Unchecked","Checked")
levels(data$without_checking___4.factor)=c("Unchecked","Checked")
levels(data$without_checking___5.factor)=c("Unchecked","Checked")
levels(data$two_hours___1.factor)=c("Unchecked","Checked")
levels(data$two_hours___2.factor)=c("Unchecked","Checked")
levels(data$two_hours___3.factor)=c("Unchecked","Checked")
levels(data$two_hours___4.factor)=c("Unchecked","Checked")
levels(data$two_hours___5.factor)=c("Unchecked","Checked")
levels(data$before___1.factor)=c("Unchecked","Checked")
levels(data$before___2.factor)=c("Unchecked","Checked")
levels(data$before___3.factor)=c("Unchecked","Checked")
levels(data$before___4.factor)=c("Unchecked","Checked")
levels(data$before___5.factor)=c("Unchecked","Checked")
levels(data$after_low___1.factor)=c("Unchecked","Checked")
levels(data$after_low___2.factor)=c("Unchecked","Checked")
levels(data$after_low___3.factor)=c("Unchecked","Checked")
levels(data$after_low___4.factor)=c("Unchecked","Checked")
levels(data$after_low___5.factor)=c("Unchecked","Checked")
levels(data$more_carbs___1.factor)=c("Unchecked","Checked")
levels(data$more_carbs___2.factor)=c("Unchecked","Checked")
levels(data$more_carbs___3.factor)=c("Unchecked","Checked")
levels(data$more_carbs___4.factor)=c("Unchecked","Checked")
levels(data$more_carbs___5.factor)=c("Unchecked","Checked")
levels(data$insulin___1.factor)=c("Unchecked","Checked")
levels(data$insulin___2.factor)=c("Unchecked","Checked")
levels(data$insulin___3.factor)=c("Unchecked","Checked")
levels(data$insulin___4.factor)=c("Unchecked","Checked")
levels(data$insulin___5.factor)=c("Unchecked","Checked")
levels(data$after_high___1.factor)=c("Unchecked","Checked")
levels(data$after_high___2.factor)=c("Unchecked","Checked")
levels(data$after_high___3.factor)=c("Unchecked","Checked")
levels(data$after_high___4.factor)=c("Unchecked","Checked")
levels(data$after_high___5.factor)=c("Unchecked","Checked")
levels(data$ketones___1.factor)=c("Unchecked","Checked")
levels(data$ketones___2.factor)=c("Unchecked","Checked")
levels(data$ketones___3.factor)=c("Unchecked","Checked")
levels(data$ketones___4.factor)=c("Unchecked","Checked")
levels(data$ketones___5.factor)=c("Unchecked","Checked")
levels(data$eight_hours___1.factor)=c("Unchecked","Checked")
levels(data$eight_hours___2.factor)=c("Unchecked","Checked")
levels(data$eight_hours___3.factor)=c("Unchecked","Checked")
levels(data$eight_hours___4.factor)=c("Unchecked","Checked")
levels(data$eight_hours___5.factor)=c("Unchecked","Checked")
levels(data$bedtime___1.factor)=c("Unchecked","Checked")
levels(data$bedtime___2.factor)=c("Unchecked","Checked")
levels(data$bedtime___3.factor)=c("Unchecked","Checked")
levels(data$bedtime___4.factor)=c("Unchecked","Checked")
levels(data$bedtime___5.factor)=c("Unchecked","Checked")
levels(data$miss___1.factor)=c("Unchecked","Checked")
levels(data$miss___2.factor)=c("Unchecked","Checked")
levels(data$miss___3.factor)=c("Unchecked","Checked")
levels(data$miss___4.factor)=c("Unchecked","Checked")
levels(data$miss___5.factor)=c("Unchecked","Checked")
levels(data$diabetes_management_questionnaire_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$clinic_study_visit.factor)=c("Yes","No")
levels(data$clinic_type.factor)=c("Telemedicine","In-Person","Other")
levels(data$bg_data_device.factor)=c("Blood glucose meter","Continuous glucose monitor (Freestyle libre)","Continuous glucose monitor (Dexcom)","Continuous glucose monitor (Medtronic)","Continuous glucose monitor (other)","Blood glucose diary","No data")
levels(data$cgm_used.factor)=c("Yes","No")
levels(data$pump_used.factor)=c("Yes","No")
levels(data$pump_type.factor)=c("Medtronic Paradigm (before 630G or 670G)","Medtronic 630G","Medtronic 670G","Tandem (without Basal IQ or Control IQ)","Tandem Basal IQ","Tandem Control IQ","Omnipod (without Horizon)","Omnipod Horizon","Animas","Other")
levels(data$canceled_visits.factor)=c("0","1","2","3","4","5","6","7+")
levels(data$screening_labs.factor)=c("Yes","No")
levels(data$no_labs___1.factor)=c("Unchecked","Checked")
levels(data$no_labs___2.factor)=c("Unchecked","Checked")
levels(data$no_labs___3.factor)=c("Unchecked","Checked")
levels(data$no_labs___4.factor)=c("Unchecked","Checked")
levels(data$supporting_staff___1.factor)=c("Unchecked","Checked")
levels(data$supporting_staff___2.factor)=c("Unchecked","Checked")
levels(data$supporting_staff___3.factor)=c("Unchecked","Checked")
levels(data$supporting_staff___4.factor)=c("Unchecked","Checked")
levels(data$diabetes_data_collection_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$gift_card_status.factor)=c("Yes","No")
levels(data$gift_card_status_complete.factor)=c("Incomplete","Unverified","Complete")
