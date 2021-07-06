#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=12:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o directory_setup.out
#SBATCH -e directory_setup.err

cd /home/jkimball/haasx092/GATK

# Create directory structure
for i in $(cat sample_list.txt); do
        mkdir -p $i
done

# Make symlinks to existing BAM files (no need to re-do alignment, we want to re-do variant calling)
for i in $(cat sample_list.txt); do
        ln -s /home/jkimball/haasx092/main_GBS/${i}/${i}_sorted.bam ${i}/${i}_sorted.bam
done

# Check to make sure paths are accurate
ls -l Sample*/Sample*bam > paths_to_sorted_bam_files.txt
