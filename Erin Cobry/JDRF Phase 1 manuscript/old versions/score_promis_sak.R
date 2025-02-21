if(Sys.info()["sysname"] == "Windows"){
  home_dir = "S:/Laura/BDC/Projects"
} else if (Sys.info()["sysname"] == "Linux"){
  home_dir = "~/UCD/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects"
} else if (Sys.info()["sysname"] == "Darwin"){
  home_dir = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects"
}

setwd('/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects')

##########
# sheets #
##########
peds_lifesatisfaction_short <- read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Life Satisfaction T-tables.xlsx", 
                                         sheet = "Pedaitric Life Satisfaction 4a")

peds_physact_short <- read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Physical Activity T-tables.xlsx", 
                                          sheet = "Pediatric Physical Activity 4a")
pp_physact_short = read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Physical Activity T-tables.xlsx", 
                                 sheet = "Parent Proxy Phys Activity 4a")

peds_posaff_short <- read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Positive Affect T-tables.xlsx", 
                                 sheet = "Pediatric Positive Affect 4a")
pp_posaff_short = read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Positive Affect T-tables.xlsx", 
                              sheet = "Parent Proxy Positive Affect 4a")

peds_pse_short <- read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Psychological Stress Experience T-tables.xlsx", 
                                sheet = "Pediatric Psych Stress Exp 4a")
pp_pse_short = read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Psychological Stress Experience T-tables.xlsx", 
                             sheet = "Parent Proxy Psy Stress Exp 4a")

peds_pse_short <- read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Psychological Stress Experience T-tables.xlsx", 
                             sheet = "Pediatric Psych Stress Exp 4a")
pp_pse_short = read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Psychological Stress Experience T-tables.xlsx", 
                          sheet = "Parent Proxy Psy Stress Exp 4a")

peds_anx_short <- read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Anxiety T-tables.xlsx", 
                             sheet = "Pediatric Anxiety 8a")
pp_anx_short = read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Anxiety T-tables.xlsx", 
                          sheet = "Parent Proxy Anxiety 8a")

psr_anx_short = read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Anxiety T-tables.xlsx", 
                          sheet = "Parent (Adult) Anxiety 4a")

peds_dep_short <- read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Depression T-tables.xlsx", 
                             sheet = "Pedaitric Depressive Symptoms 8")
pp_dep_short = read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Depression T-tables.xlsx", 
                          sheet = "Parent Proxy Depressive Sx 6a")

psr_dep_short = read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Depression T-tables.xlsx", 
                           sheet = "Parent (Adult) Depression 4a")


peds_pr_short <- read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Relationships T-tables.xlsx", 
                             sheet = "Pediatric Peer Relationships 8a")

peds_fr_short <- read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Relationships T-tables.xlsx", 
                            sheet = "Pediatric Family Relation 8a")

pp_fr_short = read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Relationships T-tables.xlsx", 
                          sheet = "Parent Prox Family Relat 8a")

peds_anger_short <- read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Anger T-tables.xlsx", 
                            sheet = "Pediatric Self Report 5a")

pp_anger_short = read_excel("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/Anger T-tables.xlsx", 
                         sheet = "Parent Proxy 5a")

# anger ttables?

##########
# PEDS   #
##########

#source("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data raw/HealthRelatedQuality-PROMISPeds_R_2022-02-01_1915.r")
promis_peds <- survey_df
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
promis_peds <- promis_peds %>% 
  mutate(disturbance = rowSums(select(.,child_falling:child_trouble_sleep)),
         impairment = rowSums(select(.,child_sleepy:child_problems_day)),
         life_satisfaction = rowSums(select(.,satisfied:wanted_life)),
         physact = rowSums(select(.,tired_body:days_sweated)),
         posaff = rowSums(select(.,child_happy:child_joyful)),
         pse = rowSums(select(.,child_stressed:child_manage)),
         anger =  rowSums(select(.,fed_up:child_felt_yelling)),
         anxiety =  rowSums(select(.,child_happen:child_worried_night)),
         depression = rowSums(select(.,child_feel_sad:child_hard_fun)),
         peer_rel = rowSums(select(.,accepted:talk_to_me)),
         fam_rel = rowSums(select(.,strong_family:attention_to_me)))
# Convert to T scores
peds_disturbance_short = read.csv("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/peds_sleep_disturbance_short.csv")
peds_impairment_short = read.csv("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/peds_sleep_impairment_short.csv")
colnames(peds_impairment_short) <- c("Raw.Summed.Score","T.Score","SE","Theta.Score")
promis_peds$disturbance = 
  peds_disturbance_short$T.Score[match(promis_peds$disturbance,
                                       peds_disturbance_short$Raw.Summed.Score)]
promis_peds$impairment = 
 peds_impairment_short$T.Score[match(promis_peds$impairment,
                                     peds_impairment_short$Raw.Summed.Score)]
promis_peds$life_satisfaction = 
  peds_lifesatisfaction_short$`T-Score`[match(promis_peds$life_satisfaction,
                                              peds_lifesatisfaction_short$`Raw Summed Score`)]
promis_peds$physact = 
  peds_physact_short$`T-score`[match(promis_peds$physact,
                                              peds_physact_short$`Raw Score`)]

