#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_gatk.out
#SBATCH -e run_gatk.err

cd /home/jkimball/haasx092/GATK

module load gatk
module load java
module load picard-tools

FASTA='/home/jkimball/shared/WR_Annotation/NCBI_submission/zizania_palustris_13Nov2018_okGsv_renamedNCBI2.fasta'
bam='Sample_0001_sorted.bam'

# The code to create the FASTA dictionary is commented out because it worked and doesn't need to be re-run each time I debug the rest of the code
#gatk --java-options "-Xmx4g"  CreateSequenceDictionary -R $FASTA

gatk --java-options "-Xmx4g" HaplotypeCaller -R $FASTA -I $bam -O Sample_0001.g.vcf.gz -ERC GVCF --sample-name Sample_0001_sorted
