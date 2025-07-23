

library(DESeq2)
#loads DESeg2 versions
setwd("C:/Users/Pribasnig Thomas/Documents/BF_NV_NF_NM/NF_data_RERUN")

BF_counts <- read.table("./counts_NF_hisat_PE_RERUN.txt", header = TRUE, row.names =1)
BF_counts[,1:5] <- NULL

nvr_columns <- data.frame(row.names=c("NF_BF1","NF_BF2","NF_BF3","NF_BF4","NF_BF5","NF_Ctrl1","NF_Ctrl2","NF_Ctrl3","NF_Ctrl4","NF_Ctrl5"),nvr_con=as.factor(c(rep("NF_BF",5),rep("NF_Ctrl",5))))

colnames(BF_counts) <- row.names(nvr_columns)


ddsNVR <- DESeqDataSetFromMatrix(countData=BF_counts, colData = nvr_columns, design = ~ nvr_con)
#creates matix as input for DESeq
#Rename the coloumns to something more recognizable (done 10x respectively).

#Perform the DESeq2 analysis (uses a different normalization than the one used earlier for the PCA plot). 
DEanalysis_NVR <- DESeq(ddsNVR)

#Compile results of the BF condition vs. the BR Condtion. 
diff_BF_BR <- results(DEanalysis_NVR, contrast=c("nvr_con", "NF_BF", "NF_Ctrl"))

#Make a text file of the DESeq2 results. 
write.table(diff_BF_BR, file="NF_BF_Control_differential_expression.txt", sep = "\t")

#Results can be found in Dataset_S1.xlsx in the tab "DESeq2_Output".

###Citations

#DESeq2
#Love MI, Huber W, Anders S. Moderated estimation of fold change and  dispersion for RNA-seq data with DESeq2. Genome Biol 2014; 15: 550. 

