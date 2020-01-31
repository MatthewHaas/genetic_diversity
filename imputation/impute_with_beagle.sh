#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=100g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e impute_with_beagle.err
#PBS -o impute_with_beagle.out
#PBS -N impute_with_beagle

# 29 January 2020
# This code is for using beagle to impute missing data from GBS data
# WD: /home/jkimball/haasx092/main_GBS/imputation/200129_imputation

cd /home/jkimball/haasx092/main_GBS/imputation/200129_imputation

# Beagle files are located here: /home/jkimball/haasx092/beagle

# Run beagle (setting an upper limit of 100Gb of memory)
for i in $(cat vcf_file_list.txt)
do
STEM=$(echo ${i} | cut -f 1 -d ".")
java -Xmx100g -jar ~/beagle/beagle.25Nov19.28d.jar gt=$i out=${STEM}_imputed gp=TRUE ne=1000
done

for i in $(cat vcf_file_list.txt)
do
STEM=$(echo ${i} | cut -f 1 -d ".")
echo $STEM
echo $i
done