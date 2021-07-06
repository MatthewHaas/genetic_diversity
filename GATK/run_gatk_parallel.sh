#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=16:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_gatk_parallel.out
#SBATCH -e run_gatk_parallel.err

cd /home/jkimball/haasx092/GATK

module load gatk
module load java
module load picard-tools
module load parallel
module load samtools

FASTA='/home/jkimball/shared/WR_Annotation/NCBI_submission/zizania_palustris_13Nov2018_okGsv_renamedNCBI2.fasta'
#bam='Sample_0001_sorted.bam'
#STEM=$(echo ${bam} | cut -f 1 -d ".")

# The code to create the FASTA dictionary is commented out because it worked and doesn't need to be re-run each time I debug the rest of the code
#gatk --java-options "-Xmx4g"  CreateSequenceDictionary -R $FASTA

#cat sample_list.txt | parallel --will-cite -j 10 "java -jar /panfs/roc/msisoft/picard/2.18.16/picard.jar AddOrReplaceReadGroups \
#       I={}/{}_sorted.bam \
#       O={}/{}_with_rgs.bam \
#       RGID=4 \
#       RGLB=lib1 \
#       RGPL=ILLUMINA \
#       RGPU=unit1 \
#       RGSM={}"

#for i in $(cat sample_list.txt); do
#       samtools index -c ${i}/${i}_with_rgs.bam
#done

cat sample_list.txt | parallel --will-cite -j 10 "gatk --java-options "-Xmx4g" HaplotypeCaller \
        -R $FASTA \
        -I {}/{}_with_rgs.bam \
        -O {}/{}.vcf.gz \
        --sample-name {}"
