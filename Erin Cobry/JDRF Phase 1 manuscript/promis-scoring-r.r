# PROMIS Scale Scoring Functions in R

#' Score a single PROMIS scale from raw responses
#' 
#' @param data A data frame containing PROMIS items
#' @param scale_name Character string indicating which scale to score
#' @param respondent Character string indicating 'child' or 'parent'
#' @return A numeric vector of raw scores
#' @export
score_promis_scale <- function(data, scale_name, respondent = "child") {
  # Define scale characteristics with exact variable patterns
  scale_items <- list(
    anger = list(
      child = list(pattern = "^a_(fedup|mad|upset|throwing|yelling)$", items = 5),
      parent = list(pattern = "^a_(mad|yelling|throwing|upset|angry)_parent$", items = 5)
    ),
    anxiety = list(
      child = list(pattern = "^a_(awful|nervous|scared|worried|worriedhm|scaredeasy|happen|bed)$", items = 8),
      parent = list(pattern = "^a_(nervous|scared|worried|awful|worriedhm|scaredeasy|happen|bed)_parent$", items = 8)
    ),
    depressive = list(
      child = list(pattern = "^ds_(sad|alone|wrong|right|lonely|sad2|unhappy|hard)$", items = 8),
      parent = list(pattern = "^ds_(sad|wrong|right|lonely|sad2|hard)_parent$", items = 6)
    ),
    family = list(
      child = list(pattern = "^fr_(strong|important|help|fun|feel|fair|listen|attention)$", items = 8),
      parent = list(pattern = "^fr_(strong|important|help|fun|feel|fair|listen|attention)_parent$", items = 8)
    ),
    peer = list(
      child = list(pattern = "^r_(accepted|count|talk|friends|help|friend|wantedbe|wantedtalk)$", items = 8),
      parent = list(pattern = "^r_(accepted|count|friends|help|friend|wantedbe|wantedtalk)_parent$", items = 7)
    ),
    physical = list(
      child = list(pattern = "^pa_(tired|exercise|breath|sweat)$", items = 4),
      parent = list(pattern = "^pa_(tired|exercise|breath|sweat)_parent$", items = 4)
    ),
    positive_affect = list(
      child = list(pattern = "^pa_(happy|great|cheerful|joyful)$", items = 4),
      parent = list(pattern = "^pa_(happy|great|cheerful|joyful)_parent$", items = 4)
    ),
    psychological_stress = list(
      child = list(pattern = "^ps_(stressed|problems|overwhelmed|manage)$", items = 4),
      parent = list(pattern = "^ps_(stressed|problems|overwhelmed|manage)_parent$", items = 4)
    ),
    sleep_disturbance = list(
      child = list(pattern = "^sd_(falling|night|problem|trouble|time|worried|fallingback|tossed)$", items = 8),
      parent = list(pattern = "^sd_(falling|night|problem|trouble|time|worried|fallingback|tossed)_parent$", items = 8)
    ),
    sleep_impairment = list(
      child = list(pattern = "^sri_(sleepy|concentrating|gtd|problems|awake|fun|eyes|mood)$", items = 8),
      parent = list(pattern = "^sri_(sleepy|concentrating|gtd|problems|awake|fun|eyes|mood)_parent$", items = 8)
    ),
    sleep_practices = list(
      child = list(pattern = "^(sp_(routine|tv|games|sleeptime|someone|electronic|waketime)|sleep_weekdays|wake_weekdays|sleep_weekends|wake_weekends)$", items = 11),
      parent = list(pattern = "^(sp_(routine|tv|games|sleeptime|someone|electronic|waketime)|sleep_weekdays|wake_weekdays|sleep_weekends|wake_weekends)_parent$", items = 11)
    ),
    life_satisfaction = list(
      child = list(pattern = "^ls_(satisfied|happy|good|wanted)$", items = 4),
      parent = NULL  # Parent version doesn't exist
    )
  )
  
  if (!scale_name %in% names(scale_items)) {
    stop(sprintf("Unknown scale: %s", scale_name))
  }
  
  scale_info <- scale_items[[scale_name]][[respondent]]
  if (is.null(scale_info)) {
    stop(sprintf("Scale %s is not available for %s respondent", scale_name, respondent))
  }
  
  # Get columns for this scale using exact pattern matching
  scale_cols <- grep(scale_info$pattern, names(data), value = TRUE)
  
  if (length(scale_cols) != scale_info$items) {
    stop(sprintf("Expected %d items for %s scale (%s version), found %d\nColumns found: %s", 
                 scale_info$items, scale_name, respondent, length(scale_cols),
                 paste(scale_cols, collapse = ", ")))
  }
  
  # Calculate raw score (mean of items * number of items)
  raw_score <- rowMeans(data[, scale_cols, drop = FALSE], na.rm = TRUE) * scale_info$items
  
  return(raw_score)
}

