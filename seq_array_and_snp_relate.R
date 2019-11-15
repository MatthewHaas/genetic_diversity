# 15 November 2019
# WD: /home/jkimball/haasx092/main_GBS
# This code is meant to be a better way to process the large-scale SNP data in R. It's a mess right now, but I think it will work in the end...

# Lots of different packages to load this time...
library(SeqArray)
library(SeqVarTools)
library(Rcpp)
source('/home/jkimball/haasx092/main_GBS/GBS_R_functions.R')

library(SNPRelate)
library(gdsfmt)

# Define VCF file
vcf.fn <- './191105_samtools/191105_samtools_Scaffold_9;HRSCAF=810.vcf.gz'

# Convert VCF to GDS format
seqVCF2GDS(vcf.fn, "tmp.gds", storage.option="ZIP_RA")

# Clean up fragments to reduce file size
# I don't think this did anything (nothing removed)
cleanup.gds("tmp.gds")

gds.fn <- 'tmp.gds'

seqOpen(gds.fn)-> gds

# Get sample ID
head(samp.id <- seqGetData(gds, "sample.id"))

# Get variant ID
head(variant.id <- seqGetData(gds, "variant.id"))

head(depth <- seqGetData(gds, "annotation/format/DP"))

# load the "parallel" package
library(parallel)

# choose an appropriate cluster size (or # of cores)
# An error is returned if this is greater than 1
seqParallelSetup(1)

# run in parallel
afreq <- seqParallel(, gds, FUN = function(f) {
        seqApply(f, "genotype", as.is="double", FUN=function(x) mean(x==0L, na.rm=TRUE))
    }, split = "by.variant")

# Get data out??
(g <- read.gdsn(index.gdsn(gds, "genotype/data"), start=NULL, count=NULL))

# import_vcf() function is not available. I think the package that it is in is not available, but I'm not sure why I can't install it.
#import_vcf(vcf.fn='./191105_samtools/191105_samtools_Scaffold_9;HRSCAF=810.vcf.gz', gds.fn='./191105_samtools/191105_scaffold_9_recode.gds', storage.option="LZMA_RA.max", ncores=40)
