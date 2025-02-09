#' Convert all PROMIS raw scores to T-scores
#' 
#' @param scores A data frame containing raw PROMIS scores (output from score_all_promis_scales)
#' @param lookup_tables A list of named vectors containing lookup tables for each scale
#' @param respondent Character string indicating 'child' or 'parent'
#' @return A data frame with both raw scores and T-scores for all scales
#' @export
convert_all_to_tscores <- function(scores, lookup_tables, respondent = "child") {
  # Create a copy of the input data frame to store both raw and T-scores
  result <- scores
  
  # Get all column names that end with "_raw"
  raw_score_cols <- grep("_raw$", names(scores), value = TRUE)
  
  # For each raw score column, create corresponding T-score
  for (col in raw_score_cols) {
    # Extract scale name by removing "_raw" suffix
    scale_name <- sub("_raw$", "", col)
    
    # Skip life satisfaction for parent respondent
    if (scale_name == "life_satisfaction" && respondent == "parent") {
      next
    }
    
    # Get lookup table for this scale
    lookup_table <- lookup_tables[[paste0(scale_name, "_", respondent)]]
    
    if (!is.null(lookup_table)) {
      # Convert raw scores to T-scores
      t_scores <- convert_to_tscore(scores[[col]], scale_name, lookup_table)
      
      # Add T-scores to result data frame
      result[[paste0(scale_name, "_tscore")]] <- t_scores
    } else {
      warning(sprintf("No lookup table found for scale: %s (%s version)", 
                      scale_name, respondent))
    }
  }
  
  return(result)
}

