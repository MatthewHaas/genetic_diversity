#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=5:00:00
#SBATCH --mem=100g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account jkimball
#SBATCH -o impute_with_beagle_with_ref_filt_by_snp_pos.out
#SBATCH -e impute_with_beagle_with_ref_filt_by_snp_pos.err

cd ~/main_GBS/imputation/210208_imputation

# Beagle files are located here: /home/jkimball/haasx092/beagle

# Run beagle (setting an upper limit of 100Gb of memory)
for i in $(cat vcf_list_filt_by_snp_pos.txt)
do
REFSTEM=$(echo ${i} | cut -f 1,2,3,4 -d "_") # need to capture multiple fields
STEM=$(echo ${i} | cut -f 1 -d ".")
java -Xmx100g -jar ~/beagle/beagle.25Nov19.28d.jar ref=filtered_vcf_files/${REFSTEM}_filtered_imputed.vcf.gz gt=filtered_vcf_files/${i} out=${STEM}_imputed_with_ref_filt_by_snp_pos impute=false ne=500000
done
