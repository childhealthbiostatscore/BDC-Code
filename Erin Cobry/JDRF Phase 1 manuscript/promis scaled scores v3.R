#' Convert raw scores to T-scores using lookup tables
#' 
#' @param raw_score Numeric vector of raw scores
#' @param scale_name Character string indicating which scale
#' @param respondent Character string indicating 'child' or 'parent'
#' @param lookup_tables List of lookup tables for all scales
#' @return Numeric vector of T-scores
#' @export
convert_to_tscore <- function(raw_score, scale_name, lookup_tables) {
  # Determine respondent type from prefix
  respondent <- if(grepl("^c_", scale_name)) "child" else if(grepl("^p_", scale_name)) "parent" else "child"
  
  # Remove c_ or p_ prefix and _raw suffix
  clean_scale_name <- sub("^[cp]_", "", scale_name)
  clean_scale_name <- sub("_raw$", "", clean_scale_name)
  
  # Get the appropriate lookup table
  table_name <- paste0(clean_scale_name, "_", respondent)
  lookup_table <- lookup_tables[[table_name]]
  
  if (is.null(lookup_table)) {
    warning(sprintf("No T-score conversion table available for %s scale (%s version)", 
                    clean_scale_name, respondent))
    return(rep(NA, length(raw_score)))
  }
  
  # Initialize result vector with NAs
  t_scores <- rep(NA, length(raw_score))
  
  # Only process non-NA and non-NaN values
  valid_indices <- which(!is.na(raw_score) & !is.nan(raw_score))
  
  if (length(valid_indices) > 0) {
    # Convert valid raw scores to character for lookup
    valid_scores <- as.character(round(raw_score[valid_indices]))
    
    # Look up T-scores for valid values
    t_scores[valid_indices] <- as.numeric(lookup_table[valid_scores])
  }
  
  return(t_scores)
}


#' Convert all PROMIS raw scores to T-scores
#' 
#' @param scores A data frame containing raw PROMIS scores
#' @param lookup_tables A list of named vectors containing lookup tables for each scale
#' @param respondent Character string indicating 'child' or 'parent'
#' @return A data frame with both raw scores and T-scores for all scales
#' @export
convert_all_to_tscores <- function(scores, lookup_tables) {
  # Create a copy of the input data frame to store both raw and T-scores
  result <- scores
  
  # Get all column names that end with "_raw"
  raw_score_cols <- grep("_raw$", names(scores), value = TRUE)
  
  # For each raw score column, create corresponding T-score
  for (col in raw_score_cols) {
    # Convert raw scores to T-scores
    t_scores <- convert_to_tscore(scores[[col]], col, lookup_tables)
    
    # Create T-score column name by replacing _raw with _tscore
    tscore_col <- sub("_raw$", "_tscore", col)
    
    # Add T-scores to result data frame
    result[[tscore_col]] <- t_scores
  }
  
  return(result)
}


