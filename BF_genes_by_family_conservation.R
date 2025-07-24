setwd("C:/Users/Pribasnig Thomas/Documents/BF_NV_NF_NM")
#Load required library
library(readr)
library(dplyr)

#This script take all the previously filtered data for sign. upregulated genes in NV, NF and NM and scans for multiple appearances of protein families.
#It will find the genes and produce a table that shows genes in all 3, in 2/3 and genes only in one of our species. 

NV_genes <- read_csv("./NV_data_RERUN/NV_BF_ctrl_significant_upregulated.csv")
NF_genes <- read_csv("./NF_data_RERUN/NF_BF_ctrl_significant_upregulated.csv")
NM_genes <- read_csv("./NM_data_RERUN/NM_BF_ctrl_significant_upregulated.csv")

NV_protein_families <- NV_genes$`Protein family LH`
NF_protein_families <- NF_genes$`Protein family LH`
NM_protein_families <- NM_genes$`Protein family LH`


# Find protein families in all three datasets
all_three_families <- intersect(intersect(NV_protein_families, NF_protein_families), NM_protein_families)

# Find protein families in NV and NF
nv_nf_families <- setdiff(intersect(NV_protein_families, NF_protein_families), all_three_families)

# Find protein families in NV and NM
nv_nm_families <- setdiff(intersect(NV_protein_families, NM_protein_families), all_three_families)

# Find protein families in NF and NM
nf_nm_families <- setdiff(intersect(NF_protein_families, NM_protein_families), all_three_families)

# Find protein families in only one dataset
only_NV_families <- setdiff(NV_protein_families, union(NF_protein_families, NM_protein_families))
only_NF_families <- setdiff(NF_protein_families, union(NV_protein_families, NM_protein_families))
only_NM_families <- setdiff(NM_protein_families, union(NV_protein_families, NF_protein_families))

#Combine the results into a single data frame

#Remove NA
all_three_families <- all_three_families[!grepl("#N/A", all_three_families)]

results <- data.frame(
  `Protein family LH` = c(all_three_families, nv_nf_families, nv_nm_families, nf_nm_families, only_NV_families, only_NF_families, only_NM_families),
  Occurrence = c(rep("All Three", length(all_three_families)),
                 rep("NV+NF", length(nv_nf_families)),
                 rep("NV+NM", length(nv_nm_families)),
                 rep("NF+NM", length(nf_nm_families)),
                 rep("Only NV", length(only_NV_families)),
                 rep("Only NF", length(only_NF_families)),
                 rep("Only NM", length(only_NM_families)))
)

write.csv(results, "upregulated_genes_by_protein_family.csv", row.names = FALSE)



#Extract info for the shared biofilm genes!
NV_3_info <- NV_genes[NV_genes$`Protein family LH` %in% all_three_families, ]
NF_3_info <- NF_genes[NF_genes$`Protein family LH` %in% all_three_families, ]
NM_3_info <- NM_genes[NM_genes$`Protein family LH` %in% all_three_families, ]

combined_info_all_3 <- rbind(NV_3_info, NF_3_info, NM_3_info)

write.csv(combined_info_all_3, "BF_genes_all_3_species_RERUN.csv", row.names = FALSE)


#NV#NF
NV_NVxNF_info <- NV_genes[NV_genes$`Protein family LH` %in% nv_nf_families, ]
NF_NVxNF_info <- NF_genes[NF_genes$`Protein family LH` %in% nv_nf_families, ]

combined_info_NVxNF <- rbind(NV_NVxNF_info, NF_NVxNF_info)

write.csv(combined_info_NVxNF, "BF_genes_NV+NF_conserved_RERUN.csv", row.names = FALSE)

#NVxNM

NV_NVxNM_info <- NV_genes[NV_genes$`Protein family LH` %in% nv_nm_families, ]
NM_NVxNM_info <- NM_genes[NM_genes$`Protein family LH` %in% nv_nm_families, ]

combined_info_NVxNM <- rbind(NV_NVxNM_info, NM_NVxNM_info)

write.csv(combined_info_NVxNM, "BF_genes_NV+NM_conserved_RERUN.csv", row.names = FALSE)


#NFxNM

NF_NFxNM_info <- NF_genes[NF_genes$`Protein family LH` %in% nf_nm_families, ]
NM_NFxNM_info <- NM_genes[NM_genes$`Protein family LH` %in% nf_nm_families, ]

combined_info_NFxNM <- rbind(NF_NFxNM_info, NM_NFxNM_info)

write.csv(combined_info_NFxNM, "BF_genes_NF+NM_conserved_RERUN.csv", row.names = FALSE)


#NVONLY

NV_ONLY <- NV_genes[NV_genes$`Protein family LH` %in% only_NV_families, ]

write.csv(NV_ONLY, "BF_genes_NV_ONLY_RERUN.csv", row.names = FALSE)

#NFONLY


NF_ONLY <- NF_genes[NF_genes$`Protein family LH` %in% only_NF_families, ]

write.csv(NF_ONLY, "BF_genes_NF_ONLY_RERUN.csv", row.names = FALSE)


#NMONLY

NM_ONLY <- NM_genes[NM_genes$`Protein family LH` %in% only_NM_families, ]

write.csv(NM_ONLY, "BF_genes_NM_ONLY_RERUN.csv", row.names = FALSE)
