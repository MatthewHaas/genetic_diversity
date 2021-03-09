#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_plink_20percent_NA_breeding_lines.out
#SBATCH -e run_plink_20percent_NA_breeding_lines.err

cd /home/jkimball/haasx092/main_GBS/210306_samtools

module load plink

plink --vcf filt_20_NA_vcf_files_concat.vcf --keep breeding_lines.txt --mind 0.20 --double-id --allow-extra-chr --recode --out plink_20percent_NA_breeding_lines

# PCA calculation
plink --pca --file plink_20percent_NA_breeding_lines --allow-extra-chr -out plink_20percent_NA_pca_breeding_lines
