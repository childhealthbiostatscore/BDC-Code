##########
# PEDS   #
##########

source("./Erin Cobry/ADA 2022/COVID/Data raw/HealthRelatedQuality-PROMISPeds_R_2022-02-01_1915.r")
promis_peds <- data
promis_peds$times = promis_peds$redcap_event_name
promis_peds = promis_peds %>% filter(as.numeric(substr(record_id,1,4))>=2000) %>%
  mutate(Timepoint = sub("_arm_.*","",redcap_event_name))
promis_peds$num_id = as.numeric(substr(promis_peds$record_id,1,4))
promis_peds$Timepoint = factor(promis_peds$Timepoint,levels = c("baseline","3_month",
                                                                    "6_month","9_month","12_month"),
                                 labels = c("Baseline","3 Month","6 Month","9 Month","12 Month"))
promis_peds$num_time = recode(promis_peds$Timepoint,"Baseline" = 0,"3 Month" = 3,
                                "6 Month" = 6,"9 Month" = 9,"12 Month" = 12)
promis_peds <- promis_peds %>% select(record_id,Timepoint,child_falling:child_problems_day) %>%
  mutate(disturbance = rowSums(select(.,child_falling:child_trouble_sleep)),
         impairment = rowSums(select(.,child_sleepy:child_problems_day)))
# need to update this part once Erin sends the corrected t-tables
# Convert to T scores
peds_disturbance_short = read.csv("./Erin Cobry/ADA 2022/COVID/Data clean/peds_sleep_disturbance_short.csv")
peds_impairment_short = read.csv("./Erin Cobry/ADA 2022/COVID/Data clean/peds_sleep_impairment_short.csv")
promis_peds$disturbance = 
  peds_disturbance_short$T.Score[match(promis_peds$disturbance,
                                 peds_disturbance$Raw.Summed.Score)]
promis_peds$impairment = 
  peds_impairment_short$T.Score[match(promis_peds$impairment,
                                peds_impairment$Raw.Summed.Score)]


source("./Erin Cobry/ADA 2022/COVID/Data raw/HealthRelatedQuality-PROMISParentProxy_R_2022-02-01_1916.r")
promis_parent_proxy <- data
promis_parent_proxy$times = promis_parent_proxy$redcap_event_name
promis_parent_proxy = promis_parent_proxy %>% filter(as.numeric(substr(record_id,1,4))<2000) %>%
  mutate(Timepoint = sub("_arm_.*","",redcap_event_name))
promis_parent_proxy$num_id = as.numeric(substr(promis_parent_proxy$record_id,1,4))
promis_parent_proxy$Timepoint = factor(promis_parent_proxy$Timepoint,levels = c("baseline","3_month",
                                                                "6_month","9_month","12_month"),
                               labels = c("Baseline","3 Month","6 Month","9 Month","12 Month"))
promis_parent_proxy$num_time = recode(promis_parent_proxy$Timepoint,"Baseline" = 0,"3 Month" = 3,
                              "6 Month" = 6,"9 Month" = 9,"12 Month" = 12)
promis_parent_proxy <- promis_parent_proxy %>% select(record_id,Timepoint,diff_sleep:probl_day) %>%
  mutate(disturbance = rowSums(select(.,diff_sleep:troub_sleep)),
         impairment = rowSums(select(.,sleepy_day:probl_day)))
# need to update this part once Erin sends the corrected t-tables
# Convert to T scores
parent_disturbance_short = read.csv("./Erin Cobry/ADA 2022/HCL and Sleep/Data clean/parent_proxy_sleep_disturbance.csv")
parent_impairment_short = read.csv("./Erin Cobry/ADA 2022/HCL and Sleep/Data clean/parent_proxy_sleep_impairment.csv")
promis_parent$disturbance = 
  parent_disturbance_short$T.Score[match(promis_parent$disturbance,
                                   parent_disturbance$Raw.Summed.Score)]
promis_parent$impairment = 
  parent_impairment_short$T.Score[match(promis_parent$impairment,
                                  parent_impairment$Raw.Summed.Score)]