#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o structure_fastq_for_tassel.out
#SBATCH -e structure_fastq_for_tassel.err

# Purpose of this script is to convert FASTQ files into a format recognizable by TASSEL

cd /home/jkimball/haasx092/TASSEL

for i in $(cat sample_list.txt);
do
ln ~/main_GBS/${i}/${i}_1.fq.gz ~/TASSEL/fastq/${i}_HCN5GDRXX_1_fastq.txt.gz
ln ~/main_GBS/${i}/${i}_2.fq.gz ~/TASSEL/fastq/${i}_HCN5GDRXX_2_fastq.txt.gz
done
