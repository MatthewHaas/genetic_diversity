# 13 September 2019
# WD: /home/jkimball/haasx092/pilot_GBS/190607_samtools
# The purpose of this script was to generate a SNP table for the pilot study without latifolia included.

# Load required packages
library(data.table)
library(reshape2)

# Load data
load("190607_snp_filtering.Rdata")

# Remove latifolia
y[sample != "Latifolia_p_S244"] -> z

# Make a new "geno" column based on ref and alt combination
z <- z[, geno := paste0(ref, "/", alt)]

# Keep only the columns we are interested in
z <- z[, .(scaffold, position, sample, geno)]

# Keep unique... where are duplicates coming from?
unique(z[, .(scaffold, position, sample, geno)]) -> a

# Convert from long format to wide format
a <- dcast(a, scaffold + position ~ sample, value.var="geno")

# Save as data.table
a <- as.data.table(a)

# Make csv file
write.csv(a, file="190913_snp_calling_from_190607_samtools_pilot_GBS.csv")

# Save data
save(a,x,y,z, file="190913_snp_calling_from_190607_samtools_pilot_GBS.csv")