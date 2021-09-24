#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=60g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_AMOVA.out
#SBATCH -e run_AMOVA.err


cd /home/jkimball/haasx092/AMOVA

module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1
module load R/3.6.0

Rscript AMOVA.R filtered_to_match_STRUCTURE_input.recode.vcf
