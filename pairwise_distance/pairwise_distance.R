# 25 November 2019
# WD: /home/jkimball/haasx092/main_GBS/191122_samtools
# Purpose of this code is to calculate pairwise distances for the natural stand material using SNPs called on 22 November 2019
# One thing I'm not sure of is why the result of this code seems to be a dissimilarity matrix rather than a similarity matrix (small values are more similar and values of 0 are identical rather than values of 1).

# Load required packages
library(data.table)
library(ape)

# Read in data
fread("191123_main_gbs_snps_filtered_125NA.csv") -> x

# Remove the first row (contains sample names vs. the column headers which are sample IDs--numbers)
x[-1,] -> y
# Remove column containing the number of NAs
y[, sum := NULL]

# Create a SNP ID column by combining scaffold, position, ref, and alt columns
y[, snp.id := paste(scaffold, position, ref, alt,sep="_")]

# Re-order columns so that the SNP ID column is first
setcolorder(y, neworder=c(631, 1:630))

# Now that these columns are part of the SNP ID column, they are no longer necessary.
y[, scaffold := NULL]
y[, position := NULL]
y[, ref := NULL]
y[, alt := NULL]

# Extract rownames
y$snp.id -> snp_ids

y[, snp.id := NULL]

# Transpose the data.table so that the rows are individuals and the columns are SNPs (required to calculate pairwise distances with dist.gene from the ape ("analyses of phylogenetics and evolution") package
t(y) -> z

# Calculate pairwise distance 
# "pairwise" method results in round numbers, ranging from values of ~10 to over 100. Are these the number of differences? I wanted values between 0 and 1, which percentage achieves.
dist.gene(z, method = "percentage", pairwise.deletion = TRUE) -> d 

# Convert to matrix
d <- as.matrix(d)

# Create a CSV file. Note: in my version on the desktop, I added both a row & a column next to the sample ID numbers to containing their sample names (lake IDs)
write.csv(d, file="191125_pairwise_distances_natural_stands.csv", col.names=TRUE, row.names=TRUE)

# Save data
save(snp_ids, d, x, y, z, file="191122_pairwise_distances_natural_stands.Rdata")
