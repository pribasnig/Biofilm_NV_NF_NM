#!/bin/bash
#SBATCH --job-name=hisat2_NF-%j
#SBATCH --cpus-per-task=4
#SBATCH --mem=2000
#SBATCH --time=00-02:30:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=thomas.pribasnig@univie.ac.at
#SBATCH --output=log/hisat2_NF-%j.out
#SBATCH --error=log/hisat2_NF-%j.err

#copy all the files with mRNA and the NV genome to the TMPDIR, containing the genome of NV and also the sorted mRNA files
cp ./sorted_NF/mRNA/*_mRNA.fq.gz $TMPDIR
cp ./genome_for_Index/NF/GCF_900696045.1_Nitrosocosmicus_franklandus_C13_genomic.fna $TMPDIR

#go to TMPDIR and load modules
pushd $TMPDIR

module load conda
conda activate hisat2
module load samtools

#make directories


mkdir ./hisat2_NF

#build genome to map to
hisat2-build -f -p $SLURM_CPUS_PER_TASK ./GCF_900696045.1_Nitrosocosmicus_franklandus_C13_genomic.fna ./N_frank


ls -1 ./*_mRNA.fq.gz|while read filename;

#this runs the actual script again, we use strandness reverse since we are working with cDNA from RNA - this is the reverse from what the RNA would be like, we use the 

do

bin_name=`basename $filename|cut -f1-2 -d '_'`
echo "Processing $bin_name"

conda activate bbmap

reformat.sh in=./$bin_name'_mRNA.fq.gz' out=./$bin_name'_mRNA_1.fq.gz' out2=./$bin_name'_mRNA_2.fq.gz'

conda activate hisat2

hisat2 -p 4 --rna-strandness RF --summary-file ./hisat2_NF/$bin_name'.summary' --no-spliced-alignment -q -x N_frank -1 ./$bin_name'_mRNA_1.fq.gz' -2 ./$bin_name'_mRNA_2.fq.gz' |samtools view -@ 5 -b > ./hisat2_NF/$bin_name'_unsorted.bam'

echo "Finished processing $bin_name"

done

pigz -p 4 ./hisat2_NF/*.bam

popd

cp  -r $TMPDIR/hisat2_NF ./
rm -r $TMPDIR



