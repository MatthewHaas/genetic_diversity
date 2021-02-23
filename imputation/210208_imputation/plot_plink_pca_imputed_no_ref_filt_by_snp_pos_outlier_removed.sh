#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o plot_plink_pca_imputed_no_ref_filt_by_snp_pos_outlier_removed.out
#SBATCH -e plot_plink_pca_imputed_no_ref_filt_by_snp_pos_outlier_removed.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

module load R/3.6.0

Rscript plot_plink_pca.R  plink_imputed_no_ref_filt_by_snp_pos_outlier_removed.eigenvec plink_imputed_no_ref_filt_by_snp_pos_outlier_removed.eigenval 210222_main_gbs_imputed_no_ref_filt_by_snp_pos_outlier_removed.pdf 210222_main_gbs_imputed_no_ref_filt_by_snp_pos_outlier_removed.Rdata
