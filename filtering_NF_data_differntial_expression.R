setwd("C:/Users/Pribasnig Thomas/Documents/BF_NV_NF_NM/NF_data_RERUN")
#Load required library
library(readr)
library(dplyr)

# Read the CSV file
data <- read_csv("NF_for_filtering_in_R.csv")
data <- data[complete.cases(data$log2FoldChange), ]

# Filter rows with padj > 0.001
data_filtered <- data[data$padj < 0.001, ]

# Filter rows with TPM BF < 100
data_filtered <- data_filtered[data_filtered$`TPM BF` >= 10 | data_filtered$`TPM Ctrl` >= 10, ]

# Sort by log2FoldChange
data_sorted <- data_filtered[order(data_filtered$log2FC, decreasing = TRUE), ]

sig_up <- data_sorted[data_sorted$log2FC >= 1, ]

sig_down <- data_sorted[data_sorted$log2FC <= -1, ]

write.csv(sig_up, "NF_BF_ctrl_significant_upregulated.csv", row.names = FALSE)
write.csv(sig_down, "NF_BF_ctrl_significant_downregulated.csv", row.names = FALSE)


# Write out the new table
write.csv(data_sorted, "NF_BF_Control_diffenetial_expression_filtered.csv", row.names = FALSE)


