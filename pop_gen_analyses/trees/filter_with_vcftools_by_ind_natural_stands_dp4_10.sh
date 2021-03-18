#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o filter_vcfs_natural_stnads_dp4_10.out
#SBATCH -e filter_vcfs_natural_stands_dp4_10.err

# Include path to the working directory
cd /home/jkimball/haasx092/main_GBS/210306_samtools

# Filter VCF files to keep natural stands only
~/vcftools/bin/vcftools --gzvcf filt_20_NA_concat_with_IDs_dp4_short_sample_names.vcf --keep natural_stands_10_subset.txt --recode --recode-INFO-all --out natural_stands_dp4_10
