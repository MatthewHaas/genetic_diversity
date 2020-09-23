# 23 September 2020
# WD: /home/jkimball/haasx092/main_GBS/200305_samtools
# This script is to use polyRAD to impute missing genotypes in our GBS dataset

args = commandArgs(trailingOnly=TRUE)
infile = args[1] 
outfile = args[2]

# Load required packages
library(polyRAD)
library(VariantAnnotation)

# Define path to genome file (used in imputation)
genome_file = "/home/jkimball/mshao/genome_seq/zizania_palustris_13Nov2018_okGsv.fasta"

# Convert data into a RAD object
data <- VCF2RADdata(file = infile, phaseSNPs = TRUE, tagsize = 150, refgenome = genome_file, al.depth.field = "AD")
