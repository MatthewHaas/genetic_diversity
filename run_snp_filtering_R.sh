#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=100g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e filter_snps_R.err
#PBS -o filter_snps_R.out
#PBS -N filter_snps_R

cd /home/jkimball/haasx092/main_GBS/191122_samtools
module load R/3.6.0
Rscript filter_snps_and_make_wide_format.R
