#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=8:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_cutadapt.out
#SBATCH -e run_cutadapt.err

cd ~/main_GBS

module load cutadapt

for i in $(cat 190819_sample_list.txt); do
cutadapt -b TCGCTGTCTCTTATACACATCT $i/${i}_concatenated.fq.gz -o $i/${i}_trimmed.fq.gz 2> $i/${i}_cutadapt.err
done
