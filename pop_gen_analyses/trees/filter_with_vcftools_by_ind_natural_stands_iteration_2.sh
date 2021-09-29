#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o filter_vcfs_natural_stnads_iteration_2.out
#SBATCH -e filter_vcfs_natural_stands_iteration_2.err

# Include path to the working directory
cd /home/jkimball/haasx092/trees_for_diversity_study

# Filter VCF files to keep natural stands only
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_short_sample_names.vcf --keep natural_stands_subset_iteration_2.txt --recode --recode-INFO-all --out natural_stands_iteration_2
