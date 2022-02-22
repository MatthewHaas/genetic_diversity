#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=8:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_filter_snps_and_make_wide_format_imputed.out
#SBATCH -e run_filter_snps_and_make_wide_format_imputed.err

cd /home/jkimball/haasx092/LD_decay

module load R/3.6.0
# args[1] is the input TSV file, args[2] is the output CSV file, and args[3] is the output Rdata file
# original output (from 13 July 2021) was missing ZPchr0010 ... because the Rscript had a typo (ZPChr0010...capitalized "C") ... so had to re-run this and save with new date
Rscript filter_snps_and_make_wide_format.R 220221_imputed.tsv 220221_imputed.csv 220221_imputed.Rdata
