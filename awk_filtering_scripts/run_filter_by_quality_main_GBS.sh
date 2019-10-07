#!/bin/bash -l
#PBS -l nodes=1:ppn=1,mem=15g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e /home/jkimball/haasx092/main_GBS/190910_samtools/main_GBS_filter_with_awk.err
#PBS -o /home/jkimball/haasx092/main_GBS/190910_samtools/main_GBS_filter_with_awk.out
#PBS -N main_GBS_filter_with_awk

# WD: /home/jkimball/haasx092/main_GBS/190910_samtools

cd /home/jkimball/haasx092/main_GBS/190910_samtools

# This awk code should print only lines with a quality score greater than 100.
# It operates on the file that was filtered for only the largest scaffolds, but is still too large
awk '{ if ($5 > 500 && $1 ~ /Scaffold_48;/) {print}}' 191006_main_GBS_SNPs_filtered.tsv > 191007_main_GBS_SNPs_filt_by_quality.tsv
