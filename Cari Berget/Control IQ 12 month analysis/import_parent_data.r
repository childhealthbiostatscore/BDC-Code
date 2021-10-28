#Read parent_data
parent_data=read.csv('./Data_Raw/ClinicalObservationP_DATA_2021-10-28_0849.csv')
#Setting Labels
label(parent_data$record_id)="Record ID"
label(parent_data$redcap_event_name)="Event Name"
label(parent_data$p_timepoint)="Time Point"
label(parent_data$survey_header_complete)="Complete?"
label(parent_data$p_baseline1)="What is the total household income in the past year for the childs primary residence?"
label(parent_data$p_baseline2)="Which of these best describes parent 1s highest level of education? "
label(parent_data$p_baseline3)="Which of these best describes parent 2s highest level of education? "
label(parent_data$p_baseline4)="Do you currently use an insulin pump to manage your diabetes? "
label(parent_data$p_baseline6)="Which insulin pump brand do you currently use? "
label(parent_data$p_baseline7)="Do you currently use a continuous glucose monitor (i.e. CGM or glucose sensor) for your diabetes management? "
label(parent_data$p_baseline9)="Which CGM brand do you currently use? "
label(parent_data$baseline_survey_9db28d_complete)="Complete?"
label(parent_data$p_b_inspire1)="I will be more hopeful about my childs future with use of automated insulin delivery (AID)"
label(parent_data$p_b_inspire2)="I will worry less about diabetes with AID"
label(parent_data$p_b_inspire3)="AID will reduce my familys concerns about my childs diabetes"
label(parent_data$p_b_inspire4)="AID will make it easier for my child to do what they want to do without diabetes getting in the way"
label(parent_data$p_b_inspire5)="AID will decrease how often my child has low glucose levels"
label(parent_data$p_b_inspire6)="AID will decrease how often my child has high glucose levels"
label(parent_data$p_b_inspire7)="AID will help my child stay in his/her target range more often"
label(parent_data$p_b_inspire8)="AID will improve my childs A1c to target level"
label(parent_data$p_b_inspire9)="AID will make it easy to eat when my child wants"
label(parent_data$p_b_inspire10)="AID will make it easy to exercise when my child wants"
label(parent_data$p_b_inspire11)="AID will make managing diabetes easy when my child is at school or work"
label(parent_data$p_b_inspire12)="AID will make managing diabetes easy when it comes to my childs social life/being with friends"
label(parent_data$p_b_inspire13)="AID will help me manage my childs sick days"
label(parent_data$p_b_inspire14)="AID will help me sleep better"
label(parent_data$p_b_inspire15)="I believe that my child will have fewer lows during the night with AID"
label(parent_data$p_b_inspire16)="AID will improve my overall quality of life"
label(parent_data$p_b_inspire17)="AID will improve my familys overall quality of life"
label(parent_data$p_b_inspire18)="AID will make managing diabetes easy when my child is driving (for those who drive) or when traveling"
label(parent_data$p_b_inspire19)="AID will help my child manage diabetes if she/he chooses to drink alcohol"
label(parent_data$p_b_inspire20)="AID will help my child manage diabetes if pregnant"
label(parent_data$p_b_inspire21)="AID will reduce my childs risk of long term complications"
label(parent_data$inspire_baseline_complete)="Complete?"
label(parent_data$p_hfs_b_behave1)="Have my child eat large snacks at bedtime"
label(parent_data$p_hfs_b_behave2)="Avoid having my child being alone when his/her blood sugar is likely to be low"
label(parent_data$p_hfs_b_behave3)="Allow my childs blood sugar to be a little high to be on the safe side"
label(parent_data$p_hfs_b_behave4)="Keep my childs sugar higher when he/she will be alone for awhile"
label(parent_data$p_hfs_b_behave5)="Have my child eat something as soon as he/she feels the first sign of low blood sugar"
label(parent_data$p_hfs_b_behave6)="Reduce my childs insulin when I think his/her sugar is too low"
label(parent_data$p_hfs_b_behave7)="Keep my childs blood sugar higher when he/she plans to be away from me for a while"
label(parent_data$p_hfs_b_behave8)="Have my child carry fast-acting sugar"
label(parent_data$p_hfs_b_behave9)="Have my child avoid a lot of exercise when I think his/her sugar is low"
label(parent_data$p_hfs_b_behave10)="Check my childs sugar often when he/she plans to go on an outing"
label(parent_data$p_hfs_b_behave11)="Get up in the middle of the night to check on my child or check my childs blood sugar levels"
label(parent_data$p_hfs_b_worry12)="Child not recognizing/realizing that he/she is having a low"
label(parent_data$p_hfs_b_worry13)="Child not having food, fruit, or juice with him/her"
label(parent_data$p_hfs_b_worry14)="Child feeling dizzy or passing out in public"
label(parent_data$p_hfs_b_worry15)="Child having a low while asleep"
label(parent_data$p_hfs_b_worry16)="Child embarrassing self or friends/family in a social situation"
label(parent_data$p_hfs_b_worry17)="Child having a low while alone"
label(parent_data$p_hfs_b_worry18)="Child appearing to be stupid or clumsy"
label(parent_data$p_hfs_b_worry19)="Child losing control of behavior due to low blood sugar"
label(parent_data$p_hfs_b_worry20)="No one being around to help my child during a low"
label(parent_data$p_hfs_b_worry21)="Child making a mistake or having an accident at school"
label(parent_data$p_hfs_b_worry22)="Child getting a bad evaluation at school because of something that happens when his/her sugar is low"
label(parent_data$p_hfs_b_worry23)="Child having seizures or convulsions"
label(parent_data$p_hfs_b_worry24)="Child developing long term complications from frequent low blood sugar"
label(parent_data$p_hfs_b_worry25)="Child feeling light-headed or faint"
label(parent_data$p_hfs_b_worry26)="Child having a low"
label(parent_data$p_hfs_b_hypo_severe)="In the past 12 months, how many times has your child experienced episodes of SEVERE HYPOGLYCEMIA? (When  your childs blood sugar was so low that he/she was unable to recognize symptoms, ask for help, or treat him/herself due to mental confusion or unconsciousness)"
label(parent_data$p_hfs_b_hypo_severe_upset)="In the PAST 12 MONTHS, how upsetting was your childs worst episode of SEVERE HYPOGLYCEMIA?  "
label(parent_data$p_hfs_b_hypo_mod)="In the PAST 3 MONTHS, how many times has your child experience episodes of MODERATE HYPOGLYCEMIA? (He/she could treat themselves but their blood sugar was so low that it got in the way of what he/she was doing and he/she had to wait a while to get better)"
label(parent_data$p_hfs_b_hypo_mod_upset)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of MODERATE HYPOGLYCEMIA? Please circle the number below that best describes your childs worst episode of moderate hypoglycemia"
label(parent_data$p_hfs_b_hypo_mild)="In the PAST MONTH, how many times has your child experienced episodes of MILD HYPOGLYCEMIA? (Low blood sugar that caused some symptoms, such as trembling, sweating and dizziness, but these things went away quickly after he/she ate or drank something and did not get in the way of his/her ability to do things)"
label(parent_data$p_hfs_b_hypo_mild_upset)="In the PAST MONTH, how upsetting was your childs worst episode or MILD HYPOGLYCEMIA?"
label(parent_data$p_hfs_b_bg_tar_low)="I try not to let my childs blood sugar get BELOW"
label(parent_data$p_hfs_b_bg_tar_above)="I try not to let my childs blood sugar get ABOVE"
label(parent_data$baseline_hfs_cb99_complete)="Complete?"
label(parent_data$p_paid1)="I feel discouraged with my childs diabetes"
label(parent_data$p_paid2)="I feel scared when thinking about my child having/living with diabetes"
label(parent_data$p_paid3)="I have difficulty dealing with school staff (e.g. teachers, principals, nurses)"
label(parent_data$p_paid4)="I feel that my child is deprived regarding food and meals"
label(parent_data$p_paid5)="I feel that my child is excluded from activities/events due to their diabetes"
label(parent_data$p_paid6)="I feel upset when my childs blood sugars are out of range"
label(parent_data$p_paid7)="I worry about my child having a low blood sugar"
label(parent_data$p_paid8)="I feel angry when I think about my child having/living with diabetes"
label(parent_data$p_paid9)="I feel constantly concerened about what my child eats"
label(parent_data$p_paid10)="I worry about the future and the possibility of serious complications for my child"
label(parent_data$p_paid11)="I feel upset when my childs diabetes management is off track"
label(parent_data$p_paid12)="I worry that my child will not be taken care of when away from home"
label(parent_data$p_paid13)="I feel like the diabetes police"
label(parent_data$p_paid14)="I feel that diabetes takes up too  much mental and physical energy"
label(parent_data$p_paid15)="I feel alone in managing my childs diabetes"
label(parent_data$p_paid16)="I feel that other family members are not supportive in managing my childs diabetes"
label(parent_data$p_paid17)="I worry whether or not my child will remember to eat his/her snack"
label(parent_data$p_paid18)="I feel burned out by the constant effort to manage diabetes"
label(parent_data$paid_complete)="Complete?"
label(parent_data$tech1)="Diabetes Technology has made my life better"
label(parent_data$tech2)="Diabetes Technology has made my life easier"
label(parent_data$tech3)="Diabetes Technology has made my health better"
label(parent_data$tech4)="Diabetes Technology does more good than bad"
label(parent_data$tech5)="Diabetes Technology takes more time and work than it is worth"
label(parent_data$diabetes_technology_complete)="Complete?"
label(parent_data$p_hfs_f_behave1)="Have my child eat large snacks at bedtime"
label(parent_data$p_hfs_f_behave2)="Avoid having my child being alone when his/her blood sugar is likely to be low"
label(parent_data$p_hfs_f_behave3)="Allow my childs blood sugar to be a little high to be on the safe side"
label(parent_data$p_hfs_f_behave4)="Keep my childs sugar higher when he/she will be alone for awhile"
label(parent_data$p_hfs_f_behave5)="Have my child eat something as soon as he/she feels the first sign of low blood sugar"
label(parent_data$p_hfs_f_behave6)="Reduce my childs insulin when I think his/her sugar is too low"
label(parent_data$p_hfs_f_behave7)="Keep my childs blood sugar higher when he/she plans to be away from me for a while"
label(parent_data$p_hfs_f_behave8)="Have my child carry fast-acting sugar"
label(parent_data$p_hfs_f_behave9)="Have my child avoid a lot of exercise when I think his/her sugar is low"
label(parent_data$p_hfs_f_behave10)="Check my childs sugar often when he/she plans to go on an outing"
label(parent_data$p_hfs_f_behave11)="Get up in the middle of the night to check on my child or check my childs blood sugar levels"
label(parent_data$p_hfs_f_worry12)="Child not recognizing/realizing that he/she is having a low"
label(parent_data$p_hfs_f_worry13)="Child not having food, fruit, or juice with him/her"
label(parent_data$p_hfs_f_worry14)="Child feeling dizzy or passing out in public"
label(parent_data$p_hfs_f_worry15)="Child having a low while asleep"
label(parent_data$p_hfs_f_worry16)="Child embarrassing self or friends/family in a social situation"
label(parent_data$p_hfs_f_worry17)="Child having a low while alone"
label(parent_data$p_hfs_f_worry18)="Child appearing to be stupid or clumsy"
label(parent_data$p_hfs_f_worry19)="Child losing control of behavior due to low blood sugar"
label(parent_data$p_hfs_f_worry20)="No one being around to help my child during a low"
label(parent_data$p_hfs_f_worry21)="Child making a mistake or having an accident at school"
label(parent_data$p_hfs_f_worry22)="Child getting a bad evaluation at school because of something that happens when his/her sugar is low"
label(parent_data$p_hfs_f_worry23)="Child having seizures or convulsions"
label(parent_data$p_hfs_f_worry24)="Child developing long term complications from frequent low blood sugar"
label(parent_data$p_hfs_f_worry25)="Child feeling light-headed or faint"
label(parent_data$p_hfs_f_worry26)="Child having a low"
label(parent_data$p_hfs_f_hypo_severe)="In the past 3 months, how many times has your child experienced episodes of SEVERE HYPOGLYCEMIA? (When  your childs blood sugar was so low that he/she was unable to recognize symptoms, ask for help, or treat him/herself due to mental confusion or unconsciousness)"
label(parent_data$p_hfs_f_hypo_severe_upset)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of SEVERE HYPOGLYCEMIA?  "
label(parent_data$p_hfs_f_hypo_mod)="In the PAST 3 MONTHS, how many times has your child experience episodes of MODERATE HYPOGLYCEMIA? (He/she could treat themselves but their blood sugar was so low that it got in the way of what he/she was doing and he/she had to wait a while to get better)"
label(parent_data$p_hfs_f_hypo_mod_upset)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of MODERATE HYPOGLYCEMIA? Please select the number below that best describes your childs worst episode of moderate hypoglycemia"
label(parent_data$p_hfs_f_hypo_mild)="In the PAST MONTH, how many times has your child experienced episodes of MILD HYPOGLYCEMIA? (Low blood sugar that caused some symptoms, such as trembling, sweating and dizziness, but these things went away quickly after he/she ate or drank something and did not get in the way of his/her ability to do things)"
label(parent_data$p_hfs_f_hypo_mild_upset)="In the PAST MONTH, how upsetting was your childs worst episode or MILD HYPOGLYCEMIA?"
label(parent_data$p_hfs_f_bg_tar_low)="I try not to let my childs blood sugar get BELOW"
label(parent_data$p_hfs_f_bg_tar_above)="I try not to let my childs blood sugar get ABOVE"
label(parent_data$baseline_hfs_complete)="Complete?"
label(parent_data$p_f_inspire1)="I was more hopeful about my childs future with use of automated insulin delivery (AID)"
label(parent_data$p_f_inspire2)="I worried less about diabetes with AID"
label(parent_data$p_f_inspire3)="AID reduced my familys concerns about my childs diabetes"
label(parent_data$p_f_inspire4)="AID made it easier for my child to do the things I wanted to do without diabetes getting in the way"
label(parent_data$p_f_inspire5)="AID decreased how often my child had low glucose levels"
label(parent_data$p_f_inspire6)="AID decreased how often my child had high glucose levels"
label(parent_data$p_f_inspire7)="AID helped my child stay in his/her target range more often"
label(parent_data$p_f_inspire8)="AID improved my childs A1c to target level"
label(parent_data$p_f_inspire9)="AID made it easier to eat when my child wanted to"
label(parent_data$p_f_inspire10)="AID made it easier to exercise when my child wanted to"
label(parent_data$p_f_inspire11)="AID made managing diabetes easier when my child was at work or school"
label(parent_data$p_f_inspire12)="AID made managing diabetes easier when it came to my childs social life/being with friends"
label(parent_data$p_f_inspire13)="AID helped me manage my childs sick days"
label(parent_data$p_f_inspire14)="AID helped me sleep better"
label(parent_data$p_f_inspire15)="My child had fewer lows during the night with AID"
label(parent_data$p_f_inspire16)="AID improved my overall quality of life"
label(parent_data$p_f_inspire17)="AID improved my familys overall quality of life"
label(parent_data$p_f_inspire18)="AID made managing diabetes easier when my child was driving (for those who drive) or when travelling"
label(parent_data$p_f_inspire19)="AID helped my child manage diabetes when they chose to drink alcohol"
label(parent_data$p_f_inspire20)="AID helped my child managed diabetes when pregnant"
label(parent_data$p_f_inspire21)="AID reduced my childs risk of long-term complications"
label(parent_data$inspire_follow_up_complete)="Complete?"
label(parent_data$timepoint_baselinesurvey)="Time Point"
label(parent_data$p_hfs_behave1)="Have my child eat large snacks at bedtime"
label(parent_data$p_hfs_behave2)="Avoid having my child being alone when his/her blood sugar is likely to be low"
label(parent_data$p_hfs_behave3)="Allow my childs blood sugar to be a little high to be on the safe side"
label(parent_data$p_hfs_behave4)="Keep my childs sugar higher when he/she will be alone for awhile"
label(parent_data$p_hfs_behave5)="Have my child eat something as soon as he/she feels the first sign of low blood sugar"
label(parent_data$p_hfs_behave6)="Reduce my childs insulin when I think his/her sugar is too low"
label(parent_data$p_hfs_behave7)="Keep my childs blood sugar higher when he/she plans to be away from me for a while"
label(parent_data$p_hfs_behave8)="Have my child carry fast-acting sugar"
label(parent_data$p_hfs_behave9)="Have my child avoid a lot of exercise when I think his/her sugar is low"
label(parent_data$p_hfs_behave10)="Check my childs sugar often when he/she plans to go on an outing"
label(parent_data$p_hfs_behave11)="Get up in the middle of the night to check on my child or check my childs blood sugar levels"
label(parent_data$p_hfs_worry12)="Child not recognizing/realizing that he/she is having a low"
label(parent_data$p_hfs_worry13)="Child not having food, fruit, or juice with him/her"
label(parent_data$p_hfs_worry14)="Child feeling dizzy or passing out in public"
label(parent_data$p_hfs_worry15)="Child having a low while asleep"
label(parent_data$p_hfs_worry16)="Child embarrassing self or friends/family in a social situation"
label(parent_data$p_hfs_worry17)="Child having a low while alone"
label(parent_data$p_hfs_worry18)="Child appearing to be stupid or clumsy"
label(parent_data$p_hfs_worry19)="Child losing control of behavior due to low blood sugar"
label(parent_data$p_hfs_worry20)="No one being around to help my child during a low"
label(parent_data$p_hfs_worry21)="Child making a mistake or having an accident at school"
label(parent_data$p_hfs_worry22)="Child getting a bad evaluation at school because of something that happens when his/her sugar is low"
label(parent_data$p_hfs_worry23)="Child having seizures or convulsions"
label(parent_data$p_hfs_worry24)="Child developing long term complications from frequent low blood sugar"
label(parent_data$p_hfs_worry25)="Child feeling light-headed or faint"
label(parent_data$p_hfs_worry26)="Child having a low"
label(parent_data$p_hypo_severe)="In the past 12 months, how many times has your child experienced episodes of SEVERE HYPOGLYCEMIA? (When  your childs blood sugar was so low that he/she was unable to recognize symptoms, ask for help, or treat him/herself due to mental confusion or unconsciousness)"
label(parent_data$p_hypo_severe_yes)="In the PAST 12 MONTHS, how upsetting was your childs worst episode of SEVERE HYPOGLYCEMIA?  "
label(parent_data$p_hypo_mod)="In the PAST 3 MONTHS, how many times has your child experience episodes of MODERATE HYPOGLYCEMIA? (He/she could treat themselves but their blood sugar was so low that it got in the way of what he/she was doing and he/she had to wait a while to get better)"
label(parent_data$p_hypo_mod_yes)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of MODERATE HYPOGLYCEMIA? Please circle the number below that best describes your childs worst episode of moderate hypoglycemia"
label(parent_data$p_hypo_mild)="In the PAST MONTH, how many times has your child experienced episodes of MILD HYPOGLYCEMIA? (Low blood sugar that caused some symptoms, such as trembling, sweating and dizziness, but these things went away quickly after he/she ate or drank something and did not get in the way of his/her ability to do things)"
label(parent_data$p_hypo_mild_yes)="In the PAST MONTH, how upsetting was your childs worst episode or MILD HYPOGLYCEMIA?"
label(parent_data$p_paid1_b)="I feel discouraged with my childs diabetes"
label(parent_data$p_paid2_b)="I feel scared when thinking about my child having/living with diabetes"
label(parent_data$p_paid3_b)="I have difficulty dealing with school staff (e.g. teachers, principals, nurses)"
label(parent_data$p_paid4_b)="I feel that my child is deprived regarding food and meals"
label(parent_data$p_paid5_b)="I feel that my child is excluded from activities/events due to their diabetes"
label(parent_data$p_paid6_b)="I feel upset when my childs blood sugars are out of range"
label(parent_data$p_paid7_b)="I worry about my child having a low blood sugar"
label(parent_data$p_paid8_b)="I feel angry when I think about my child having/living with diabetes"
label(parent_data$p_paid9_b)="I feel constantly concerened about what my child eats"
label(parent_data$p_paid10_b)="I worry about the future and the possibility of serious complications for my child"
label(parent_data$p_paid11_b)="I feel upset when my childs diabetes management is off track"
label(parent_data$p_paid12_b)="I worry that my child will not be taken care of when away from home"
label(parent_data$p_paid13_b)="I feel like the diabetes police"
label(parent_data$p_paid14_b)="I feel that diabetes takes up too  much mental and physical energy"
label(parent_data$p_paid15_b)="I feel alone in managing my childs diabetes"
label(parent_data$p_paid16_b)="I feel that other family members are not supportive in managing my childs diabetes"
label(parent_data$p_paid17_b)="I worry whether or not my child will remember to eat his/her snack"
label(parent_data$p_paid18_b)="I feel burned out by the constant effort to manage diabetes"
label(parent_data$baseline_survey_complete)="Complete?"
label(parent_data$timepoint_survey1)="Time Point"
label(parent_data$p_hfs_behave1_t1)="Have my child eat large snacks at bedtime"
label(parent_data$p_hfs_behave2_t1)="Avoid having my child being alone when his/her blood sugar is likely to be low"
label(parent_data$p_hfs_behave3_t1)="Allow my childs blood sugar to be a little high to be on the safe side"
label(parent_data$p_hfs_behave4_t1)="Keep my childs sugar higher when he/she will be alone for awhile"
label(parent_data$p_hfs_behave5_t1)="Have my child eat something as soon as he/she feels the first sign of low blood sugar"
label(parent_data$p_hfs_behave6_t1)="Reduce my childs insulin when I think his/her sugar is too low"
label(parent_data$p_hfs_behave7_t1)="Keep my childs blood sugar higher when he/she plans to be away from me for a while"
label(parent_data$p_hfs_behave8_t1)="Have my child carry fast-acting sugar"
label(parent_data$p_hfs_behave9_t1)="Have my child avoid a lot of exercise when I think his/her sugar is low"
label(parent_data$p_hfs_behave10_t1)="Check my childs sugar often when he/she plans to go on an outing"
label(parent_data$p_hfs_behave11_t1)="Get up in the middle of the night to check on my child or check my childs blood sugar levels"
label(parent_data$p_hfs_worry12_t1)="Child not recognizing/realizing that he/she is having a low"
label(parent_data$p_hfs_worry13_t1)="Child not having food, fruit, or juice with him/her"
label(parent_data$p_hfs_worry14_t1)="Child feeling dizzy or passing out in public"
label(parent_data$p_hfs_worry15_t1)="Child having a low while asleep"
label(parent_data$p_hfs_worry16_t1)="Child embarrassing self or friends/family in a social situation"
label(parent_data$p_hfs_worry17_t1)="Child having a low while alone"
label(parent_data$p_hfs_worry18_t1)="Child appearing to be stupid or clumsy"
label(parent_data$p_hfs_worry19_t1)="Child losing control of behavior due to low blood sugar"
label(parent_data$p_hfs_worry20_t1)="No one being around to help my child during a low"
label(parent_data$p_hfs_worry21_t1)="Child making a mistake or having an accident at school"
label(parent_data$p_hfs_worry22_t1)="Child getting a bad evaluation at school because of something that happens when his/her sugar is low"
label(parent_data$p_hfs_worry23_t1)="Child having seizures or convulsions"
label(parent_data$p_hfs_worry24_t1)="Child developing long term complications from frequent low blood sugar"
label(parent_data$p_hfs_worry25_t1)="Child feeling light-headed or faint"
label(parent_data$p_hfs_worry26_t1)="Child having a low"
label(parent_data$p_hypo_severe_t1)="In the past 3 months, how many times has your child experienced episodes of SEVERE HYPOGLYCEMIA? (When  your childs blood sugar was so low that he/she was unable to recognize symptoms, ask for help, or treat him/herself due to mental confusion or unconsciousness)"
label(parent_data$p_hypo_severe_yes_t1)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of SEVERE HYPOGLYCEMIA?  "
label(parent_data$p_hypo_mod_t1)="In the PAST 3 MONTHS, how many times has your child experience episodes of MODERATE HYPOGLYCEMIA? (He/she could treat themselves but their blood sugar was so low that it got in the way of what he/she was doing and he/she had to wait a while to get better)"
label(parent_data$p_hypo_mod_yes_t1)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of MODERATE HYPOGLYCEMIA? Please circle the number below that best describes your childs worst episode of moderate hypoglycemia"
label(parent_data$p_hypo_mild_t1)="In the PAST MONTH, how many times has your child experienced episodes of MILD HYPOGLYCEMIA? (Low blood sugar that caused some symptoms, such as trembling, sweating and dizziness, but these things went away quickly after he/she ate or drank something and did not get in the way of his/her ability to do things)"
label(parent_data$p_hypo_mild_yes_t1)="In the PAST MONTH, how upsetting was your childs worst episode or MILD HYPOGLYCEMIA?"
label(parent_data$p_paid1_t1)="I feel discouraged with my childs diabetes"
label(parent_data$p_paid2_t1)="I feel scared when thinking about my child having/living with diabetes"
label(parent_data$p_paid3_t1)="I have difficulty dealing with school staff (e.g. teachers, principals, nurses)"
label(parent_data$p_paid4_t1)="I feel that my child is deprived regarding food and meals"
label(parent_data$p_paid5_t1)="I feel that my child is excluded from activities/events due to their diabetes"
label(parent_data$p_paid6_t1)="I feel upset when my childs blood sugars are out of range"
label(parent_data$p_paid7_t1)="I worry about my child having a low blood sugar"
label(parent_data$p_paid8_t1)="I feel angry when I think about my child having/living with diabetes"
label(parent_data$p_paid9_t1)="I feel constantly concerened about what my child eats"
label(parent_data$p_paid10_t1)="I worry about the future and the possibility of serious complications for my child"
label(parent_data$p_paid11_t1)="I feel upset when my childs diabetes management is off track"
label(parent_data$p_paid12_t1)="I worry that my child will not be taken care of when away from home"
label(parent_data$p_paid13_t1)="I feel like the diabetes police"
label(parent_data$p_paid14_t1)="I feel that diabetes takes up too  much mental and physical energy"
label(parent_data$p_paid15_t1)="I feel alone in managing my childs diabetes"
label(parent_data$p_paid16_t1)="I feel that other family members are not supportive in managing my childs diabetes"
label(parent_data$p_paid17_t1)="I worry whether or not my child will remember to eat his/her snack"
label(parent_data$p_paid18_t1)="I feel burned out by the constant effort to manage diabetes"
label(parent_data$dtb)="Diabetes Technology has made my life better"
label(parent_data$dte)="Diabetes Technology has made my life easier"
label(parent_data$dth)="Diabetes Technology has made my health better"
label(parent_data$dtgb)="Diabetes Technology does more good than bad"
label(parent_data$dttw)="Diabetes Technology takes more time and work than it is worth"
label(parent_data$p_inspire1_t1)="I was more hopeful about my childs future with use of automated insulin delivery (AID)"
label(parent_data$p_inspire2_t1)="I worried less about diabetes with AID"
label(parent_data$p_inspire3_t1)="AID reduced my familys concerns about my childs diabetes"
label(parent_data$p_inspire4_t1)="AID made it easier for me to do the things I wanted to do without diabetes getting in the way"
label(parent_data$p_inspire5_t1)="AID decreased how often my child had low glucose levels"
label(parent_data$p_inspire6_t1)="AID decreased how often my child had high glucose levels"
label(parent_data$p_inspire7_t1)="AID helped my child stay in his/her target range more often"
label(parent_data$p_inspire8_t1)="AID improved my childs A1c to target level"
label(parent_data$p_inspire9_t1)="AID made it easier to eat when my child wanted to"
label(parent_data$p_inspire10_t1)="AID made it easier to exercise when my child wanted to"
label(parent_data$p_inspire11_t1)="AID made managing diabetes easier when my child was at work or school"
label(parent_data$p_inspire12_t1)="AID made managing diabetes easier when it came to my childs social life/being with friends"
label(parent_data$p_inspire13_t1)="AID helped me manage my childs sick days"
label(parent_data$p_inspire14_t1)="AID helped me sleep better"
label(parent_data$p_inspire15_t1)="My child had fewer lows during the night with AID"
label(parent_data$p_inspire16_t1)="AID improved my overall quality of life"
label(parent_data$p_inspire17_t1)="AID improved my familys overall quality of life"
label(parent_data$p_inspire18_t1)="AID made managing diabetes easier when my child was driving (for those who drive) or when travelling"
label(parent_data$p_inspire19_t1)="AID helped my child manage diabetes when they chose to drink alcohol"
label(parent_data$p_inspire20_t1)="AID helped my child managed diabetes when pregnant"
label(parent_data$p_inspire21_t1)="AID reduced my childs risk of long-term complications"
label(parent_data$survey_1_complete)="Complete?"
label(parent_data$timepoint_survey2)="Time Point"
label(parent_data$p_hfs_behave1_t2)="Have my child eat large snacks at bedtime"
label(parent_data$p_hfs_behave2_t2)="Avoid having my child being alone when his/her blood sugar is likely to be low"
label(parent_data$p_hfs_behave3_t2)="Allow my childs blood sugar to be a little high to be on the safe side"
label(parent_data$p_hfs_behave4_t2)="Keep my childs sugar higher when he/she will be alone for awhile"
label(parent_data$p_hfs_behave5_t2)="Have my child eat something as soon as he/she feels the first sign of low blood sugar"
label(parent_data$p_hfs_behave6_t2)="Reduce my childs insulin when I think his/her sugar is too low"
label(parent_data$p_hfs_behave7_t2)="Keep my childs blood sugar higher when he/she plans to be away from me for a while"
label(parent_data$p_hfs_behave8_t2)="Have my child carry fast-acting sugar"
label(parent_data$p_hfs_behave9_t2)="Have my child avoid a lot of exercise when I think his/her sugar is low"
label(parent_data$p_hfs_behave10_t2)="Check my childs sugar often when he/she plans to go on an outing"
label(parent_data$p_hfs_behave11_t2)="Get up in the middle of the night to check on my child or check my childs blood sugar levels"
label(parent_data$p_hfs_worry12_t2)="Child not recognizing/realizing that he/she is having a low"
label(parent_data$p_hfs_worry13_t2)="Child not having food, fruit, or juice with him/her"
label(parent_data$p_hfs_worry14_t2)="Child feeling dizzy or passing out in public"
label(parent_data$p_hfs_worry15_t2)="Child having a low while asleep"
label(parent_data$p_hfs_worry16_t2)="Child embarrassing self or friends/family in a social situation"
label(parent_data$p_hfs_worry17_t2)="Child having a low while alone"
label(parent_data$p_hfs_worry18_t2)="Child appearing to be stupid or clumsy"
label(parent_data$p_hfs_worry19_t2)="Child losing control of behavior due to low blood sugar"
label(parent_data$p_hfs_worry20_t2)="No one being around to help my child during a low"
label(parent_data$p_hfs_worry21_t2)="Child making a mistake or having an accident at school"
label(parent_data$p_hfs_worry22_t2)="Child getting a bad evaluation at school because of something that happens when his/her sugar is low"
label(parent_data$p_hfs_worry23_t2)="Child having seizures or convulsions"
label(parent_data$p_hfs_worry24_t2)="Child developing long term complications from frequent low blood sugar"
label(parent_data$p_hfs_worry25_t2)="Child feeling light-headed or faint"
label(parent_data$p_hfs_worry26_t2)="Child having a low"
label(parent_data$p_hypo_severe_t2)="In the last 3 MONTHS, how many times has your child experienced episodes of SEVERE HYPOGLYCEMIA? (When  your childs blood sugar was so low that he/she was unable to recognize symptoms, ask for help, or treat him/herself due to mental confusion or unconsciousness)"
label(parent_data$p_hypo_severe_yes_t2)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of SEVERE HYPOGLYCEMIA?  "
label(parent_data$p_hypo_mod_t2)="In the PAST 3 MONTHS, how many times has your child experience episodes of MODERATE HYPOGLYCEMIA? (He/she could treat themselves but their blood sugar was so low that it got in the way of what he/she was doing and he/she had to wait a while to get better)"
label(parent_data$p_hypo_mod_yes_t2)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of MODERATE HYPOGLYCEMIA? Please circle the number below that best describes your childs worst episode of moderate hypoglycemia"
label(parent_data$p_hypo_mild_t2)="In the PAST MONTH, how many times has your child experienced episodes of MILD HYPOGLYCEMIA? (Low blood sugar that caused some symptoms, such as trembling, sweating and dizziness, but these things went away quickly after he/she ate or drank something and did not get in the way of his/her ability to do things)"
label(parent_data$p_hypo_mild_yes_t2)="In the PAST MONTH, how upsetting was your childs worst episode or MILD HYPOGLYCEMIA?"
label(parent_data$p_paid1_t2)="I feel discouraged with my childs diabetes"
label(parent_data$p_paid2_t2)="I feel scared when thinking about my child having/living with diabetes"
label(parent_data$p_paid3_t2)="I have difficulty dealing with school staff (e.g. teachers, principals, nurses)"
label(parent_data$p_paid4_t2)="I feel that my child is deprived regarding food and meals"
label(parent_data$p_paid5_t2)="I feel that my child is excluded from activities/events due to their diabetes"
label(parent_data$p_paid6_t2)="I feel upset when my childs blood sugars are out of range"
label(parent_data$p_paid7_t2)="I worry about my child having a low blood sugar"
label(parent_data$p_paid8_t2)="I feel angry when I think about my child having/living with diabetes"
label(parent_data$p_paid9_t2)="I feel constantly concerened about what my child eats"
label(parent_data$p_paid10_t2)="I worry about the future and the possibility of serious complications for my child"
label(parent_data$p_paid11_t2)="I feel upset when my childs diabetes management is off track"
label(parent_data$p_paid12_t2)="I worry that my child will not be taken care of when away from home"
label(parent_data$p_paid13_t2)="I feel like the diabetes police"
label(parent_data$p_paid14_t2)="I feel that diabetes takes up too  much mental and physical energy"
label(parent_data$p_paid15_t2)="I feel alone in managing my childs diabetes"
label(parent_data$p_paid16_t2)="I feel that other family members are not supportive in managing my childs diabetes"
label(parent_data$p_paid17_t2)="I worry whether or not my child will remember to eat his/her snack"
label(parent_data$p_paid18_t2)="I feel burned out by the constant effort to manage diabetes"
label(parent_data$dtb2)="Diabetes Technology has made my life better"
label(parent_data$dte2)="Diabetes Technology has made my life easier"
label(parent_data$dth2)="Diabetes Technology has made my health better"
label(parent_data$dtgb2)="Diabetes Technology does more good than bad"
label(parent_data$dttw2)="Diabetes Technology takes more time and work than it is worth"
label(parent_data$p_inspire1_t2)="I was more hopeful about my childs future with use of automated insulin delivery (AID)"
label(parent_data$p_inspire2_t2)="I worried less about diabetes with AID"
label(parent_data$p_inspire3_t2)="AID reduced my familys concerns about my childs diabetes"
label(parent_data$p_inspire4_t2)="AID made it easier for my child to do the things I wanted to do without diabetes getting in the way"
label(parent_data$p_inspire5_t2)="AID decreased how often my child had low glucose levels"
label(parent_data$p_inspire6_t2)="AID decreased how often my child had high glucose levels"
label(parent_data$p_inspire7_t2)="AID helped my child stay in his/her target range more often"
label(parent_data$p_inspire8_t2)="AID improved my childs A1c to target level"
label(parent_data$p_inspire9_t2)="AID made it easier to eat when my child wanted to"
label(parent_data$p_inspire10_t2)="AID made it easier to exercise when my child wanted to"
label(parent_data$p_inspire11_t2)="AID made managing diabetes easier when my child was at work or school"
label(parent_data$p_inspire12_t2)="AID made managing diabetes easier when it came to my childs social life/being with friends"
label(parent_data$p_inspire13_t2)="AID helped me manage my childs sick days"
label(parent_data$p_inspire14_t2)="AID helped me sleep better"
label(parent_data$p_inspire15_t2)="My child had fewer lows during the night with AID"
label(parent_data$p_inspire16_t2)="AID improved my overall quality of life"
label(parent_data$p_inspire17_t2)="AID improved my familys overall quality of life"
label(parent_data$p_inspire18_t2)="AID made managing diabetes easier when my child was driving (for those who drive) or when travelling"
label(parent_data$p_inspire19_t2)="AID helped my child manage diabetes when they chose to drink alcohol"
label(parent_data$p_inspire20_t2)="AID helped my child managed diabetes when pregnant"
label(parent_data$p_inspire21_t2)="AID reduced my childs risk of long-term complications"
label(parent_data$survey_2_complete)="Complete?"
label(parent_data$timepoint_survey3)="Time Point"
label(parent_data$p_hfs_behave1_t3)="Have my child eat large snacks at bedtime"
label(parent_data$p_hfs_behave2_t3)="Avoid having my child being alone when his/her blood sugar is likely to be low"
label(parent_data$p_hfs_behave3_t3)="Allow my childs blood sugar to be a little high to be on the safe side"
label(parent_data$p_hfs_behave4_t3)="Keep my childs sugar higher when he/she will be alone for awhile"
label(parent_data$p_hfs_behave5_t3)="Have my child eat something as soon as he/she feels the first sign of low blood sugar"
label(parent_data$p_hfs_behave6_t3)="Reduce my childs insulin when I think his/her sugar is too low"
label(parent_data$p_hfs_behave7_t3)="Keep my childs blood sugar higher when he/she plans to be away from me for a while"
label(parent_data$p_hfs_behave8_t3)="Have my child carry fast-acting sugar"
label(parent_data$p_hfs_behave9_t3)="Have my child avoid a lot of exercise when I think his/her sugar is low"
label(parent_data$p_hfs_behave10_t3)="Check my childs sugar often when he/she plans to go on an outing"
label(parent_data$p_hfs_behave11_t3)="Get up in the middle of the night to check on my child or check my childs blood sugar levels"
label(parent_data$p_hfs_worry12_t3)="Child not recognizing/realizing that he/she is having a low"
label(parent_data$p_hfs_worry13_t3)="Child not having food, fruit, or juice with him/her"
label(parent_data$p_hfs_worry14_t3)="Child feeling dizzy or passing out in public"
label(parent_data$p_hfs_worry15_t3)="Child having a low while asleep"
label(parent_data$p_hfs_worry16_t3)="Child embarrassing self or friends/family in a social situation"
label(parent_data$p_hfs_worry17_t3)="Child having a low while alone"
label(parent_data$p_hfs_worry18_t3)="Child appearing to be stupid or clumsy"
label(parent_data$p_hfs_worry19_t3)="Child losing control of behavior due to low blood sugar"
label(parent_data$p_hfs_worry20_t3)="No one being around to help my child during a low"
label(parent_data$p_hfs_worry21_t3)="Child making a mistake or having an accident at school"
label(parent_data$p_hfs_worry22_t3)="Child getting a bad evaluation at school because of something that happens when his/her sugar is low"
label(parent_data$p_hfs_worry23_t3)="Child having seizures or convulsions"
label(parent_data$p_hfs_worry24_t3)="Child developing long term complications from frequent low blood sugar"
label(parent_data$p_hfs_worry25_t3)="Child feeling light-headed or faint"
label(parent_data$p_hfs_worry26_t3)="Child having a low"
label(parent_data$p_hypo_severe_t3)="In the past 3 months, how many times has your child experience episodes of SEVERE HYPOGLYCEMIA? (When  your childs blood sugar was so low that he/she was unable to recognize symptoms, ask for help, or treat him/herself due to mental confusion or unconsciousness)"
label(parent_data$p_hypo_severe_yes_t3)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of SEVERE HYPOGLYCEMIA?  "
label(parent_data$p_hypo_mod_t3)="In the past 3 months, how many times has your child experience episodes of MODERATE HYPOGLYCEMIA? (He/she could treat themselves but their blood sugar was so low that it got in the way of what he/she was doing and he/she had to wait a while to get better)"
label(parent_data$p_hypo_mod_yes_t3)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of MODERATE HYPOGLYCEMIA? Please circle the number below that best describes your childs worst episode of moderate hypoglycemia"
label(parent_data$p_hypo_mild_t3)="In the PAST MONTH, how many times has your child experienced episodes of MILD HYPOGLYCEMIA? (Low blood sugar that caused some symptoms, such as trembling, sweating and dizziness, but these things went away quickly after he/she ate or drank something and did not get in the way of his/her ability to do things)"
label(parent_data$p_hypo_mild_yes_t3)="In the PAST MONTH, how upsetting was your childs worst episode or MILD HYPOGLYCEMIA?"
label(parent_data$p_paid1_t3)="I feel discouraged with my childs diabetes"
label(parent_data$p_paid2_t3)="I feel scared when thinking about my child having/living with diabetes"
label(parent_data$p_paid3_t3)="I have difficulty dealing with school staff (e.g. teachers, principals, nurses)"
label(parent_data$p_paid4_t3)="I feel that my child is deprived regarding food and meals"
label(parent_data$p_paid5_t3)="I feel that my child is excluded from activities/events due to their diabetes"
label(parent_data$p_paid6_t3)="I feel upset when my childs blood sugars are out of range"
label(parent_data$p_paid7_t3)="I worry about my child having a low blood sugar"
label(parent_data$p_paid8_t3)="I feel angry when I think about my child having/living with diabetes"
label(parent_data$p_paid9_t3)="I feel constantly concerened about what my child eats"
label(parent_data$p_paid10_t3)="I worry about the future and the possibility of serious complications for my child"
label(parent_data$p_paid11_t3)="I feel upset when my childs diabetes management is off track"
label(parent_data$p_paid12_t3)="I worry that my child will not be taken care of when away from home"
label(parent_data$p_paid13_t3)="I feel like the diabetes police"
label(parent_data$p_paid14_t3)="I feel that diabetes takes up too  much mental and physical energy"
label(parent_data$p_paid15_t3)="I feel alone in managing my childs diabetes"
label(parent_data$p_paid16_t3)="I feel that other family members are not supportive in managing my childs diabetes"
label(parent_data$p_paid17_t3)="I worry whether or not my child will remember to eat his/her snack"
label(parent_data$p_paid18_t3)="I feel burned out by the constant effort to manage diabetes"
label(parent_data$dtb3)="Diabetes Technology has made my life better"
label(parent_data$dte3)="Diabetes Technology has made my life easier"
label(parent_data$dth3)="Diabetes Technology has made my health better"
label(parent_data$dtgb3)="Diabetes Technology does more good than bad"
label(parent_data$dttw3)="Diabetes Technology takes more time and work than it is worth"
label(parent_data$p_inspire1_t3)="I was more hopeful about my childs future with use of automated insulin delivery (AID)"
label(parent_data$p_inspire2_t3)="I worried less about diabetes with AID"
label(parent_data$p_inspire3_t3)="AID reduced my familys concerns about my childs diabetes"
label(parent_data$p_inspire4_t3)="AID made it easier for my child to do the things I wanted to do without diabetes getting in the way"
label(parent_data$p_inspire5_t3)="AID decreased how often my child had low glucose levels"
label(parent_data$p_inspire6_t3)="AID decreased how often my child had high glucose levels"
label(parent_data$p_inspire7_t3)="AID helped my child stay in his/her target range more often"
label(parent_data$p_inspire8_t3)="AID improved my childs A1c to target level"
label(parent_data$p_inspire9_t3)="AID made it easier to eat when my child wanted to"
label(parent_data$p_inspire10_t3)="AID made it easier to exercise when my child wanted to"
label(parent_data$p_inspire11_t3)="AID made managing diabetes easier when my child was at work or school"
label(parent_data$p_inspire12_t3)="AID made managing diabetes easier when it came to my childs social life/being with friends"
label(parent_data$p_inspire13_t3)="AID helped me manage my childs sick days"
label(parent_data$p_inspire14_t3)="AID helped me sleep better"
label(parent_data$p_inspire15_t3)="My child had fewer lows during the night with AID"
label(parent_data$p_inspire16_t3)="AID improved my overall quality of life"
label(parent_data$p_inspire17_t3)="AID improved my familys overall quality of life"
label(parent_data$p_inspire18_t3)="AID made managing diabetes easier when my child was driving (for those who drive) or when travelling"
label(parent_data$p_inspire19_t3)="AID helped my child manage diabetes when they chose to drink alcohol"
label(parent_data$p_inspire20_t3)="AID helped my child managed diabetes when pregnant"
label(parent_data$p_inspire21_t3)="AID reduced my childs risk of long-term complications"
label(parent_data$survey_3_complete)="Complete?"
label(parent_data$timepoint_survey4)="Time Point"
label(parent_data$p_hfs_behave1_t4)="Have my child eat large snacks at bedtime"
label(parent_data$p_hfs_behave2_t4)="Avoid having my child being alone when his/her blood sugar is likely to be low"
label(parent_data$p_hfs_behave3_t4)="Allow my childs blood sugar to be a little high to be on the safe side"
label(parent_data$p_hfs_behave4_t4)="Keep my childs sugar higher when he/she will be alone for awhile"
label(parent_data$p_hfs_behave5_t4)="Have my child eat something as soon as he/she feels the first sign of low blood sugar"
label(parent_data$p_hfs_behave6_t4)="Reduce my childs insulin when I think his/her sugar is too low"
label(parent_data$p_hfs_behave7_t4)="Keep my childs blood sugar higher when he/she plans to be away from me for a while"
label(parent_data$p_hfs_behave8_t4)="Have my child carry fast-acting sugar"
label(parent_data$p_hfs_behave9_t4)="Have my child avoid a lot of exercise when I think his/her sugar is low"
label(parent_data$p_hfs_behave10_t4)="Check my childs sugar often when he/she plans to go on an outing"
label(parent_data$p_hfs_behave11_t4)="Get up in the middle of the night to check on my child or check my childs blood sugar levels"
label(parent_data$p_hfs_worry12_t4)="Child not recognizing/realizing that he/she is having a low"
label(parent_data$p_hfs_worry13_t4)="Child not having food, fruit, or juice with him/her"
label(parent_data$p_hfs_worry14_t4)="Child feeling dizzy or passing out in public"
label(parent_data$p_hfs_worry15_t4)="Child having a low while asleep"
label(parent_data$p_hfs_worry16_t4)="Child embarrassing self or friends/family in a social situation"
label(parent_data$p_hfs_worry17_t4)="Child having a low while alone"
label(parent_data$p_hfs_worry18_t4)="Child appearing to be stupid or clumsy"
label(parent_data$p_hfs_worry19_t4)="Child losing control of behavior due to low blood sugar"
label(parent_data$p_hfs_worry20_t4)="No one being around to help my child during a low"
label(parent_data$p_hfs_worry21_t4)="Child making a mistake or having an accident at school"
label(parent_data$p_hfs_worry22_t4)="Child getting a bad evaluation at school because of something that happens when his/her sugar is low"
label(parent_data$p_hfs_worry23_t4)="Child having seizures or convulsions"
label(parent_data$p_hfs_worry24_t4)="Child developing long term complications from frequent low blood sugar"
label(parent_data$p_hfs_worry25_t4)="Child feeling light-headed or faint"
label(parent_data$p_hfs_worry26_t4)="Child having a low"
label(parent_data$p_hypo_severe_t4)="In the past 3 months, how many times has your child experience episodes of SEVERE HYPOGLYCEMIA? (When  your childs blood sugar was so low that he/she was unable to recognize symptoms, ask for help, or treat him/herself due to mental confusion or unconsciousness)"
label(parent_data$p_hypo_severe_yes_t4)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of SEVERE HYPOGLYCEMIA?  "
label(parent_data$p_hypo_mod_t4)="In the past 3 months, how many times has your child experience episodes of MODERATE HYPOGLYCEMIA? (He/she could treat themselves but their blood sugar was so low that it got in the way of what he/she was doing and he/she had to wait a while to get better)"
label(parent_data$p_hypo_mod_yes_t4)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of MODERATE HYPOGLYCEMIA? Please circle the number below that best describes your childs worst episode of moderate hypoglycemia"
label(parent_data$p_hypo_mild_t4)="In the PAST MONTH, how many times has your child experienced episodes of MILD HYPOGLYCEMIA? (Low blood sugar that caused some symptoms, such as trembling, sweating and dizziness, but these things went away quickly after he/she ate or drank something and did not get in the way of his/her ability to do things)"
label(parent_data$p_hypo_mild_yes_t4)="In the PAST MONTH, how upsetting was your childs worst episode or MILD HYPOGLYCEMIA?"
label(parent_data$p_paid1_t4)="I feel discouraged with my childs diabetes"
label(parent_data$p_paid2_t4)="I feel scared when thinking about my child having/living with diabetes"
label(parent_data$p_paid3_t4)="I have difficulty dealing with school staff (e.g. teachers, principals, nurses)"
label(parent_data$p_paid4_t4)="I feel that my child is deprived regarding food and meals"
label(parent_data$p_paid5_t4)="I feel that my child is excluded from activities/events due to their diabetes"
label(parent_data$p_paid6_t4)="I feel upset when my childs blood sugars are out of range"
label(parent_data$p_paid7_t4)="I worry about my child having a low blood sugar"
label(parent_data$p_paid8_t4)="I feel angry when I think about my child having/living with diabetes"
label(parent_data$p_paid9_t4)="I feel constantly concerened about what my child eats"
label(parent_data$p_paid10_t4)="I worry about the future and the possibility of serious complications for my child"
label(parent_data$p_paid11_t4)="I feel upset when my childs diabetes management is off track"
label(parent_data$p_paid12_t4)="I worry that my child will not be taken care of when away from home"
label(parent_data$p_paid13_t4)="I feel like the diabetes police"
label(parent_data$p_paid14_t4)="I feel that diabetes takes up too  much mental and physical energy"
label(parent_data$p_paid15_t4)="I feel alone in managing my childs diabetes"
label(parent_data$p_paid16_t4)="I feel that other family members are not supportive in managing my childs diabetes"
label(parent_data$p_paid17_t4)="I worry whether or not my child will remember to eat his/her snack"
label(parent_data$p_paid18_t4)="I feel burned out by the constant effort to manage diabetes"
label(parent_data$dtb4)="Diabetes Technology has made my life better"
label(parent_data$dte4)="Diabetes Technoogy has made my life easier"
label(parent_data$dth4)="Diabetes Technology has made my health better"
label(parent_data$dtgb4)="Diabetes Technology does more good than bad"
label(parent_data$dttw4)="Diabetes Technology takes more time and work than it is worth"
label(parent_data$p_inspire1_t4)="I was more hopeful about my childs future with use of automated insulin delivery (AID)"
label(parent_data$p_inspire2_t4)="I worried less about diabetes with AID"
label(parent_data$p_inspire3_t4)="AID reduced my familys concerns about my childs diabetes"
label(parent_data$p_inspire4_t4)="AID made it easier for my child to do the things I wanted to do without diabetes getting in the way"
label(parent_data$p_inspire5_t4)="AID decreased how often my child had low glucose levels"
label(parent_data$p_inspire6_t4)="AID decreased how often my child had high glucose levels"
label(parent_data$p_inspire7_t4)="AID helped my child stay in his/her target range more often"
label(parent_data$p_inspire8_t4)="AID improved my childs A1c to target level"
label(parent_data$p_inspire9_t4)="AID made it easier to eat when my child wanted to"
label(parent_data$p_inspire10_t4)="AID made it easier to exercise when my child wanted to"
label(parent_data$p_inspire11_t4)="AID made managing diabetes easier when my child was at work or school"
label(parent_data$p_inspire12_t4)="AID made managing diabetes easier when it came to my childs social life/being with friends"
label(parent_data$p_inspire13_t4)="AID helped me manage my childs sick days"
label(parent_data$p_inspire14_t4)="AID helped me sleep better"
label(parent_data$p_inspire15_t4)="My child had fewer lows during the night with AID"
label(parent_data$p_inspire16_t4)="AID improved my overall quality of life"
label(parent_data$p_inspire17_t4)="AID improved my familys overall quality of life"
label(parent_data$p_inspire18_t4)="AID made managing diabetes easier when my child was driving (for those who drive) or when travelling"
label(parent_data$p_inspire19_t4)="AID helped my child manage diabetes when they chose to drink alcohol"
label(parent_data$p_inspire20_t4)="AID helped my child managed diabetes when pregnant"
label(parent_data$p_inspire21_t4)="AID reduced my childs risk of long-term complications"
label(parent_data$survey_4_complete)="Complete?"
label(parent_data$timepoint_survey4_suvey5)="Time Point"
label(parent_data$p_hfs_behave1_t4_suvey5)="Have my child eat large snacks at bedtime"
label(parent_data$p_hfs_behave2_t4_suvey5)="Avoid having my child being alone when his/her blood sugar is likely to be low"
label(parent_data$p_hfs_behave3_t4_suvey5)="Allow my childs blood sugar to be a little high to be on the safe side"
label(parent_data$p_hfs_behave4_t4_suvey5)="Keep my childs sugar higher when he/she will be alone for awhile"
label(parent_data$p_hfs_behave5_t4_suvey5)="Have my child eat something as soon as he/she feels the first sign of low blood sugar"
label(parent_data$p_hfs_behave6_t4_suvey5)="Reduce my childs insulin when I think his/her sugar is too low"
label(parent_data$p_hfs_behave7_t4_suvey5)="Keep my childs blood sugar higher when he/she plans to be away from me for a while"
label(parent_data$p_hfs_behave8_t4_suvey5)="Have my child carry fast-acting sugar"
label(parent_data$p_hfs_behave9_t4_suvey5)="Have my child avoid a lot of exercise when I think his/her sugar is low"
label(parent_data$p_hfs_behave10_t4_suvey5)="Check my childs sugar often when he/she plans to go on an outing"
label(parent_data$p_hfs_behave11_t4_suvey5)="Get up in the middle of the night to check on my child or check my childs blood sugar levels"
label(parent_data$p_hfs_worry12_t4_suvey5)="Child not recognizing/realizing that he/she is having a low"
label(parent_data$p_hfs_worry13_t4_suvey5)="Child not having food, fruit, or juice with him/her"
label(parent_data$p_hfs_worry14_t4_suvey5)="Child feeling dizzy or passing out in public"
label(parent_data$p_hfs_worry15_t4_suvey5)="Child having a low while asleep"
label(parent_data$p_hfs_worry16_t4_suvey5)="Child embarrassing self or friends/family in a social situation"
label(parent_data$p_hfs_worry17_t4_suvey5)="Child having a low while alone"
label(parent_data$p_hfs_worry18_t4_suvey5)="Child appearing to be stupid or clumsy"
label(parent_data$p_hfs_worry19_t4_suvey5)="Child losing control of behavior due to low blood sugar"
label(parent_data$p_hfs_worry20_t4_suvey5)="No one being around to help my child during a low"
label(parent_data$p_hfs_worry21_t4_suvey5)="Child making a mistake or having an accident at school"
label(parent_data$p_hfs_worry22_t4_suvey5)="Child getting a bad evaluation at school because of something that happens when his/her sugar is low"
label(parent_data$p_hfs_worry23_t4_suvey5)="Child having seizures or convulsions"
label(parent_data$p_hfs_worry24_t4_suvey5)="Child developing long term complications from frequent low blood sugar"
label(parent_data$p_hfs_worry25_t4_suvey5)="Child feeling light-headed or faint"
label(parent_data$p_hfs_worry26_t4_suvey5)="Child having a low"
label(parent_data$p_hypo_severe_t4_suvey5)="In the past 3 months, how many times has your child experience episodes of SEVERE HYPOGLYCEMIA? (When  your childs blood sugar was so low that he/she was unable to recognize symptoms, ask for help, or treat him/herself due to mental confusion or unconsciousness)"
label(parent_data$p_hypo_severe_yes_t4_suvey5)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of SEVERE HYPOGLYCEMIA?  "
label(parent_data$p_hypo_mod_t4_suvey5)="In the past 3 months, how many times has your child experience episodes of MODERATE HYPOGLYCEMIA? (He/she could treat themselves but their blood sugar was so low that it got in the way of what he/she was doing and he/she had to wait a while to get better)"
label(parent_data$p_hypo_mod_yes_t4_suvey5)="In the PAST 3 MONTHS, how upsetting was your childs worst episode of MODERATE HYPOGLYCEMIA? Please circle the number below that best describes your childs worst episode of moderate hypoglycemia"
label(parent_data$p_hypo_mild_t4_suvey5)="In the PAST MONTH, how many times has your child experienced episodes of MILD HYPOGLYCEMIA? (Low blood sugar that caused some symptoms, such as trembling, sweating and dizziness, but these things went away quickly after he/she ate or drank something and did not get in the way of his/her ability to do things)"
label(parent_data$p_hypo_mild_yes_t4_suvey5)="In the PAST MONTH, how upsetting was your childs worst episode or MILD HYPOGLYCEMIA?"
label(parent_data$p_paid1_t4_suvey5)="I feel discouraged with my childs diabetes"
label(parent_data$p_paid2_t4_suvey5)="I feel scared when thinking about my child having/living with diabetes"
label(parent_data$p_paid3_t4_suvey5)="I have difficulty dealing with school staff (e.g. teachers, principals, nurses)"
label(parent_data$p_paid4_t4_suvey5)="I feel that my child is deprived regarding food and meals"
label(parent_data$p_paid5_t4_suvey5)="I feel that my child is excluded from activities/events due to their diabetes"
label(parent_data$p_paid6_t4_suvey5)="I feel upset when my childs blood sugars are out of range"
label(parent_data$p_paid7_t4_suvey5)="I worry about my child having a low blood sugar"
label(parent_data$p_paid8_t4_suvey5)="I feel angry when I think about my child having/living with diabetes"
label(parent_data$p_paid9_t4_suvey5)="I feel constantly concerened about what my child eats"
label(parent_data$p_paid10_t4_suvey5)="I worry about the future and the possibility of serious complications for my child"
label(parent_data$p_paid11_t4_suvey5)="I feel upset when my childs diabetes management is off track"
label(parent_data$p_paid12_t4_suvey5)="I worry that my child will not be taken care of when away from home"
label(parent_data$p_paid13_t4_suvey5)="I feel like the diabetes police"
label(parent_data$p_paid14_t4_suvey5)="I feel that diabetes takes up too  much mental and physical energy"
label(parent_data$p_paid15_t4_suvey5)="I feel alone in managing my childs diabetes"
label(parent_data$p_paid16_t4_suvey5)="I feel that other family members are not supportive in managing my childs diabetes"
label(parent_data$p_paid17_t4_suvey5)="I worry whether or not my child will remember to eat his/her snack"
label(parent_data$p_paid18_t4_suvey5)="I feel burned out by the constant effort to manage diabetes"
label(parent_data$dtb4_suvey5)="Diabetes Technology has made my life better"
label(parent_data$dte4_suvey5)="Diabetes Technoogy has made my life easier"
label(parent_data$dth4_suvey5)="Diabetes Technology has made my health better"
label(parent_data$dtgb4_suvey5)="Diabetes Technology does more good than bad"
label(parent_data$dttw4_suvey5)="Diabetes Technology takes more time and work than it is worth"
label(parent_data$p_inspire1_t4_suvey5)="I was more hopeful about my childs future with use of automated insulin delivery (AID)"
label(parent_data$p_inspire2_t4_suvey5)="I worried less about diabetes with AID"
label(parent_data$p_inspire3_t4_suvey5)="AID reduced my familys concerns about my childs diabetes"
label(parent_data$p_inspire4_t4_suvey5)="AID made it easier for my child to do the things I wanted to do without diabetes getting in the way"
label(parent_data$p_inspire5_t4_suvey5)="AID decreased how often my child had low glucose levels"
label(parent_data$p_inspire6_t4_suvey5)="AID decreased how often my child had high glucose levels"
label(parent_data$p_inspire7_t4_suvey5)="AID helped my child stay in his/her target range more often"
label(parent_data$p_inspire8_t4_suvey5)="AID improved my childs A1c to target level"
label(parent_data$p_inspire9_t4_suvey5)="AID made it easier to eat when my child wanted to"
label(parent_data$p_inspire10_t4_suvey5)="AID made it easier to exercise when my child wanted to"
label(parent_data$p_inspire11_t4_suvey5)="AID made managing diabetes easier when my child was at work or school"
label(parent_data$p_inspire12_t4_suvey5)="AID made managing diabetes easier when it came to my childs social life/being with friends"
label(parent_data$p_inspire13_t4_suvey5)="AID helped me manage my childs sick days"
label(parent_data$p_inspire14_t4_suvey5)="AID helped me sleep better"
label(parent_data$p_inspire15_t4_suvey5)="My child had fewer lows during the night with AID"
label(parent_data$p_inspire16_t4_suvey5)="AID improved my overall quality of life"
label(parent_data$p_inspire17_t4_suvey5)="AID improved my familys overall quality of life"
label(parent_data$p_inspire18_t4_suvey5)="AID made managing diabetes easier when my child was driving (for those who drive) or when travelling"
label(parent_data$p_inspire19_t4_suvey5)="AID helped my child manage diabetes when they chose to drink alcohol"
label(parent_data$p_inspire20_t4_suvey5)="AID helped my child managed diabetes when pregnant"
label(parent_data$p_inspire21_t4_suvey5)="AID reduced my childs risk of long-term complications"
label(parent_data$survey_5_complete)="Complete?"
label(parent_data$dtbpar_freq1)="1. Check to see what your childs glucose level is"
label(parent_data$dtbpar_freq2)="2. Think about your child going low"
label(parent_data$dtbpar_freq3)="3. Treat your childs low glucose"
label(parent_data$dtbpar_freq4)="4. Think about your child going high"
label(parent_data$dtbpar_freq5)="5. Treat your childs high glucose"
label(parent_data$dtbpar_freq6)="6. Rearrange how your childs diabetes devices are positioned (tubing, clips, clothing placement, etc.)"
label(parent_data$dtbpar_freq7)="7. Think about what your child will eat and how much insulin to give for it"
label(parent_data$dtbpar_freq8)="8. Give your child a dose (bolus) of insulin"
label(parent_data$dtbpar_freq9)="9. Check to see if your childs diabetes devices are working"
label(parent_data$dtbpar_freq10)="10. Troubleshoot your childs diabetes device issue"
label(parent_data$dtbpar_freq11)="11.	Think about how to manage your childs diabetes during activities (school, sports, exercise, etc.)"
label(parent_data$dtbpar_freq12)="12. Program special settings into your childs diabetes device (temporary settings, event markers, etc.)"
label(parent_data$dtbpar_freq13)="13. Respond to (or silence) a diabetes device alarm"
label(parent_data$dtbpar_freq14)="14. Replace your childs infusion sets or glucose sensors"
label(parent_data$dtbpar_freq15)="15. Wake up in the middle of the night thinking about your childs diabetes"
label(parent_data$dtbpar_freq16)="16.	Wake up in the middle of the night to treat your childs low or high glucose level"
label(parent_data$dtbpar_freq17)="17.	Wake up in the middle of the night to troubleshoot your childs diabetes device issue"
label(parent_data$dtbpar_freq18)="18. Get interrupted in other ways due to your childs diabetes/diabetes devices"
label(parent_data$dtbpar_freq19)="19. Think about your childs diabetes/diabetes devices for any other reason"
label(parent_data$dtbpar_length1)="1. Check to see what your childs glucose level is"
label(parent_data$dtbpar_length2)="2. Think about your child going low"
label(parent_data$dtbpar_length3)="3. Treat your childs low glucose"
label(parent_data$dtbpar_length4)="4. Think about your child going high"
label(parent_data$dtbpar_length5)="5. Treat your childs high glucose"
label(parent_data$dtbpar_length6)="6. Rearrange how your childs diabetes devices are positioned (tubing, clips, clothing placement, etc.)"
label(parent_data$dtbpar_length7)="7. Think about what your child will eat and how much insulin to give for it"
label(parent_data$dtbpar_length8)="8. Give your child a dose (bolus) of insulin"
label(parent_data$dtbpar_length9)="9. Check to see if your childs diabetes devices are working"
label(parent_data$dtbpar_length10)="10. Troubleshoot your childs diabetes device issue"
label(parent_data$dtbpar_length11)="11. Think about how to manage your childs diabetes during activities (school, sports, exercise, etc.)"
label(parent_data$dtbpar_length12)="12. Program special settings into your childs diabetes device (temporary settings, event markers, etc.)"
label(parent_data$dtbpar_length13)="13. Respond to (or silence) a diabetes device alarm"
label(parent_data$dtbpar_length14)="14. Replace your childs infusion sets or glucose sensors"
label(parent_data$dtbpar_length15)="15. Wake up in the middle of the night thinking about your childs diabetes"
label(parent_data$dtbpar_length16)="16. Wake up in the middle of the night to treat your childs low or high glucose level"
label(parent_data$dtbpar_length17)="17. Wake up in the middle of the night to troubleshoot your childs diabetes device issue"
label(parent_data$dtbpar_length18)="18. Get interrupted in other ways due to your childs diabetes/diabetes devices"
label(parent_data$dtbpar_length19)="19. Think about your childs diabetes/diabetes devices for any other reason"
label(parent_data$dtbpar_upset1)="1. Check to see what your childs glucose level is"
label(parent_data$dtbpar_upset2)="2. Think about your child going low"
label(parent_data$dtbpar_upset3)="3. Treat your childs low glucose"
label(parent_data$dtbpar_upset4)="4. Think about your child going high"
label(parent_data$dtbpar_upset5)="5. Treat your childs high glucose"
label(parent_data$dtbpar_upset6)="6. Rearrange how your childs diabetes devices are positioned (tubing, clips, clothing placement, etc.)"
label(parent_data$dtbpar_upset7)="7. Think about what your child will eat and how much insulin to give for it"
label(parent_data$dtbpar_upset8)="8. Give your child a dose (bolus) of insulin"
label(parent_data$dtbpar_upset9)="9. Check to see if your childs diabetes devices are working"
label(parent_data$dtbpar_upset10)="10. Troubleshoot your childs diabetes device issue"
label(parent_data$dtbpar_upset11)="11. Think about how to manage your childs diabetes during activities (school, sports, exercise, etc.)"
label(parent_data$dtbpar_upset12)="12. Program special settings into your childs diabetes device (temporary settings, event markers, etc.)"
label(parent_data$dtbpar_upset13)="13. Respond to (or silence) a diabetes device alarm"
label(parent_data$dtbpar_upset14)="14. Replace your childs infusion sets or glucose sensors"
label(parent_data$dtbpar_upset15)="15. Wake up in the middle of the night thinking about your childs diabetes"
label(parent_data$dtbpar_upset16)="16. Wake up in the middle of the night to treat your childs low or high glucose level"
label(parent_data$dtbpar_upset17)="17. Wake up in the middle of the night to troubleshoot your childs diabetes device issue"
label(parent_data$dtbpar_upset18)="18. Get interrupted in other ways due to your childs diabetes/diabetes devices"
label(parent_data$dtbpar_upset19)="19. Think about your childs diabetes/diabetes devices for any other reason"
label(parent_data$diabetes_treatmentrelated_burden_parent_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
parent_data$redcap_event_name.factor = factor(parent_data$redcap_event_name,levels=c("baseline_arm_1","12_month_arm_1"))
parent_data$p_timepoint.factor = factor(parent_data$p_timepoint,levels=c("0","1","2","3","4","5"))
parent_data$survey_header_complete.factor = factor(parent_data$survey_header_complete,levels=c("0","1","2"))
parent_data$p_baseline1.factor = factor(parent_data$p_baseline1,levels=c("1","2","3","4","5","6","7"))
parent_data$p_baseline2.factor = factor(parent_data$p_baseline2,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_baseline3.factor = factor(parent_data$p_baseline3,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_baseline4.factor = factor(parent_data$p_baseline4,levels=c("1","2"))
parent_data$p_baseline6.factor = factor(parent_data$p_baseline6,levels=c("1","2","3","4","5"))
parent_data$p_baseline7.factor = factor(parent_data$p_baseline7,levels=c("1","2"))
parent_data$p_baseline9.factor = factor(parent_data$p_baseline9,levels=c("1","2","3","4"))
parent_data$baseline_survey_9db28d_complete.factor = factor(parent_data$baseline_survey_9db28d_complete,levels=c("0","1","2"))
parent_data$p_b_inspire1.factor = factor(parent_data$p_b_inspire1,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire2.factor = factor(parent_data$p_b_inspire2,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire3.factor = factor(parent_data$p_b_inspire3,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire4.factor = factor(parent_data$p_b_inspire4,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire5.factor = factor(parent_data$p_b_inspire5,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire6.factor = factor(parent_data$p_b_inspire6,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire7.factor = factor(parent_data$p_b_inspire7,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire8.factor = factor(parent_data$p_b_inspire8,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire9.factor = factor(parent_data$p_b_inspire9,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire10.factor = factor(parent_data$p_b_inspire10,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire11.factor = factor(parent_data$p_b_inspire11,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire12.factor = factor(parent_data$p_b_inspire12,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire13.factor = factor(parent_data$p_b_inspire13,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire14.factor = factor(parent_data$p_b_inspire14,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire15.factor = factor(parent_data$p_b_inspire15,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire16.factor = factor(parent_data$p_b_inspire16,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire17.factor = factor(parent_data$p_b_inspire17,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire18.factor = factor(parent_data$p_b_inspire18,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire19.factor = factor(parent_data$p_b_inspire19,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire20.factor = factor(parent_data$p_b_inspire20,levels=c("0","1","2","3","4","5"))
parent_data$p_b_inspire21.factor = factor(parent_data$p_b_inspire21,levels=c("0","1","2","3","4","5"))
parent_data$inspire_baseline_complete.factor = factor(parent_data$inspire_baseline_complete,levels=c("0","1","2"))
parent_data$p_hfs_b_behave1.factor = factor(parent_data$p_hfs_b_behave1,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_behave2.factor = factor(parent_data$p_hfs_b_behave2,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_behave3.factor = factor(parent_data$p_hfs_b_behave3,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_behave4.factor = factor(parent_data$p_hfs_b_behave4,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_behave5.factor = factor(parent_data$p_hfs_b_behave5,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_behave6.factor = factor(parent_data$p_hfs_b_behave6,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_behave7.factor = factor(parent_data$p_hfs_b_behave7,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_behave8.factor = factor(parent_data$p_hfs_b_behave8,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_behave9.factor = factor(parent_data$p_hfs_b_behave9,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_behave10.factor = factor(parent_data$p_hfs_b_behave10,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_behave11.factor = factor(parent_data$p_hfs_b_behave11,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry12.factor = factor(parent_data$p_hfs_b_worry12,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry13.factor = factor(parent_data$p_hfs_b_worry13,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry14.factor = factor(parent_data$p_hfs_b_worry14,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry15.factor = factor(parent_data$p_hfs_b_worry15,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry16.factor = factor(parent_data$p_hfs_b_worry16,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry17.factor = factor(parent_data$p_hfs_b_worry17,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry18.factor = factor(parent_data$p_hfs_b_worry18,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry19.factor = factor(parent_data$p_hfs_b_worry19,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry20.factor = factor(parent_data$p_hfs_b_worry20,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry21.factor = factor(parent_data$p_hfs_b_worry21,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry22.factor = factor(parent_data$p_hfs_b_worry22,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry23.factor = factor(parent_data$p_hfs_b_worry23,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry24.factor = factor(parent_data$p_hfs_b_worry24,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry25.factor = factor(parent_data$p_hfs_b_worry25,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_worry26.factor = factor(parent_data$p_hfs_b_worry26,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_hypo_severe.factor = factor(parent_data$p_hfs_b_hypo_severe,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hfs_b_hypo_severe_upset.factor = factor(parent_data$p_hfs_b_hypo_severe_upset,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_hypo_mod.factor = factor(parent_data$p_hfs_b_hypo_mod,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hfs_b_hypo_mod_upset.factor = factor(parent_data$p_hfs_b_hypo_mod_upset,levels=c("0","1","2","3","4"))
parent_data$p_hfs_b_hypo_mild.factor = factor(parent_data$p_hfs_b_hypo_mild,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hfs_b_hypo_mild_upset.factor = factor(parent_data$p_hfs_b_hypo_mild_upset,levels=c("0","1","2","3","4"))
parent_data$baseline_hfs_cb99_complete.factor = factor(parent_data$baseline_hfs_cb99_complete,levels=c("0","1","2"))
parent_data$p_paid1.factor = factor(parent_data$p_paid1,levels=c("1","2","3","4","5"))
parent_data$p_paid2.factor = factor(parent_data$p_paid2,levels=c("1","2","3","4","5"))
parent_data$p_paid3.factor = factor(parent_data$p_paid3,levels=c("1","2","3","4","5"))
parent_data$p_paid4.factor = factor(parent_data$p_paid4,levels=c("1","2","3","4","5"))
parent_data$p_paid5.factor = factor(parent_data$p_paid5,levels=c("1","2","3","4","5"))
parent_data$p_paid6.factor = factor(parent_data$p_paid6,levels=c("1","2","3","4","5"))
parent_data$p_paid7.factor = factor(parent_data$p_paid7,levels=c("1","2","3","4","5"))
parent_data$p_paid8.factor = factor(parent_data$p_paid8,levels=c("1","2","3","4","5"))
parent_data$p_paid9.factor = factor(parent_data$p_paid9,levels=c("1","2","3","4","5"))
parent_data$p_paid10.factor = factor(parent_data$p_paid10,levels=c("1","2","3","4","5"))
parent_data$p_paid11.factor = factor(parent_data$p_paid11,levels=c("1","2","3","4","5"))
parent_data$p_paid12.factor = factor(parent_data$p_paid12,levels=c("1","2","3","4","5"))
parent_data$p_paid13.factor = factor(parent_data$p_paid13,levels=c("1","2","3","4","5"))
parent_data$p_paid14.factor = factor(parent_data$p_paid14,levels=c("1","2","3","4","5"))
parent_data$p_paid15.factor = factor(parent_data$p_paid15,levels=c("1","2","3","4","5"))
parent_data$p_paid16.factor = factor(parent_data$p_paid16,levels=c("1","2","3","4","5"))
parent_data$p_paid17.factor = factor(parent_data$p_paid17,levels=c("1","2","3","4","5"))
parent_data$p_paid18.factor = factor(parent_data$p_paid18,levels=c("1","2","3","4","5"))
parent_data$paid_complete.factor = factor(parent_data$paid_complete,levels=c("0","1","2"))
parent_data$tech1.factor = factor(parent_data$tech1,levels=c("0","1","2","3","4"))
parent_data$tech2.factor = factor(parent_data$tech2,levels=c("0","1","2","3","4"))
parent_data$tech3.factor = factor(parent_data$tech3,levels=c("0","1","2","3","4"))
parent_data$tech4.factor = factor(parent_data$tech4,levels=c("0","1","2","3","4"))
parent_data$tech5.factor = factor(parent_data$tech5,levels=c("0","1","2","3","4"))
parent_data$diabetes_technology_complete.factor = factor(parent_data$diabetes_technology_complete,levels=c("0","1","2"))
parent_data$p_hfs_f_behave1.factor = factor(parent_data$p_hfs_f_behave1,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_behave2.factor = factor(parent_data$p_hfs_f_behave2,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_behave3.factor = factor(parent_data$p_hfs_f_behave3,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_behave4.factor = factor(parent_data$p_hfs_f_behave4,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_behave5.factor = factor(parent_data$p_hfs_f_behave5,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_behave6.factor = factor(parent_data$p_hfs_f_behave6,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_behave7.factor = factor(parent_data$p_hfs_f_behave7,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_behave8.factor = factor(parent_data$p_hfs_f_behave8,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_behave9.factor = factor(parent_data$p_hfs_f_behave9,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_behave10.factor = factor(parent_data$p_hfs_f_behave10,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_behave11.factor = factor(parent_data$p_hfs_f_behave11,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry12.factor = factor(parent_data$p_hfs_f_worry12,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry13.factor = factor(parent_data$p_hfs_f_worry13,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry14.factor = factor(parent_data$p_hfs_f_worry14,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry15.factor = factor(parent_data$p_hfs_f_worry15,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry16.factor = factor(parent_data$p_hfs_f_worry16,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry17.factor = factor(parent_data$p_hfs_f_worry17,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry18.factor = factor(parent_data$p_hfs_f_worry18,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry19.factor = factor(parent_data$p_hfs_f_worry19,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry20.factor = factor(parent_data$p_hfs_f_worry20,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry21.factor = factor(parent_data$p_hfs_f_worry21,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry22.factor = factor(parent_data$p_hfs_f_worry22,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry23.factor = factor(parent_data$p_hfs_f_worry23,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry24.factor = factor(parent_data$p_hfs_f_worry24,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry25.factor = factor(parent_data$p_hfs_f_worry25,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_worry26.factor = factor(parent_data$p_hfs_f_worry26,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_hypo_severe.factor = factor(parent_data$p_hfs_f_hypo_severe,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hfs_f_hypo_severe_upset.factor = factor(parent_data$p_hfs_f_hypo_severe_upset,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_hypo_mod.factor = factor(parent_data$p_hfs_f_hypo_mod,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hfs_f_hypo_mod_upset.factor = factor(parent_data$p_hfs_f_hypo_mod_upset,levels=c("0","1","2","3","4"))
parent_data$p_hfs_f_hypo_mild.factor = factor(parent_data$p_hfs_f_hypo_mild,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hfs_f_hypo_mild_upset.factor = factor(parent_data$p_hfs_f_hypo_mild_upset,levels=c("0","1","2","3","4"))
parent_data$baseline_hfs_complete.factor = factor(parent_data$baseline_hfs_complete,levels=c("0","1","2"))
parent_data$p_f_inspire1.factor = factor(parent_data$p_f_inspire1,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire2.factor = factor(parent_data$p_f_inspire2,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire3.factor = factor(parent_data$p_f_inspire3,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire4.factor = factor(parent_data$p_f_inspire4,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire5.factor = factor(parent_data$p_f_inspire5,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire6.factor = factor(parent_data$p_f_inspire6,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire7.factor = factor(parent_data$p_f_inspire7,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire8.factor = factor(parent_data$p_f_inspire8,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire9.factor = factor(parent_data$p_f_inspire9,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire10.factor = factor(parent_data$p_f_inspire10,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire11.factor = factor(parent_data$p_f_inspire11,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire12.factor = factor(parent_data$p_f_inspire12,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire13.factor = factor(parent_data$p_f_inspire13,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire14.factor = factor(parent_data$p_f_inspire14,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire15.factor = factor(parent_data$p_f_inspire15,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire16.factor = factor(parent_data$p_f_inspire16,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire17.factor = factor(parent_data$p_f_inspire17,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire18.factor = factor(parent_data$p_f_inspire18,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire19.factor = factor(parent_data$p_f_inspire19,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire20.factor = factor(parent_data$p_f_inspire20,levels=c("0","1","2","3","4","5"))
parent_data$p_f_inspire21.factor = factor(parent_data$p_f_inspire21,levels=c("0","1","2","3","4","5"))
parent_data$inspire_follow_up_complete.factor = factor(parent_data$inspire_follow_up_complete,levels=c("0","1","2"))
parent_data$timepoint_baselinesurvey.factor = factor(parent_data$timepoint_baselinesurvey,levels=c("0","1","2","3","4","5"))
parent_data$p_hfs_behave1.factor = factor(parent_data$p_hfs_behave1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave2.factor = factor(parent_data$p_hfs_behave2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave3.factor = factor(parent_data$p_hfs_behave3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave4.factor = factor(parent_data$p_hfs_behave4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave5.factor = factor(parent_data$p_hfs_behave5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave6.factor = factor(parent_data$p_hfs_behave6,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave7.factor = factor(parent_data$p_hfs_behave7,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave8.factor = factor(parent_data$p_hfs_behave8,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave9.factor = factor(parent_data$p_hfs_behave9,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave10.factor = factor(parent_data$p_hfs_behave10,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave11.factor = factor(parent_data$p_hfs_behave11,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry12.factor = factor(parent_data$p_hfs_worry12,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry13.factor = factor(parent_data$p_hfs_worry13,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry14.factor = factor(parent_data$p_hfs_worry14,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry15.factor = factor(parent_data$p_hfs_worry15,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry16.factor = factor(parent_data$p_hfs_worry16,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry17.factor = factor(parent_data$p_hfs_worry17,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry18.factor = factor(parent_data$p_hfs_worry18,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry19.factor = factor(parent_data$p_hfs_worry19,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry20.factor = factor(parent_data$p_hfs_worry20,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry21.factor = factor(parent_data$p_hfs_worry21,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry22.factor = factor(parent_data$p_hfs_worry22,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry23.factor = factor(parent_data$p_hfs_worry23,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry24.factor = factor(parent_data$p_hfs_worry24,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry25.factor = factor(parent_data$p_hfs_worry25,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry26.factor = factor(parent_data$p_hfs_worry26,levels=c("1","2","3","4","5"))
parent_data$p_hypo_severe.factor = factor(parent_data$p_hypo_severe,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_severe_yes.factor = factor(parent_data$p_hypo_severe_yes,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mod.factor = factor(parent_data$p_hypo_mod,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mod_yes.factor = factor(parent_data$p_hypo_mod_yes,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mild.factor = factor(parent_data$p_hypo_mild,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mild_yes.factor = factor(parent_data$p_hypo_mild_yes,levels=c("0","1","2","3","4"))
parent_data$p_paid1_b.factor = factor(parent_data$p_paid1_b,levels=c("1","2","3","4","5"))
parent_data$p_paid2_b.factor = factor(parent_data$p_paid2_b,levels=c("1","2","3","4","5"))
parent_data$p_paid3_b.factor = factor(parent_data$p_paid3_b,levels=c("1","2","3","4","5"))
parent_data$p_paid4_b.factor = factor(parent_data$p_paid4_b,levels=c("1","2","3","4","5"))
parent_data$p_paid5_b.factor = factor(parent_data$p_paid5_b,levels=c("1","2","3","4","5"))
parent_data$p_paid6_b.factor = factor(parent_data$p_paid6_b,levels=c("1","2","3","4","5"))
parent_data$p_paid7_b.factor = factor(parent_data$p_paid7_b,levels=c("1","2","3","4","5"))
parent_data$p_paid8_b.factor = factor(parent_data$p_paid8_b,levels=c("1","2","3","4","5"))
parent_data$p_paid9_b.factor = factor(parent_data$p_paid9_b,levels=c("1","2","3","4","5"))
parent_data$p_paid10_b.factor = factor(parent_data$p_paid10_b,levels=c("1","2","3","4","5"))
parent_data$p_paid11_b.factor = factor(parent_data$p_paid11_b,levels=c("1","2","3","4","5"))
parent_data$p_paid12_b.factor = factor(parent_data$p_paid12_b,levels=c("1","2","3","4","5"))
parent_data$p_paid13_b.factor = factor(parent_data$p_paid13_b,levels=c("1","2","3","4","5"))
parent_data$p_paid14_b.factor = factor(parent_data$p_paid14_b,levels=c("1","2","3","4","5"))
parent_data$p_paid15_b.factor = factor(parent_data$p_paid15_b,levels=c("1","2","3","4","5"))
parent_data$p_paid16_b.factor = factor(parent_data$p_paid16_b,levels=c("1","2","3","4","5"))
parent_data$p_paid17_b.factor = factor(parent_data$p_paid17_b,levels=c("1","2","3","4","5"))
parent_data$p_paid18_b.factor = factor(parent_data$p_paid18_b,levels=c("1","2","3","4","5"))
parent_data$baseline_survey_complete.factor = factor(parent_data$baseline_survey_complete,levels=c("0","1","2"))
parent_data$timepoint_survey1.factor = factor(parent_data$timepoint_survey1,levels=c("0","1","2","3","4","5"))
parent_data$p_hfs_behave1_t1.factor = factor(parent_data$p_hfs_behave1_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave2_t1.factor = factor(parent_data$p_hfs_behave2_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave3_t1.factor = factor(parent_data$p_hfs_behave3_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave4_t1.factor = factor(parent_data$p_hfs_behave4_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave5_t1.factor = factor(parent_data$p_hfs_behave5_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave6_t1.factor = factor(parent_data$p_hfs_behave6_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave7_t1.factor = factor(parent_data$p_hfs_behave7_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave8_t1.factor = factor(parent_data$p_hfs_behave8_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave9_t1.factor = factor(parent_data$p_hfs_behave9_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave10_t1.factor = factor(parent_data$p_hfs_behave10_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave11_t1.factor = factor(parent_data$p_hfs_behave11_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry12_t1.factor = factor(parent_data$p_hfs_worry12_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry13_t1.factor = factor(parent_data$p_hfs_worry13_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry14_t1.factor = factor(parent_data$p_hfs_worry14_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry15_t1.factor = factor(parent_data$p_hfs_worry15_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry16_t1.factor = factor(parent_data$p_hfs_worry16_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry17_t1.factor = factor(parent_data$p_hfs_worry17_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry18_t1.factor = factor(parent_data$p_hfs_worry18_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry19_t1.factor = factor(parent_data$p_hfs_worry19_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry20_t1.factor = factor(parent_data$p_hfs_worry20_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry21_t1.factor = factor(parent_data$p_hfs_worry21_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry22_t1.factor = factor(parent_data$p_hfs_worry22_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry23_t1.factor = factor(parent_data$p_hfs_worry23_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry24_t1.factor = factor(parent_data$p_hfs_worry24_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry25_t1.factor = factor(parent_data$p_hfs_worry25_t1,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry26_t1.factor = factor(parent_data$p_hfs_worry26_t1,levels=c("1","2","3","4","5"))
parent_data$p_hypo_severe_t1.factor = factor(parent_data$p_hypo_severe_t1,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_severe_yes_t1.factor = factor(parent_data$p_hypo_severe_yes_t1,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mod_t1.factor = factor(parent_data$p_hypo_mod_t1,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mod_yes_t1.factor = factor(parent_data$p_hypo_mod_yes_t1,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mild_t1.factor = factor(parent_data$p_hypo_mild_t1,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mild_yes_t1.factor = factor(parent_data$p_hypo_mild_yes_t1,levels=c("0","1","2","3","4"))
parent_data$p_paid1_t1.factor = factor(parent_data$p_paid1_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid2_t1.factor = factor(parent_data$p_paid2_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid3_t1.factor = factor(parent_data$p_paid3_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid4_t1.factor = factor(parent_data$p_paid4_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid5_t1.factor = factor(parent_data$p_paid5_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid6_t1.factor = factor(parent_data$p_paid6_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid7_t1.factor = factor(parent_data$p_paid7_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid8_t1.factor = factor(parent_data$p_paid8_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid9_t1.factor = factor(parent_data$p_paid9_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid10_t1.factor = factor(parent_data$p_paid10_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid11_t1.factor = factor(parent_data$p_paid11_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid12_t1.factor = factor(parent_data$p_paid12_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid13_t1.factor = factor(parent_data$p_paid13_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid14_t1.factor = factor(parent_data$p_paid14_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid15_t1.factor = factor(parent_data$p_paid15_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid16_t1.factor = factor(parent_data$p_paid16_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid17_t1.factor = factor(parent_data$p_paid17_t1,levels=c("1","2","3","4","5"))
parent_data$p_paid18_t1.factor = factor(parent_data$p_paid18_t1,levels=c("1","2","3","4","5"))
parent_data$dtb.factor = factor(parent_data$dtb,levels=c("50","51","52","53","54"))
parent_data$dte.factor = factor(parent_data$dte,levels=c("50","51","52","53","54"))
parent_data$dth.factor = factor(parent_data$dth,levels=c("50","51","52","53","54"))
parent_data$dtgb.factor = factor(parent_data$dtgb,levels=c("50","51","52","53","54"))
parent_data$dttw.factor = factor(parent_data$dttw,levels=c("50","51","52","53","54"))
parent_data$p_inspire1_t1.factor = factor(parent_data$p_inspire1_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire2_t1.factor = factor(parent_data$p_inspire2_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire3_t1.factor = factor(parent_data$p_inspire3_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire4_t1.factor = factor(parent_data$p_inspire4_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire5_t1.factor = factor(parent_data$p_inspire5_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire6_t1.factor = factor(parent_data$p_inspire6_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire7_t1.factor = factor(parent_data$p_inspire7_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire8_t1.factor = factor(parent_data$p_inspire8_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire9_t1.factor = factor(parent_data$p_inspire9_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire10_t1.factor = factor(parent_data$p_inspire10_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire11_t1.factor = factor(parent_data$p_inspire11_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire12_t1.factor = factor(parent_data$p_inspire12_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire13_t1.factor = factor(parent_data$p_inspire13_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire14_t1.factor = factor(parent_data$p_inspire14_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire15_t1.factor = factor(parent_data$p_inspire15_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire16_t1.factor = factor(parent_data$p_inspire16_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire17_t1.factor = factor(parent_data$p_inspire17_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire18_t1.factor = factor(parent_data$p_inspire18_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire19_t1.factor = factor(parent_data$p_inspire19_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire20_t1.factor = factor(parent_data$p_inspire20_t1,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire21_t1.factor = factor(parent_data$p_inspire21_t1,levels=c("0","1","2","3","4","5"))
parent_data$survey_1_complete.factor = factor(parent_data$survey_1_complete,levels=c("0","1","2"))
parent_data$timepoint_survey2.factor = factor(parent_data$timepoint_survey2,levels=c("0","1","2","3","4","5"))
parent_data$p_hfs_behave1_t2.factor = factor(parent_data$p_hfs_behave1_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave2_t2.factor = factor(parent_data$p_hfs_behave2_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave3_t2.factor = factor(parent_data$p_hfs_behave3_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave4_t2.factor = factor(parent_data$p_hfs_behave4_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave5_t2.factor = factor(parent_data$p_hfs_behave5_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave6_t2.factor = factor(parent_data$p_hfs_behave6_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave7_t2.factor = factor(parent_data$p_hfs_behave7_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave8_t2.factor = factor(parent_data$p_hfs_behave8_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave9_t2.factor = factor(parent_data$p_hfs_behave9_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave10_t2.factor = factor(parent_data$p_hfs_behave10_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave11_t2.factor = factor(parent_data$p_hfs_behave11_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry12_t2.factor = factor(parent_data$p_hfs_worry12_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry13_t2.factor = factor(parent_data$p_hfs_worry13_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry14_t2.factor = factor(parent_data$p_hfs_worry14_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry15_t2.factor = factor(parent_data$p_hfs_worry15_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry16_t2.factor = factor(parent_data$p_hfs_worry16_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry17_t2.factor = factor(parent_data$p_hfs_worry17_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry18_t2.factor = factor(parent_data$p_hfs_worry18_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry19_t2.factor = factor(parent_data$p_hfs_worry19_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry20_t2.factor = factor(parent_data$p_hfs_worry20_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry21_t2.factor = factor(parent_data$p_hfs_worry21_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry22_t2.factor = factor(parent_data$p_hfs_worry22_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry23_t2.factor = factor(parent_data$p_hfs_worry23_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry24_t2.factor = factor(parent_data$p_hfs_worry24_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry25_t2.factor = factor(parent_data$p_hfs_worry25_t2,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry26_t2.factor = factor(parent_data$p_hfs_worry26_t2,levels=c("1","2","3","4","5"))
parent_data$p_hypo_severe_t2.factor = factor(parent_data$p_hypo_severe_t2,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_severe_yes_t2.factor = factor(parent_data$p_hypo_severe_yes_t2,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mod_t2.factor = factor(parent_data$p_hypo_mod_t2,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mod_yes_t2.factor = factor(parent_data$p_hypo_mod_yes_t2,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mild_t2.factor = factor(parent_data$p_hypo_mild_t2,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mild_yes_t2.factor = factor(parent_data$p_hypo_mild_yes_t2,levels=c("0","1","2","3","4"))
parent_data$p_paid1_t2.factor = factor(parent_data$p_paid1_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid2_t2.factor = factor(parent_data$p_paid2_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid3_t2.factor = factor(parent_data$p_paid3_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid4_t2.factor = factor(parent_data$p_paid4_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid5_t2.factor = factor(parent_data$p_paid5_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid6_t2.factor = factor(parent_data$p_paid6_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid7_t2.factor = factor(parent_data$p_paid7_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid8_t2.factor = factor(parent_data$p_paid8_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid9_t2.factor = factor(parent_data$p_paid9_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid10_t2.factor = factor(parent_data$p_paid10_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid11_t2.factor = factor(parent_data$p_paid11_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid12_t2.factor = factor(parent_data$p_paid12_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid13_t2.factor = factor(parent_data$p_paid13_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid14_t2.factor = factor(parent_data$p_paid14_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid15_t2.factor = factor(parent_data$p_paid15_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid16_t2.factor = factor(parent_data$p_paid16_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid17_t2.factor = factor(parent_data$p_paid17_t2,levels=c("1","2","3","4","5"))
parent_data$p_paid18_t2.factor = factor(parent_data$p_paid18_t2,levels=c("1","2","3","4","5"))
parent_data$dtb2.factor = factor(parent_data$dtb2,levels=c("50","51","52","53","54"))
parent_data$dte2.factor = factor(parent_data$dte2,levels=c("50","51","52","53","54"))
parent_data$dth2.factor = factor(parent_data$dth2,levels=c("50","51","52","53","54"))
parent_data$dtgb2.factor = factor(parent_data$dtgb2,levels=c("50","51","52","53","54"))
parent_data$dttw2.factor = factor(parent_data$dttw2,levels=c("50","51","52","53","54"))
parent_data$p_inspire1_t2.factor = factor(parent_data$p_inspire1_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire2_t2.factor = factor(parent_data$p_inspire2_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire3_t2.factor = factor(parent_data$p_inspire3_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire4_t2.factor = factor(parent_data$p_inspire4_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire5_t2.factor = factor(parent_data$p_inspire5_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire6_t2.factor = factor(parent_data$p_inspire6_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire7_t2.factor = factor(parent_data$p_inspire7_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire8_t2.factor = factor(parent_data$p_inspire8_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire9_t2.factor = factor(parent_data$p_inspire9_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire10_t2.factor = factor(parent_data$p_inspire10_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire11_t2.factor = factor(parent_data$p_inspire11_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire12_t2.factor = factor(parent_data$p_inspire12_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire13_t2.factor = factor(parent_data$p_inspire13_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire14_t2.factor = factor(parent_data$p_inspire14_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire15_t2.factor = factor(parent_data$p_inspire15_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire16_t2.factor = factor(parent_data$p_inspire16_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire17_t2.factor = factor(parent_data$p_inspire17_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire18_t2.factor = factor(parent_data$p_inspire18_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire19_t2.factor = factor(parent_data$p_inspire19_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire20_t2.factor = factor(parent_data$p_inspire20_t2,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire21_t2.factor = factor(parent_data$p_inspire21_t2,levels=c("0","1","2","3","4","5"))
parent_data$survey_2_complete.factor = factor(parent_data$survey_2_complete,levels=c("0","1","2"))
parent_data$timepoint_survey3.factor = factor(parent_data$timepoint_survey3,levels=c("0","1","2","3","4","5"))
parent_data$p_hfs_behave1_t3.factor = factor(parent_data$p_hfs_behave1_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave2_t3.factor = factor(parent_data$p_hfs_behave2_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave3_t3.factor = factor(parent_data$p_hfs_behave3_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave4_t3.factor = factor(parent_data$p_hfs_behave4_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave5_t3.factor = factor(parent_data$p_hfs_behave5_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave6_t3.factor = factor(parent_data$p_hfs_behave6_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave7_t3.factor = factor(parent_data$p_hfs_behave7_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave8_t3.factor = factor(parent_data$p_hfs_behave8_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave9_t3.factor = factor(parent_data$p_hfs_behave9_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave10_t3.factor = factor(parent_data$p_hfs_behave10_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave11_t3.factor = factor(parent_data$p_hfs_behave11_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry12_t3.factor = factor(parent_data$p_hfs_worry12_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry13_t3.factor = factor(parent_data$p_hfs_worry13_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry14_t3.factor = factor(parent_data$p_hfs_worry14_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry15_t3.factor = factor(parent_data$p_hfs_worry15_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry16_t3.factor = factor(parent_data$p_hfs_worry16_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry17_t3.factor = factor(parent_data$p_hfs_worry17_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry18_t3.factor = factor(parent_data$p_hfs_worry18_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry19_t3.factor = factor(parent_data$p_hfs_worry19_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry20_t3.factor = factor(parent_data$p_hfs_worry20_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry21_t3.factor = factor(parent_data$p_hfs_worry21_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry22_t3.factor = factor(parent_data$p_hfs_worry22_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry23_t3.factor = factor(parent_data$p_hfs_worry23_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry24_t3.factor = factor(parent_data$p_hfs_worry24_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry25_t3.factor = factor(parent_data$p_hfs_worry25_t3,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry26_t3.factor = factor(parent_data$p_hfs_worry26_t3,levels=c("1","2","3","4","5"))
parent_data$p_hypo_severe_t3.factor = factor(parent_data$p_hypo_severe_t3,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_severe_yes_t3.factor = factor(parent_data$p_hypo_severe_yes_t3,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mod_t3.factor = factor(parent_data$p_hypo_mod_t3,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mod_yes_t3.factor = factor(parent_data$p_hypo_mod_yes_t3,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mild_t3.factor = factor(parent_data$p_hypo_mild_t3,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mild_yes_t3.factor = factor(parent_data$p_hypo_mild_yes_t3,levels=c("0","1","2","3","4"))
parent_data$p_paid1_t3.factor = factor(parent_data$p_paid1_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid2_t3.factor = factor(parent_data$p_paid2_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid3_t3.factor = factor(parent_data$p_paid3_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid4_t3.factor = factor(parent_data$p_paid4_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid5_t3.factor = factor(parent_data$p_paid5_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid6_t3.factor = factor(parent_data$p_paid6_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid7_t3.factor = factor(parent_data$p_paid7_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid8_t3.factor = factor(parent_data$p_paid8_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid9_t3.factor = factor(parent_data$p_paid9_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid10_t3.factor = factor(parent_data$p_paid10_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid11_t3.factor = factor(parent_data$p_paid11_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid12_t3.factor = factor(parent_data$p_paid12_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid13_t3.factor = factor(parent_data$p_paid13_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid14_t3.factor = factor(parent_data$p_paid14_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid15_t3.factor = factor(parent_data$p_paid15_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid16_t3.factor = factor(parent_data$p_paid16_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid17_t3.factor = factor(parent_data$p_paid17_t3,levels=c("1","2","3","4","5"))
parent_data$p_paid18_t3.factor = factor(parent_data$p_paid18_t3,levels=c("1","2","3","4","5"))
parent_data$dtb3.factor = factor(parent_data$dtb3,levels=c("50","51","52","53","54"))
parent_data$dte3.factor = factor(parent_data$dte3,levels=c("50","51","52","53","54"))
parent_data$dth3.factor = factor(parent_data$dth3,levels=c("50","51","52","53","54"))
parent_data$dtgb3.factor = factor(parent_data$dtgb3,levels=c("50","51","52","53","54"))
parent_data$dttw3.factor = factor(parent_data$dttw3,levels=c("50","51","52","53","54"))
parent_data$p_inspire1_t3.factor = factor(parent_data$p_inspire1_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire2_t3.factor = factor(parent_data$p_inspire2_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire3_t3.factor = factor(parent_data$p_inspire3_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire4_t3.factor = factor(parent_data$p_inspire4_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire5_t3.factor = factor(parent_data$p_inspire5_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire6_t3.factor = factor(parent_data$p_inspire6_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire7_t3.factor = factor(parent_data$p_inspire7_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire8_t3.factor = factor(parent_data$p_inspire8_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire9_t3.factor = factor(parent_data$p_inspire9_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire10_t3.factor = factor(parent_data$p_inspire10_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire11_t3.factor = factor(parent_data$p_inspire11_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire12_t3.factor = factor(parent_data$p_inspire12_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire13_t3.factor = factor(parent_data$p_inspire13_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire14_t3.factor = factor(parent_data$p_inspire14_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire15_t3.factor = factor(parent_data$p_inspire15_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire16_t3.factor = factor(parent_data$p_inspire16_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire17_t3.factor = factor(parent_data$p_inspire17_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire18_t3.factor = factor(parent_data$p_inspire18_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire19_t3.factor = factor(parent_data$p_inspire19_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire20_t3.factor = factor(parent_data$p_inspire20_t3,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire21_t3.factor = factor(parent_data$p_inspire21_t3,levels=c("0","1","2","3","4","5"))
parent_data$survey_3_complete.factor = factor(parent_data$survey_3_complete,levels=c("0","1","2"))
parent_data$timepoint_survey4.factor = factor(parent_data$timepoint_survey4,levels=c("0","1","2","3","4","5"))
parent_data$p_hfs_behave1_t4.factor = factor(parent_data$p_hfs_behave1_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave2_t4.factor = factor(parent_data$p_hfs_behave2_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave3_t4.factor = factor(parent_data$p_hfs_behave3_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave4_t4.factor = factor(parent_data$p_hfs_behave4_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave5_t4.factor = factor(parent_data$p_hfs_behave5_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave6_t4.factor = factor(parent_data$p_hfs_behave6_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave7_t4.factor = factor(parent_data$p_hfs_behave7_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave8_t4.factor = factor(parent_data$p_hfs_behave8_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave9_t4.factor = factor(parent_data$p_hfs_behave9_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave10_t4.factor = factor(parent_data$p_hfs_behave10_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave11_t4.factor = factor(parent_data$p_hfs_behave11_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry12_t4.factor = factor(parent_data$p_hfs_worry12_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry13_t4.factor = factor(parent_data$p_hfs_worry13_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry14_t4.factor = factor(parent_data$p_hfs_worry14_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry15_t4.factor = factor(parent_data$p_hfs_worry15_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry16_t4.factor = factor(parent_data$p_hfs_worry16_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry17_t4.factor = factor(parent_data$p_hfs_worry17_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry18_t4.factor = factor(parent_data$p_hfs_worry18_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry19_t4.factor = factor(parent_data$p_hfs_worry19_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry20_t4.factor = factor(parent_data$p_hfs_worry20_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry21_t4.factor = factor(parent_data$p_hfs_worry21_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry22_t4.factor = factor(parent_data$p_hfs_worry22_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry23_t4.factor = factor(parent_data$p_hfs_worry23_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry24_t4.factor = factor(parent_data$p_hfs_worry24_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry25_t4.factor = factor(parent_data$p_hfs_worry25_t4,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry26_t4.factor = factor(parent_data$p_hfs_worry26_t4,levels=c("1","2","3","4","5"))
parent_data$p_hypo_severe_t4.factor = factor(parent_data$p_hypo_severe_t4,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_severe_yes_t4.factor = factor(parent_data$p_hypo_severe_yes_t4,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mod_t4.factor = factor(parent_data$p_hypo_mod_t4,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mod_yes_t4.factor = factor(parent_data$p_hypo_mod_yes_t4,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mild_t4.factor = factor(parent_data$p_hypo_mild_t4,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mild_yes_t4.factor = factor(parent_data$p_hypo_mild_yes_t4,levels=c("0","1","2","3","4"))
parent_data$p_paid1_t4.factor = factor(parent_data$p_paid1_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid2_t4.factor = factor(parent_data$p_paid2_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid3_t4.factor = factor(parent_data$p_paid3_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid4_t4.factor = factor(parent_data$p_paid4_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid5_t4.factor = factor(parent_data$p_paid5_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid6_t4.factor = factor(parent_data$p_paid6_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid7_t4.factor = factor(parent_data$p_paid7_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid8_t4.factor = factor(parent_data$p_paid8_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid9_t4.factor = factor(parent_data$p_paid9_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid10_t4.factor = factor(parent_data$p_paid10_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid11_t4.factor = factor(parent_data$p_paid11_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid12_t4.factor = factor(parent_data$p_paid12_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid13_t4.factor = factor(parent_data$p_paid13_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid14_t4.factor = factor(parent_data$p_paid14_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid15_t4.factor = factor(parent_data$p_paid15_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid16_t4.factor = factor(parent_data$p_paid16_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid17_t4.factor = factor(parent_data$p_paid17_t4,levels=c("1","2","3","4","5"))
parent_data$p_paid18_t4.factor = factor(parent_data$p_paid18_t4,levels=c("1","2","3","4","5"))
parent_data$dtb4.factor = factor(parent_data$dtb4,levels=c("50","51","52","53","54"))
parent_data$dte4.factor = factor(parent_data$dte4,levels=c("50","51","52","53","54"))
parent_data$dth4.factor = factor(parent_data$dth4,levels=c("50","51","52","53","54"))
parent_data$dtgb4.factor = factor(parent_data$dtgb4,levels=c("50","51","52","53","54"))
parent_data$dttw4.factor = factor(parent_data$dttw4,levels=c("50","51","52","53","54"))
parent_data$p_inspire1_t4.factor = factor(parent_data$p_inspire1_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire2_t4.factor = factor(parent_data$p_inspire2_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire3_t4.factor = factor(parent_data$p_inspire3_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire4_t4.factor = factor(parent_data$p_inspire4_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire5_t4.factor = factor(parent_data$p_inspire5_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire6_t4.factor = factor(parent_data$p_inspire6_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire7_t4.factor = factor(parent_data$p_inspire7_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire8_t4.factor = factor(parent_data$p_inspire8_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire9_t4.factor = factor(parent_data$p_inspire9_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire10_t4.factor = factor(parent_data$p_inspire10_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire11_t4.factor = factor(parent_data$p_inspire11_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire12_t4.factor = factor(parent_data$p_inspire12_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire13_t4.factor = factor(parent_data$p_inspire13_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire14_t4.factor = factor(parent_data$p_inspire14_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire15_t4.factor = factor(parent_data$p_inspire15_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire16_t4.factor = factor(parent_data$p_inspire16_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire17_t4.factor = factor(parent_data$p_inspire17_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire18_t4.factor = factor(parent_data$p_inspire18_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire19_t4.factor = factor(parent_data$p_inspire19_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire20_t4.factor = factor(parent_data$p_inspire20_t4,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire21_t4.factor = factor(parent_data$p_inspire21_t4,levels=c("0","1","2","3","4","5"))
parent_data$survey_4_complete.factor = factor(parent_data$survey_4_complete,levels=c("0","1","2"))
parent_data$timepoint_survey4_suvey5.factor = factor(parent_data$timepoint_survey4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_hfs_behave1_t4_suvey5.factor = factor(parent_data$p_hfs_behave1_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave2_t4_suvey5.factor = factor(parent_data$p_hfs_behave2_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave3_t4_suvey5.factor = factor(parent_data$p_hfs_behave3_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave4_t4_suvey5.factor = factor(parent_data$p_hfs_behave4_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave5_t4_suvey5.factor = factor(parent_data$p_hfs_behave5_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave6_t4_suvey5.factor = factor(parent_data$p_hfs_behave6_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave7_t4_suvey5.factor = factor(parent_data$p_hfs_behave7_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave8_t4_suvey5.factor = factor(parent_data$p_hfs_behave8_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave9_t4_suvey5.factor = factor(parent_data$p_hfs_behave9_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave10_t4_suvey5.factor = factor(parent_data$p_hfs_behave10_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_behave11_t4_suvey5.factor = factor(parent_data$p_hfs_behave11_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry12_t4_suvey5.factor = factor(parent_data$p_hfs_worry12_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry13_t4_suvey5.factor = factor(parent_data$p_hfs_worry13_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry14_t4_suvey5.factor = factor(parent_data$p_hfs_worry14_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry15_t4_suvey5.factor = factor(parent_data$p_hfs_worry15_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry16_t4_suvey5.factor = factor(parent_data$p_hfs_worry16_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry17_t4_suvey5.factor = factor(parent_data$p_hfs_worry17_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry18_t4_suvey5.factor = factor(parent_data$p_hfs_worry18_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry19_t4_suvey5.factor = factor(parent_data$p_hfs_worry19_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry20_t4_suvey5.factor = factor(parent_data$p_hfs_worry20_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry21_t4_suvey5.factor = factor(parent_data$p_hfs_worry21_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry22_t4_suvey5.factor = factor(parent_data$p_hfs_worry22_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry23_t4_suvey5.factor = factor(parent_data$p_hfs_worry23_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry24_t4_suvey5.factor = factor(parent_data$p_hfs_worry24_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry25_t4_suvey5.factor = factor(parent_data$p_hfs_worry25_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hfs_worry26_t4_suvey5.factor = factor(parent_data$p_hfs_worry26_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_hypo_severe_t4_suvey5.factor = factor(parent_data$p_hypo_severe_t4_suvey5,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_severe_yes_t4_suvey5.factor = factor(parent_data$p_hypo_severe_yes_t4_suvey5,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mod_t4_suvey5.factor = factor(parent_data$p_hypo_mod_t4_suvey5,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mod_yes_t4_suvey5.factor = factor(parent_data$p_hypo_mod_yes_t4_suvey5,levels=c("0","1","2","3","4"))
parent_data$p_hypo_mild_t4_suvey5.factor = factor(parent_data$p_hypo_mild_t4_suvey5,levels=c("0","1","2","3","4","5","6","7","8","9"))
parent_data$p_hypo_mild_yes_t4_suvey5.factor = factor(parent_data$p_hypo_mild_yes_t4_suvey5,levels=c("0","1","2","3","4"))
parent_data$p_paid1_t4_suvey5.factor = factor(parent_data$p_paid1_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid2_t4_suvey5.factor = factor(parent_data$p_paid2_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid3_t4_suvey5.factor = factor(parent_data$p_paid3_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid4_t4_suvey5.factor = factor(parent_data$p_paid4_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid5_t4_suvey5.factor = factor(parent_data$p_paid5_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid6_t4_suvey5.factor = factor(parent_data$p_paid6_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid7_t4_suvey5.factor = factor(parent_data$p_paid7_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid8_t4_suvey5.factor = factor(parent_data$p_paid8_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid9_t4_suvey5.factor = factor(parent_data$p_paid9_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid10_t4_suvey5.factor = factor(parent_data$p_paid10_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid11_t4_suvey5.factor = factor(parent_data$p_paid11_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid12_t4_suvey5.factor = factor(parent_data$p_paid12_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid13_t4_suvey5.factor = factor(parent_data$p_paid13_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid14_t4_suvey5.factor = factor(parent_data$p_paid14_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid15_t4_suvey5.factor = factor(parent_data$p_paid15_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid16_t4_suvey5.factor = factor(parent_data$p_paid16_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid17_t4_suvey5.factor = factor(parent_data$p_paid17_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$p_paid18_t4_suvey5.factor = factor(parent_data$p_paid18_t4_suvey5,levels=c("1","2","3","4","5"))
parent_data$dtb4_suvey5.factor = factor(parent_data$dtb4_suvey5,levels=c("50","51","52","53","54"))
parent_data$dte4_suvey5.factor = factor(parent_data$dte4_suvey5,levels=c("50","51","52","53","54"))
parent_data$dth4_suvey5.factor = factor(parent_data$dth4_suvey5,levels=c("50","51","52","53","54"))
parent_data$dtgb4_suvey5.factor = factor(parent_data$dtgb4_suvey5,levels=c("50","51","52","53","54"))
parent_data$dttw4_suvey5.factor = factor(parent_data$dttw4_suvey5,levels=c("50","51","52","53","54"))
parent_data$p_inspire1_t4_suvey5.factor = factor(parent_data$p_inspire1_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire2_t4_suvey5.factor = factor(parent_data$p_inspire2_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire3_t4_suvey5.factor = factor(parent_data$p_inspire3_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire4_t4_suvey5.factor = factor(parent_data$p_inspire4_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire5_t4_suvey5.factor = factor(parent_data$p_inspire5_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire6_t4_suvey5.factor = factor(parent_data$p_inspire6_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire7_t4_suvey5.factor = factor(parent_data$p_inspire7_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire8_t4_suvey5.factor = factor(parent_data$p_inspire8_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire9_t4_suvey5.factor = factor(parent_data$p_inspire9_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire10_t4_suvey5.factor = factor(parent_data$p_inspire10_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire11_t4_suvey5.factor = factor(parent_data$p_inspire11_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire12_t4_suvey5.factor = factor(parent_data$p_inspire12_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire13_t4_suvey5.factor = factor(parent_data$p_inspire13_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire14_t4_suvey5.factor = factor(parent_data$p_inspire14_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire15_t4_suvey5.factor = factor(parent_data$p_inspire15_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire16_t4_suvey5.factor = factor(parent_data$p_inspire16_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire17_t4_suvey5.factor = factor(parent_data$p_inspire17_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire18_t4_suvey5.factor = factor(parent_data$p_inspire18_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire19_t4_suvey5.factor = factor(parent_data$p_inspire19_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire20_t4_suvey5.factor = factor(parent_data$p_inspire20_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$p_inspire21_t4_suvey5.factor = factor(parent_data$p_inspire21_t4_suvey5,levels=c("0","1","2","3","4","5"))
parent_data$survey_5_complete.factor = factor(parent_data$survey_5_complete,levels=c("0","1","2"))
parent_data$dtbpar_freq1.factor = factor(parent_data$dtbpar_freq1,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq2.factor = factor(parent_data$dtbpar_freq2,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq3.factor = factor(parent_data$dtbpar_freq3,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq4.factor = factor(parent_data$dtbpar_freq4,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq5.factor = factor(parent_data$dtbpar_freq5,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq6.factor = factor(parent_data$dtbpar_freq6,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq7.factor = factor(parent_data$dtbpar_freq7,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq8.factor = factor(parent_data$dtbpar_freq8,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq9.factor = factor(parent_data$dtbpar_freq9,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq10.factor = factor(parent_data$dtbpar_freq10,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq11.factor = factor(parent_data$dtbpar_freq11,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq12.factor = factor(parent_data$dtbpar_freq12,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq13.factor = factor(parent_data$dtbpar_freq13,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq14.factor = factor(parent_data$dtbpar_freq14,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq15.factor = factor(parent_data$dtbpar_freq15,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq16.factor = factor(parent_data$dtbpar_freq16,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq17.factor = factor(parent_data$dtbpar_freq17,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq18.factor = factor(parent_data$dtbpar_freq18,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_freq19.factor = factor(parent_data$dtbpar_freq19,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length1.factor = factor(parent_data$dtbpar_length1,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length2.factor = factor(parent_data$dtbpar_length2,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length3.factor = factor(parent_data$dtbpar_length3,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length4.factor = factor(parent_data$dtbpar_length4,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length5.factor = factor(parent_data$dtbpar_length5,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length6.factor = factor(parent_data$dtbpar_length6,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length7.factor = factor(parent_data$dtbpar_length7,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length8.factor = factor(parent_data$dtbpar_length8,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length9.factor = factor(parent_data$dtbpar_length9,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length10.factor = factor(parent_data$dtbpar_length10,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length11.factor = factor(parent_data$dtbpar_length11,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length12.factor = factor(parent_data$dtbpar_length12,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length13.factor = factor(parent_data$dtbpar_length13,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length14.factor = factor(parent_data$dtbpar_length14,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length15.factor = factor(parent_data$dtbpar_length15,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length16.factor = factor(parent_data$dtbpar_length16,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length17.factor = factor(parent_data$dtbpar_length17,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length18.factor = factor(parent_data$dtbpar_length18,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_length19.factor = factor(parent_data$dtbpar_length19,levels=c("0","1","2","3","4","5","6","7"))
parent_data$dtbpar_upset1.factor = factor(parent_data$dtbpar_upset1,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset2.factor = factor(parent_data$dtbpar_upset2,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset3.factor = factor(parent_data$dtbpar_upset3,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset4.factor = factor(parent_data$dtbpar_upset4,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset5.factor = factor(parent_data$dtbpar_upset5,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset6.factor = factor(parent_data$dtbpar_upset6,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset7.factor = factor(parent_data$dtbpar_upset7,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset8.factor = factor(parent_data$dtbpar_upset8,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset9.factor = factor(parent_data$dtbpar_upset9,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset10.factor = factor(parent_data$dtbpar_upset10,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset11.factor = factor(parent_data$dtbpar_upset11,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset12.factor = factor(parent_data$dtbpar_upset12,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset13.factor = factor(parent_data$dtbpar_upset13,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset14.factor = factor(parent_data$dtbpar_upset14,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset15.factor = factor(parent_data$dtbpar_upset15,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset16.factor = factor(parent_data$dtbpar_upset16,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset17.factor = factor(parent_data$dtbpar_upset17,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset18.factor = factor(parent_data$dtbpar_upset18,levels=c("0","1","2","3","4","5","6"))
parent_data$dtbpar_upset19.factor = factor(parent_data$dtbpar_upset19,levels=c("0","1","2","3","4","5","6"))
parent_data$diabetes_treatmentrelated_burden_parent_complete.factor = factor(parent_data$diabetes_treatmentrelated_burden_parent_complete,levels=c("0","1","2"))

levels(parent_data$redcap_event_name.factor)=c("Baseline","12 month")
levels(parent_data$p_timepoint.factor)=c("Baseline","Month 1/ Training f/u","3 Months","6 Months","9 Months","12 Months")
levels(parent_data$survey_header_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$p_baseline1.factor)=c("< $25,000 per year","$25,000 to less than $35,000 per year","$35,000 to less than $50,000 per year","$50,000 to less than $75,000 per year","$75,000 to less than $100,000 per year","$100,000 or more per year","Decline to answer")
levels(parent_data$p_baseline2.factor)=c("Not Known/ Decline to answer","< 7th grade","Junior High School","Partial High School (10th or 11th grade)","High School Graduate/GED","Partial College","Associates Degree","Bachelors Degree","Masters Degree","Doctorate Degree")
levels(parent_data$p_baseline3.factor)=c("Not Known/ Decline to answer","< 7th grade","Junior High School","Partial High School (10th or 11th grade)","High School Graduate/GED","Partial College","Associates Degree","Bachelors Degree","Masters Degree","Doctorate Degree")
levels(parent_data$p_baseline4.factor)=c("Yes","No")
levels(parent_data$p_baseline6.factor)=c("Animas (One Touch Ping or Vibe)","Medtronic (530G, 630G)","Tandem (t:slim x2)","Omnipod (Omnipod system or Omnipod dash system)","Other")
levels(parent_data$p_baseline7.factor)=c("Yes","No")
levels(parent_data$p_baseline9.factor)=c("Medtronic (Guardian 3 or Enlite)","Dexcom (Dexcom G4, G5 or G6)","Freestyle Libre","Other")
levels(parent_data$baseline_survey_9db28d_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$p_b_inspire1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire6.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire7.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire8.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire9.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire10.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire11.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire12.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire13.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire14.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire15.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire16.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire17.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire18.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire19.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire20.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_b_inspire21.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$inspire_baseline_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$p_hfs_b_behave1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_behave2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_behave3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_behave4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_behave5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_behave6.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_behave7.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_behave8.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_behave9.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_behave10.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_behave11.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry12.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry13.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry14.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry15.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry16.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry17.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry18.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry19.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry20.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry21.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry22.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry23.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry24.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry25.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_worry26.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_b_hypo_severe.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hfs_b_hypo_severe_upset.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hfs_b_hypo_mod.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hfs_b_hypo_mod_upset.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hfs_b_hypo_mild.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hfs_b_hypo_mild_upset.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$baseline_hfs_cb99_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$p_paid1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid6.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid7.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid8.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid9.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid10.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid11.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid12.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid13.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid14.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid15.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid16.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid17.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid18.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$paid_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$tech1.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(parent_data$tech2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(parent_data$tech3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(parent_data$tech4.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(parent_data$tech5.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(parent_data$diabetes_technology_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$p_hfs_f_behave1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_behave2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_behave3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_behave4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_behave5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_behave6.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_behave7.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_behave8.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_behave9.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_behave10.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_behave11.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry12.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry13.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry14.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry15.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry16.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry17.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry18.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry19.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry20.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry21.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry22.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry23.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry24.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry25.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_worry26.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_f_hypo_severe.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hfs_f_hypo_severe_upset.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hfs_f_hypo_mod.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hfs_f_hypo_mod_upset.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hfs_f_hypo_mild.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hfs_f_hypo_mild_upset.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$baseline_hfs_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$p_f_inspire1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire6.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire7.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire8.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire9.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire10.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire11.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire12.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire13.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire14.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire15.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire16.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire17.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire18.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire19.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire20.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_f_inspire21.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$inspire_follow_up_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$timepoint_baselinesurvey.factor)=c("baseline","month 1","Time 1","Time 2","Time 3","Time 4")
levels(parent_data$p_hfs_behave1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave6.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave7.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave8.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave9.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave10.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave11.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry12.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry13.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry14.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry15.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry16.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry17.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry18.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry19.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry20.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry21.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry22.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry23.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry24.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry25.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry26.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hypo_severe.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_severe_yes.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hypo_mod.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mod_yes.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hypo_mild.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mild_yes.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_paid1_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid2_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid3_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid4_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid5_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid6_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid7_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid8_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid9_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid10_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid11_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid12_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid13_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid14_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid15_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid16_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid17_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid18_b.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$baseline_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$timepoint_survey1.factor)=c("Baseline","Month 1/ Training f/u","3 Months","6 Months","9 Months","12 Months")
levels(parent_data$p_hfs_behave1_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave2_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave3_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave4_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave5_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave6_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave7_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave8_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave9_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave10_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave11_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry12_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry13_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry14_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry15_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry16_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry17_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry18_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry19_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry20_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry21_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry22_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry23_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry24_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry25_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry26_t1.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hypo_severe_t1.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_severe_yes_t1.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hypo_mod_t1.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mod_yes_t1.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hypo_mild_t1.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mild_yes_t1.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_paid1_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid2_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid3_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid4_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid5_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid6_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid7_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid8_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid9_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid10_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid11_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid12_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid13_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid14_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid15_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid16_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid17_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid18_t1.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$dtb.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(parent_data$dte.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(parent_data$dth.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(parent_data$dtgb.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(parent_data$dttw.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly agree")
levels(parent_data$p_inspire1_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire2_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire3_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire4_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire5_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire6_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire7_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire8_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire9_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire10_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire11_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire12_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire13_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire14_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire15_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire16_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire17_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire18_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire19_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire20_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire21_t1.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$survey_1_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$timepoint_survey2.factor)=c("Baseline","Month 1/ Training f/u","3 Months","6 Months","9 Months","12 Months")
levels(parent_data$p_hfs_behave1_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave2_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave3_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave4_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave5_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave6_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave7_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave8_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave9_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave10_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave11_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry12_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry13_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry14_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry15_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry16_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry17_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry18_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry19_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry20_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry21_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry22_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry23_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry24_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry25_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry26_t2.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hypo_severe_t2.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_severe_yes_t2.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hypo_mod_t2.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mod_yes_t2.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hypo_mild_t2.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mild_yes_t2.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_paid1_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid2_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid3_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid4_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid5_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid6_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid7_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid8_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid9_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid10_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid11_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid12_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid13_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid14_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid15_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid16_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid17_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid18_t2.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$dtb2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dte2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dth2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dtgb2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dttw2.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$p_inspire1_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire2_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire3_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire4_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire5_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire6_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire7_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire8_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire9_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire10_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire11_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire12_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire13_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire14_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire15_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire16_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire17_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire18_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire19_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire20_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire21_t2.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$survey_2_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$timepoint_survey3.factor)=c("Baseline","Month 1/ Training f/u","3 Months","6 Months","9 Months","12 Months")
levels(parent_data$p_hfs_behave1_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave2_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave3_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave4_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave5_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave6_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave7_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave8_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave9_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave10_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave11_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry12_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry13_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry14_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry15_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry16_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry17_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry18_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry19_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry20_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry21_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry22_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry23_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry24_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry25_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry26_t3.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hypo_severe_t3.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_severe_yes_t3.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Not at all upsetting")
levels(parent_data$p_hypo_mod_t3.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mod_yes_t3.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Not at all upsetting")
levels(parent_data$p_hypo_mild_t3.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mild_yes_t3.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Not at all upsetting")
levels(parent_data$p_paid1_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid2_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid3_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid4_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid5_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid6_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid7_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid8_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid9_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid10_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid11_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid12_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid13_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid14_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid15_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid16_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid17_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid18_t3.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$dtb3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dte3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dth3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dtgb3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dttw3.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$p_inspire1_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire2_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire3_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire4_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire5_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire6_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire7_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire8_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire9_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire10_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire11_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire12_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire13_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire14_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire15_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire16_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire17_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire18_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire19_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire20_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire21_t3.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$survey_3_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$timepoint_survey4.factor)=c("Baseline","Month 1/ Training f/u","3 Months","6 Months","9 Months","12 Months")
levels(parent_data$p_hfs_behave1_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave2_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave3_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave4_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave5_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave6_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave7_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave8_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave9_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave10_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave11_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry12_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry13_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry14_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry15_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry16_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry17_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry18_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry19_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry20_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry21_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry22_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry23_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry24_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry25_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry26_t4.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hypo_severe_t4.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_severe_yes_t4.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hypo_mod_t4.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mod_yes_t4.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hypo_mild_t4.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mild_yes_t4.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_paid1_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid2_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid3_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid4_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid5_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid6_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid7_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid8_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid9_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid10_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid11_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid12_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid13_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid14_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid15_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid16_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid17_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid18_t4.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$dtb4.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dte4.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dth4.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dtgb4.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dttw4.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$p_inspire1_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire2_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire3_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire4_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire5_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire6_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire7_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire8_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire9_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire10_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire11_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire12_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire13_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire14_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire15_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire16_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire17_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire18_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire19_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire20_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire21_t4.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$survey_4_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$timepoint_survey4_suvey5.factor)=c("Baseline","Month 1/ Training f/u","3 Months","6 Months","9 Months","12 Months")
levels(parent_data$p_hfs_behave1_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave2_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave3_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave4_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave5_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave6_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave7_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave8_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave9_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave10_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_behave11_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry12_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry13_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry14_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry15_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry16_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry17_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry18_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry19_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry20_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry21_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry22_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry23_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry24_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry25_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hfs_worry26_t4_suvey5.factor)=c("Never","Rarely","Sometimes","Often","Almost Always")
levels(parent_data$p_hypo_severe_t4_suvey5.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_severe_yes_t4_suvey5.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hypo_mod_t4_suvey5.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mod_yes_t4_suvey5.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_hypo_mild_t4_suvey5.factor)=c("0","1","2","3","4","5","6","7","8","9 or more")
levels(parent_data$p_hypo_mild_yes_t4_suvey5.factor)=c("0 Not at all upsetting","1","2 Somewhat upsetting","3","4 Extremely upsetting")
levels(parent_data$p_paid1_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid2_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid3_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid4_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid5_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid6_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid7_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid8_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid9_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid10_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid11_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid12_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid13_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid14_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid15_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid16_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid17_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$p_paid18_t4_suvey5.factor)=c("Agree","Somewhat Agree","Neutral","Somewhat Disagree","Disagree")
levels(parent_data$dtb4_suvey5.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dte4_suvey5.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dth4_suvey5.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dtgb4_suvey5.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$dttw4_suvey5.factor)=c("Strongly disagree","Disagree","Neutral","Agree","Strongly Agree")
levels(parent_data$p_inspire1_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire2_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire3_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire4_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire5_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire6_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire7_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire8_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire9_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire10_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire11_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire12_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire13_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire14_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire15_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire16_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire17_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire18_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire19_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire20_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$p_inspire21_t4_suvey5.factor)=c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","N/A")
levels(parent_data$survey_5_complete.factor)=c("Incomplete","Unverified","Complete")
levels(parent_data$dtbpar_freq1.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq2.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq3.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq4.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq5.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq6.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq7.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq8.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq9.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq10.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq11.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq12.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq13.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq14.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq15.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq16.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq17.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq18.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_freq19.factor)=c("More than once per hour","About once each hour","About 10 times per day","About 5 times per day","About once per day","About once every 3 days","Once per week or less","Almost never")
levels(parent_data$dtbpar_length1.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length2.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length3.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length4.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length5.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length6.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length7.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length8.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length9.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length10.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length11.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length12.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length13.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length14.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length15.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length16.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length17.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length18.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_length19.factor)=c("Not applicable","About 10 seconds","About 30 seconds","About 1 minute","About 5 minutes","About 15 minutes","About 30 minutes","About 1 hour")
levels(parent_data$dtbpar_upset1.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset2.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset3.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset4.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset5.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset6.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset7.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset8.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset9.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset10.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset11.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset12.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset13.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset14.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset15.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset16.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset17.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset18.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$dtbpar_upset19.factor)=c("Not at all nervous, upset or frustrated","","","Somewhat nervous, upset or frustrated","","","Extremely nervous, upset or frustrated")
levels(parent_data$diabetes_treatmentrelated_burden_parent_complete.factor)=c("Incomplete","Unverified","Complete")
