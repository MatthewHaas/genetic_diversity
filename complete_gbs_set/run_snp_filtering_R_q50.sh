#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=100g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e filter_snps_R_q50.err
#PBS -o filter_snps_R_q50.out
#PBS -N filter_snps_R_q50

cd /home/jkimball/haasx092/main_GBS/191126_samtools
module load R/3.6.0
Rscript filter_snps_and_make_wide_format_q50.R
