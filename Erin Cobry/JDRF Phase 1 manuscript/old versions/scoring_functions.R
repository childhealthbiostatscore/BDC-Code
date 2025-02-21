library(readxl)
library(dplyr)

#################################################################
#                 PROMIS LIFE SATISFACTION                      #
#################################################################

score_promis_satisfaction <- function(data, 
                                      item1, 
                                      item2, 
                                      item3, 
                                      item4, 
                                      item5 = NULL, 
                                      t_scores_file = NULL) {
  # Validate that all specified item columns exist in the data
  items <- c(item1, item2, item3, item4)
  if (!is.null(item5)) items <- c(items, item5)
  
  missing_cols <- setdiff(items, names(data))
  if (length(missing_cols) > 0) {
    stop("The following columns are missing from the data: ", 
         paste(missing_cols, collapse = ", "))
  }
  
  # Determine if using 4-item or 5-item version
  is_4_item <- is.null(item5)
  
  # Create a data frame with just the items
  item_data <- data[items]
  
  # Ensure all items are numeric
  item_data <- lapply(item_data, as.numeric)
  item_data <- as.data.frame(item_data)
  
  # Calculate raw scores (sum will be NA if any item is NA)
  data$raw_score <- rowSums(item_data, na.rm = FALSE)
  
  # Load T-score conversion table
  load_t_scores <- function(file_path, is_4_item) {
    if (!is.null(file_path) && file.exists(file_path)) {
      tryCatch({
        # Read based on file extension
        if (grepl("\\.xlsx$|\\.xls$", file_path)) {
          scores_df <- read_excel(file_path, sheet = 1)
          # Convert to data.frame (read_excel returns tibble)
          scores_df <- as.data.frame(scores_df)
        } else if (grepl("\\.csv$", file_path)) {
          scores_df <- read.csv(file_path, stringsAsFactors = FALSE)
        } else {
          stop("Unsupported file format. Please use .xlsx, .xls, or .csv")
        }
        
        # Standardize column names
        names(scores_df) <- tolower(names(scores_df))
        
        # Validate columns
        if (!all(c("raw_score", "t_score") %in% names(scores_df))) {
          stop("T-scores file must contain columns: raw_score, t_score")
        }
        
        # Convert to numeric and handle missing values
        scores_df$raw_score <- as.numeric(scores_df$raw_score)
        scores_df$t_score <- as.numeric(scores_df$t_score)
        scores_df <- scores_df[complete.cases(scores_df[, c("raw_score", "t_score")]), ]
        
        return(scores_df)
        
      }, error = function(e) {
        warning("Error reading T-scores file: ", e$message, "\nUsing built-in scores instead.")
        return(get_default_t_scores(is_4_item))
      })
    } else {
      return(get_default_t_scores(is_4_item))
    }
  }
  
  # Get T-scores table
  t_scores <- load_t_scores(t_scores_file, is_4_item)
  
  # Merge T-scores with data
  scored_data <- merge(data, t_scores, by = "raw_score", all.x = TRUE)
  
  # Calculate percentiles (will be NA where t_score is NA)
  scored_data$percentile <- round(pnorm((scored_data$t_score - 50) / 10) * 100, 1)
  
  # Add interpretation
  scored_data$interpretation <- case_when(
    is.na(scored_data$t_score) ~ NA_character_,
    scored_data$t_score < 40 ~ "Much lower life satisfaction than average",
    scored_data$t_score < 45 ~ "Lower life satisfaction than average",
    scored_data$t_score < 55 ~ "Average life satisfaction",
    scored_data$t_score < 60 ~ "Higher life satisfaction than average",
    TRUE ~ "Much higher life satisfaction than average"
  )
  
  # Add version information
  scored_data$version <- if(is_4_item) "4-item" else "5-item"
  
  # Add mean score
  scored_data$mean_score <- rowMeans(item_data, na.rm = FALSE)
  
  return(scored_data)
}

