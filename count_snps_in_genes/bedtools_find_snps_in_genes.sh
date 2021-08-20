#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o bedtools_find_snps_in_genes.out
#SBATCH -e bedtools_find_snps_in_genes.err

cd /home/jkimball/haasx092/plink_incl_nonbiallelic_snps

module load bedtools

VCF_INFILE='filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf'
GFF_INFILE='rice.gene_structures_post_PASA_updates.21917.reordered.gff3'

bedtools intersect -a $VCF_INFILE -b $GFF_INFILE -header -wa > snps_in_genes.vcf
