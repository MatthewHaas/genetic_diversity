#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=5:00:00
#SBATCH --mem=100g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account jkimball
#SBATCH -o impute_with_beagle.out
#SBATCH -e impute_with_beagle.err

cd ~/main_GBS/imputation/210208_imputation

# Beagle files are located here: /home/jkimball/haasx092/beagle

# Run beagle (setting an upper limit of 100Gb of memory)
for i in $(cat filtered_vcf_files.txt)
do
STEM=$(echo ${i} | cut -f 1 -d ".")
java -Xmx100g -jar ~/beagle/beagle.25Nov19.28d.jar gt=$i out=${STEM}_imputed gp=TRUE ne=500000
done
