#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=10:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_normalize_awk.out
#SBATCH -e run_normalize_awk.err

cd /home/jkimball/haasx092/LD_decay

normalize_prefix="220221_imputed"
mktemp | read tmp
cat biallelic_snps_only_imputed_sep_fixed.vcf  | awk -f ./normalize.awk > '$tmp' 2> $normalize_prefix.err
cp '$tmp' 220221_imputed.tsv
