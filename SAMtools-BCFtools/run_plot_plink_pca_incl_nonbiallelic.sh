#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o plot_plink_pca_incl_nonbiallelic.out
#SBATCH -e plot_plink_pca_incl_nonbiallelic.err

cd /home/jkimball/haasx092/plink_incl_nonbiallelic_snps

module load R/3.6.0

# These first two lines of code were run when I only had 4 args in the R script (before I made args 4 and 5 separate PCA files and moved the Rdata file from arg 4 to arg 6
#Rscript plot_plink_pca.R  plink_incl_nonbiallelic.eigenvec plink_incl_nonbiallelic.eigenval 210812_pca_all_incl_nonbiallelic.pdf 210812_pca_all_incl_nonbiallelic.Rdata
#Rscript plot_plink_pca.R  plink_incl_nonbiallelic.eigenvec plink_incl_nonbiallelic.eigenval 220414_pca_all_shapes_by_watershed.pdf 220414_pca_all_shapes_by_watershed.Rdata

Rscript plot_plink_pca.R  plink_incl_nonbiallelic.eigenvec plink_incl_nonbiallelic.eigenval 220414_pca_all_shapes_by_watershed.pdf 220413_pca_all_PC1_vs_PC2_shapes_by_watershed.pdf 220413_pca_all_PC2_vs_PC3_shapes_by_watershed.pdf 220414_pca_all_shapes_by_watershed.Rdata