# Helper function to provide default T-scores
get_default_t_scores <- function(is_4_item = FALSE) {
  if(is_4_item) {
    # T-scores for 4-item version
    data.frame(
      raw_score = 4:20,
      t_score = c(
        23.5, 27.5, 30.5, 33.0, 35.3, 37.4, 39.4, 41.3,
        43.2, 45.1, 47.1, 49.1, 51.2, 53.4, 55.8, 58.5, 61.8
      )
    )
  } else {
    # T-scores for 5-item version
    data.frame(
      raw_score = 5:25,
      t_score = c(
        21.3, 25.3, 28.3, 30.8, 33.0, 35.0, 36.9, 38.7, 40.5,
        42.3, 44.1, 46.0, 48.0, 50.0, 52.1, 54.2, 56.5, 58.9,
        61.5, 64.5, 68.0
      )
    )
  }
}

# Example usage:
# df <- data.frame(
#   id = 1:3,
#   q1 = c(4, 3, NA),
#   q2 = c(3, 4, 5),
#   q3 = c(5, 3, 4),
#   q4 = c(4, 5, 3),
#   q5 = c(3, 4, 5)
# )
#
# # Score 5-item version with custom column names
# results <- score_promis_satisfaction(
#   data = df,
#   item1 = "q1",
#   item2 = "q2",
#   item3 = "q3",
#   item4 = "q4",
#   item5 = "q5"
# )
#
# # Score 4-item version
# results_4item <- score_promis_satisfaction(
#   data = df,
#   item1 = "q1",
#   item2 = "q2",
#   item3 = "q3",
#   item4 = "q4"
# )

#################################################################
#               PROMIS CHILD PHYSICAL ACTIVITY                  #
#################################################################
library(readxl)
library(dplyr)

score_promis_activity_child <- function(data, 
                                        item1,  # "I could do sports and exercise that other kids my age could do"
                                        item2,  # "I could do physical activities like running"
                                        item3,  # "I could keep up when I played with other kids"
                                        item4,  # "I could do physical activities or exercise without getting tired quickly",
                                        t_scores_file = NULL) {
  
  # Validate that all specified item columns exist in the data
  items <- c(item1, item2, item3, item4)
  missing_cols <- setdiff(items, names(data))
  if (length(missing_cols) > 0) {
    stop("The following columns are missing from the data: ", 
         paste(missing_cols, collapse = ", "))
  }
  
  # Create a data frame with just the items
  item_data <- data[items]
  
  # Ensure all items are numeric
  item_data <- lapply(item_data, as.numeric)
  item_data <- as.data.frame(item_data)
  
  # Validate response ranges
  invalid_responses <- sapply(item_data, function(x) any(!is.na(x) & (x < 1 | x > 5)))
  if (any(invalid_responses)) {
    invalid_cols <- names(invalid_responses)[invalid_responses]
    stop("Invalid responses found in columns: ", 
         paste(invalid_cols, collapse = ", "), 
         ". All responses must be between 1 and 5.")
  }
  
  # Calculate raw scores (sum will be NA if any item is NA)
  data$raw_score <- rowSums(item_data, na.rm = FALSE)
  
  # Load T-score conversion table
  load_t_scores <- function(file_path) {
    if (!is.null(file_path) && file.exists(file_path)) {
      tryCatch({
        # Read based on file extension
        if (grepl("\\.xlsx$|\\.xls$", file_path)) {
          scores_df <- read_excel(file_path, sheet = 1)
          # Convert to data.frame (read_excel returns tibble)
          scores_df <- as.data.frame(scores_df)
        } else if (grepl("\\.csv$", file_path)) {
          scores_df <- read.csv(file_path, stringsAsFactors = FALSE)
        } else {
          stop("Unsupported file format. Please use .xlsx, .xls, or .csv")
        }
        
        # Standardize column names
        names(scores_df) <- tolower(names(scores_df))
        
        # Validate columns
        if (!all(c("raw_score", "t_score") %in% names(scores_df))) {
          stop("T-scores file must contain columns: raw_score, t_score")
        }
        
        # Convert to numeric and handle missing values
        scores_df$raw_score <- as.numeric(scores_df$raw_score)
        scores_df$t_score <- as.numeric(scores_df$t_score)
        scores_df <- scores_df[complete.cases(scores_df[, c("raw_score", "t_score")]), ]
        
        return(scores_df)
        
      }, error = function(e) {
        warning("Error reading T-scores file: ", e$message, "\nUsing built-in scores instead.")
        return(get_default_t_scores())
      })
    } else {
      return(get_default_t_scores())
    }
  }
  
  # Get T-scores table
  t_scores <- load_t_scores(t_scores_file)
  
  # Merge T-scores with data
  scored_data <- merge(data, t_scores, by = "raw_score", all.x = TRUE)
  
  # Calculate percentiles (will be NA where t_score is NA)
  scored_data$percentile <- round(pnorm((scored_data$t_score - 50) / 10) * 100, 1)
  
  # Add interpretation
  scored_data$interpretation <- case_when(
    is.na(scored_data$t_score) ~ NA_character_,
    scored_data$t_score < 30 ~ "Much lower physical activity than average",
    scored_data$t_score < 40 ~ "Lower physical activity than average",
    scored_data$t_score < 60 ~ "Average physical activity",
    scored_data$t_score < 70 ~ "Higher physical activity than average",
    TRUE ~ "Much higher physical activity than average"
  )
  
  # Add mean score
  scored_data$mean_score <- rowMeans(item_data, na.rm = FALSE)
  
  return(scored_data)
}

