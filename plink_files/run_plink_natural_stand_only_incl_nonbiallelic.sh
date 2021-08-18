#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_plink_natural_stands_incl_nonbiallelic.out
#SBATCH -e run_plink_natural_stands_incl_nonbiallelic.err

cd /home/jkimball/haasx092/plink_incl_nonbiallelic_snps

module load plink

plink --vcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --mind 0.95 --keep natural_stands.txt --double-id --allow-extra-chr --recode --out plink_natural_stands_incl_nonbiallelic

# PCA calculation
plink --pca --file plink_natural_stands_incl_nonbiallelic --allow-extra-chr -out plink_natural_stands_incl_nonbiallelic
