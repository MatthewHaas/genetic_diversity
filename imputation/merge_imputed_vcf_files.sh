#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=30g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e merge_vcf_files.err
#PBS -o merge_vcf_files.out
#PBS -N merge_vcf_files

cd /home/jkimball/haasx092/main_GBS/imputation/200210_imputation

module load bcftools

bcftools concat -o largest_scaffolds_imputed.vcf 'Scaffold_1_filtered_imputed.vcf.gz' 'Scaffold_3_filtered_imputed.vcf.gz' 'Scaffold_7_filtered_imputed.vcf.gz' 'Scaffold_9_filtered_imputed.vcf.gz' 'Scaffold_13_filtered_imputed.vcf.gz' 'Scaffold_18_filtered_imputed.vcf.gz' 'Scaffold_48_filtered_imputed.vcf.gz' 'Scaffold_51_filtered_imputed.vcf.gz' 'Scaffold_70_filtered_imputed.vcf.gz' 'Scaffold_93_filtered_imputed.vcf.gz' 'Scaffold_415_filtered_imputed.vcf.gz' 'Scaffold_693_filtered_imputed.vcf.gz' 'Scaffold_1062_filtered_imputed.vcf.gz' 'Scaffold_1063_filtered_imputed.vcf.gz' 'Scaffold_1064_filtered_imputed.vcf.gz' 'Scaffold_1065_filtered_imputed.vcf.gz'
