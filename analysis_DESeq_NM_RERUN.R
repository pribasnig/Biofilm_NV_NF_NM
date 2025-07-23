

library(DESeq2)
#loads DESeg2 versions
setwd("C:/Users/Pribasnig Thomas/Documents/BF_NV_NF_NM/NM_data_RERUN")

BF_counts <- read.table("./counts_NM_PE_RERUN.txt", header = TRUE, row.names =1)
BF_counts[,1:5] <- NULL

nvr_columns <- data.frame(row.names=c("NM_BF1","NM_BF2","NM_BF3","NM_BF4","NM_Ctrl1","NM_Ctrl2","NM_Ctrl3","NM_Ctrl4","NM_Ctrl5"),nvr_con=as.factor(c(rep("NM_BF",4),rep("NM_Ctrl",5))))

colnames(BF_counts) <- row.names(nvr_columns)


ddsNVR <- DESeqDataSetFromMatrix(countData=BF_counts, colData = nvr_columns, design = ~ nvr_con)
#creates matix as input for DESeq
#Rename the coloumns to something more recognizable (done 10x respectively).

#Perform the DESeq2 analysis (uses a different normalization than the one used earlier for the PCA plot). 
DEanalysis_NVR <- DESeq(ddsNVR)

#Compile results of the BF condition vs. the BR Condtion. 
diff_BF_BR <- results(DEanalysis_NVR, contrast=c("nvr_con", "NM_BF", "NM_Ctrl"))

#Make a text file of the DESeq2 results. 
write.table(diff_BF_BR, file="NM_BF_Control_differential_expression.txt", sep = "\t")

#Results can be found in Dataset_S1.xlsx in the tab "DESeq2_Output".

###Citations

#DESeq2
#Love MI, Huber W, Anders S. Moderated estimation of fold change and  dispersion for RNA-seq data with DESeq2. Genome Biol 2014; 15: 550. 