# Helper function to provide default T-scores for 4-item version
get_default_t_scores <- function() {
  data.frame(
    raw_score = 4:20,  # Possible raw scores for 4 items scored 1-5
    t_score = c(
      20.0, 25.4, 29.6, 33.0, 35.8, 38.3, 40.6, 42.8, 45.0,
      47.1, 49.3, 51.5, 53.8, 56.2, 58.9, 62.1, 66.0
    )
  )
}

# Example usage:
# df <- data.frame(
#   id = 1:3,
#   pa1 = c(4, 3, NA),   # could do sports and exercise
#   pa2 = c(5, 4, 4),    # could do activities like running
#   pa3 = c(4, 5, 3),    # could keep up when playing
#   pa4 = c(3, 4, 5)     # could exercise without getting tired
# )
#
# # Score with default column names
# results <- score_promis_activity_child(
#   data = df,
#   item1 = "pa1",
#   item2 = "pa2",
#   item3 = "pa3",
#   item4 = "pa4"
# )
#
# # Print results
# print(results)

#################################################################
#              PROMIS PARENT PHYSICAL ACTIVITY                  #
#################################################################

library(readxl)
library(dplyr)

score_promis_activity_parent <- function(data, 
                                         item1,  # "My child could do sports and exercise that other children his/her age could do"
                                         item2,  # "My child could do physical activities like running"
                                         item3,  # "My child could keep up when playing with other children"
                                         item4,  # "My child could do physical activities or exercise without getting tired quickly"
                                         t_scores_file = NULL) {
  
  # Validate that all specified item columns exist in the data
  items <- c(item1, item2, item3, item4)
  missing_cols <- setdiff(items, names(data))
  if (length(missing_cols) > 0) {
    stop("The following columns are missing from the data: ", 
         paste(missing_cols, collapse = ", "))
  }
  
  # Create a data frame with just the items
  item_data <- data[items]
  
  # Ensure all items are numeric
  item_data <- lapply(item_data, as.numeric)
  item_data <- as.data.frame(item_data)
  
  # Validate response ranges
  invalid_responses <- sapply(item_data, function(x) any(!is.na(x) & (x < 1 | x > 5)))
  if (any(invalid_responses)) {
    invalid_cols <- names(invalid_responses)[invalid_responses]
    stop("Invalid responses found in columns: ", 
         paste(invalid_cols, collapse = ", "), 
         ". All responses must be between 1 and 5.")
  }
  
  # Calculate raw scores (sum will be NA if any item is NA)
  data$raw_score <- rowSums(item_data, na.rm = FALSE)
  
  # Load T-score conversion table
  load_t_scores <- function(file_path) {
    if (!is.null(file_path) && file.exists(file_path)) {
      tryCatch({
        # Read based on file extension
        if (grepl("\\.xlsx$|\\.xls$", file_path)) {
          scores_df <- read_excel(file_path, sheet = 1)
          # Convert to data.frame (read_excel returns tibble)
          scores_df <- as.data.frame(scores_df)
        } else if (grepl("\\.csv$", file_path)) {
          scores_df <- read.csv(file_path, stringsAsFactors = FALSE)
        } else {
          stop("Unsupported file format. Please use .xlsx, .xls, or .csv")
        }
        
        # Standardize column names
        names(scores_df) <- tolower(names(scores_df))
        
        # Validate columns
        if (!all(c("raw_score", "t_score") %in% names(scores_df))) {
          stop("T-scores file must contain columns: raw_score, t_score")
        }
        
        # Convert to numeric and handle missing values
        scores_df$raw_score <- as.numeric(scores_df$raw_score)
        scores_df$t_score <- as.numeric(scores_df$t_score)
        scores_df <- scores_df[complete.cases(scores_df[, c("raw_score", "t_score")]), ]
        
        return(scores_df)
        
      }, error = function(e) {
        warning("Error reading T-scores file: ", e$message, "\nUsing built-in scores instead.")
        return(get_default_t_scores())
      })
    } else {
      return(get_default_t_scores())
    }
  }
  
  # Get T-scores table
  t_scores <- load_t_scores(t_scores_file)
  
  # Merge T-scores with data
  scored_data <- merge(data, t_scores, by = "raw_score", all.x = TRUE)
  
  # Calculate percentiles (will be NA where t_score is NA)
  scored_data$percentile <- round(pnorm((scored_data$t_score - 50) / 10) * 100, 1)
  
  # Add interpretation
  scored_data$interpretation <- case_when(
    is.na(scored_data$t_score) ~ NA_character_,
    scored_data$t_score < 30 ~ "Much lower physical activity than average",
    scored_data$t_score < 40 ~ "Lower physical activity than average",
    scored_data$t_score < 60 ~ "Average physical activity",
    scored_data$t_score < 70 ~ "Higher physical activity than average",
    TRUE ~ "Much higher physical activity than average"
  )
  
  # Add mean score
  scored_data$mean_score <- rowMeans(item_data, na.rm = FALSE)
  
  return(scored_data)
}

# Helper function to provide default T-scores for 4-item parent proxy version
get_default_t_scores <- function() {
  data.frame(
    raw_score = 4:20,  # Possible raw scores for 4 items scored 1-5
    t_score = c(
      21.7, 27.1, 31.0, 34.0, 36.6, 38.9, 41.1, 43.2, 45.3,
      47.3, 49.4, 51.5, 53.7, 56.1, 58.8, 61.9, 65.8
    )
  )
}

# Example usage:
# df <- data.frame(
#   id = 1:3,
#   pa1 = c(4, 3, NA),   # could do sports and exercise
#   pa2 = c(5, 4, 4),    # could do activities like running
#   pa3 = c(4, 5, 3),    # could keep up when playing
#   pa4 = c(3, 4, 5)     # could exercise without getting tired
# )
#
# # Score with custom column names
# results <- score_promis_activity_parent(
#   data = df,
#   item1 = "pa1",
#   item2 = "pa2",
#   item3 = "pa3",
#   item4 = "pa4"
# )
#
# # Print results
# print(results)