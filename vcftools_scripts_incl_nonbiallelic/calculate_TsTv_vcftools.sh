#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o calculate_TsTv_vcftools.out
#SBATCH -e calculate_TsTv_vcftools.err

cd /home/jkimball/haasx092/TajimaD

# This is the code that was run to get the genome-wide TsTv numbers
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --TsTv 1000000
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --TsTv-summary

# The following code was used to get the chromosome-specific TsTv results (remove the pound symbol if you want to re-run any particular code)
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0001 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0001 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0002 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0002 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0003 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0003 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0004 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0004 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0005 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0005 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0006 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0006 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0007 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0007 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0008 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0008 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0009 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0009 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0010 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0010 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0011 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0011 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0012 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0012 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0013 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0013 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0014 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0014 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0015 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0015 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0016 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0016 --TsTv-summary

#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0458 --TsTv 1000000
#~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --chr ZPchr0458 --TsTv-summary
