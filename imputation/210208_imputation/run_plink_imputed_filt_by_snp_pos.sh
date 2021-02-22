#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_plink_imputed_filt_by_snp_pos.out
#SBATCH -e run_plink_imputed_filt_by_snp_pos.err

cd /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

module load plink

plink --vcf imputed_snps_filt_by_snp_pos.vcf -double-id --allow-extra-chr --recode --out plink_imputed_filt_by_snp_pos

# PCA calculation
plink --pca --file plink_imputed_filt_by_snp_pos --allow-extra-chr -out plink_imputed_filt_by_snp_pos
