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

# Use this method to read in VCF before converting to RADobject
myVCF <- system.file("extdata", infile, package = "polyRAD")

# Convert data into a RADdata object
data <- VCF2RADdata(file = myVCF, phaseSNPs = TRUE, tagsize = 150, refgenome = genome_file, al.depth.field = "AD")

data <- VCF2RADdata(file = 'practice_conversion.gvcf', phaseSNPs = TRUE,
					Al.depth.field = "AD", min.ind.with.reads = 1)

# We have population structure, so IteratePopStruct is the best function for imputation.
# It runs the following polyRAD functions iteratively: 1) AddPCA, 2) AddAlleleFreqByTaxa, 3) AddAlleleFreqHWE, 4) AddGenotypePriorProb_ByTaxa, 5) AddGenotypeLikelihood, 6) AddPloidyChiSq, and 7) AddGenotypePosteriorProb
IteratePopStruct(object, selfing.rate = 0, tol = 1e-03,
                      excludeTaxa = GetBlankTaxa(object),
                      nPcsInit = 10, minfreq = 0.0001,
                      overdispersion = 9)

# Convert back to VCF format for further processing	
# Name of outfile should be specified as sys.arg[2] in shell script that launches this R script.			
RADdata2VCF(object = data, file = outfile, as SNPs = TRUE)
