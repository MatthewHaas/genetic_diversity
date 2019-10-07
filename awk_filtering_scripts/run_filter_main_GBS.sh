#!/bin/bash -l
#PBS -l nodes=1:ppn=1,mem=15g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e /home/jkimball/haasx092/main_GBS/190910_samtools/main_GBS_filter_with_awk.err
#PBS -o /home/jkimball/haasx092/main_GBS/190910_samtools/main_GBS_filter_with_awk.out
#PBS -N main_GBS_filter_with_awk

# WD: /home/jkimball/haasx092/main_GBS/190910_samtools

cd /home/jkimball/haasx092/main_GBS/190910_samtools

# This awk code should print only lines containing the scaffolds we are interested to a filtered file
awk '{ if ($1 ~ /Scaffold_1;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_3;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_7;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_9;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_13;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_18;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_48;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_51;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_70;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_93;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_415;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_693;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_1062;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_1063;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_1064;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv
awk '{ if ($1 ~ /Scaffold_1065;/) {print}}' 191004_main_GBS_normalize.tsv >> 191006_main_GBS_SNPs_filtered.tsv

