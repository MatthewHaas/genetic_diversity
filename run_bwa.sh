#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=15g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
module load bwa
module load samtools
FASTA='/home/jkimball/mshao/genome_seq/zizania_palustris_13Nov2018_okGsv.fasta.gz'
cd ~/main_GBS
for i in $(cat filename.txt); do
bwa mem $FASTA $i/${i}_trimmed.fq.gz 2> $i/${i}_bwa.err | samtools sort -o $i/${i}_sorted.bam 2> $i/${i}_samtools_sort.err;
done