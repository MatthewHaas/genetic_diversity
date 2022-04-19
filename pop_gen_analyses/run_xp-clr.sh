#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_xp-clr.out
#SBATCH -e run_xp-clr.err

cd /home/jkimball/haasx092/XP-CLR

~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr1 -w1 0.005 200 2000 1 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr2 -w1 0.005 200 2000 2 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr3 -w1 0.005 200 2000 3 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr4 -w1 0.005 200 2000 4 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr5 -w1 0.005 200 2000 5 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr6 -w1 0.005 200 2000 6 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr7 -w1 0.005 200 2000 7 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr8 -w1 0.005 200 2000 8 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr9 -w1 0.005 200 2000 9 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr10 -w1 0.005 200 2000 10 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr11 -w1 0.005 200 2000 11 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr12 -w1 0.005 200 2000 12 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr13 -w1 0.005 200 2000 13 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr14 -w1 0.005 200 2000 14 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr15 -w1 0.005 200 2000 15 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr16 -w1 0.005 200 2000 16 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genotypes.geno natural_stands_genotypes.geno nwr_map_data.snp xp-clr_results_chr458 -w1 0.005 200 2000 17 -p0 0.95
