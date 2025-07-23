setwd(dirname(rstudioapi::getActiveDocumentContext()$path))  # Works in RStudio

# Load required libraries
library(readr)
library(dplyr)

# Load input data
NV_data <- read_csv("./NV_data_RERUN/ALL_NV_for_BF_genes.csv")
NF_data <- read_csv("./NF_data_RERUN/ALL_NF_for_BF_genes.csv")
NM_data <- read_csv("./NM_data_RERUN/ALL_NM_for_BF_genes.csv")

# Function to get top 50 genes by log2FC, filtered by expression rank
get_top_50_genes_filtered <- function(data) {
  data %>%
    arrange(desc(log2FC)) %>%
    slice_head(n = 50) %>%
    filter(`Rank TPM` <= 100)
}

# Get top genes per species
top_NV_genes_TP <- get_top_50_genes_filtered(NV_data)
top_NF_genes_TP <- get_top_50_genes_filtered(NF_data)
top_NM_genes_TP <- get_top_50_genes_filtered(NM_data)

# Extract protein families for each species
protein_fam_NV_only <- unique(top_NV_genes_TP$`Protein family LH`)
protein_fam_NF_only <- unique(top_NF_genes_TP$`Protein family LH`)
protein_fam_NM_only <- unique(top_NM_genes_TP$`Protein family LH`)

# Function to filter by protein family
filter_by_protein_family <- function(data, families) {
  data %>%
    filter(`Protein family LH` %in% families)
}

# Filter datasets by species-specific top protein families
filtered_NV_ONLY <- filter_by_protein_family(NV_data, protein_fam_NV_only)
filtered_NF_ONLY <- filter_by_protein_family(NF_data, protein_fam_NF_only)
filtered_NM_ONLY <- filter_by_protein_family(NM_data, protein_fam_NM_only)

# Combine and filter for meaningful log2FC
findings_TP_REVISED <- bind_rows(filtered_NV_ONLY, filtered_NF_ONLY, filtered_NM_ONLY) %>%
  filter(log2FC >= 1)

# Write result to file
write.csv(findings_TP_REVISED, "BF_genes.csv", row.names = FALSE)
