#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_normalize_awk_filt.out
#SBATCH -e run_normalize_awk_filt.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

prefix="200305_samtools"
normalize_prefix="210221_normalize"
mktemp | read tmp
cat ${prefix}_*imputed_with_ref_filt_by_snp_pos_sep_fixed.vcf | awk -f ./normalize.awk > '$tmp' 2> $normalize_prefix.err
cp '$tmp' 210221_normalize_filt_snp_pos.tsv
