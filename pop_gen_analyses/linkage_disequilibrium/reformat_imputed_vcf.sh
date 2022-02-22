#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o reformat_vcf_sep.out
#SBATCH -e reformat_vcf_sep.err

cd /home/jkimball/haasx092/LD_decay

zcat biallelic_snps_only_imputed.vcf.gz | sed 's/|/\//g' > biallelic_snps_only_imputed_sep_fixed.vcf
