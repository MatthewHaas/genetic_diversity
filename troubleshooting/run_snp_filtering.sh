#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=20g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e run_snp_filtering.err
#PBS -o run_snp_filtering.out
#PBS -N run_snp_filtering

cd /home/jkimball/haasx092/main_GBS/191118_samtools
module load R
R --file=snp_filtering.R
