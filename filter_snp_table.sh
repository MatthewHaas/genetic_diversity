#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=15g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e filtering_snp_table.err
#PBS -o filtering_snp_table.out
#PBS -N filtering_snp_table

cd /home/jkimball/haasx092/main_GBS/191122_samtools

awk '{ if ($8 >= 5) {print}}' 191122_normalize.tsv > 191122_normalize_filtered.tsv
