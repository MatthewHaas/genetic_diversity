#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_plink_imputed_no_ref_filt_by_snp_pos_outlier_removed.out
#SBATCH -e run_plink_imputed_no_ref_filt_by_snp_pos_outlier_removed.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

module load plink

plink --vcf impute_snps_no_ref_filt_by_snp_pos.vcf --remove sample_to_remove_from_plink.txt -double-id --allow-extra-chr --recode --out plink_imputed_no_ref_filt_by_snp_pos_outlier_removed

# PCA calculation
plink --pca --file plink_imputed_no_ref_filt_by_snp_pos_outlier_removed --allow-extra-chr -out plink_imputed_no_ref_filt_by_snp_pos_outlier_removed
