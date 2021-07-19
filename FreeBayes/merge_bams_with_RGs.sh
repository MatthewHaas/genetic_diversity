#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o merge_bams.out
#SBATCH -e merge_bams.err

cd /home/jkimball/haasx092/main_GBS

module load samtools

samtools merge -b bams_with_RGs.txt merged_bam_with_RGs.bam
