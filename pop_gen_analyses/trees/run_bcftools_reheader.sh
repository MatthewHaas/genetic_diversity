#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o bcftools_reheader.out
#SBATCH -e bcftools_reheader.err

ccd /home/jkimball/haasx092/trees_for_diversity_study

module load bcftools

bcftools reheader --samples gbs_sample_names_919_indv.txt -o filt_20_NA_vcf_files_concat_incl_nonbiallelicshort_sample_names.vcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf
