#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=15g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e filter_normalized_tsv.err
#PBS -o filter_normalized_tsv.out
#PBS -N filter_normalized_tsv

cd /home/jkimball/haasx092/main_GBS/191126_samtools

awk '{ if ($8 >= 5) {print}}' 191126_normalize.tsv >> 191126_normalize_filtered.tsv
