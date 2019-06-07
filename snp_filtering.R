# 7 June 2019
# On the command line, you must type "module load R" and then "R" again to get R to work on the MSI servers.
# working directory is: /home/jkimball/haasx092/pilot_GBS/190607_samtools

# Load the data.table package
library(data.table)

# Read in the data, give column names, and remove a unnecessary/empty column
fread("190607_normalize.tsv") -> x
setnames(x, c("scaffold", "position", "ref", "alt", "quality", "sample", "GT", "V8", "DP", "DV"))
x[, V8 := NULL]

# Filter for low quality scores (minimum=40)
x[quality > 40] -> y
# Filter for a minimum depth of 50 reads
y[DP > 50] -> y

# Clean up sample names by stripping the "relative path" style, leaving only the sample name.
# The sample names will be turned into column names for part of the analysis, so this will make it cleaner.
y[, sample := sub("/.+$", "", sample)]

# Calculate DV/DP ratio and round to two digits
y[, ratio := signif(DV/DP, digits=2)]

# Save
save(x, y, file="190607_snp_filtering.Rdata")