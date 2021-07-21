#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o filter_with_vcftools.out
#SBATCH -e filter_with_vcftools.err

# Include path to the working directory
cd /home/jkimball/haasx092/FreeBayes

# Filter VCF files for missing data (20%), biallelic sites only, no indels, and a depth of
~/vcftools/bin/vcftools --vcf  variants_first_pass.vcf --max-missing 0.90 --min-alleles 2 --maf 0.01 --minDP 6 --remove-indels --recode --recode-INFO-all --out variants_first_pass_filt
