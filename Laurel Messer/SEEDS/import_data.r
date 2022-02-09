#Read Data
data=read.csv('UnderstandingProvide_DATA_2022-02-09_0919.csv')
#Setting Labels
label(data$record_id)="Record ID"
label(data$redcap_survey_identifier)="Survey Identifier"
label(data$hcp_needs_survey_econsent_v2_timestamp)="Survey Timestamp"
label(data$care_type_v2)="Do you work in Adult Endocrinology, Pediatric Endocrinology, or Primary Care in the United States?"
label(data$econsent_confirm_v2)="I agree to participate in this research and to provide my electronic signature. "
label(data$first_name_v2)="First name"
label(data$last_name_v2)="Last name"
label(data$prof_email_v2)="Professional email address"
label(data$alt_email_v2)="Alternative email address for giftcard, if necessary"
label(data$signature_v2)="Please type your name to indicate you provide consent to participate in this study."
label(data$drawn_signature_v2)="Please provide your signature"
label(data$hcp_needs_survey_econsent_v2_complete)="Complete?"
label(data$diabetes_devices_survey_econsent_timestamp)="Survey Timestamp"
label(data$care_type)="Do you work in Adult Endocrinology, Pediatric Endocrinology, or Primary Care?"
label(data$econsent_confirm)="I agree to participate in this research and to provide my electronic signature. "
label(data$first_name)="First name"
label(data$last_name)="Last name"
label(data$prof_email)="Professional email address"
label(data$alt_email)="Alternative email address for giftcard, if necessary"
label(data$email)="Email address"
label(data$signature)="Please type your name to indicate you provide consent to participate in this study."
label(data$drawn_signature)="Please provide your signature"
label(data$diabetes_devices_survey_econsent_complete)="Complete?"
label(data$hcp_provider_needs_for_diabetes_devices_timestamp)="Survey Timestamp"
label(data$real_record)="Real participant"
label(data$hcpsurvey_start_time)="Time started survey"
label(data$organization)="Organization:"
label(data$practicestate)="Which state is your practice located in?"
label(data$practice_notinus)="Select only if subject is not in the United States"
label(data$practicename)="Practice name:"
label(data$age)="Your age:"
label(data$gender)="Your gender:"
label(data$race)="Your race:"
label(data$ethnicity)="Your ethnicity:"
label(data$providertype)="Type of provider:"
label(data$otherhcp)="If other provider type, please define:"
label(data$practiceyears)="Years in practice:"
label(data$specialty)="Your specialty:"
label(data$otherspecialty)="If other specialty, please describe:"
label(data$practicetype)="Type of practice:"
label(data$otherpractice)="If other practice type, please describe:"
label(data$practicesetting)="Practice setting:"
label(data$comprehesionquestion)="What is the commonly used abbreviation for diabetic ketoacidosis?"
label(data$medicare)="Medicare"
label(data$medicaid)="Medicaid"
label(data$privateins)="Private Insurance"
label(data$uninsured)="No Insurance"
label(data$staffsupport___0)="Do you have access to any of the following types of support when working with patients with diabetes? (check all that apply) (choice=Clinical pharmacist)"
label(data$staffsupport___1)="Do you have access to any of the following types of support when working with patients with diabetes? (check all that apply) (choice=Diabetes educator/certified diabetes care and education specialist)"
label(data$staffsupport___2)="Do you have access to any of the following types of support when working with patients with diabetes? (check all that apply) (choice=Care manager)"
label(data$staffsupport___3)="Do you have access to any of the following types of support when working with patients with diabetes? (check all that apply) (choice=Advanced practice professional (PA, NP, etc.))"
label(data$staffsupport___4)="Do you have access to any of the following types of support when working with patients with diabetes? (check all that apply) (choice=Behavioral health professional)"
label(data$staffsupport___5)="Do you have access to any of the following types of support when working with patients with diabetes? (check all that apply) (choice=Other personnel)"
label(data$staffsupport___6)="Do you have access to any of the following types of support when working with patients with diabetes? (check all that apply) (choice=None of the above)"
label(data$otherstaffsupport)="If other personnel selected, please specify what role(s):"
label(data$patientage___0)="What ages of insulin-requiring patients with diabetes you care for (check all that apply)? (choice=Pediatric patients with diabetes (< 18 years old))"
label(data$patientage___1)="What ages of insulin-requiring patients with diabetes you care for (check all that apply)? (choice=Adult patients with diabetes  (≥18 years old))"
label(data$diabetestype___0)="What types of insulin-requiring patients with diabetes you care you (check all that apply)? (choice=Type 1 diabetes)"
label(data$diabetestype___2)="What types of insulin-requiring patients with diabetes you care you (check all that apply)? (choice=Type 2 diabetes)"
label(data$diabetestype___3)="What types of insulin-requiring patients with diabetes you care you (check all that apply)? (choice=Other diabetes (gestational, MODY, etc.))"
label(data$patientsoninsulin)="On average, how many insulin-requiring patients with diabetes do you care for in a month?"
label(data$mdi_type_sliding)="Sliding scale dosing (e.g. if BG is X-Y, take Z units)"
label(data$mdi_type_fixed_sliding)="Fixed meal dose +/- sliding scale (e.g. For breakfast take X units with or without a sliding scale correction)"
label(data$mdi_type_est_sliding)="Meal estimation +/- sliding scale (e.g. X units for small, Y units for medium, Z units for large meal, with or without a sliding scale correction)"
label(data$mdi_type_ratios)="Carb counting and correction factor (e.g. 1 unit for X grams of carb and 1 unit for Y mg/dl >150 mg/dl)"
label(data$mdi_type_others)="Other"
label(data$cgmpatientratio)="Approximately what percent (%) of all of your insulin-requiring patients with diabetes use a continuous glucose monitor (CGM)?"
label(data$whoprescribescgm)="Do you prescribe CGMs or do the patients see a different type of specialist who prescribes CGM?"
label(data$penpatientratio)="Approximatley what percent (%) of your insulin-requiring patients with diabetes use a smart insulin pen (an insulin pen connected to an app that can be downloaded)?"
label(data$whoprescribespen)="Do you prescribe smart insulin pens or do the patients see a different type of specialist who prescribes smart insulin pens?"
label(data$pumppatientratio)="Approximately what percent (%) of your insulin-requiring patients with diabetes use an insulin pump (not as part of a hybrid closed-loop system)"
label(data$whoprescribespump)="Do you prescribe insulin pumps or do the patients see a different type of specialist who prescribes insulin pumps?"
label(data$hclpatientratio)="Approximately what percent (%) of your insulin-requiring patients with diabetes use a hybrid closed-loop (an insulin pump and CGM that use an algorithm to help automate insulin delivery)?"
label(data$whoprescribeshcl)="Do you prescribe hybrid closed-loops or do the patients see a different type of specialist who prescribes hybrid closed-loops?"
label(data$tech_persona)="Which of the following most closely describes your thoughts on diabetes technologies?"
label(data$education_timesperyear)="How many times a year do your insulin-requiring patients with diabetes receive diabetes education?"
label(data$educationtime)="On average, for your insulin-requiring patients with diabetes, how many minutes are spent on diabetes education at a clinical visit?"
label(data$educationhow___0)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=I provide education)"
label(data$educationhow___1)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=Someone on my team provides education)"
label(data$educationhow___2)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=Handouts)"
label(data$educationhow___3)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=Referral to an endocrinologist)"
label(data$educationhow___4)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=Referral to a diabetes care and education specialist (previously known as diabetes educator))"
label(data$educationhow___5)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=Links to websites)"
label(data$educationhow___6)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=Books)"
label(data$educationhow___7)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=Referral to a group diabetes education class)"
label(data$educationhow___8)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=Links to You Tube videos)"
label(data$educationhow___9)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=Other)"
label(data$educationhow___10)="How do insulin-requiring patients with diabetes in your practice receive diabetes education? Check all that apply. (choice=None)"
label(data$othereducation)="If other education selection, please describe:"
label(data$cgmcomfort)="Overall comfort with CGM"
label(data$cgmcanidacy)="Knowing who is a candidate for a CGM"
label(data$cgmqs)="Explaining and answering patient questions about CGM"
label(data$cgminscov)="Checking insurance coverage for a CGM"
label(data$cgmprescription)="Writing prescription for a CGM"
label(data$cgmtraining)="Training patient on a CGM"
label(data$cgmreview)="Reviewing and interpreting CGM data"
label(data$pencomfort)="Overall comfort with smart insulin pens"
label(data$pencandidacy)="Knowing who is a candidate for a smart insulin pen"
label(data$penqs)="Explaining and answering patient questions about smart insulin pens"
label(data$peninscov)="Checking insurance coverage for a smart insulin pen"
label(data$penprescription)="Writing prescription for a smart insulin pen"
label(data$pentraining)="Training patient on a smart insulin pen"
label(data$penreview)="Reviewing and interpreting smart insulin pen data"
label(data$pumpcomfort)="Overall comfort with insulin pumps"
label(data$pumpcandidacy)="Knowing who is a candidate for an insulin pump"
label(data$pumpqs)="Explaining and answering patient questions about an insulin pump"
label(data$pumpinscov)="Checking insurance coverage for an insulin pump"
label(data$pumpprescription)="Writing prescription for an insulin pump"
label(data$pumptraining)="Training patient on an insulin pump"
label(data$pumpreview)="Reviewing and interpreting insulin pump data"
label(data$hclcomfort)="Overall comfort with hybrid closed-loop systems"
label(data$hclcandidacy)="Knowing who is a candidate for a hybrid closed-loop"
label(data$hclqs)="Explaining and answering patient questions about hybrid closed-loops"
label(data$hclinscov)="Checking insurance coverage for a hybrid closed-loop"
label(data$hclprescription)="Writing prescription for a hybrid closed-loop"
label(data$hcltraining)="Training patient on a hybrid closed-loop"
label(data$hclreview)="Reviewing and interpreting data from a hybrid closed-loop"
label(data$deviceselectiontool)="DEVICE SELECTION TOOL: An online Tool to help you and your patient decide if a diabetes device would be a good fit for their diabetes care. It would give information about the devices, what it is like to use the device, and how it would impact their diabetes care."
label(data$deviceinscovtool)="DEVICE INSURANCE COVERAGE: An online Tool to help determine if a diabetes device is covered by a patient’s insurance. This could be accessed in the moment of the clinical care visit and assist with device selection."
label(data$insulindosingtool)="INSULIN DOSING SUPPORT: This Tool could suggest initial insulin dosing for new therapies (like an insulin pump) and ongoing insulin dosing adjustments based on downloaded glucose and insulin data."
label(data$dataplatform)="DATA PLATFORM: An online, all-in-one diabetes device platform for both patients and providers to use to access information from diabetes devices."
label(data$devicetrainingtool)="DEVICE TRAINING SUPPORT:  A Tool to help you and the patient get in contact with device trainers and training resources from industry representatives"
label(data$ptedmodules)="PATIENT EDUCATION MODULES: Modules sent to the patient from your office to help them with use of their new diabetes device. This could include best practices for using the device, how to troubleshoot common problems, and new diabetes self-management habits to consider while using the device."
label(data$pttroubleshootodules)="TROUBLESHOOTING MODULE:  For patients having problems with diabetes devices."
label(data$consulttool)="EXPERT CONSULTATION TOOL: Ability to periodically consult with an expert diabetes center for assistance with workflow and use of diabetes devices in clinical practice."
label(data$toolehrinterate)="How important is it that these Tools could be accessed directly from the electronic health record (via a single sign on connection)?"
label(data$dataehrintegrate)="How important is it that insulin dosing and glycemic information from these Tools could be autopopulated into the electronic health record either as discrete data points or a text file?"
label(data$directehrsend)="How important is it that information from the Online Diabetes Device Pathway could be sent to the patient via the electronic health record (versus other methods)?"
label(data$freetext1)="1. Do you have any other comments/insights about the Tools listed above that would help us create meaningful Tools? Please be as descriptive as possible."
label(data$freetext2)="2. In addition to the Tools described above, what other support or resources would help you utilize diabetes devices more in your clinical practice? Please be as descriptive as possible."
label(data$freetext3)="3. Imagine if you/your practice could obtain personalized support for diabetes devices from a specialty diabetes center. Please describe in as much detail as possible what that would ideally entail.Example--Would you prefer one time set-up assistance, periodic check-ins, or more intensive communication? What would be the most important topics for support (workflow, how to adjust insulin doses, device training, patient education, etc.?)."
label(data$freetext4)="4. Time management is an enormous issue for clinical care appointments. In what ways could you envision an Online Diabetes Device Pathway helping with time management during or after clinical care visits?"
label(data$paid)="Participant Paid?"
label(data$hcp_provider_needs_for_diabetes_devices_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$care_type_v2.factor = factor(data$care_type_v2,levels=c("1","2","3"))
data$econsent_confirm_v2.factor = factor(data$econsent_confirm_v2,levels=c("1","0"))
data$hcp_needs_survey_econsent_v2_complete.factor = factor(data$hcp_needs_survey_econsent_v2_complete,levels=c("0","1","2"))
data$care_type.factor = factor(data$care_type,levels=c("1","2","3"))
data$econsent_confirm.factor = factor(data$econsent_confirm,levels=c("1","0"))
data$diabetes_devices_survey_econsent_complete.factor = factor(data$diabetes_devices_survey_econsent_complete,levels=c("0","1","2"))
data$real_record.factor = factor(data$real_record,levels=c("1","2","3","4"))
data$practicestate.factor = factor(data$practicestate,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50"))
data$practice_notinus.factor = factor(data$practice_notinus,levels=c("0"))
data$gender.factor = factor(data$gender,levels=c("0","1","2"))
data$race.factor = factor(data$race,levels=c("0","1","2","3","4"))
data$ethnicity.factor = factor(data$ethnicity,levels=c("0","1"))
data$providertype.factor = factor(data$providertype,levels=c("0","1","2","3","4","5"))
data$specialty.factor = factor(data$specialty,levels=c("0","1","2","3","4","5","6"))
data$practicetype.factor = factor(data$practicetype,levels=c("0","1","2","3","4","5","6"))
data$practicesetting.factor = factor(data$practicesetting,levels=c("0","1","2"))
data$medicare.factor = factor(data$medicare,levels=c("0","1","2","3","4"))
data$medicaid.factor = factor(data$medicaid,levels=c("0","1","2","3","4"))
data$privateins.factor = factor(data$privateins,levels=c("0","1","2","3","4"))
data$uninsured.factor = factor(data$uninsured,levels=c("0","1","2","3","4"))
data$staffsupport___0.factor = factor(data$staffsupport___0,levels=c("0","1"))
data$staffsupport___1.factor = factor(data$staffsupport___1,levels=c("0","1"))
data$staffsupport___2.factor = factor(data$staffsupport___2,levels=c("0","1"))
data$staffsupport___3.factor = factor(data$staffsupport___3,levels=c("0","1"))
data$staffsupport___4.factor = factor(data$staffsupport___4,levels=c("0","1"))
data$staffsupport___5.factor = factor(data$staffsupport___5,levels=c("0","1"))
data$staffsupport___6.factor = factor(data$staffsupport___6,levels=c("0","1"))
data$patientage___0.factor = factor(data$patientage___0,levels=c("0","1"))
data$patientage___1.factor = factor(data$patientage___1,levels=c("0","1"))
data$diabetestype___0.factor = factor(data$diabetestype___0,levels=c("0","1"))
data$diabetestype___2.factor = factor(data$diabetestype___2,levels=c("0","1"))
data$diabetestype___3.factor = factor(data$diabetestype___3,levels=c("0","1"))
data$mdi_type_sliding.factor = factor(data$mdi_type_sliding,levels=c("0","1","2","3","4"))
data$mdi_type_fixed_sliding.factor = factor(data$mdi_type_fixed_sliding,levels=c("0","1","2","3","4"))
data$mdi_type_est_sliding.factor = factor(data$mdi_type_est_sliding,levels=c("0","1","2","3","4"))
data$mdi_type_ratios.factor = factor(data$mdi_type_ratios,levels=c("0","1","2","3","4"))
data$mdi_type_others.factor = factor(data$mdi_type_others,levels=c("0","1","2","3","4"))
data$whoprescribescgm.factor = factor(data$whoprescribescgm,levels=c("0","1","2"))
data$whoprescribespen.factor = factor(data$whoprescribespen,levels=c("0","1","2"))
data$whoprescribespump.factor = factor(data$whoprescribespump,levels=c("0","1","2"))
data$whoprescribeshcl.factor = factor(data$whoprescribeshcl,levels=c("0","1","2"))
data$tech_persona.factor = factor(data$tech_persona,levels=c("0","1","2"))
data$educationhow___0.factor = factor(data$educationhow___0,levels=c("0","1"))
data$educationhow___1.factor = factor(data$educationhow___1,levels=c("0","1"))
data$educationhow___2.factor = factor(data$educationhow___2,levels=c("0","1"))
data$educationhow___3.factor = factor(data$educationhow___3,levels=c("0","1"))
data$educationhow___4.factor = factor(data$educationhow___4,levels=c("0","1"))
data$educationhow___5.factor = factor(data$educationhow___5,levels=c("0","1"))
data$educationhow___6.factor = factor(data$educationhow___6,levels=c("0","1"))
data$educationhow___7.factor = factor(data$educationhow___7,levels=c("0","1"))
data$educationhow___8.factor = factor(data$educationhow___8,levels=c("0","1"))
data$educationhow___9.factor = factor(data$educationhow___9,levels=c("0","1"))
data$educationhow___10.factor = factor(data$educationhow___10,levels=c("0","1"))
data$cgmcomfort.factor = factor(data$cgmcomfort,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$cgmcanidacy.factor = factor(data$cgmcanidacy,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$cgmqs.factor = factor(data$cgmqs,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$cgminscov.factor = factor(data$cgminscov,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$cgmprescription.factor = factor(data$cgmprescription,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$cgmtraining.factor = factor(data$cgmtraining,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$cgmreview.factor = factor(data$cgmreview,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$pencomfort.factor = factor(data$pencomfort,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$pencandidacy.factor = factor(data$pencandidacy,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$penqs.factor = factor(data$penqs,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$peninscov.factor = factor(data$peninscov,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$penprescription.factor = factor(data$penprescription,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$pentraining.factor = factor(data$pentraining,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$penreview.factor = factor(data$penreview,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$pumpcomfort.factor = factor(data$pumpcomfort,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$pumpcandidacy.factor = factor(data$pumpcandidacy,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$pumpqs.factor = factor(data$pumpqs,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$pumpinscov.factor = factor(data$pumpinscov,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$pumpprescription.factor = factor(data$pumpprescription,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$pumptraining.factor = factor(data$pumptraining,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$pumpreview.factor = factor(data$pumpreview,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$hclcomfort.factor = factor(data$hclcomfort,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$hclcandidacy.factor = factor(data$hclcandidacy,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$hclqs.factor = factor(data$hclqs,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$hclinscov.factor = factor(data$hclinscov,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$hclprescription.factor = factor(data$hclprescription,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$hcltraining.factor = factor(data$hcltraining,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$hclreview.factor = factor(data$hclreview,levels=c("1","2","3","4","5","6","7","8","9","10"))
data$paid.factor = factor(data$paid,levels=c("1","0"))
data$hcp_provider_needs_for_diabetes_devices_complete.factor = factor(data$hcp_provider_needs_for_diabetes_devices_complete,levels=c("0","1","2"))

levels(data$care_type_v2.factor)=c("Adult Endocrinology","Peds Endocrinology","Primary Care")
levels(data$econsent_confirm_v2.factor)=c("Yes","No")
levels(data$hcp_needs_survey_econsent_v2_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$care_type.factor)=c("Adult Endocrinology","Peds Endocrinology","Primary Care")
levels(data$econsent_confirm.factor)=c("Yes","No")
levels(data$diabetes_devices_survey_econsent_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$real_record.factor)=c("Real","Questionable","Fake","Not in the United States")
levels(data$practicestate.factor)=c("Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming")
levels(data$practice_notinus.factor)=c("not in US")
levels(data$gender.factor)=c("Male","Female","Other")
levels(data$race.factor)=c("White","Asian/Pacific Islander","Black","Native American","Other")
levels(data$ethnicity.factor)=c("Non-Hispanic or Latino","Hispanic or Latino")
levels(data$providertype.factor)=c("Physician (MD, DO or equivalent)","Advance practice professional (Physician assistant, nurse practitioner)","Diabetes care and education specialist (diabetes educator, nurse, dietitian, other)","Endocrinology fellow","Medical resident","Other")
levels(data$specialty.factor)=c("Primary care-family medicine","Primary care-internal medicine","Primary care-pediatrics","Primary care-med/peds","Pediatric Endocrinology","Adult endocrinology","Other")
levels(data$practicetype.factor)=c("Academic Medical Center/faculty practice","Hospital or Health system owned","Health maintenance organization (e.g. Kaiser Permanente)","Clinician-owned solo or group practice","Federally Qualified Health Canter","Veterans administration","Other")
levels(data$practicesetting.factor)=c("Urban","Suburban","Rural")
levels(data$medicare.factor)=c("0%","1-25%","26-50%","51-75%","76-100%")
levels(data$medicaid.factor)=c("0%","1-25%","26-50%","51-75%","76-100%")
levels(data$privateins.factor)=c("0%","1-25%","26-50%","51-75%","76-100%")
levels(data$uninsured.factor)=c("0%","1-25%","26-50%","51-75%","76-100%")
levels(data$staffsupport___0.factor)=c("Unchecked","Checked")
levels(data$staffsupport___1.factor)=c("Unchecked","Checked")
levels(data$staffsupport___2.factor)=c("Unchecked","Checked")
levels(data$staffsupport___3.factor)=c("Unchecked","Checked")
levels(data$staffsupport___4.factor)=c("Unchecked","Checked")
levels(data$staffsupport___5.factor)=c("Unchecked","Checked")
levels(data$staffsupport___6.factor)=c("Unchecked","Checked")
levels(data$patientage___0.factor)=c("Unchecked","Checked")
levels(data$patientage___1.factor)=c("Unchecked","Checked")
levels(data$diabetestype___0.factor)=c("Unchecked","Checked")
levels(data$diabetestype___2.factor)=c("Unchecked","Checked")
levels(data$diabetestype___3.factor)=c("Unchecked","Checked")
levels(data$mdi_type_sliding.factor)=c("0%","1-25%","26-50%","51-75%","76-100%")
levels(data$mdi_type_fixed_sliding.factor)=c("0%","1-25%","26-50%","51-75%","76-100%")
levels(data$mdi_type_est_sliding.factor)=c("0%","1-25%","26-50%","51-75%","76-100%")
levels(data$mdi_type_ratios.factor)=c("0%","1-25%","26-50%","51-75%","76-100%")
levels(data$mdi_type_others.factor)=c("0%","1-25%","26-50%","51-75%","76-100%")
levels(data$whoprescribescgm.factor)=c("I/my team prescribes their CGM","Another specialist prescribes their CGM","A mix of both")
levels(data$whoprescribespen.factor)=c("I/my team prescribes their smart insulin pen","Another specialist prescribes their smart insulin pen","A mix of both")
levels(data$whoprescribespump.factor)=c("I/my team prescribes their insulin pump","Another specialist prescribes their insulin pump","A mix of both")
levels(data$whoprescribeshcl.factor)=c("I/my team prescribes their hybrid closed-loop","Another specialist prescribes their hybrid closed-loop","A mix of both")
levels(data$tech_persona.factor)=c("Positive attitudes toward diabetes technologies, perceive low patient barriers to diabetes devices","Positive attitudes toward diabetes technologies, perceive high patient barriers to diabetes devices","More cautious attitude toward diabetes technologies, having little time to review data in clinic, difficulty keeping up with advances and concern about potential patient barriers")
levels(data$educationhow___0.factor)=c("Unchecked","Checked")
levels(data$educationhow___1.factor)=c("Unchecked","Checked")
levels(data$educationhow___2.factor)=c("Unchecked","Checked")
levels(data$educationhow___3.factor)=c("Unchecked","Checked")
levels(data$educationhow___4.factor)=c("Unchecked","Checked")
levels(data$educationhow___5.factor)=c("Unchecked","Checked")
levels(data$educationhow___6.factor)=c("Unchecked","Checked")
levels(data$educationhow___7.factor)=c("Unchecked","Checked")
levels(data$educationhow___8.factor)=c("Unchecked","Checked")
levels(data$educationhow___9.factor)=c("Unchecked","Checked")
levels(data$educationhow___10.factor)=c("Unchecked","Checked")
levels(data$cgmcomfort.factor)=c("Not at all","","","","","","","","","Very")
levels(data$cgmcanidacy.factor)=c("Not at all","","","","","","","","","Very")
levels(data$cgmqs.factor)=c("Not at all","","","","","","","","","Very")
levels(data$cgminscov.factor)=c("Not at all","","","","","","","","","Very")
levels(data$cgmprescription.factor)=c("Not at all","","","","","","","","","Very")
levels(data$cgmtraining.factor)=c("Not at all","","","","","","","","","Very")
levels(data$cgmreview.factor)=c("Not at all","","","","","","","","","Very")
levels(data$pencomfort.factor)=c("Not at all","","","","","","","","","Very")
levels(data$pencandidacy.factor)=c("Not at all","","","","","","","","","Very")
levels(data$penqs.factor)=c("Not at all","","","","","","","","","Very")
levels(data$peninscov.factor)=c("Not at all","","","","","","","","","Very")
levels(data$penprescription.factor)=c("Not at all","","","","","","","","","Very")
levels(data$pentraining.factor)=c("Not at all","","","","","","","","","Very")
levels(data$penreview.factor)=c("Not at all","","","","","","","","","Very")
levels(data$pumpcomfort.factor)=c("Not at all","","","","","","","","","Very")
levels(data$pumpcandidacy.factor)=c("Not at all","","","","","","","","","Very")
levels(data$pumpqs.factor)=c("Not at all","","","","","","","","","Very")
levels(data$pumpinscov.factor)=c("Not at all","","","","","","","","","Very")
levels(data$pumpprescription.factor)=c("Not at all","","","","","","","","","Very")
levels(data$pumptraining.factor)=c("Not at all","","","","","","","","","Very")
levels(data$pumpreview.factor)=c("Not at all","","","","","","","","","Very")
levels(data$hclcomfort.factor)=c("Not at all",",","","","","","","","","Very")
levels(data$hclcandidacy.factor)=c("Not at all",",","","","","","","","","Very")
levels(data$hclqs.factor)=c("Not at all",",","","","","","","","","Very")
levels(data$hclinscov.factor)=c("Not at all",",","","","","","","","","Very")
levels(data$hclprescription.factor)=c("Not at all",",","","","","","","","","Very")
levels(data$hcltraining.factor)=c("Not at all",",","","","","","","","","Very")
levels(data$hclreview.factor)=c("Not at all",",","","","","","","","","Very")
levels(data$paid.factor)=c("Yes","No")
levels(data$hcp_provider_needs_for_diabetes_devices_complete.factor)=c("Incomplete","Unverified","Complete")
