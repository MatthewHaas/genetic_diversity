#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o plot_plink_pca_breeding_lines_incl_nonbiallelic.out
#SBATCH -e plot_plink_pca_breeding_lines_incl_nonbiallelic.err

cd /home/jkimball/haasx092/plink_incl_nonbiallelic_snps

module load R/3.6.0

Rscript plot_breeding_lines_plink_pca.R  plink_breeding_lines_incl_nonbiallelic.eigenvec plink_breeding_lines_incl_nonbiallelic.eigenval 210818_breeding_lines_pca_incl_nonbiallelic.pdf 210818_breeding_lines_pca_incl_nonbiallelic.Rdata
