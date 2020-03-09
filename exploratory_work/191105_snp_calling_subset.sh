#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=15g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e 191105_snp_calling_subset.err
#PBS -N 191105_snp_calling_subset

cd /home/jkimball/haasx092/main_GBS

module load samtools
module load bcftools
module load htslib
module load parallel

bams='190910_sorted_bam_files_no_JohnsonDora.txt'
prefix="191105_samtools"
parallel_samtools_processes=15
ref="/home/jkimball/mshao/genome_seq/zizania_palustris_13Nov2018_okGsv.fasta"

mkdir -p $prefix
cut -f 1 ${ref}.fai \
 | parallel --will-cite -I'{}' -j $parallel_samtools_processes \
  \(samtools mpileup -q 50 -gDVu \
  -b $bams \
  -r '{}' \
  -f ${ref} \
  \| bcftools call -mv \
  \| bgzip -c \
  \> $prefix/${prefix}_'{}'.vcf.gz \) \
  2\> $prefix/${prefix}_'{}'.err
