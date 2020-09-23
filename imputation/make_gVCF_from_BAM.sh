#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=22g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e make_gvcf.err
#PBS -o make_gvcf.out
#PBS -N make gvcf

# 22 Sept 2020
# Converting existing BAM files into gVCF format. Still in practice mode as of 22 Sept 2020.

cd /home/jkimball/haasx092/main_GBS/200305_samtools

module load bcftools

ref="/home/jkimball/mshao/genome_seq/zizania_palustris_13Nov2018_okGsv.fasta"

bcftools mpileup -b practice_bam_list.txt -f ${ref} -a AD -g 5 -o practice_conversion.gvcf
