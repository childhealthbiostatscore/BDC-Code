/**********************************************************************
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      06AUG19
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
***********************************************************************/
   data WORK.dat    ;
   %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
   infile '\\Mac\Home\Desktop\dissertation.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
      informat ID best32. ;
      informat days_worn best32. ;
      informat StudyVisit $3. ;
      informat VisitDate yymmdd10. ;
      informat Days_since_last_visit best32. ;
      informat Physician $6. ;
      informat Treatment $3. ;
      informat HbA1c best32. ;
      informat Cold best32. ;
      informat Flu best32. ;
      informat FOH_C_Maint best32. ;
      informat FOH_C_Soc best32. ;
      informat FOH_C_Help best32. ;
      informat CDI_total best32. ;
      informat BDI_total $1. ;
      informat zDEPRESSION best32. ;
      informat total_piu70 best32. ;
      informat total_piu_70149 best32. ;
      informat total_piu_150249 best32. ;
      informat total_piu_250 best32. ;
      informat total_bwp70 best32. ;
      informat total_bwp_70180 best32. ;
      informat total_bwp_181250 best32. ;
      informat total_bwp_251400 best32. ;
      informat total_bwp_400 best32. ;
      informat total_readings best32. ;
      informat readings_per_day best32. ;
      informat readings_per_weekday best32. ;
      informat readings_per_weekend best32. ;
      informat perc_days_4_bgs best32. ;
      informat total_carb_inputs best32. ;
      informat carb_inputs_per_day best32. ;
      informat carb_inputs_per_weekday best32. ;
      informat carb_inputs_per_weekend best32. ;
      informat perc_days_3_carbs best32. ;
      informat total_bolus best32. ;
      informat boluses_per_day best32. ;
      informat boluses_per_weekday best32. ;
      informat boluses_per_weekend best32. ;
      informat perc_days_3_boluses best32. ;
      informat bolus_within_15_piu70 best32. ;
      informat bolus_within_15_piu_70149 best32. ;
      informat bolus_within_15_piu_150249 best32. ;
      informat bolus_within_15_piu_250 best32. ;
      informat bolus_within_15_bwp70 best32. ;
      informat bolus_within_15_bwp_70180 best32. ;
      informat bolus_within_15_bwp_181250 best32. ;
      informat bolus_within_15_bwp_251400 best32. ;
      informat bolus_within_15_bwp_400 best32. ;
      informat bolus_within_30_piu70 best32. ;
      informat bolus_within_30_piu_70149 best32. ;
      informat bolus_within_30_piu_150249 best32. ;
      informat bolus_within_30_piu_250 best32. ;
      informat bolus_within_30_bwp70 best32. ;
      informat bolus_within_30_bwp_70180 best32. ;
      informat bolus_within_30_bwp_181250 best32. ;
      informat bolus_within_30_bwp_251400 best32. ;
      informat bolus_within_30_bwp_400 best32. ;
      informat days_reading6_hours best32. ;
      informat days_bolus6_hours best32. ;
      informat perc_bolus_equal_bwz best32. ;
      informat perc_bolus_higher_bwz best32. ;
      informat perc_bolus_lower_bwz best32. ;
      informat perc_lowBG_followed_by_carb_bol best32. ;
      informat perc_lowBG_followed_by_bolus best32. ;
      informat perc_intargetBG_followed_by_car best32. ;
      informat perc_intargetBG_followed_by_bol best32. ;
      informat perc_highBG_followed_by_carb_bo best32. ;
      informat perc_highBG_followed_by_bolus best32. ;
      informat perc_veryhighBG_followed_by_car best32. ;
      informat perc_veryhighBG_followed_by_bol best32. ;
      informat perc_extremeBG_followed_by_carb best32. ;
      informat perc_extremeBG_followed_by_bolu best32. ;
      informat lowBG_without_carb_with_bolus best32. ;
      informat lowBG_with_carb_and_bolus best32. ;
      informat intargetBG_without_carb_with_bo best32. ;
      informat intargetBG_with_carb_and_bolus best32. ;
      informat highBG_without_carb_with_bolus best32. ;
      informat highBG_with_carb_and_bolus best32. ;
      informat veryhighBG_without_carb_with_bo best32. ;
      informat veryhighBG_with_carb_and_bolus best32. ;
      informat extremeBG_without_carb_with_bol best32. ;
      informat extremeBG_with_carb_and_bolus best32. ;
      informat VAR84 best32. ;
      informat perc_lowBG_followed_by_bolus_pi best32. ;
      informat VAR86 best32. ;
      informat VAR87 best32. ;
      informat VAR88 best32. ;
      informat perc_highBG_followed_by_bolus_p best32. ;
      informat VAR90 best32. ;
      informat VAR91 best32. ;
      informat lowBG_without_carb_with_bolus_p best32. ;
      informat lowBG_with_carb_and_bolus_piu best32. ;
      informat VAR94 best32. ;
      informat intargetBG_with_carb_and_bolus_ best32. ;
      informat highBG_without_carb_with_bolus_ best32. ;
      informat highBG_with_carb_and_bolus_piu best32. ;
      informat VAR98 best32. ;
      informat extremeBG_with_carb_and_bolus_p best32. ;
      informat num_rebound_bgs best32. ;
      informat perc70 best32. ;
      informat perc70149 best32. ;
      informat perc150249 best32. ;
      informat perc250 best32. ;
      informat DateofBirth yymmdd10. ;
      informat Sex best32. ;
      informat Race best32. ;
      informat Ethnicity best32. ;
      informat Insurance best32. ;
      informat DiagnosisDate yymmdd10. ;
      informat IncomeLevel $3. ;
      informat interview_educ_years best32. ;
      informat interview_educ_degrees best32. ;
      informat PumpStartDate yymmdd10. ;
      informat pump_dur_days best32. ;
      informat pump_dur_yrs best32. ;
      informat age_days best32. ;
      informat age_years best32. ;
      informat filter best32. ;
      informat T1D_dur_days best32. ;
      informat T1D_dur_years best32. ;
      informat piu_perc_bolus_after_less70 best32. ;
      informat piu_perc_bolus_after70149 best32. ;
      informat piu_perc_bolus_after150249 best32. ;
      informat piu_perc_bolus_after250 best32. ;
      informat Colorado best32. ;
      informat filter__ best32. ;
      informat Site $9. ;
      informat Days_since_baseline best32. ;
      informat readings_per_day_b best32. ;
      informat VAR131 best32. ;
      informat carb_inputs_per_day_b best32. ;
      informat boluses_per_day_b best32. ;
      informat VAR134 best32. ;
      informat readings_per_day_change best32. ;
      informat highBG_change best32. ;
      informat carb_inputs_per_day_change best32. ;
      format ID best12. ;
      format days_worn best12. ;
      format StudyVisit $3. ;
      format VisitDate yymmdd10. ;
      format Days_since_last_visit best12. ;
      format Physician $6. ;
      format Treatment $3. ;
      format HbA1c best12. ;
      format Cold best12. ;
      format Flu best12. ;
      format FOH_C_Maint best12. ;
      format FOH_C_Soc best12. ;
      format FOH_C_Help best12. ;
      format CDI_total best12. ;
      format BDI_total $1. ;
      format zDEPRESSION best12. ;
      format total_piu70 best12. ;
      format total_piu_70149 best12. ;
      format total_piu_150249 best12. ;
      format total_piu_250 best12. ;
      format total_bwp70 best12. ;
      format total_bwp_70180 best12. ;
      format total_bwp_181250 best12. ;
      format total_bwp_251400 best12. ;
      format total_bwp_400 best12. ;
      format total_readings best12. ;
      format readings_per_day best12. ;
      format readings_per_weekday best12. ;
      format readings_per_weekend best12. ;
      format perc_days_4_bgs best12. ;
      format total_carb_inputs best12. ;
      format carb_inputs_per_day best12. ;
      format carb_inputs_per_weekday best12. ;
      format carb_inputs_per_weekend best12. ;
      format perc_days_3_carbs best12. ;
      format total_bolus best12. ;
      format boluses_per_day best12. ;
      format boluses_per_weekday best12. ;
      format boluses_per_weekend best12. ;
      format perc_days_3_boluses best12. ;
      format bolus_within_15_piu70 best12. ;
      format bolus_within_15_piu_70149 best12. ;
      format bolus_within_15_piu_150249 best12. ;
      format bolus_within_15_piu_250 best12. ;
      format bolus_within_15_bwp70 best12. ;
      format bolus_within_15_bwp_70180 best12. ;
      format bolus_within_15_bwp_181250 best12. ;
      format bolus_within_15_bwp_251400 best12. ;
      format bolus_within_15_bwp_400 best12. ;
      format bolus_within_30_piu70 best12. ;
      format bolus_within_30_piu_70149 best12. ;
      format bolus_within_30_piu_150249 best12. ;
      format bolus_within_30_piu_250 best12. ;
      format bolus_within_30_bwp70 best12. ;
      format bolus_within_30_bwp_70180 best12. ;
      format bolus_within_30_bwp_181250 best12. ;
      format bolus_within_30_bwp_251400 best12. ;
      format bolus_within_30_bwp_400 best12. ;
      format days_reading6_hours best12. ;
      format days_bolus6_hours best12. ;
      format perc_bolus_equal_bwz best12. ;
      format perc_bolus_higher_bwz best12. ;
      format perc_bolus_lower_bwz best12. ;
      format perc_lowBG_followed_by_carb_bol best12. ;
      format perc_lowBG_followed_by_bolus best12. ;
      format perc_intargetBG_followed_by_car best12. ;
      format perc_intargetBG_followed_by_bol best12. ;
      format perc_highBG_followed_by_carb_bo best12. ;
      format perc_highBG_followed_by_bolus best12. ;
      format perc_veryhighBG_followed_by_car best12. ;
      format perc_veryhighBG_followed_by_bol best12. ;
      format perc_extremeBG_followed_by_carb best12. ;
      format perc_extremeBG_followed_by_bolu best12. ;
      format lowBG_without_carb_with_bolus best12. ;
      format lowBG_with_carb_and_bolus best12. ;
      format intargetBG_without_carb_with_bo best12. ;
      format intargetBG_with_carb_and_bolus best12. ;
      format highBG_without_carb_with_bolus best12. ;
      format highBG_with_carb_and_bolus best12. ;
      format veryhighBG_without_carb_with_bo best12. ;
      format veryhighBG_with_carb_and_bolus best12. ;
      format extremeBG_without_carb_with_bol best12. ;
      format extremeBG_with_carb_and_bolus best12. ;
      format VAR84 best12. ;
      format perc_lowBG_followed_by_bolus_pi best12. ;
      format VAR86 best12. ;
      format VAR87 best12. ;
      format VAR88 best12. ;
      format perc_highBG_followed_by_bolus_p best12. ;
      format VAR90 best12. ;
      format VAR91 best12. ;
      format lowBG_without_carb_with_bolus_p best12. ;
      format lowBG_with_carb_and_bolus_piu best12. ;
      format VAR94 best12. ;
      format intargetBG_with_carb_and_bolus_ best12. ;
      format highBG_without_carb_with_bolus_ best12. ;
      format highBG_with_carb_and_bolus_piu best12. ;
      format VAR98 best12. ;
      format extremeBG_with_carb_and_bolus_p best12. ;
      format num_rebound_bgs best12. ;
      format perc70 best12. ;
      format perc70149 best12. ;
      format perc150249 best12. ;
      format perc250 best12. ;
      format DateofBirth yymmdd10. ;
      format Sex best12. ;
      format Race best12. ;
      format Ethnicity best12. ;
      format Insurance best12. ;
      format DiagnosisDate yymmdd10. ;
      format IncomeLevel $3. ;
      format interview_educ_years best12. ;
      format interview_educ_degrees best12. ;
      format PumpStartDate yymmdd10. ;
      format pump_dur_days best12. ;
      format pump_dur_yrs best12. ;
      format age_days best12. ;
      format age_years best12. ;
      format filter best12. ;
      format T1D_dur_days best12. ;
      format T1D_dur_years best12. ;
      format piu_perc_bolus_after_less70 best12. ;
      format piu_perc_bolus_after70149 best12. ;
      format piu_perc_bolus_after150249 best12. ;
      format piu_perc_bolus_after250 best12. ;
      format Colorado best12. ;
      format filter__ best12. ;
      format Site $9. ;
      format Days_since_baseline best12. ;
      format readings_per_day_b best12. ;
      format VAR131 best12. ;
      format carb_inputs_per_day_b best12. ;
      format boluses_per_day_b best12. ;
      format VAR134 best12. ;
      format readings_per_day_change best12. ;
      format highBG_change best12. ;
      format carb_inputs_per_day_change best12. ;
   input
               ID
               days_worn
               StudyVisit  $
               VisitDate
               Days_since_last_visit
               Physician  $
               Treatment  $
               HbA1c
               Cold
               Flu
               FOH_C_Maint
               FOH_C_Soc
               FOH_C_Help
               CDI_total
               BDI_total  $
               zDEPRESSION
               total_piu70
               total_piu_70149
               total_piu_150249
               total_piu_250
               total_bwp70
               total_bwp_70180
               total_bwp_181250
               total_bwp_251400
               total_bwp_400
               total_readings
               readings_per_day
               readings_per_weekday
               readings_per_weekend
               perc_days_4_bgs
               total_carb_inputs
               carb_inputs_per_day
               carb_inputs_per_weekday
               carb_inputs_per_weekend
               perc_days_3_carbs
               total_bolus
               boluses_per_day
               boluses_per_weekday
               boluses_per_weekend
               perc_days_3_boluses
               bolus_within_15_piu70
               bolus_within_15_piu_70149
               bolus_within_15_piu_150249
               bolus_within_15_piu_250
               bolus_within_15_bwp70
               bolus_within_15_bwp_70180
               bolus_within_15_bwp_181250
               bolus_within_15_bwp_251400
               bolus_within_15_bwp_400
               bolus_within_30_piu70
               bolus_within_30_piu_70149
               bolus_within_30_piu_150249
               bolus_within_30_piu_250
               bolus_within_30_bwp70
               bolus_within_30_bwp_70180
               bolus_within_30_bwp_181250
               bolus_within_30_bwp_251400
               bolus_within_30_bwp_400
               days_reading6_hours
               days_bolus6_hours
               perc_bolus_equal_bwz
               perc_bolus_higher_bwz
               perc_bolus_lower_bwz
               perc_lowBG_followed_by_carb_bol
               perc_lowBG_followed_by_bolus
               perc_intargetBG_followed_by_car
               perc_intargetBG_followed_by_bol
               perc_highBG_followed_by_carb_bo
               perc_highBG_followed_by_bolus
               perc_veryhighBG_followed_by_car
               perc_veryhighBG_followed_by_bol
               perc_extremeBG_followed_by_carb
               perc_extremeBG_followed_by_bolu
               lowBG_without_carb_with_bolus
               lowBG_with_carb_and_bolus
               intargetBG_without_carb_with_bo
               intargetBG_with_carb_and_bolus
               highBG_without_carb_with_bolus
               highBG_with_carb_and_bolus
               veryhighBG_without_carb_with_bo
               veryhighBG_with_carb_and_bolus
               extremeBG_without_carb_with_bol
               extremeBG_with_carb_and_bolus
               VAR84
               perc_lowBG_followed_by_bolus_pi
               VAR86
               VAR87
               VAR88
               perc_highBG_followed_by_bolus_p
               VAR90
               VAR91
               lowBG_without_carb_with_bolus_p
               lowBG_with_carb_and_bolus_piu
               VAR94
               intargetBG_with_carb_and_bolus_
               highBG_without_carb_with_bolus_
               highBG_with_carb_and_bolus_piu
               VAR98
               extremeBG_with_carb_and_bolus_p
               num_rebound_bgs
               perc70
               perc70149
               perc150249
               perc250
               DateofBirth
               Sex
               Race
               Ethnicity
               Insurance
               DiagnosisDate
               IncomeLevel  $
               interview_educ_years
               interview_educ_degrees
               PumpStartDate
               pump_dur_days
               pump_dur_yrs
               age_days
               age_years
               filter
               T1D_dur_days
               T1D_dur_years
               piu_perc_bolus_after_less70
               piu_perc_bolus_after70149
               piu_perc_bolus_after150249
               piu_perc_bolus_after250
               Colorado
               filter__
               Site  $
               Days_since_baseline
               readings_per_day_b
               VAR131
               carb_inputs_per_day_b
               boluses_per_day_b
               VAR134
               readings_per_day_change
               highBG_change
               carb_inputs_per_day_change;
   if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
   run;


proc mixed data = dat;
class id treatment studyvisit incomelevel;
model readings_per_day_change = zDEPRESSION Treatment StudyVisit Treatment*zDEPRESSION Treatment*StudyVisit Sex age_years IncomeLevel Insurance / s;
random INT / type = UN subject = ID;
run;

proc mixed data = dat;
class id treatment studyvisit incomelevel;
model readings_per_day_change = zDEPRESSION Treatment StudyVisit Treatment*zDEPRESSION Treatment*StudyVisit / s;
random INT / type = UN subject = ID;
run;