promis_peds$posaff = 
  peds_posaff_short$`T-score`[match(promis_peds$posaff,
                                     peds_posaff_short$`Raw Score`)]
promis_peds$pse = 
  peds_pse_short$`T-score`[match(promis_peds$pse,
                                    peds_pse_short$`Raw Score`)]

promis_peds$anxiety = 
  peds_anx_short$`T-Score`[match(promis_peds$anxiety,
                                 peds_anx_short$`Raw Summed Score`)]

promis_peds$depression = 
  peds_dep_short$`T-score`[match(promis_peds$depression,
                                 peds_dep_short$`Raw Score`)]

promis_peds$peer_rel = 
  peds_pr_short$`T-score`[match(promis_peds$peer_rel,
                                 peds_pr_short$`Raw Score`)]

promis_peds$fam_rel = 
  peds_pr_short$`T-score`[match(promis_peds$fam_rel,
                                peds_pr_short$`Raw Score`)]

promis_peds$anger = 
  peds_anger_short$`T-Score`[match(promis_peds$anger,
                                peds_anger_short$`Raw Summed Score`)]

##################
# PARENT PROXY   #
##################

source("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data raw/HealthRelatedQuality-PROMISParentProxy_R_2022-02-01_1916.r")
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

promis_parent_proxy <- promis_parent_proxy %>% 
  mutate(disturbance = rowSums(select(.,diff_sleep:troub_sleep)),
         impairment = rowSums(select(.,sleepy_day:probl_day)),
         physact = rowSums(select(.,body_tired:sweat)),
         posaff = rowSums(select(.,happy:joyful)),
         pse = rowSums(select(.,stressed:manage)),
         anger = rowSums(select(.,child_mad:child_stay_mad)),
         anxiety = rowSums(select(.,nervous:worried_bed)),
         depression = rowSums(select(.,feeling_sad:hard_fun)),
         fam_rel = rowSums(select(.,strong:attention)))
# Convert to T scores
parent_disturbance_short = read.csv("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/parent_proxy_sleep_disturbance_short.csv")
parent_impairment_short = read.csv("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/parent_proxy_sleep_impairment_short.csv")
promis_parent_proxy$disturbance = 
 parent_disturbance_short$T.Score[match(promis_parent_proxy$disturbance,
                                        parent_disturbance_short$Raw.Summed.Score)]
promis_parent_proxy$impairment = 
 parent_impairment_short$T.Score[match(promis_parent_proxy$impairment,
                                       parent_impairment_short$Raw.Summed.Score)]

promis_parent_proxy$physact = 
  pp_physact_short$`T-score`[match(promis_parent_proxy$physact,
                                     pp_physact_short$`Raw Score`)]

promis_parent_proxy$posaff = 
  pp_posaff_short$`T-score`[match(promis_parent_proxy$posaff,
                                    pp_posaff_short$`Raw Scored`)]

promis_parent_proxy$pse = 
  pp_pse_short$`T-score`[match(promis_parent_proxy$pse,
                                  pp_pse_short$`Raw Score`)]

promis_parent_proxy$anxiety = 
  pp_anx_short$`T-Score`[match(promis_parent_proxy$anxiety,
                               pp_anx_short$`Raw Score`)]

promis_parent_proxy$depression = 
  pp_dep_short$`T-score`[match(promis_parent_proxy$depression,
                               pp_dep_short$`Raw Score`)]

promis_parent_proxy$fam_rel = 
  pp_fr_short$`T-score`[match(promis_parent_proxy$fam_rel,
                               pp_fr_short$`Raw Score`)]

promis_parent_proxy$anger = 
  pp_anger_short$`T-Score`[match(promis_parent_proxy$anger,
                              pp_anger_short$`Raw Summed Score`)]

########################
# PARENT SELF REPORT   #
########################

source("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data raw/HealthRelatedQuality-PROMISParentSelfRepo_R_2022-02-01_1917.r")
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
promis_parent <- promis_parent %>%
  mutate(disturbance = rowSums(select(.,sleep_quality:difficulty)),
         impairment = rowSums(select(.,hard_time:sleepy)),
         anxiety = rowSums(select(.,fearful:uneasy)),
         depression = rowSums(select(.,worthless:hopeless)))

# Convert to T scores
parent_self_disturbance_short = read.csv("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/parent_self_disturbance_short.csv")
parent_self_impairment_short = read.csv("/Volumes/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/ADA 2022/COVID/Data clean/parent_self_impairment_short.csv")
promis_parent$disturbance = 
  parent_self_disturbance_short$T.Score[match(promis_parent$disturbance,
                                              parent_self_disturbance_short$Raw.Summed.Score)]
promis_parent$impairment = 
  parent_self_impairment_short$T.Score[match(promis_parent$impairment,
                                             parent_self_impairment_short$Raw.Summed.Score)]

promis_parent$anxiety = 
  psr_anx_short$`T-Score`[match(promis_parent$anxiety,
                                psr_anx_short$`Raw Summed Score`)]

promis_parent$depression = 
  psr_dep_short$`T-score`[match(promis_parent$depression,
                                psr_dep_short$`Raw Score`)]
