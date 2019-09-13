# 13 September 2019
# WD: /home/jkimball/haasx092/main_GBS/190910_samtools
# The purpose of this code was to reformat a SNP table for the pilot study
# The directory isn't in the pilot_GBS because I was working on the main_GBS project but was asked to do a small task and I was already working in R.

# Load required packages
library(data.table)
library(reshape2)

# Load data
load("../../pilot_GBS/190627_samtools/190627_snp_filtering_q60.Rdata")

# Make a new data table (z) containing only the columns we want
z <- y[, .(scaffold, position, ref, alt, sample)]

# Re-make the data table "z" with a genotype column that combines the ref and alt genotypes
z[, geno := paste0(ref, "/", alt)]

# Remove the ref and alt columns. They're no longer needed since we have the geno column with the same info
z <- z[, .(scaffold, position, sample, geno)]

# Change z from long format to wide format. We want scaffold + position to remain as rows, but we want one column per sample
z <- dcast(z, scaffold + position ~ sample, value.var="geno")

# dcast altered z so that it is no longer a data table. Make it a data table again
z <- as.data.table(z)

# Write to csv file
write.csv(z, file="190913_pilot_GBS_snp_filtering_wide_format_q60.csv", col.names=TRUE, row.names=FALSE)

# Save R objects
save(y,z, file="190913_pilot_GBS_snip_filtering_wide_format_q60.Rdata")

# Note: due to the inclusion of latifolia, it seems like the SNP calls aren't too useful. It is necessary to go back to an earlier step and try again.