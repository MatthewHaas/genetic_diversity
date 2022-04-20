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

~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.1 natural_stand_genos.1 map_data.1 xp-clr_results_ZPchr0001 -w1 0.005 200 2000 1 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.2 natural_stand_genos.2 map_data.2 xp-clr_results_ZPchr0002 -w1 0.005 200 2000 2 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.3 natural_stand_genos.3 map_data.3 xp-clr_results_ZPchr0003 -w1 0.005 200 2000 3 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.4 natural_stand_genos.4 map_data.4 xp-clr_results_ZPchr0004 -w1 0.005 200 2000 4 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.5 natural_stand_genos.5 map_data.5 xp-clr_results_ZPchr0005 -w1 0.005 200 2000 5 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.6 natural_stand_genos.6 map_data.6 xp-clr_results_ZPchr0006 -w1 0.005 200 2000 6 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.7 natural_stand_genos.7 map_data.7 xp-clr_results_ZPchr0007 -w1 0.005 200 2000 7 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.8 natural_stand_genos.8 map_data.8 xp-clr_results_ZPchr0008 -w1 0.005 200 2000 8 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.9 natural_stand_genos.9 map_data.9 xp-clr_results_ZPchr0009 -w1 0.005 200 2000 9 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.10 natural_stand_genos.10 map_data.10 xp-clr_results_ZPchr0010 -w1 0.005 200 2000 10 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.11 natural_stand_genos.11 map_data.11 xp-clr_results_ZPchr0011 -w1 0.005 200 2000 11 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.12 natural_stand_genos.12 map_data.12 xp-clr_results_ZPchr0012 -w1 0.005 200 2000 12 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.13 natural_stand_genos.13 map_data.13 xp-clr_results_ZPchr0013 -w1 0.005 200 2000 13 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.14 natural_stand_genos.14 map_data.14 xp-clr_results_ZPchr0014 -w1 0.005 200 2000 14 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.15 natural_stand_genos.15 map_data.15 xp-clr_results_ZPchr0015 -w1 0.005 200 2000 15 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.16 natural_stand_genos.16 map_data.16 xp-clr_results_ZPchr0016 -w1 0.005 200 2000 16 -p0 0.95
~/XP-CLR/XPCLR/src/XPCLR -xpclr cultivated_genos.17 natural_stand_genos.17 map_data.17 xp-clr_results_ZPchr0458 -w1 0.005 200 2000 17 -p0 0.95
