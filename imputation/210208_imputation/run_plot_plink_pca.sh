#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o plot_plink_pca.out
#SBATCH -e plot_plink_pca.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

module load R/3.6.0

Rscript plot_plink_pca.R  plink_20percent_NA_pca.eigenvec plink_20percent_NA_pca.eigenval 210218_main_gbs_20percent_NA.pdf 210218_main_gbs_20percent_NA.Rdata