#' Create lookup tables for PROMIS scales
#' 
#' @return A list of lookup tables for each scale and respondent type
#' @export
create_promis_lookup_tables <- function() {
  lookup_tables <- list()
  
  # Life Satisfaction (child only)
  lookup_tables$life_satisfaction_child <- c(
    "4" = 21.3, "5" = 24.9, "6" = 27.2, "7" = 29.1, "8" = 30.8,
    "9" = 32.4, "10" = 33.9, "11" = 35.4, "12" = 36.9, "13" = 38.4,
    "14" = 39.9, "15" = 41.5, "16" = 43.2, "17" = 45.0, "18" = 47.0,
    "19" = 49.3, "20" = 52.0
  )
  
  # Anxiety (same for child and parent)
  #anxiety_table <- c(
  #  "4" = 40.3, "5" = 48.0, "6" = 51.2, "7" = 53.6, "8" = 55.7,
  #  "9" = 57.6, "10" = 59.4, "11" = 61.1, "12" = 62.8, "13" = 64.4,
  #  "14" = 66.0, "15" = 67.6, "16" = 69.2, "17" = 70.9, "18" = 72.6,
  #  "19" = 74.4, "20" = 76.3
  #)
  anxiety_table <- c(
    "8" = 33.5, "9" = 38.0, "10" = 40.6, "11" = 43.0, "12" = 44.9,
    "13" = 46.7, "14" = 48.3, "15" = 49.8, "16" = 51.2, "17" = 52.5,
    "18" = 53.8, "19" = 55.1, "20" = 56.3, "21" = 57.5, "22" = 58.7,
    "23" = 59.9, "24" = 61.0, "25" = 62.2, "26" = 63.4, "27" = 64.5, "28" = 65.7, 
    "29" = 66.9, "30" = 68.1, "31" = 69.3, "32" = 70.6, "33" = 71.8, "34" = 73.2, "35" = 74.6, 
    "36" = 76.0, "37" = 77.6, "38" = 79.3, "39" = 81.1, "40" = 83.3
  )
  lookup_tables$anxiety_child <- anxiety_table
  lookup_tables$anxiety_parent <- anxiety_table
  
  # Depression
  # PROMIS Child Depression Scale T-Score Conversion Table
  c_depression_table <- c(
    "8" = 35.2, "9" = 40.4, "10" = 43.2, "11" = 45.5, "12" = 47.4,
    "13" = 49.1, "14" = 50.6, "15" = 52.0, "16" = 53.3, "17" = 54.5,
    "18" = 55.7, "19" = 56.8, "20" = 57.9, "21" = 59.0, "22" = 60.0,
    "23" = 61.1, "24" = 62.1, "25" = 63.1, "26" = 64.1, "27" = 65.1,
    "28" = 66.1, "29" = 67.2, "30" = 68.2, "31" = 69.3, "32" = 70.3,
    "33" = 71.4, "34" = 72.6, "35" = 73.8, "36" = 75.1, "37" = 76.5,
    "38" = 78.1, "39" = 79.9, "40" = 82.4
  )
  parent_depression_table <- c(
    "6" = 36.2, "7" = 42.1, "8" = 45.4, "9" = 48.0, "10" = 50.2,
    "11" = 52.1, "12" = 53.9, "13" = 55.6, "14" = 57.2, "15" = 58.9,
    "16" = 60.5, "17" = 62.1, "18" = 63.7, "19" = 65.3, "20" = 66.8,
    "21" = 68.4, "22" = 70.0, "23" = 71.5, "24" = 73.1, "25" = 74.7,
    "26" = 76.3, "27" = 78.1, "28" = 80.2, "29" = 82.5, "30" = 84.7
  )
  lookup_tables$depressive_child <- c_depression_table
  lookup_tables$depressive_parent <- parent_depression_table
  
  # Physical Activity
    lookup_tables$physical_child <- c(
    "4" = 32.3, "5" = 37.3, "6" = 39.5, "7" = 41.4, "8" = 43.1,
    "9" = 44.6, "10" = 46.2, "11" = 47.7, "12" = 49.3, "13" = 51.0,
    "14" = 52.8, "15" = 54.6, "16" = 56.4, "17" = 58.3, "18" = 60.5,
    "19" = 63.3, "20" = 68.4
  )
  # PROMIS Parent Physical Activity Scale T-Score Conversion Table
  lookup_tables$physical_parent <- c(
    "4" = 31.3, "5" = 36.1, "6" = 38.1, "7" = 40.2, "8" = 41.9,
    "9" = 43.6, "10" = 45.3, "11" = 46.9, "12" = 48.6, "13" = 50.5,
    "14" = 52.5, "15" = 54.7, "16" = 56.9, "17" = 59.2, "18" = 61.8,
    "19" = 64.9, "20" = 69.7
  )
  
  # PROMIS Child Positive Affect Scale T-Score Conversion Table
  lookup_tables$positive_affect_child <- c(
    "4" = 22.0, "5" = 25.7, "6" = 28.0, "7" = 30.0, "8" = 31.8,
    "9" = 33.6, "10" = 35.4, "11" = 37.4, "12" = 39.5, "13" = 41.6,
    "14" = 43.8, "15" = 46.2, "16" = 48.7, "17" = 51.2, "18" = 53.8,
    "19" = 56.8, "20" = 63.0
  )
  # PROMIS Parent Positive Affect Scale T-Score Conversion Table
  lookup_tables$positive_affect_parent <- c(
    "4" = 16.8, "5" = 19.9, "6" = 22.3, "7" = 24.5, "8" = 26.5,
    "9" = 28.5, "10" = 30.8, "11" = 33.3, "12" = 36.1, "13" = 38.7,
    "14" = 41.3, "15" = 44.3, "16" = 48.3, "17" = 52.0, "18" = 54.9,
    "19" = 57.8, "20" = 63.8
  )
  
  # Psychological Stress
  # PROMIS Child Psychological Stress Scale T-Score Conversion Table
  lookup_tables$psychological_stress_child <- c(
    "4" = 39.5, "5" = 46.2, "6" = 49.4, "7" = 52.0, "8" = 54.2,
    "9" = 56.2, "10" = 58.0, "11" = 59.8, "12" = 61.6, "13" = 63.3,
    "14" = 65.0, "15" = 66.8, "16" = 68.5, "17" = 70.4, "18" = 72.4,
    "19" = 74.8, "20" = 78.4
  )
  lookup_tables$psychological_stress_parent <- c(
    "4" = 39.6, "5" = 46.8, "6" = 50.5, "7" = 53.4, "8" = 55.9,
    "9" = 58.3, "10" = 60.6, "11" = 62.9, "12" = 65.1, "13" = 67.1,
    "14" = 69.2, "15" = 71.1, "16" = 73.1, "17" = 75.0, "18" = 77.1,
    "19" = 79.5, "20" = 82.7
  )
  
  # Sleep Disturbance
  lookup_tables$sleep_disturbance_child  <- c(
    "8" = 36.6, "9" = 42.1, "10" = 44.8, "11" = 46.8, "12" = 48.5,
    "13" = 50.0, "14" = 51.3, "15" = 52.5, "16" = 53.7, "17" = 54.9,
    "18" = 56.0, "19" = 57.1, "20" = 58.2, "21" = 59.3, "22" = 60.3,
    "23" = 61.4, "24" = 62.4, "25" = 63.5, "26" = 64.5, "27" = 65.6,
    "28" = 66.6, "29" = 67.6, "30" = 68.7, "31" = 69.7, "32" = 70.7,
    "33" = 71.8, "34" = 72.9, "35" = 74.1, "36" = 75.4, "37" = 76.8,
    "38" = 78.5, "39" = 80.3, "40" = 82.7
  )
  # lookup_tables$sleep_disturbance_parent <- c(
  #   "8" = 38.7, "9" = 44.4, "10" = 47.3, "11" = 49.5, "12" = 51.4,
  #   "13" = 53.1, "14" = 54.7, "15" = 56.2, "16" = 57.7, "17" = 59.1,
  #   "18" = 60.5, "19" = 61.9, "20" = 63.3, "21" = 64.7, "22" = 66.2,
  #   "23" = 67.7, "24" = 69.2, "25" = 70.8, "26" = 72.5, "27" = 74.3,
  #   "28" = 76.2, "29" = 78.3, "30" = 80.5, "31" = 83.0, "32" = 85.7,
  #   "33" = 88.7, "34" = 91.9, "35" = 95.4, "36" = 99.2, "37" = 103.2,
  #   "38" = 107.5, "39" = 112.1, "40" = 116.9
  # )
  
  # Sleep Impairment
  # PROMIS Child Sleep Impairment Scale T-Score Conversion Table
  lookup_tables$sleep_impairment_child <- c(
    "8" = 37.4, "9" = 43.3, "10" = 45.9, "11" = 48.1, "12" = 49.7,
    "13" = 51.2, "14" = 52.5, "15" = 53.7, "16" = 54.8, "17" = 55.9,
    "18" = 57.0, "19" = 58.1, "20" = 59.2, "21" = 60.3, "22" = 61.5,
    "23" = 62.7, "24" = 63.9, "25" = 65.1, "26" = 66.2, "27" = 67.4,
    "28" = 68.6, "29" = 69.7, "30" = 70.9, "31" = 72.0, "32" = 73.1,
    "33" = 74.2, "34" = 75.4, "35" = 76.6, "36" = 78.0, "37" = 79.6,
    "38" = 81.4, "39" = 84.0
  )
  # lookup_tables$sleep_impairment_parent <- c(
  #   "8" = 37.9, "9" = 43.8, "10" = 47.0, "11" = 49.3, "12" = 51.2,
  #   "13" = 52.9, "14" = 54.5, "15" = 55.9, "16" = 57.3, "17" = 58.7,
  #   "18" = 60.0, "19" = 61.4, "20" = 62.7, "21" = 64.1, "22" = 65.5,
  #   "23" = 66.9, "24" = 68.4, "25" = 69.9, "26" = 71.5, "27" = 73.2,
  #   "28" = 75.0, "29" = 76.9, "30" = 79.0, "31" = 81.2, "32" = 83.6,
  #   "33" = 86.2, "34" = 89.0, "35" = 92.1, "36" = 95.4, "37" = 99.0
  # )
  
  # Peer Relationships
  # PROMIS Child Peer Relationships Scale T-Score Conversion Table
  lookup_tables$peer_child <- c(
    "8" = 17.68, "9" = 19.97, "10" = 21.43, "11" = 23.04, "12" = 24.40,
    "13" = 25.72, "14" = 26.94, "15" = 28.11, "16" = 29.24, "17" = 30.35,
    "18" = 31.43, "19" = 32.50, "20" = 33.55, "21" = 34.60, "22" = 35.64,
    "23" = 36.68, "24" = 37.72, "25" = 38.76, "26" = 39.82, "27" = 40.90,
    "28" = 41.99, "29" = 43.12, "30" = 44.27, "31" = 45.47, "32" = 46.71,
    "33" = 48.03, "34" = 49.43, "35" = 50.94, "36" = 52.64, "37" = 54.48,
    "38" = 56.82, "39" = 59.52, "40" = 64.44
  )
  # lookup_tables$peer_parent <- c(
  #   "7" = 15.0, "8" = 18.0, "9" = 20.0, "10" = 21.5, "11" = 23.0,
  #   "12" = 24.5, "13" = 26.0, "14" = 27.5, "15" = 29.0, "16" = 30.5,
  #   "17" = 32.0, "18" = 33.5, "19" = 35.0, "20" = 36.5, "21" = 38.0,
  #   "22" = 39.5, "23" = 41.0, "24" = 42.5, "25" = 44.0, "26" = 45.5,
  #   "27" = 47.0, "28" = 48.5, "29" = 50.0, "30" = 51.5, "31" = 53.0,
  #   "32" = 54.5, "33" = 56.0, "34" = 57.5, "35" = 59.0
  # )
  
  # Family Relationships
  # PROMIS Child Family Relationships Scale T-Score Conversion Table
    lookup_tables$family_child <- c(
      "8" = 17.9, "9" = 20.5, "10" = 22.3, "11" = 23.7, "12" = 25.0,
      "13" = 26.2, "14" = 27.2, "15" = 28.3, "16" = 29.3, "17" = 30.3,
      "18" = 31.2, "19" = 32.3, "20" = 33.3, "21" = 34.3, "22" = 35.4,
      "23" = 36.5, "24" = 27.6, "25" = 38.7, "26" = 39.8, "27" = 41.0,
      "28" = 42.1, "29" = 43.4, "30" = 44.4, "31" = 45.6, "32" = 46.8,
      "33" = 48.0, "34" = 49.3, "35" = 50.6, "36" = 52.1, "37" = 53.7,
      "38" = 55.7, "39" = 58.4, "40" = 63.9
    )
    
  # THIS IS THE ONE THAT NEEDS TO BE FIXED - ERIN CREATED NEW FORM
  # lookup_tables$family_parent <- c(
  #   "8" = 17.0, "9" = 19.3, "10" = 21.5, "11" = 23.5, "12" = 25.2,
  #   "13" = 26.8, "14" = 28.4, "15" = 29.9, "16" = 31.4, "17" = 32.8,
  #   "18" = 34.2, "19" = 35.6, "20" = 37.0, "21" = 38.4, "22" = 39.8,
  #   "23" = 41.2, "24" = 42.7, "25" = 44.2, "26" = 45.8, "27" = 47.6,
  #   "28" = 49.4, "29" = 51.5, "30" = 54.1, "31" = 57.4, "32" = 63.1
  # )
  
  # Anger
  # PROMIS Child Anger Scale T-Score Conversion Table
  lookup_tables$anger_child  <- c(
    "5" = 31.5, "6" = 36.4, "7" = 39.7, "8" = 42.5, "9" = 45.2,
    "10" = 47.6, "11" = 49.9, "12" = 52.1, "13" = 54.2, "14" = 56.3,
    "15" = 58.3, "16" = 60.3, "17" = 62.3, "18" = 64.3, "19" = 66.3,
    "20" = 68.4, "21" = 70.5, "22" = 72.6, "23" = 74.9, "24" = 77.5,
    "25" = 80.3
  )
  # PROMIS Parent Anger Scale T-Score Conversion Table
  lookup_tables$anger_parent <- c(
    "5" = 29, "6" = 34, "7" = 38, "8" = 41, "9" = 44,
    "10" = 47, "11" = 50, "12" = 53, "13" = 55, "14" = 58,
    "15" = 61, "16" = 63, "17" = 66, "18" = 68, "19" = 70,
    "20" = 73, "21" = 75, "22" = 77, "23" = 80, "24" = 82,
    "25" = 85
  )
  
  return(lookup_tables)
}


# Example usage:
# lookup_tables <- create_promis_lookup_tables()
# all_scores <- convert_all_to_tscores(scores = sd_df, lookup_tables = lookup_tables)