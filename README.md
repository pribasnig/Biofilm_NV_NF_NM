# Biofilm_NV_NF_NM
Transcriptomic study of N. viennensis, Ca. N. franklandianus and N. maritimus in biofilms compared to planktonic controls


## Table of Contents

## Transcriptomic Processing

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
  * counted 