#' Convert raw scores to T-scores using lookup tables
#' 
#' @param raw_score Numeric vector of raw scores
#' @param scale_name Character string indicating which scale
#' @param lookup_table Named vector or list mapping raw scores to T-scores
#' @return Numeric vector of T-scores
#' @export
convert_to_tscore <- function(raw_score, scale_name, lookup_table = NULL) {
  if (is.null(lookup_table)) {
    return(raw_score)
  }
  
  # Match raw scores to T-scores using lookup table
  t_scores <- lookup_table[as.character(`T-score`)]
  names(t_scores) <- names(raw_score)
  
  return(t_scores)
}

#' Score all available PROMIS scales in the dataset
#' 
#' @param data A data frame containing PROMIS items
#' @param respondent Character string indicating 'child' or 'parent'
#' @return A data frame with raw scores for all available scales
#' @export
score_all_promis_scales <- function(data, respondent = "child") {
  # Initialize results data frame
  scores <- data.frame(row.names = rownames(data))
  
  # List of all possible scales
  scales <- c("anger", "anxiety", "depressive", "family", "peer",
              "physical", "positive_affect", "psychological_stress",
              "sleep_disturbance", "sleep_impairment", "sleep_practices")
  
  # Add life satisfaction for child respondent only
  if (respondent == "child") {
    scales <- c(scales, "life_satisfaction")
  }
  
  # Score each scale
  for (scale in scales) {
    tryCatch({
      scores[[paste0(scale, "_raw")]] <- score_promis_scale(data, scale, respondent)
    }, error = function(e) {
      warning(sprintf("Could not score %s scale: %s", scale, e$message))
    })
  }
  
  return(scores)
}

#' Validate responses for a PROMIS scale
#' 
#' @param data A data frame containing PROMIS items
#' @param scale_name Character string indicating which scale to validate
#' @param respondent Character string indicating 'child' or 'parent'
#' @return List with logical is_valid and character error_message
#' @export
validate_responses <- function(data, scale_name, respondent = "child") {
  # First try to get the scale columns using score_promis_scale pattern matching
  tryCatch({
    scale_cols <- names(score_promis_scale(data, scale_name, respondent))
    
    if (length(scale_cols) == 0) {
      return(list(
        is_valid = FALSE,
        error_message = sprintf("No items found for scale: %s", scale_name)
      ))
    }
    
    # Check for values outside valid range (1-5)
    values_in_range <- all(sapply(data[scale_cols], function(x) {
      all(x[!is.na(x)] %in% 1:5)
    }))
    
    if (!values_in_range) {
      return(list(
        is_valid = FALSE,
        error_message = "Response values must be between 1 and 5"
      ))
    }
    
    # Check for minimum number of responses (50% or more items)
    min_responses <- length(scale_cols) %/% 2
    response_counts <- rowSums(!is.na(data[scale_cols]))
    
    if (any(response_counts < min_responses)) {
      return(list(
        is_valid = FALSE,
        error_message = sprintf("At least %d items must be completed", min_responses)
      ))
    }
    
    return(list(
      is_valid = TRUE,
      error_message = "Responses are valid"
    ))
  }, error = function(e) {
    return(list(
      is_valid = FALSE,
      error_message = sprintf("Error validating scale: %s", e$message)
    ))
  })
}

# Example usage:
#
# # Load your data
# data <- read.csv("promis_responses.csv")
#
# # Score all scales for child respondent
# child_scores <- score_all_promis_scales(data, respondent = "child")
#
# # Score all scales for parent respondent
# parent_scores <- score_all_promis_scales(data, respondent = "parent")
#
# # Score specific scale
# anxiety_scores <- score_promis_scale(data, "anxiety", respondent = "child")
#
# # Validate responses
# validation <- validate_responses(data, "anxiety", respondent = "child")

