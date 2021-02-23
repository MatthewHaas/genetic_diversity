#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o plot_plink_pca_imputed_filt_by_snp_pos.out
#SBATCH -e plot_plink_pca_imputed_filt_by_snp_pos.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

module load R/3.6.0

Rscript plot_plink_pca.R  plink_imputed_filt_by_snp_pos.eigenvec plink_imputed_filt_by_snp_pos.eigenval 210221_main_gbs_imputed_filt_by_snp_pos.pdf 210221_main_gbs_imputed_filt_by_snp_pos.Rdata
