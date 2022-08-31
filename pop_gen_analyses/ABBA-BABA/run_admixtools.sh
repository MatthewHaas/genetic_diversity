#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=8:00:00
#SBATCH --mem=120g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_admixTools.out
#SBATCH -e run_admixTools.err

cd /home/jkimball/haasx092/plink_incl_nonbiallelic_snps

module load R/4.1.0

Rscript admixTools.R
