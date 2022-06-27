#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_plink_ibs.out
#SBATCH -e run_plink_ibs.err

cd /home/jkimball/haasx092/plink_incl_nonbiallelic_snps

module load plink

plink --vcf biallelic_snps_only.recode.vcf --mind 0.99 --keep cultivated_and_phantom_lake.txt --double-id --allow-extra-chr --recode --out plink_ibs

# PCA calculation
plink --ibs-matrix --file plink_ibs --allow-extra-chr -out plink_ibs
