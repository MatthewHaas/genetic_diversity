#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=8:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_fastqc.out
#SBATCH -e run_fastqc.err

cd ~/main_GBS

# Load fastQC
module load fastqc

# Run fastQC on trimmed reads
for i in $(cat 190515_sample_list,txt); do
fastqc $i/${i}_R1_001_trimmed.fastq.gz;
done
