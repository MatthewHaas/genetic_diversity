#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_filter_snps_and_make_wide_no_ref_filt_by_snp_pos.out
#SBATCH -e run_filter_snps_and_make_wide_no_ref_filt_by_snp_pos.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

module load R/3.6.0
# args[1] is the input TSV file, args[2] is the output CSV file, and args[3] is the output Rdata file
Rscript filter_snps_and_make_wide_format.R 210222_normalize_filtered_no_ref_with_snp_pos.tsv 21022_main_gbs_imputed_no_ref_filt_by_snp_pos.csv 210222_main_gbs_imputed_no_ref_filt_by_snp_pos.Rdata
#Rscript filter_snps_and_make_wide_format.R 210220_normalize_filtered_with_snp_pos.tsv 210219_main_gbs_filtered_by_snp_pos.csv 210219_main_gbs_filtered_by_snp_pos.Rdata
