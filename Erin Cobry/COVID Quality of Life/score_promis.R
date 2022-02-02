##########
# PEDS   #
##########

source("./Erin Cobry/ADA 2022/COVID/Data raw/HealthRelatedQuality-PROMISPeds_R_2022-02-01_1915.r")
promis_peds <- data



promis_peds = exportRecords(rcon,forms = "promis_pediatric_817")
promis_peds$record_id = ids
promis_peds$timepoint = times
promis_peds = promis_peds %>% select(record_id,timepoint,falling_asleep:bad_mood_sleepy) %>%
  filter(!record_id %in% exclude,grepl("enrollment|month_3|month_6",timepoint),
         record_id >= 200,rowSums(is.na(.)) < ncol(.)-2) %>%
  mutate(across(falling_asleep:bad_mood_sleepy,.fns = as.numeric),
         through_night = 6 - through_night) %>% 
  mutate(disturbance = rowSums(select(.,falling_asleep:tossed_and_turned)),
         impairment = rowSums(select(.,daytime:bad_mood_sleepy)))
promis_peds$timepoint = sub("enrollment_","baseline_",promis_peds$timepoint)
# Convert to T scores
peds_disturbance = read.csv("./Erin Cobry/ADA 2022/HCL and Sleep/Data_Clean/peds_sleep_disturbance.csv")
peds_impairment = read.csv("./Erin Cobry/ADA 2022/HCL and Sleep/Data_Clean/peds_sleep_impairment.csv")
promis_peds$disturbance = 
  peds_disturbance$T.Score[match(promis_peds$disturbance,
                                 peds_disturbance$Raw.Summed.Score)]
promis_peds$impairment = 
  peds_impairment$T.Score[match(promis_peds$impairment,
                                peds_impairment$Raw.Summed.Score)]


promis_parent = exportRecords(rcon,forms = "promis_parent_proxy_817")
promis_parent$record_id = ids
promis_parent$timepoint = times
promis_parent = promis_parent %>% select(record_id,timepoint,asleep:bad_mood) %>%
  filter(!record_id %in% exclude,grepl("enrollment|month_3|month_6",timepoint),
         record_id < 200,rowSums(is.na(.)) < ncol(.)-2) %>%
  mutate(across(asleep:bad_mood,.fns = as.numeric),
         night = 6 - night) %>% 
  mutate(disturbance = rowSums(select(.,asleep:tossed)),
         impairment = rowSums(select(.,sleepy:bad_mood)))
promis_parent$timepoint = sub("enrollment_","baseline_",promis_parent$timepoint)
# Convert to T scores
parent_disturbance = read.csv("./Erin Cobry/ADA 2022/HCL and Sleep/Data_Clean/parent_proxy_sleep_disturbance.csv")
parent_impairment = read.csv("./Erin Cobry/ADA 2022/HCL and Sleep/Data_Clean/parent_proxy_sleep_impairment.csv")
promis_parent$disturbance = 
  parent_disturbance$T.Score[match(promis_parent$disturbance,
                                   parent_disturbance$Raw.Summed.Score)]
promis_parent$impairment = 
  parent_impairment$T.Score[match(promis_parent$impairment,
                                  parent_impairment$Raw.Summed.Score)]