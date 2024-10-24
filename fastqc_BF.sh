#!/bin/bash
#SBATCH --job-name=fastqc_BF-%j
#SBATCH --cpus-per-task=16
#SBATCH --mem=10000
#SBATCH --time=00-00:30:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=thomas.pribasnig@univie.ac.at
#SBATCH --output=log/fastqc_BF-%j.out
#SBATCH --error=log/fastqc_BF-%j.err

#copy everything into TMP
cp ./trimmed_fastp/*trimmed.fastq.gz $TMPDIR

#switch to TMP
pushd $TMPDIR

#load whatever we need
module load fastqc
module load conda
conda activate multiqc
#we load the old module because the new one (v.) has a glitch that makes it so our script would take 8 days


fastqc ./*.gz -t 16

multiqc ./ -n trimmed_fastp_paired_multiqc

popd


cp  $TMPDIR/* /lisc/scratch/ecogenomics/pribasnig/Biofilm_NV_NF_NM/trimmed_fastp/fastqc_trimmed_fastp
rm -r $TMPDIR
