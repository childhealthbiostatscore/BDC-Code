# Sensor glucose column must be called "sensorglucose" (without quotes).
# Datetime column must be called "timestamp" (again without quotes) and be in 
# POSIXct format (easiest to do using the lubridate package). 
# Capitalization does not matter. 

# Function arguments come from: 
# Baysal, N. (2014). A novel method to detect pressure-induced sensor 
# attenuations (PISA) in an artificial pancreas. Journal of Diabetes Science 
# and Technology, 8(6), 1091–1096. https://doi.org/10.1177/1932296814553267

# This function requires Kalman Filter-based estimated glucose.

pisa_detection <- function(data,t_pisa_max = Inf,t_dropout = 60,
                           g_p_in = -1.9,g_p_ratio = 1.2,g_p_out = -2.8) {
  df <- data
  df$pisa <- NA
  # Format column names and columns
  colnames(df) <- tolower(colnames(df))
  # Delete missing rows
  df <- df[!is.na(df$sensorglucose),]
  # Iterate through sensor values
  g_p_km1 <- 0
  n_pisa <- 0
  for (k in 3:nrow(df)) {
    # Glucose readings and times
    g_k <- df$sensorglucose[k]
    g_km1 <- df$sensorglucose[k-1]
    t_k <- df$timestamp[k]
    t_km1 <- df$timestamp[k-1]
    # Rate of change
    g_p_k <- (g_k - g_km1)/(as.numeric(t_k - t_km1))
    # Check for PISA start
    if ((g_p_k < g_p_in) & 
        (g_p_k/g_p_km1 > g_p_ratio | g_p_km1 > 0)) {
      df$pisa[k] <- "start"
    }
    # Count number of readings in PISA
    if (n_pisa > 0){n_pisa <- n_pisa + 1}
    # Set previous gpkm1
    g_p_km1 <- g_p_k
    # Check for PISA end
    t_k_n_pisa <- df$timestamp[k-n_pisa]
    if (as.numeric(t_km1 - t_k_n_pisa) > t_pisa_max | 
        as.numeric(t_k - t_km1) >= t_dropout |
        (g_p_k > g_p_out)){}
    # Reset at end of PISA
    if (!is.na(df$pisa[k] == "end")) {
      g_p_km1 <- 0
      n_pisa <- 0
      }
  }
}