# Credit for this script goes to John B Horne (https://johnbhorne.wordpress.com/2017/07/12/identifying-private-snps-in-r/)
# Load required packages
library(hierfstat)

 # Read in data
data <- read.fstat(data.dat, na.s = "NA")

relative_freqs <- pop.freq(data)

zeros <- lapply(relative_freqs, function(x) which(x == 0))

# 12 populations in the natural stands (+ Z. aquatica and cultivated material)
eleven_zeros <- lapply(zeros, function(x) which(length(x) == 11))

# How many private SNPs are there?
length(which(eleven_zeros == 1))

# Pull out the private SNPs
private_snps <- relative_freqs[which(eleven_zeros == 1)]
