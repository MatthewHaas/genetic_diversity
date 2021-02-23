#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_normalize_awk_no_ref_with_snp_pos.out
#SBATCH -e run_normalize_awk_no_ref_with_snp_pos.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

prefix="200305_samtools"
normalize_prefix="210222_normalize"
mktemp | read tmp
cat ${prefix}_*imputed_no_ref_filt_by_snp_pos_no_ref_sep_fixed.vcf | awk -f ./normalize.awk > '$tmp' 2> $normalize_prefix.err
#cat filtered_vcf_files/${prefix}_*with_IDs_filtered_with_IDs_filtered_by_snp_id.recode.vcf | awk -f ./normalize.awk > '$tmp' 2> $normalize_prefix.err
#cat filtered_vcf_files/${prefix}_*filtered_by_snp_id.recode.vcf | awk -f ./normalize.awk > '$tmp' 2> $normalize_prefix.err
cp '$tmp' 210222_normalize_filtered_no_ref_with_snp_pos.tsv
