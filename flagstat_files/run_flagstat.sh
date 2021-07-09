#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=48:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_flagstat.out
#SBATCH -e run_flagstat.err

cd /home/jkimball/haasx092/main_GBS

module load samtools

for i in $(cat sample_list.txt); do
samtools flagstat ${i}/${i}_sorted.bam > ${i}/${i}_bam_flagstat_output.txt
done
