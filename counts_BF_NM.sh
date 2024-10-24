#!/bin/bash
#SBATCH --job-name=counts_NM
#SBATCH --cpus-per-task=8
#SBATCH --mem=10000
#SBATCH --time=00-00:30:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=thomas.pribasnig@univie.ac.at
#SBATCH --output=log/counts_NM-%j.out
#SBATCH --error=log/counts_NM-%j.err

#copy the sam files and the genomefile in gff format into TMPDIR
mkdir ./counted_NM

module load samtools

cp ./hisat2_NM/*.bam.gz /$TMPDIR
cp ./genome_for_featurecounts/NM/Nmar.gff /$TMPDIR

pushd $TMPDIR

pigz -d -p $SLURM_CPUS_PER_TASK ./*.gz


ls -1 ./*.bam|while read filename;

#this runs the actual script again, we use strandness reverse since we are working with cDNA from RNA - this is the reverse from what the RNA would be like, we use the 

do

bin_name=`basename $filename|cut -f1-2 -d '_'`
echo "Processing $bin_name"

samtools sort -o ./$bin_name'_mRNA_sorted.bam' -O bam -@ $SLURM_CPUS_PER_TASK $filename

done

module load subread

featureCounts -p -a ./Nmar.gff -t gene -g ID -T $SLURM_CPUS_PER_TASK -o ./counts_NF_hisat_unstranded.txt -s 0 ./*_sorted.bam

popd

cp $TMPDIR/*.txt $TMPDIR/*.summary ./counted_NM

