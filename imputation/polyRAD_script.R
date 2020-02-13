# 13 February 2020
# Imputation with polyRAD
# WD: /home/jkimball/haasx092/main_GBS/imputation/200210_imputation

# Load required package
library(polyRAD)

# Define path to reference genome
FASTA = "/home/jkimball/mshao/genome_seq/zizania_palustris_13Nov2018_okGsv.fasta.gz"

# Read in data in VCF format
x <- VCF2RADdata(file = "Scaffold_1_filtered.recode.vcf", phaseSNPs = TRUE, tagsize = 150,
	refgenome = FASTA, al.depth.field = "AD", min.ind.with.reads = 200, min.ind.with.minor.allele = 50)

# Read in data in VCF format
x <- VCF2RADdata(file = "Scaffold_1_filtered.recode.vcf", phaseSNPs = FALSE,
	refgenome = FASTA)
	