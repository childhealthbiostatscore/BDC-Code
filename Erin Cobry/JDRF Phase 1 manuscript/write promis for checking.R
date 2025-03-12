# Function to extract PROMIS response values and scores

#' Extract all PROMIS variables (responses and scores) from dataset
#' 
#' @param data A data frame containing PROMIS items and scores
#' @param output_file Character string for output CSV file path
#' @return A data frame containing all PROMIS variables (responses and scores)
#' @export
extract_promis_values <- function(data, output_file = "promis_values.csv") {
  
  # Define patterns for each PROMIS scale's items
  promis_patterns <- list(
    # Child patterns
    child = list(
      anger = c("^a_fedup$", "^a_mad$", "^a_upset$", "^a_throwing$", "^a_yelling$"),
      anxiety = c("^a_awful$", "^a_nervous$", "^a_scared$", "^a_worried$", 
                  "^a_worriedhm$", "^a_scaredeasy$", "^a_happen$", "^a_bed$"),
      depressive = c("^ds_sad$", "^ds_alone$", "^ds_wrong$", "^ds_right$", 
                     "^ds_lonely$", "^ds_sad2$", "^ds_unhappy$", "^ds_hard$"),
      family = c("^fr_strong$", "^fr_important$", "^fr_help$", "^fr_fun$", 
                 "^fr_feel$", "^fr_fair$", "^fr_listen$", "^fr_attention$"),
      peer = c("^r_accepted$", "^r_count$", "^r_talk$", "^r_friends$", 
               "^r_help$", "^r_friend$", "^r_wantedbe$", "^r_wantedtalk$"),
      physical = c("^pa_tired$", "^pa_exercise$", "^pa_breath$", "^pa_sweat$"),
      positive_affect = c("^pa_happy$", "^pa_great$", "^pa_cheerful$", "^pa_joyful$"),
      psychological_stress = c("^ps_stressed$", "^ps_problems$", 
                               "^ps_overwhelmed$", "^ps_manage$"),
      sleep_disturbance = c("^sd_falling$", "^sd_night$", "^sd_problem$", 
                            "^sd_trouble$", "^sd_time$", "^sd_worried$", 
                            "^sd_fallingback$", "^sd_tossed$"),
      sleep_impairment = c("^sri_sleepy$", "^sri_concentrating$", "^sri_gtd$", 
                           "^sri_problems$", "^sri_awake$", "^sri_fun$", 
                           "^sri_eyes$", "^sri_mood$"),
      sleep_practices = c("^sp_routine$", "^sp_tv$", "^sp_games$", "^sp_sleeptime$", 
                          "^sp_someone$", "^sp_electronic$", "^sp_waketime$", 
                          "^sleep_weekdays$", "^wake_weekdays$", 
                          "^sleep_weekends$", "^wake_weekends$"),
      life_satisfaction = c("^ls_satisfied$", "^ls_happy$", "^ls_good$", "^ls_wanted$")
    ),
    
    # Parent patterns
    parent = list(
      anger = c("^a_mad_parent$", "^a_yelling_parent$", "^a_throwing_parent$", 
                "^a_upset_parent$", "^a_angry_parent$"),
      anxiety = c("^a_nervous_parent$", "^a_scared_parent$", "^a_worried_parent$", 
                  "^a_awful_parent$", "^a_worriedhm_parent$", 
                  "^a_scaredeasy_parent$", "^a_happen_parent$", "^a_bed_parent$"),
      depressive = c("^ds_sad_parent$", "^ds_wrong_parent$", "^ds_right_parent$", 
                     "^ds_lonely_parent$", "^ds_sad2_parent$", "^ds_hard_parent$"),
      family = c("^fr_strong_parent$", "^fr_important_parent$", "^fr_help_parent$", 
                 "^fr_fun_parent$", "^fr_feel_parent$", "^fr_fair_parent$", 
                 "^fr_listen_parent$", "^fr_attention_parent$"),
      peer = c("^r_accepted_parent$", "^r_count_parent$", "^r_friends_parent$", 
               "^r_help_parent$", "^r_friend_parent$", "^r_wantedbe_parent$", 
               "^r_wantedtalk_parent$"),
      physical = c("^pa_tired_parent$", "^pa_exercise_parent$", 
                   "^pa_breath_parent$", "^pa_sweat_parent$"),
      positive_affect = c("^pa_happy_parent$", "^pa_great_parent$", 
                          "^pa_cheerful_parent$", "^pa_joyful_parent$"),
      psychological_stress = c("^ps_stressed_parent$", "^ps_problems_parent$", 
                               "^ps_overwhelmed_parent$", "^ps_manage_parent$"),
      sleep_disturbance = c("^sd_falling_parent$", "^sd_night_parent$", 
                            "^sd_problem_parent$", "^sd_trouble_parent$", 
                            "^sd_time_parent$", "^sd_worried_parent$", 
                            "^sd_fallingback_parent$", "^sd_tossed_parent$"),
      sleep_impairment = c("^sri_sleepy_parent$", "^sri_concentrating_parent$", 
                           "^sri_gtd_parent$", "^sri_problems_parent$", 
                           "^sri_awake_parent$", "^sri_fun_parent$", 
                           "^sri_eyes_parent$", "^sri_mood_parent$"),
      sleep_practices = c("^sp_routine_parent$", "^sp_tv_parent$", 
                          "^sp_games_parent$", "^sp_sleeptime_parent$", 
                          "^sp_someone_parent$", "^sp_electronic_parent$", 
                          "^sp_waketime_parent$", "^sleep_weekdays_parent$", 
                          "^wake_weekdays_parent$", "^sleep_weekends_parent$", 
                          "^wake_weekends_parent$")
    ),
    
    # Score patterns
    scores = c(
      "_raw$",    # Raw scores
      "_tscore$"  # T-scores
    )
  )
  
  # Function to get matching variables for a pattern
  get_matching_vars <- function(pattern) {
    grep(pattern, names(data), value = TRUE)
  }
  
  # Get all PROMIS variables
  promis_vars <- c()
  
  # Get child response variables
  for(scale in names(promis_patterns$child)) {
    for(pattern in promis_patterns$child[[scale]]) {
      vars <- get_matching_vars(pattern)
      promis_vars <- c(promis_vars, vars)
    }
  }
  
  # Get parent response variables
  for(scale in names(promis_patterns$parent)) {
    for(pattern in promis_patterns$parent[[scale]]) {
      vars <- get_matching_vars(pattern)
      promis_vars <- c(promis_vars, vars)
    }
  }
  
  # Get score variables
  for(pattern in promis_patterns$scores) {
    vars <- get_matching_vars(pattern)
    promis_vars <- c(promis_vars, vars)
  }
  
  # Add record_id if it exists
  if("record_id" %in% names(data)) {
    promis_vars <- c("record_id", "redcap_event_name", promis_vars)
  }
  
  # Remove any duplicates
  promis_vars <- unique(promis_vars)
  
  # Create subset with all PROMIS variables
  promis_subset <- data[, promis_vars, drop = FALSE]
  
  # Write to CSV
  write.csv(promis_subset, file = output_file, row.names = FALSE)
  
  # Print summary of extracted variables
  cat("\nExtracted variables summary:\n")
  
  cat("\nChild Response Variables:")
  for(scale in names(promis_patterns$child)) {
    vars <- unlist(lapply(promis_patterns$child[[scale]], get_matching_vars))
    if(length(vars) > 0) {
      cat(sprintf("\n%s: %d variables", scale, length(vars)))
    }
  }
  
  cat("\n\nParent Response Variables:")
  for(scale in names(promis_patterns$parent)) {
    vars <- unlist(lapply(promis_patterns$parent[[scale]], get_matching_vars))
    if(length(vars) > 0) {
      cat(sprintf("\n%s: %d variables", scale, length(vars)))
    }
  }
  
  cat("\n\nScore Variables:")
  raw_scores <- grep("_raw$", promis_vars, value = TRUE)
  t_scores <- grep("_tscore$", promis_vars, value = TRUE)
  cat(sprintf("\nRaw scores: %d variables", length(raw_scores)))
  cat(sprintf("\nT-scores: %d variables", length(t_scores)))
  cat("\n")
  
  return(promis_subset)
}

# Example usage:
# data <- read.csv("your_data.csv")
# promis_values <- extract_promis_values(data, "promis_values.csv")