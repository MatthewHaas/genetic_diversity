#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_filter_snps_and_make_wide_format_R.out
#SBATCH -e run_filter_snps_and_make_wide_format_R.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

module load R/3.6.0
Rscript filter_snps_and_make_wide_format.R
