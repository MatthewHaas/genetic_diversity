#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=2:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account jkimball
#SBATCH -o filter_vcfs_by_indv.out
#SBATCH -e filter_vcfs_by_indv.err

# Include path to the working directory
cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

mkdir filtered_vcf_files

# Filter VCF files to keep samples with fewer than 200 genotypes missing (to make a reference panel)
for i in $(cat vcf_list_short.txt)
do
STEM=$(echo ${i} | cut -f 1 -d ".")
~/vcftools/bin/vcftools --gzvcf  $i --max-missing 0.9 --min-alleles 2 --max-alleles 2 --remove-indels --minDP 6 --keep samples_to_keep_for_ref_panel_fewer_than_200_missing.txt --recode --recode-INFO-all --out filtered_vcf_files/${STEM}_filtered
done
