#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=8:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_Dsuite_ABBA-BABA.out
#SBATCH -e run_Dsuite_ABBA-BABA.err

cd /home/jkimball/haasx092/ABBA-BABA

 ~/ABBA-BABA/Dsuite/Build/Dsuite Dtrios biallelic_snps_only.recode.vcf sample_list_with_key.txt
