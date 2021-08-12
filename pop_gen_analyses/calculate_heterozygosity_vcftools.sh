#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o calculate_heterozygosity_vcftools.out
#SBATCH -e calculate_heterozygosity_vcftools.err

cd /home/jkimball/haasx092/TajimaD

~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --het
