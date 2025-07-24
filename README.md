# Biofilm_NV_NF_NM
Transcriptomic study of N. viennensis, Ca. N. franklandianus and N. maritimus in biofilms compared to planktonic controls


## Table of Contents

## 1. Transcriptomic Processing in batch

 *  fastqc_BF.sh
  * script for initial quality check

* trim_BF.sh
  * script to trim sequences

* sort_me_RNA_NV.sh
  * scripts to sort RNA into mRNA and rRNA

* sort_me_RNA_NF.sh
  * scripts to sort RNA into mRNA and rRNA

* sort_me_RNA_NM.sh
  * scripts to sort RNA into mRNA and rRNA

* Nviennensis_rRNAs.fasta
  * Reference file for rRNA NV

* Nfran_rRNA.fasta
  * Reference file for rRNA NF

* Nmar_rRNA.fasta
  * Reference file for rRNA NM


* hisat2_BF_NV.sh
  * script to align RNA to genome

* hisat2_BF_NF.sh
  * script to align RNA to genome

* hisat2_BF_NM.sh
  * script to align RNA to genome


* GCA_000698785.1_ASM69878v1_genomic.fna
  * N. viennensis genome file used for hisat2

* GCF_900696045.1_Nitrosocosmicus_franklandus_C13_genomic.fna
  * N. franklandianus genome file used for hisat2

* GCF_000018465.1_ASM1846v1_genomic.fna
  * N. maritimus genome file used for hisat2

* counts_BF_NV.sh
  * Script for counting reads matched genes using featurecounts

* counts_BF_NF.sh
  * Script for counting reads matched genes using featurecounts

* counts_BF_NM.sh
  * Script for counting reads matched genes using featurecounts


* GCA_000698785.1_ASM69878v1_genomic.gff
  * N. viennensis annotation file Genbank for feature counts

* Nfran.gff
  * N. franklandianus annotation file RefSeq for feature counts

* Nmar.gff
  * N. maritimus annotation file RefSeq for feature counts

* counts_NV_hisat.txt
  *  file used for input in DESeq2 after processing reads 

* counts_NF_hisat.txt
  *  file used for input in DESeq2 after processing reads  

* counts_NM_hisat.txt
  *  file used for input in DESeq2 after processing reads  


## 2. Analysis in R

*  analysis_DESeq_NV_RERUN.R
   * Runs differential expression analysis with DESeq2.

*  analysis_DESeq_NF_RERUN.R
   * Runs differential expression analysis with DESeq2.

* analysis_DESeq_NM_RERUN.R
   * Runs differential expression analysis with DESeq2.

* counts_NV_hisat_PE_RERUN.txt
   * File for expression analysis with DESeq2.
    
* counts_NF_hisat_PE_RERUN.txt
   * File for expression analysis with DESeq2.
     
* counts_NM_hisat_PE_RERUN.txt
   * File for expression analysis with DESeq2.
     
 
 * counts_NV_hisat_PE_RERUN_TPM_calc.xlsx
   * File that contains calculation for TPM and log2TPM for NV.
    
* counts_NF_hisat_PE_RERUN_TPM_calc.xlsx
   * File that contains calculation for TPM and log2TPM for NF.
     
* counts_NM_hisat_PE_RERUN_TPM_calc.xlsx
   * File that contains calculation for TPM and log2TPM for NM.


 * PCA_plot_analysis_NV_RERUN.R
   * Performs PCA and PERMANOVA on rlog-transformed RNA-seq data. 
    
* PCA_plot_analysis_NF_RERUN.R
   * Performs PCA and PERMANOVA on rlog-transformed RNA-seq data. 
     
* PCA_plot_analysis_NM_RERUN.R
   * Performs PCA and PERMANOVA on rlog-transformed RNA-seq data.


* filtering_NV_data_differntial_expression.R
   * Script that filters significantly differentially expressed genes. 
    
* filtering_NV_data_differntial_expression.R
   * Script that filters significantly differentially expressed genes.  
     
* filtering_NV_data_differntial_expression.R
   * Script that filters significantly differentially expressed genes.

* NV_for_filtering_in_R_LH.csv
   * file to filter 
    
* NF_for_filtering_in_R_LH.csv
   * file to filter
     
* NM_for_filtering_in_R_LH.csv
   * file to filter

* BF_genes_by_family_conservation.R
   * takes file with significantly upregulated genes and checks for genes upregualted in all combinations of the 3 transcriptomes.  Conservation based on protein family.
 
* BF_genes_by_protein_family_LH.csv
  * manually curated file containing information on conserved upregulation in the 3 transcriptomes.

* Venn_diagramm_BF_genes_RERUN.R
  * script that builds a Venn diagramm showing overlaps of conversedly upregualted genes based on protein family.



 
 
* BF_gene_finder_TOP50.R
   * Selects top 50 upregulated genes per species, filters for highly expressed ones (Rank TPM ≤ 100), and extracts all members of their protein families from the respective species.

* HFX_list.txt
   * All protein family information for AOA
 
    
* ALL_NV_for_BF_genes.csv
   * Manually curated file containing NV RNA-seq data and TPM data and protein family information to find bona fide BF genes.
    
* ALL_NF_for_BF_genes.csv
   * Manually curated file containing NF RNA-seq data, TPM data and protein family information to find bona fide BF genes.. 
     
* ALL_NM_for_BF_genes.csv
   * Manually curated file containing NM RNA-seq data, TPM data and protein family information to find bona fide BF genes.





