#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o reformat_vcf_sep.out
#SBATCH -e reformat_vcf_sep.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

for i in $(cat imputed_vcf_files.txt); do
STEM=$(echo ${i} | cut -f 1 -d ".")
zcat $i | sed 's/|/\//g' > ${STEM}_sep_fixed.vcf
done
