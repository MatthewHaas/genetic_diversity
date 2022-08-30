#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o plot_plink_pca_temporal_incl_nonbiallelic.out
#SBATCH -e plot_plink_pca_temporal_incl_nonbiallelic.err

cd /home/jkimball/haasx092/plink_incl_nonbiallelic_snps

module load R/3.6.0

# New arg added to Rscript to create a PC1 vs PC2 only plot. As a result, the 4th argument becomes that PDF figure file and a new 5th argument is the Rdata file (old 4th arg)
#Rscript plot_temporal_plink_pca.R  plink_pca_temporal_incl_nonbiallelic.eigenvec plink_pca_temporal_incl_nonbiallelic.eigenval 210820_temporal_pca_incl_nonbialelic.pdf 210820_temporal_pca_incl_nonbiallelic.Rdata
Rscript plot_temporal_plink_pca.R  plink_pca_temporal_incl_nonbiallelic.eigenvec plink_pca_temporal_incl_nonbiallelic.eigenval 210820_temporal_pca_incl_nonbialelic.pdf 210820_temporal_pca_PC1_vs_PC2_only.pdf 210820_temporal_pca_incl_nonbiallelic.Rdata
