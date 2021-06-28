#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o calculate_Fst_vcftools_pilot_data.out
#SBATCH -e calculate_Fst_vcftools_pilot_data.err

cd /home/jkimball/haasx092/Kimball_Project_001_analysis/Kimball_Project_001_analysis/kimball_001_BtgI-TaqI_4000000_stacks2/Resources 

~/vcftools/bin/vcftools --gzvcf variants.filt.vcf.gz --weir-fst-pop breeding_lines.txt --weir-fst-pop natural_stands.txt
