#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=30g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e add_IDs_to_VCF.err
#PBS -o add_IDs_to_VCF.out
#PBS -N add_IDs_to_VCF

# Change into the directory to work in
cd /home/jkimball/haasx092/main_GBS/imputation/200129_imputation

# Use Tom Kono's Python code to add IDs to VCF files

for i in $(cat original_vcf_file_list.txt)
do
STEM=$(echo $i | cut -f -1 -d ".")
python3 Add_ID_to_VCF.py $i ${STEM} 1
done
