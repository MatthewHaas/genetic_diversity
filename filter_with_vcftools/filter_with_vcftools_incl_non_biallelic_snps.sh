#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o filter_vcfs_20NA_incl_nonbiallelic_snps.out
#SBATCH -e filter_vcfs_20NA_incl_nonbiallelic_snps.err

# Include path to the working directory
cd /home/jkimball/haasx092/main_GBS/210306_samtools

# Filter VCF files for missing data (20%), biallelic sites only, no indels, and a depth of 4
for i in $(cat vcf_file_list.txt)
do
STEM=$(echo ${i} | cut -f 1 -d ".")
~/vcftools/bin/vcftools --gzvcf  $i --max-missing 0.80 --min-alleles 2 --maf 0.05 --remove-indels --minDP 4 --recode --recode-INFO-all --out ${STEM}_filtered_20_NA_incl_nonbiallelic_snps
done
