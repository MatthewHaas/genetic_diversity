#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=12:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_FreeBayes.out
#SBATCH -e run_FreeBayes.err

cd /home/jkimball/haasx092/FreeBayes

module load freebayes

FASTA='/home/jkimball/shared/WR_Annotation/NCBI_submission/zizania_palustris_13Nov2018_okGsv_renamedNCBI2.fasta'

freebayes -f $FASTA merged_bam_with_RGs.bam > ~/FreeBayes/variants.vcf
