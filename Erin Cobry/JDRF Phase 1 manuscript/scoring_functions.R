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
                                        item2,  # "I had trouble doing sports or exercise"
                                        item3,  # "I could do physical activities like running"
                                        item4,  # "I could do physical activities like riding a bike"
                                        item5,  # "I could keep up when I played with other kids"
                                        item6,  # "I could move my body quickly"
                                        item7,  # "I could run a mile without stopping"
                                        item8,  # "I could do physical activities or exercise without getting tired quickly"
                                        t_scores_file = NULL) {
  
  # Validate that all specified item columns exist in the data
  items <- c(item1, item2, item3, item4, item5, item6, item7, item8)
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
  
  # Reverse score item2 (negative item)
  # Original scoring: Never (5), Almost Never (4), Sometimes (3), Often (2), Almost Always (1)
  # After reverse: Never (1), Almost Never (2), Sometimes (3), Often (4), Almost Always (5)
  item_data[[item2]] <- 6 - item_data[[item2]]
  
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

# Helper function to provide default T-scores for 8-item version
get_default_t_scores <- function() {
  data.frame(
    raw_score = 8:40,  # Possible raw scores for 8 items scored 1-5
    t_score = c(
      20.0, 24.4, 27.8, 30.3, 32.3, 34.0, 35.6, 37.0, 38.3,
      39.6, 40.8, 42.0, 43.2, 44.4, 45.6, 46.8, 48.0, 49.2,
      50.4, 51.7, 53.0, 54.3, 55.8, 57.3, 58.9, 60.7, 62.6,
      64.8, 67.2, 70.0, 73.3, 77.2, 80.0
    )
  )
}

# Example usage:
# df <- data.frame(
#   id = 1:3,
#   pa1 = c(4, 3, NA),   # could do sports and exercise
#   pa2 = c(2, 1, 2),    # trouble doing sports (reverse scored)
#   pa3 = c(5, 3, 4),    # could do activities like running
#   pa4 = c(4, 5, 3),    # could do activities like riding a bike
#   pa5 = c(3, 4, 5),    # could keep up with other kids
#   pa6 = c(4, 3, 4),    # could move quickly
#   pa7 = c(3, 4, 5),    # could run a mile
#   pa8 = c(4, 3, 4)     # could exercise without getting tired
# )
#
# # Score with default column names
# results <- score_promis_activity_child(
#   data = df,
#   item1 = "pa1",
#   item2 = "pa2",
#   item3 = "pa3",
#   item4 = "pa4",
#   item5 = "pa5",
#   item6 = "pa6",
#   item7 = "pa7",
#   item8 = "pa8"
# )
#
# # Print results
# print(results)
