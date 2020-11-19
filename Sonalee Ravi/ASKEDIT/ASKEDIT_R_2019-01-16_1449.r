graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('S:/Shared Projects/Laura/BDC/Projects/Sonalee Ravi/ASKED-IT/Data/ASKEDIT_DATA_2019-01-16_1449.csv')

#Setting Labels

label(data$pid)="Participant ID"
label(data$redcap_event_name)="Event Name"
label(data$redcap_survey_identifier)="Survey Identifier"
#label(data$demographics_timestamp)="Survey Timestamp"
label(data$smoda_timestamp)="Survey Timestamp"
label(data$smoda1)="1. I consult my parents when Im not sure what to do to manage my diabetes."
label(data$smoda2)="2. I adjust my insulin dose by myself."
label(data$smoda3)="3. I handle my high blood sugars myself."
label(data$smoda4)="4. My parents talk to me about what to eat or not to eat."
label(data$smoda5)="5. My parents help me decide my insulin dose."
label(data$smoda6)="6. My parents count carbohydrates with me."
label(data$smoda7)="7. I ask my parents what to do when my blood sugar is out of range."
label(data$smoda8)="8. My parents and I look together at the record of my blood sugar readings to make adjustments."
label(data$smoda9)="9. My parents check to see if Ive taken my insulin."
label(data$smoda10)="10. My parents check my meter to see if Ive tested my blood sugar."
label(data$smoda11)="11. I ask my parents how many carbohydrates are in some foods."
label(data$smoda12)="12. My parents tell me how much insulin to take."
label(data$smoda13)="13. I tell my parents when my blood sugar is out of range."
label(data$smoda14)="14. I follow my meal plan or count carbohydrates."
label(data$smoda15)="15. I check my blood sugar before eating."
label(data$smoda16)="16. I eat without first checking my blood sugar."
label(data$smoda17)="17. If my blood sugar is high, I check it again in 1 to 2 hours."
label(data$smoda18)="18. I carry glucose tabs or some quick-acting sugars."
label(data$smoda19)="19. I test for ketones if my blood sugar is high."
label(data$smoda20)="20. If my blood sugar is too low, I treat and then check later if I still feel low."
label(data$smoda21)="21. I need to be reminded to take my insulin."
label(data$smoda22)="22. I skip insulin injections or boluses."
label(data$smoda23)="23. My parents and I argue about when I should test my blood sugar."
label(data$smoda24)="24. I carry something with me that says I have diabetes."
label(data$smoda25)="25. I go out without my diabetes supplies."
label(data$smoda26)="26. I dont like it when someone reminds me to check my blood sugar."
label(data$smoda27)="27. I check my blood sugar without being reminded."
label(data$smoda28)="28. I keep my own record of blood sugar numbers."
label(data$smoda29)="29. When I exercise I change how I eat or how much insulin I take."
label(data$smoda30)="30. I decide how much insulin to take."
label(data$smoda31)="31. I adjust my dose of insulin based on my blood sugar numbers."
label(data$smoda32)="32. If my blood sugar is high, and its not mealtime, I give myself insulin."
label(data$smoda33)="33. I remember what my HbA1c (A1c) number is from my last clinic visit."
label(data$smoda34)="34. I know what my HbA1c (A1c) number should be."
label(data$smoda35)="35. To figure my insulin dose, I consider my blood sugar and what I will eat."
label(data$smoda36)="36. When my diabetes bothers me, I talk to my nurse or doctor about it."
label(data$smoda37)="37. I try to change my diabetes routine if my nurse or doctor asks me to."
label(data$smoda38)="38. If my parents have a problem with how I manage my diabetes, we talk about it."
label(data$smoda39)="39. Before clinic visits I think about what I want to say to my nurse or doctor."
label(data$smoda40)="40. I stay informed about whats new in diabetes."
label(data$smoda41)="41. I review my blood sugar records with my nurse or doctor."
label(data$smoda42)="42. During clinic visits, I spend some time alone with my nurse or doctor."
label(data$smoda43)="43. I tell my friends that I have diabetes."
label(data$smoda44)="44. If something is bothering me about the way things are going with my diabetes, I talk to my parents about it."
label(data$smoda45)="45. I contact my nurse or doctor when I cant get my blood sugars back into range."
label(data$goals1)="1. One of my goals is to take care of my diabetes more on my own."
label(data$goals2)="2. I take care of my diabetes to try to not have problems in the future."
label(data$goals3)="3. I take care of my diabetes to feel good."
label(data$goals4)="4. I take care of my diabetes so Im able to do things with my friends."
label(data$goals5)="5. One of my goals is to be able to stay away from home overnight."
label(data$goals6)="6. One of my goals is to be in charge of taking care of my diabetes."
label(data$goals7)="7. I want to understand why sometimes my blood sugar numbers are too high or too low."
label(data$reversesmod2)="Reverse Score Question 2"
label(data$reversesmod3)="Reverse Score Question 3"
label(data$collaboration_score)="Collaboration with Parents Subscale"
label(data$reversesmod16)="Reverse Score Question 16"
label(data$reversesmod21)="Reverse Score Question 21"
label(data$reversesmod22)="Reverse Score Question 22"
label(data$reversesmod23)="Reverse Score Question 23"
label(data$reversesmod25)="Reverse Score Question 25"
label(data$reversesmod26)="Reverse Score Question 26"
label(data$care_subscale)="Care Subscale"
label(data$problem_solve_score)="Problem Solving Subscale"
label(data$communication_score)="Communication Subscale"
label(data$goal_score)="Goals Subscale"
label(data$smod_score)="Total Score"
label(data$smoda_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("enrollment_arm_1","3_months_arm_1","6_months_arm_1","enrollment_arm_2","3_months_arm_2","6_months_arm_2"))
data$smoda1.factor = factor(data$smoda1,levels=c("0","1","2","3"))
data$smoda2.factor = factor(data$smoda2,levels=c("0","1","2","3"))
data$smoda3.factor = factor(data$smoda3,levels=c("0","1","2","3"))
data$smoda4.factor = factor(data$smoda4,levels=c("0","1","2","3"))
data$smoda5.factor = factor(data$smoda5,levels=c("0","1","2","3"))
data$smoda6.factor = factor(data$smoda6,levels=c("0","1","2","3"))
data$smoda7.factor = factor(data$smoda7,levels=c("0","1","2","3"))
data$smoda8.factor = factor(data$smoda8,levels=c("0","1","2","3"))
data$smoda9.factor = factor(data$smoda9,levels=c("0","1","2","3"))
data$smoda10.factor = factor(data$smoda10,levels=c("0","1","2","3"))
data$smoda11.factor = factor(data$smoda11,levels=c("0","1","2","3"))
data$smoda12.factor = factor(data$smoda12,levels=c("0","1","2","3"))
data$smoda13.factor = factor(data$smoda13,levels=c("0","1","2","3"))
data$smoda14.factor = factor(data$smoda14,levels=c("0","1","2","3"))
data$smoda15.factor = factor(data$smoda15,levels=c("0","1","2","3"))
data$smoda16.factor = factor(data$smoda16,levels=c("0","1","2","3"))
data$smoda17.factor = factor(data$smoda17,levels=c("0","1","2","3"))
data$smoda18.factor = factor(data$smoda18,levels=c("0","1","2","3"))
data$smoda19.factor = factor(data$smoda19,levels=c("0","1","2","3"))
data$smoda20.factor = factor(data$smoda20,levels=c("0","1","2","3"))
data$smoda21.factor = factor(data$smoda21,levels=c("0","1","2","3"))
data$smoda22.factor = factor(data$smoda22,levels=c("0","1","2","3"))
data$smoda23.factor = factor(data$smoda23,levels=c("0","1","2","3"))
data$smoda24.factor = factor(data$smoda24,levels=c("0","1","2","3"))
data$smoda25.factor = factor(data$smoda25,levels=c("0","1","2","3"))
data$smoda26.factor = factor(data$smoda26,levels=c("0","1","2","3"))
data$smoda27.factor = factor(data$smoda27,levels=c("0","1","2","3"))
data$smoda28.factor = factor(data$smoda28,levels=c("0","1","2","3"))
data$smoda29.factor = factor(data$smoda29,levels=c("0","1","2","3"))
data$smoda30.factor = factor(data$smoda30,levels=c("0","1","2","3"))
data$smoda31.factor = factor(data$smoda31,levels=c("0","1","2","3"))
data$smoda32.factor = factor(data$smoda32,levels=c("0","1","2","3"))
data$smoda33.factor = factor(data$smoda33,levels=c("0","1","2","3"))
data$smoda34.factor = factor(data$smoda34,levels=c("0","1","2","3"))
data$smoda35.factor = factor(data$smoda35,levels=c("0","1","2","3"))
data$smoda36.factor = factor(data$smoda36,levels=c("0","1","2","3"))
data$smoda37.factor = factor(data$smoda37,levels=c("0","1","2","3"))
data$smoda38.factor = factor(data$smoda38,levels=c("0","1","2","3"))
data$smoda39.factor = factor(data$smoda39,levels=c("0","1","2","3"))
data$smoda40.factor = factor(data$smoda40,levels=c("0","1","2","3"))
data$smoda41.factor = factor(data$smoda41,levels=c("0","1","2","3"))
data$smoda42.factor = factor(data$smoda42,levels=c("0","1","2","3"))
data$smoda43.factor = factor(data$smoda43,levels=c("0","1","2","3"))
data$smoda44.factor = factor(data$smoda44,levels=c("0","1","2","3"))
data$smoda45.factor = factor(data$smoda45,levels=c("0","1","2","3"))
data$goals1.factor = factor(data$goals1,levels=c("0","1","2","3"))
data$goals2.factor = factor(data$goals2,levels=c("0","1","2","3"))
data$goals3.factor = factor(data$goals3,levels=c("0","1","2","3"))
data$goals4.factor = factor(data$goals4,levels=c("0","1","2","3"))
data$goals5.factor = factor(data$goals5,levels=c("0","1","2","3"))
data$goals6.factor = factor(data$goals6,levels=c("0","1","2","3"))
data$goals7.factor = factor(data$goals7,levels=c("0","1","2","3"))
data$smoda_complete.factor = factor(data$smoda_complete,levels=c("0","1","2"))

