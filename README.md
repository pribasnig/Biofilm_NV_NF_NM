# Biofilm_NV_NF_NM
Transcriptomic study of N. viennensis, Ca. N. franklandianus and N. maritimus in biofilms compared to planktonic controls


Table of Contents
Transcriptomic Processing

Workflow_Information_for_Processing_Reads
Contains information on how to access transcriptomic data as well as programs and commands used to prepare data for DESeq2 (i.e. create the file cu_counts.txt).
cu_trim.sh
Script for trimming adapter sequences from raw reads using Trimmomatic.
cu_prinseq.sh
Script for filtering reads based on quality using PrinSeq-Lite.
cu_sortmerna.sh
Script for separating mRNA reads using SortMeRNA.
Nviennensis_rRNAs.fasta
Reference file for rRNA genes found in N. viennensis. Used with SortMeRNA.
cu_bowtie2.sh
Script for aligning reads to a genome using Bowtie2.
GCA_000698785.1_ASM69878v1_genomic.fna
N. viennensis genome used for Bowtie2.
cu_counts.sh
Script for counting reads matched genes using featurecounts.
GCA_000698785.1_ASM69878v1_genomic.gff
N. viennensis annotation file used for featurecounts.
cu_counts.txt
Text file used for input in DESeq2 after processing reads.
DESeq2_Commands.R
Commands used to process data in DESeq2 version 1.10.1.
rlog_mat.txt
Text file containig the rlog normalized reads of genes used to create the PCA plot of samples.
PCA_Plot_Script.R
R script used to create PCA plot of samples.
