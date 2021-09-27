#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o filter_vcfs_temporal_samples.out
#SBATCH -e filter_vcfs_temporal_samples.err

# Include path to the working directory
cd /home/jkimball/haasx092/main_GBS/trees_for_diversity_study

# Filter VCF files to keep natural stands only
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_short_sample_names.vcf --keep temporal_samples_for_vcftools_filt.txt --recode --recode-INFO-all --out temporal_sample
