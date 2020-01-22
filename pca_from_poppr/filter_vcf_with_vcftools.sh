#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=15g,walltime=1:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e filtering_vcf_with_vcftools.err
#PBS -o filtering_vcf_with_vcftools.out
#PBS -N filtering_vcf_with_vcftools

# This code is for filtering VCF files using VCFtools
# I am playing around with the variables to replicate the PLINK results (namely, the PCA plot)
# I wonder if the PLINK PCA was created with SNPs I have since filtered out due to read depth, missing data, or other

cd /home/jkimball/haasx092/main_GBS/191021_samtools

~/vcftools/bin/vcftools --gzvcf seventeen_largest_vcfs_merged.vcf.gz --maf 0.05 --max-missing 0.75 --recode
mv out.recode.vcf largest_scaffolds_max_missing_three_fourths.vcf
