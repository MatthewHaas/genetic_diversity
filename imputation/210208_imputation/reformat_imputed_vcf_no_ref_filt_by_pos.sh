#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o reformat_vcf_sep_no_ref_filt_snp_pos.out
#SBATCH -e reformat_vcf_sep_no_ref_filt_snp_pos.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

for i in $(cat imputed_vcf_no_ref_filt_by_pos.txt); do
STEM=$(echo ${i} | cut -f 1,2,3,4,14,15,16,17,18,19,20 -d "_" | cut -f 1 -d ".") #shorten lengthy file name by underscore and get rid of filename extension
zcat $i | sed 's/|/\//g' > ${STEM}_no_ref_sep_fixed.vcf
done