levels(data$redcap_event_name.factor)=c("Enrollment (Arm 1: Control)","3 Months (Arm 1: Control)","6 Months (Arm 1: Control)","Enrollment (Arm 2: Texting)","3 Months (Arm 2: Texting)","6 Months (Arm 2: Texting)")
levels(data$smoda1.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda2.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda3.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda4.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda5.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda6.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda7.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda8.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda9.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda10.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda11.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda12.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda13.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda14.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda15.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda16.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda17.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda18.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda19.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda20.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda21.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda22.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda23.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda24.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda25.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda26.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda27.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda28.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda29.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda30.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda31.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda32.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda33.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda34.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda35.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda36.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda37.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda38.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda39.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda40.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda41.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda42.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda43.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda44.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$smoda45.factor)=c("Never","Sometimes","Most of the time","Always")
levels(data$goals1.factor)=c("Never a goal for me","Sometimes a goal for me","Definitely a goal for me","Ive met this goal")
levels(data$goals2.factor)=c("Never a goal for me","Sometimes a goal for me","Definitely a goal for me","Ive met this goal")
levels(data$goals3.factor)=c("Never a goal for me","Sometimes a goal for me","Definitely a goal for me","Ive met this goal")
levels(data$goals4.factor)=c("Never a goal for me","Sometimes a goal for me","Definitely a goal for me","Ive met this goal")
levels(data$goals5.factor)=c("Never a goal for me","Sometimes a goal for me","Definitely a goal for me","Ive met this goal")
levels(data$goals6.factor)=c("Never a goal for me","Sometimes a goal for me","Definitely a goal for me","Ive met this goal")
levels(data$goals7.factor)=c("Never a goal for me","Sometimes a goal for me","Definitely a goal for me","Ive met this goal")
levels(data$smoda_complete.factor)=c("Incomplete","Unverified","Complete")
