#!/bin/bash
#SBATCH --job-name=sortmeRNA_NV-%j
#SBATCH --cpus-per-task=8
#SBATCH --mem=2000
#SBATCH --time=00-03:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=thomas.pribasnig@univie.ac.at
#SBATCH --output=log/sortmeRNA_NV-%j.out
#SBATCH --error=log/sortmeRNA_NV-%j.err

#copy everything into TMP
cp ./trimmed_fastp_adapter_forced/Nfran*_trimmed.fastq.gz $TMPDIR
cp ./rRNA_for_Index/Nfran_rRNA.fasta $TMPDIR

#switch to TMP
pushd $TMPDIR

#load whatever we need
module load sortmerna
module load fastqc
module load conda
conda activate multiqc
#we load the old module because the new one (v.) has a glitch that makes it so our script would take 8 days

#make all direcotries
mkdir sorted_NF

mkdir sorted_NF/rRNA
mkdir sorted_NF/mRNA
mkdir sorted_NF/mRNA/fastqc_sorted_mRNA
mkdir sorted_NF/mRNA/multiqc_sorted_mRNA

#here we build an Index, the sequences we use to compare (16s from )

#unzip the filtered files
pigz -d -p 8 ./*.fastq.gz

#
for r1_file in *-R1_trimmed.fastq; do
    # Extract sample name
    sample_name=$(basename "$r1_file" | cut -f1 -d '-')
    echo "Processing $sample_name"

    # Construct corresponding R2 file name
    r2_file="${sample_name}-R2_trimmed.fastq"
sortmerna --ref ./Nviennensis_rRNAs.fasta --reads "$r1_file" --reads "$r2_file" --aligned ./sorted_NF/rRNA/"${sample_name}_rRNA" --other ./sorted_NF/mRNA/"${sample_name}_mRNA" --fastx --paired_out --threads 8 --workdir ./run/	

echo "Finished processing $sample_name"

rm -r ./run
done


pigz -p 8 ./sorted_NF/rRNA/*.fq 
pigz -p 8 ./sorted_NF/mRNA/*.fq 


popd


cp -r $TMPDIR/sorted_NF /lisc/scratch/ecogenomics/pribasnig/Biofilm_NV_NF_NM
rm -r $TMPDIR
