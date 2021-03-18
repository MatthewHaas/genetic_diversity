#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o bcftools_reheader_dp4.out
#SBATCH -e bcftools_reheader_dp4.err

cd /home/jkimball/haasx092/main_GBS/210306_samtools
