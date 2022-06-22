#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_make_tree_natural_stands_breeding_lines.out
#SBATCH -e run_make_tree_natural_stands_breeding_lines.err

cd /home/jkimball/haasx092/trees_for_diversity_study

module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1

module load R/3.6.0

# arg[1] is a VCF file; arg[2] os a CSV file containing population data; arg[3] is Rdata file you want to save to; arg[4] is the PDF file to save the plot
# This is the version that was used to make the phylogram in the "fan" style with the edges/branches colored. **Note** GPP/GPN were also removed after Raymie informed us those were actually Natural Stands, not cultivated material
Rscript make_tree_natural_stands_and_breeding_lines_fan.R natural_stands_and_breeding_lines_no_GPP_or_GPN.recode.vcf natural_stands_and_breeding_lines_no_GPP_or_GPN.csv natural_stand_and_breeding_lines_no_GPP_or_GPN_tree_fan.Rdata natural_stand_and_breeding_lines_no_GPP_or_GPN_tree_fan.pdf
