#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o calculate_Fst_vcftools_upper_rice_lake_comparisons.out
#SBATCH -e calculate_Fst_vcftools_upper_rice_lake_comparisons.err

cd /home/jkimball/haasx092/Fst_vcftools

~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat.vcf --weir-fst-pop upper_rice_lake.txt --weir-fst-pop zaquatica.txt
