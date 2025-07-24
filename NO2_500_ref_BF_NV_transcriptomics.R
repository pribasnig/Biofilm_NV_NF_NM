# In this script i want to calculate when a certain BF culture reaches NO2 of 1000 on average and compare that against a reference dataset 
#dataset of known innoculation volumina. I want to calculate then based on that the potential average innoculation volume!

#Load reference datasets
library(tidyverse)
library(dplyr)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))  # Works in RStudio

# Load combined dataset
combined_data <- read.csv("./combined_innoculation_reference_NV.csv") %>%
  na.omit()

# Function to interpolate the time at which NO2 reaches 500 µM
time_at_NO2_500 <- function(df) {
  interp <- approx(df$NO2, df$time, xout = 500, method = "linear")
  return(interp$y)
}

# Calculate interpolation results per replicate and dataset
results_ref <- combined_data %>%
  group_by(dataset, replicate) %>%
  summarize(time_at_NO2_500 = time_at_NO2_500(cur_data()), .groups = "drop") %>%
  na.omit()

# Summarize averages and SD per dataset
results_ref_averages <- results_ref %>%
  group_by(dataset) %>%
  summarize(
    average_time = mean(time_at_NO2_500),
    sd_time = sd(time_at_NO2_500),
    .groups = "drop"
  )


###

combined_data <- read.csv("./combined_transfers.csv")
combined_data <- na.omit(combined_data)

# Split data by transfer
dfsdata <- split(combined_data, combined_data$transfer)

# Loop over each data frame and calculate the time at which NO2 = 1000
results_list_data <- lapply(names(dfsdata), function(name) {
  df <- dfsdata[[name]]
  replicates <- unique(df$replicate)
  results_rep <- data.frame(replicate = replicates,
                            time_at_NO2_500 = numeric(length(replicates)))
  for (i in seq_along(replicates)) {
    rep <- replicates[i]
    df_rep <- dplyr::filter(df, replicate == rep)
    time <- time_at_NO2_500(df_rep)  # Your custom function
    results_rep$time_at_NO2_500[i] <- time
  }
  results_rep$dataset <- paste0("Transfer", name)
  return(results_rep)
})

# Combine all results
results_data <- do.call(rbind, results_list_data)
results_data <- na.omit(results_data)

# Calculate average + SD per transfer
results_data_averages <- results_data %>%
  group_by(dataset) %>%
  summarize(
    average_time = mean(time_at_NO2_500),
    sd_time = sd(time_at_NO2_500)
  )


write.csv(results_ref_averages, "./NV_innoculation_vol_to_500.csv", row.names = FALSE)


write.csv(results_data_averages, "./BF_to_500_NV.csv", row.names = FALSE)
#Now we would have to calculate from data how much the innoculation volume was


