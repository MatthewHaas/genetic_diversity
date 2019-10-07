#!/bin/bash -l
#PBS -l nodes=1:ppn=1,mem=15g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e /home/jkimball/haasx092/main_GBS/190910_samtools/main_GBS_filter_with_awk.err
#PBS -o /home/jkimball/haasx092/main_GBS/190910_samtools/main_GBS_filter_with_awk.out
#PBS -N main_GBS_filter_with_awk

# WD: /home/jkimball/haasx092/main_GBS/190910_samtools

cd /home/jkimball/haasx092/main_GBS/190910_samtools

# Similar awk code already used to filter for largest scaffolds only & quality > 900. File is still too large.
# Now the aim is to only keep one scaffold at a time. Maybe I can combine/concatenate them later
awk '{ if ($1 ~ /Scaffold_48;/) {print}}' 191007_main_GBS_SNPs_filt_by_quality.tsv >> 191007_main_GBS_SNPs_scf48_filtered.tsv

