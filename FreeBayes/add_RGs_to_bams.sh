#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o add_RGs.out
#SBATCH -e add_RGs.err

cd /home/jkimball/haasx092/main_GBS

source activate addRGs

for bam in $(cat 200312_sample_list.txt); do
bamaddrg -b $bam/${bam}_sorted.bam > /scratch.global/haasx092/${bam}_with_RGs.bam
done
