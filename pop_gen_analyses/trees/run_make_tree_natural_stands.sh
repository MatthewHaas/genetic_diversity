#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_make_tree.out
#SBATCH -e run_make_tree.err

cd /home/jkimball/haasx092/main_GBS/210309_samtools

module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1

module load R/3.6.0

# arg[1] is a VCF file; arg[2] os a CSV file containing population data; arg[3] is Rdata file you want to save to; arg[4] is the PDF file to save the plot
Rscript make_tree_natural_stands.R natural_stands.recode.vcf natural_stand_samples.csv natural_stand_tree.Rdata natural_stand_tree.pdf
