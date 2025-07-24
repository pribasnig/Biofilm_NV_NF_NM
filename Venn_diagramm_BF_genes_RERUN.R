setwd("C:/Users/Pribasnig Thomas/Documents/BF_NV_NF_NM")
#Load required library
if (!requireNamespace("VennDiagram", quietly = TRUE)) {
  install.packages("VennDiagram")
}
library(VennDiagram)
library(grid)
library(readr)
#This script take all the previously filtered data for sign. upregulated genes in NV, NF and NM and scans for multiple appearances of protein families.
#It will find the genes and produce a table that shows genes in all 3, in 2/3 and genes only in one of our species. Those are the biofilm genes!

data_for_Venn <- read_csv("./BF_genes_RERUN/BF_genes_by_protein_family_LH.csv")
# Create a named vector with counts for each category
sets_list <- list()

# Define the sets
sets_list$NV <- data_for_Venn$Protein.family.LH[data_for_Venn$Occurrence %in% c("All Three", "NV+NF", "NV+NM", "Only NV")]
sets_list$NF <- data_for_Venn$Protein.family.LH[data_for_Venn$Occurrence %in% c("All Three", "NV+NF", "NF+NM", "Only NF")]
sets_list$NM <- data_for_Venn$Protein.family.LH[data_for_Venn$Occurrence %in% c("All Three", "NV+NM", "NF+NM", "Only NM")]


# Add placeholder for NF+NM if it's missing to ensure it appears in the Venn diagram
if (length(intersect(sets_list$NF, sets_list$NM)) == 0) {
  sets_list$NF <- c(sets_list$NF, "Placeholder")
  sets_list$NM <- c(sets_list$NM, "Placeholder")
}

# Create the Venn diagram
venn.plot <- venn.diagram(
  x = sets_list,
  category.names = c("NV", "NF", "NM"),
  filename = NULL,
  col = c("darkgreen", "#8B4513", "darkblue"),  # Change colors here
  fill = c(adjustcolor("darkgreen", alpha.f = 0.5), adjustcolor("#8B4513", alpha.f = 0.5), adjustcolor("darkblue", alpha.f = 0.5)),  # Shaded fill colors with transparency
  alpha = 0.5,
  cex = 2,
  cat.cex = 2,
  cat.col = c("darkgreen", "#8B4513", "darkblue"),  # Match category text colors
  main = "Upregulated genes under BF conditions based on protein families",
  main.cex = 2,
  lwd = 4  # Adjust line width for thicker circles
)

# Plot the Venn diagram
grid.draw(venn.plot) 