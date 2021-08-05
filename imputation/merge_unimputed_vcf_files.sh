#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=30g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e merge_vcf_files.err
#PBS -o merge_vcf_files.out
#PBS -N merge_vcf_files

cd /home/jkimball/haasx092/main_GBS/imputation/200210_imputation

module load bcftools

bcftools concat -o largest_scaffolds_filtered_unimputed.vcf 'Scaffold_1_filtered.recode.vcf' 'Scaffold_3_filtered.recode.vcf' 'Scaffold_7_filtered.recode.vcf' 'Scaffold_9_filtered.recode.vcf' 'Scaffold_13_filtered.recode.vcf' 'Scaffold_18_filtered.recode.vcf' 'Scaffold_48_filtered.recode.vcf' 'Scaffold_51_filtered.recode.vcf' 'Scaffold_70_filtered.recode.vcf' 'Scaffold_93_filtered.recode.vcf' 'Scaffold_415_filtered.recode.vcf' 'Scaffold_693_filtered.recode.vcf' 'Scaffold_1062_filtered.recode.vcf' 'Scaffold_1063_filtered.recode.vcf' 'Scaffold_1064_filtered.recode.vcf' 'Scaffold_1065_filtered.recode.vcf'
