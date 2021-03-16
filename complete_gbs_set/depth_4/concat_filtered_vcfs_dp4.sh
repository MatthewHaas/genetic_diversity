#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o concat_filtered_vcfs_20NA_dp4.out
#SBATCH -e concat_filtered_vcfs_20NA_dp4.err

# Include path to the working directory
cd /home/jkimball/haasx092/main_GBS/210306_samtools

module load bcftools

chr1='210306_samtools_ZPchr0001_filtered_20_NA_dp4.recode.vcf'
chr2='210306_samtools_ZPchr0002_filtered_20_NA_dp4.recode.vcf'
chr3='210306_samtools_ZPchr0003_filtered_20_NA_dp4.recode.vcf'
chr4='210306_samtools_ZPchr0004_filtered_20_NA_dp4.recode.vcf'
chr5='210306_samtools_ZPchr0005_filtered_20_NA_dp4.recode.vcf'
chr6='210306_samtools_ZPchr0006_filtered_20_NA_dp4.recode.vcf'
chr7='210306_samtools_ZPchr0007_filtered_20_NA_dp4.recode.vcf'
chr8='210306_samtools_ZPchr0008_filtered_20_NA_dp4.recode.vcf'
chr9='210306_samtools_ZPchr0009_filtered_20_NA_dp4.recode.vcf'
chr10='210306_samtools_ZPchr0010_filtered_20_NA_dp4.recode.vcf'
chr11='210306_samtools_ZPchr0011_filtered_20_NA_dp4.recode.vcf'
chr12='210306_samtools_ZPchr0012_filtered_20_NA_dp4.recode.vcf'
chr13='210306_samtools_ZPchr0013_filtered_20_NA_dp4.recode.vcf'
chr14='210306_samtools_ZPchr0014_filtered_20_NA_dp4.recode.vcf'
chr15='210306_samtools_ZPchr0015_filtered_20_NA_dp4.recode.vcf'
scf16='210306_samtools_ZPchr0016_filtered_20_NA_dp4.recode.vcf'
scf458='210306_samtools_ZPchr0458_filtered_20_NA_dp4.recode.vcf'

bcftools concat $chr1 $chr2 $chr3 $chr4 $chr5 $chr6 $chr7 $chr8 $chr9 $chr10 $chr11 $chr12 $chr13 $chr14 $chr15 $scf16 $scf458 > filt_20_NA_vcf_files_concat_dp4.vcf
