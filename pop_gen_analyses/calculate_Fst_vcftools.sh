#!/bin/bash -l
#PBS -l nodes=1:ppn=24,mem=20g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e Fst_with_vcftools.err
#PBS -o Fst_with_vcftools.out
#PBS -N Fst_with_vcftools

cd /home/jkimball/haasx092/main_GBS/imputation/200210_imputation

~/vcftools/bin/vcftools --gzvcf largest_scaffolds_unimputed.vcf --maf 0.05 --weir-fst-pop shell_lake.txt --weir-fst-pop bass_lake.txt
