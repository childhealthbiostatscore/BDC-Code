if(Sys.info()["sysname"] == "Windows"){
  home_dir = "S:/Laura/BDC/Projects"
} else if (Sys.info()["sysname"] == "Linux"){
  home_dir = "~/UCD/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects"
} else if (Sys.info()["sysname"] == "Darwin"){
  home_dir = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects"
}

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
# reverse score question 2
promis_peds$child_slept <- promis_peds$child_slept+2*(3-promis_peds$child_slept)
promis_peds <- promis_peds %>% select(record_id,num_time,Timepoint,child_falling:child_problems_day) %>%
  mutate(disturbance = rowSums(select(.,child_falling:child_trouble_sleep)),
         impairment = rowSums(select(.,child_sleepy:child_problems_day)))
# Convert to T scores
peds_disturbance_short = read.csv("./Erin Cobry/ADA 2022/COVID/Data clean/peds_sleep_disturbance_short.csv")
peds_impairment_short = read.csv("./Erin Cobry/ADA 2022/COVID/Data clean/peds_sleep_impairment_short.csv")
colnames(peds_impairment_short) <- c("Raw.Summed.Score","T.Score","SE","Theta.Score")
promis_peds$disturbance = 
  peds_disturbance_short$T.Score[match(promis_peds$disturbance,
                                       peds_disturbance_short$Raw.Summed.Score)]
promis_peds$impairment = 
 peds_impairment_short$T.Score[match(promis_peds$impairment,
                                     peds_impairment_short$Raw.Summed.Score)]

##################
# PARENT PROXY   #
##################

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
# reverse score question 2
promis_parent_proxy$slept_night <- promis_parent_proxy$slept_night+2*(3-promis_parent_proxy$slept_night)

promis_parent_proxy <- promis_parent_proxy %>% select(record_id,num_time,Timepoint,diff_sleep:probl_day) %>%
  mutate(disturbance = rowSums(select(.,diff_sleep:troub_sleep)),
         impairment = rowSums(select(.,sleepy_day:probl_day)))
# Convert to T scores
parent_disturbance_short = read.csv("./Erin Cobry/ADA 2022/COVID/Data clean/parent_proxy_sleep_disturbance_short.csv")
parent_impairment_short = read.csv("./Erin Cobry/ADA 2022/COVID/Data clean/parent_proxy_sleep_impairment_short.csv")
promis_parent_proxy$disturbance = 
 parent_disturbance_short$T.Score[match(promis_parent_proxy$disturbance,
                                        parent_disturbance_short$Raw.Summed.Score)]
promis_parent_proxy$impairment = 
 parent_impairment_short$T.Score[match(promis_parent_proxy$impairment,
                                       parent_impairment_short$Raw.Summed.Score)]

########################
# PARENT SELF REPORT   #
########################

source("./Erin Cobry/ADA 2022/COVID/Data raw/HealthRelatedQuality-PROMISParentSelfRepo_R_2022-02-01_1917.r")
promis_parent <- data
promis_parent$times = promis_parent$redcap_event_name
promis_parent = promis_parent %>% filter(as.numeric(substr(record_id,1,4))<2000) %>%
  mutate(Timepoint = sub("_arm_.*","",redcap_event_name))
promis_parent$num_id = as.numeric(substr(promis_parent$record_id,1,4))
promis_parent$Timepoint = factor(promis_parent$Timepoint,levels = c("baseline","3_month",
                                                                                "6_month","9_month","12_month"),
                                       labels = c("Baseline","3 Month","6 Month","9 Month","12 Month"))
promis_parent$num_time = recode(promis_parent$Timepoint,"Baseline" = 0,"3 Month" = 3,
                                      "6 Month" = 6,"9 Month" = 9,"12 Month" = 12)

# reverse score questions 1 and 2 of sleep disturbance
promis_parent$sleep_quality <- promis_parent$sleep_quality+2*(3-promis_parent$sleep_quality)
promis_parent$refreshing <- promis_parent$refreshing+2*(3-promis_parent$refreshing)
promis_parent <- promis_parent %>% select(record_id,num_time,Timepoint,sleep_quality:sleepy) %>%
  mutate(disturbance = rowSums(select(.,sleep_quality:difficulty)),
         impairment = rowSums(select(.,hard_time:sleepy)))

# Convert to T scores
parent_self_disturbance_short = read.csv("./Erin Cobry/ADA 2022/COVID/Data clean/parent_self_disturbance_short.csv")
parent_self_impairment_short = read.csv("./Erin Cobry/ADA 2022/COVID/Data clean/parent_self_impairment_short.csv")
promis_parent$disturbance = 
  parent_self_disturbance_short$T.Score[match(promis_parent$disturbance,
                                              parent_self_disturbance_short$Raw.Summed.Score)]
promis_parent$impairment = 
  parent_self_impairment_short$T.Score[match(promis_parent$impairment,
                                             parent_self_impairment_short$Raw.Summed.Score)]