#' Create lookup tables for PROMIS scales
#' 
#' @return A list of lookup tables for each scale and respondent type
#' @export
create_promis_lookup_tables <- function() {
  lookup_tables <- list()
  
  # Anxiety (same for child and parent)
  anxiety_table <- c(
    "4" = 40.3, "5" = 48.0, "6" = 51.2, "7" = 53.6, "8" = 55.7,
    "9" = 57.6, "10" = 59.4, "11" = 61.1, "12" = 62.8, "13" = 64.4,
    "14" = 66.0, "15" = 67.6, "16" = 69.2, "17" = 70.9, "18" = 72.6,
    "19" = 74.4, "20" = 76.3
  )
  lookup_tables$anxiety_child <- anxiety_table
  lookup_tables$anxiety_parent <- anxiety_table
  
  # Depression
  depression_table <- c(
    "8" = 35.2, "9" = 40.4, "10" = 43.2, "11" = 45.4, "12" = 47.3,
    "13" = 49.0, "14" = 50.6, "15" = 52.1, "16" = 53.6, "17" = 55.0,
    "18" = 56.4, "19" = 57.8, "20" = 59.2, "21" = 60.6, "22" = 62.1,
    "23" = 63.6, "24" = 65.2, "25" = 66.8, "26" = 68.5, "27" = 70.3,
    "28" = 72.2, "29" = 74.2, "30" = 76.4, "31" = 78.8, "32" = 81.5
  )
  lookup_tables$depressive_child <- depression_table
  lookup_tables$depressive_parent <- depression_table
  
  # Life Satisfaction (child only)
  lookup_tables$life_satisfaction_child <- c(
    "4" = 21.3, "5" = 24.9, "6" = 27.2, "7" = 29.1, "8" = 30.8,
    "9" = 32.4, "10" = 33.9, "11" = 35.4, "12" = 36.9, "13" = 38.4,
    "14" = 39.9, "15" = 41.5, "16" = 43.2, "17" = 45.0, "18" = 47.0,
    "19" = 49.3, "20" = 52.0
  )

  # Physical Activity
  lookup_tables$physical_child <- c(
    "4" = 32.3, "5" = 37.3, "6" = 39.5, "7" = 41.2, "8" = 42.7,
    "9" = 44.1, "10" = 45.4, "11" = 46.7, "12" = 48.0, "13" = 49.3,
    "14" = 50.7, "15" = 52.1, "16" = 53.6, "17" = 55.2, "18" = 57.0,
    "19" = 59.0, "20" = 61.3
  )
  
  lookup_tables$physical_parent <- c(
    "4" = 31.3, "5" = 36.1, "6" = 38.1, "7" = 39.7, "8" = 41.1,
    "9" = 42.4, "10" = 43.6, "11" = 44.8, "12" = 46.0, "13" = 47.2,
    "14" = 48.5, "15" = 49.8, "16" = 51.2, "17" = 52.7, "18" = 54.4,
    "19" = 56.3, "20" = 58.5
  )
  
  # Positive Affect (same for child and parent)
  positive_affect_table <- c(
    "4" = 22.0, "5" = 25.7, "6" = 28.0, "7" = 29.9, "8" = 31.6,
    "9" = 33.2, "10" = 34.7, "11" = 36.2, "12" = 37.7, "13" = 39.2,
    "14" = 40.8, "15" = 42.4, "16" = 44.2, "17" = 46.1, "18" = 48.2,
    "19" = 50.7, "20" = 53.6
  )
  lookup_tables$positive_affect_child <- positive_affect_table
  lookup_tables$positive_affect_parent <- positive_affect_table
  
  # Psychological Stress
  lookup_tables$psychological_stress_child <- c(
    "4" = 39.5, "5" = 46.2, "6" = 49.4, "7" = 51.8, "8" = 53.9,
    "9" = 55.8, "10" = 57.6, "11" = 59.4, "12" = 61.1, "13" = 62.9,
    "14" = 64.7, "15" = 66.6, "16" = 68.6, "17" = 70.8, "18" = 73.2,
    "19" = 76.0, "20" = 79.2
  )
  
  lookup_tables$psychological_stress_parent <- c(
    "4" = 39.6, "5" = 46.8, "6" = 50.5, "7" = 53.2, "8" = 55.5,
    "9" = 57.6, "10" = 59.6, "11" = 61.5, "12" = 63.4, "13" = 65.3,
    "14" = 67.3, "15" = 69.4, "16" = 71.6, "17" = 74.0, "18" = 76.7,
    "19" = 79.8, "20" = 83.3
  )
  
  # Peer Relationships
  lookup_tables$peer_child <- c(
    "8" = 17.68, "9" = 19.97, "10" = 21.43, "11" = 22.89, "12" = 24.35,
    "13" = 25.81, "14" = 27.27, "15" = 28.73, "16" = 30.19, "17" = 31.65,
    "18" = 33.11, "19" = 34.57, "20" = 36.03, "21" = 37.49, "22" = 38.95,
    "23" = 40.41, "24" = 41.87, "25" = 43.33, "26" = 44.79, "27" = 46.25,
    "28" = 47.71, "29" = 49.17, "30" = 50.63, "31" = 52.09, "32" = 53.55,
    "33" = 55.01, "34" = 56.47, "35" = 57.93, "36" = 59.39, "37" = 60.85,
    "38" = 62.31, "39" = 63.77, "40" = 65.23
  )
  
  lookup_tables$peer_parent <- c(
    "7" = 15.0, "8" = 18.0, "9" = 20.0, "10" = 21.5, "11" = 23.0,
    "12" = 24.5, "13" = 26.0, "14" = 27.5, "15" = 29.0, "16" = 30.5,
    "17" = 32.0, "18" = 33.5, "19" = 35.0, "20" = 36.5, "21" = 38.0,
    "22" = 39.5, "23" = 41.0, "24" = 42.5, "25" = 44.0, "26" = 45.5,
    "27" = 47.0, "28" = 48.5, "29" = 50.0, "30" = 51.5, "31" = 53.0,
    "32" = 54.5, "33" = 56.0, "34" = 57.5, "35" = 59.0
  )
  
  # Family Relationships
  lookup_tables$family_child <- c(
    "8" = 17.9, "9" = 20.5, "10" = 22.3, "11" = 23.9, "12" = 25.4,
    "13" = 26.8, "14" = 28.2, "15" = 29.6, "16" = 31.0, "17" = 32.4,
    "18" = 33.8, "19" = 35.2, "20" = 36.6, "21" = 38.0, "22" = 39.4,
    "23" = 40.8, "24" = 42.2, "25" = 43.6, "26" = 45.0, "27" = 46.4,
    "28" = 47.8, "29" = 49.2, "30" = 50.6, "31" = 52.0, "32" = 53.4,
    "33" = 54.8, "34" = 56.2, "35" = 57.6, "36" = 59.0, "37" = 60.4,
    "38" = 61.8, "39" = 63.2, "40" = 64.6
  )
  
  lookup_tables$family_parent <- c(
    "8" = 17.0, "9" = 19.3, "10" = 21.5, "11" = 23.2, "12" = 24.8,
    "13" = 26.3, "14" = 27.7, "15" = 29.1, "16" = 30.5, "17" = 31.9,
    "18" = 33.3, "19" = 34.7, "20" = 36.1, "21" = 37.5, "22" = 38.9,
    "23" = 40.3, "24" = 41.7, "25" = 43.1, "26" = 44.5, "27" = 45.9,
    "28" = 47.3, "29" = 48.7, "30" = 50.1, "31" = 51.5, "32" = 52.9,
    "33" = 54.3, "34" = 55.7, "35" = 57.1, "36" = 58.5, "37" = 59.9,
    "38" = 61.3, "39" = 62.7, "40" = 64.1
  )
  
  # Sleep Disturbance
  lookup_tables$sleep_disturbance_child <- c(
    "8" = 36.6, "9" = 42.1, "10" = 44.8, "11" = 46.9, "12" = 48.7,
    "13" = 50.3, "14" = 51.8, "15" = 53.2, "16" = 54.6, "17" = 56.0,
    "18" = 57.3, "19" = 58.7, "20" = 60.0, "21" = 61.4, "22" = 62.8,
    "23" = 64.2, "24" = 65.7, "25" = 67.2, "26" = 68.8, "27" = 70.5,
    "28" = 72.3, "29" = 74.2, "30" = 76.3, "31" = 78.6, "32" = 81.2,
    "33" = 84.0, "34" = 87.1, "35" = 90.4, "36" = 93.9, "37" = 97.7,
    "38" = 101.7, "39" = 105.9, "40" = 110.3
  )
  
  lookup_tables$sleep_disturbance_parent <- c(
    "8" = 38.7, "9" = 44.4, "10" = 47.3, "11" = 49.5, "12" = 51.4,
    "13" = 53.1, "14" = 54.7, "15" = 56.2, "16" = 57.7, "17" = 59.1,
    "18" = 60.5, "19" = 61.9, "20" = 63.3, "21" = 64.7, "22" = 66.2,
    "23" = 67.7, "24" = 69.2, "25" = 70.8, "26" = 72.5, "27" = 74.3,
    "28" = 76.2, "29" = 78.3, "30" = 80.5, "31" = 83.0, "32" = 85.7,
    "33" = 88.7, "34" = 91.9, "35" = 95.4, "36" = 99.2, "37" = 103.2,
    "38" = 107.5, "39" = 112.1, "40" = 116.9
  )
  
  # Sleep Impairment
  lookup_tables$sleep_impairment_child <- c(
    "8" = 37.4, "9" = 43.3, "10" = 45.9, "11" = 47.9, "12" = 49.6,
    "13" = 51.2, "14" = 52.6, "15" = 54.0, "16" = 55.3, "17" = 56.6,
    "18" = 57.9, "19" = 59.2, "20" = 60.5, "21" = 61.8, "22" = 63.1,
    "23" = 64.5, "24" = 65.9, "25" = 67.3, "26" = 68.8, "27" = 70.4,
    "28" = 72.1, "29" = 73.9, "30" = 75.8, "31" = 77.9, "32" = 80.2,
    "33" = 82.7, "34" = 85.4, "35" = 88.4, "36" = 91.6, "37" = 95.1,
    "38" = 98.9, "39" = 102.9
  )
  
  lookup_tables$sleep_impairment_parent <- c(
    "8" = 37.9, "9" = 43.8, "10" = 47.0, "11" = 49.3, "12" = 51.2,
    "13" = 52.9, "14" = 54.5, "15" = 55.9, "16" = 57.3, "17" = 58.7,
    "18" = 60.0, "19" = 61.4, "20" = 62.7, "21" = 64.1, "22" = 65.5,
    "23" = 66.9, "24" = 68.4, "25" = 69.9, "26" = 71.5, "27" = 73.2,
    "28" = 75.0, "29" = 76.9, "30" = 79.0, "31" = 81.2, "32" = 83.6,
    "33" = 86.2, "34" = 89.0, "35" = 92.1, "36" = 95.4, "37" = 99.0
  )
  
  return(lookup_tables)
}

# Example usage:
#
# # Create lookup tables
# lookup_tables <- create_promis_lookup_tables()
#
# # Score all scales
# raw_scores <- score_all_promis_scales(data, respondent = "child")
#
# # Convert to T-scores
# all_scores <- convert_all_to_tscores(raw_scores, lookup_tables, respondent = "child")
#
# # Access specific scores
# anxiety_raw <- all_scores$anxiety_raw
# anxiety_tscore <- all_scores$anxiety_tscore