# 15 October 2019
# WD: /home/jkimball/haasx092/main_GBS/191010_samtools
# The purpose of this code is to filter SNP data from a subset of 200 samples

# Load necessary packages
library(data.table)
library(reshape2)

# Read in data
fread("191010_normalize_filtered.tsv") -> x

# Set column  names, remove unnecessary column, and remove messy part (file path) of sample name
setnames(x, c("scaffold", "position", "ref", "alt", "quality", "sample", "GT", "V8", "DP", "DV"))
x[, V8 := NULL]
x[, sample := sub("/.+$", "", sample)]

# Select SNPs with a depth greater than 5
x[DP > 10] -> y

# Change from long format to wide format
dcast(y, scaffold + position ~ sample, value.var="GT") -> y
# Put back into data table format
y <- as.data.table(y)

# Make a CSV file
write.csv(y, file="191015_main_GBS_SNPs_200_samples.csv", row.names=FALSE, col.names=TRUE)

# Try a lower depth threshold to try and get more SNPs (10 could be too high)
x[DP > 5] -> z
# Change from long format to wide format
dcast(z, scaffold + position ~ sample, value.var="GT") -> z
# Put back into data table format
z <- as.data.table(z)

# Trim scaffold names (drop the HRSCAF part)
z[, scaffold := sub(";.+$", "", scaffold)]

scaffolds_of_interest = c("Scaffold_1", "Scaffold_3", "Scaffold_9", "Scaffold_13", "Scaffold_18", "Scaffold_48", "Scaffold_51", "Scaffold_70", "Scaffold_93", "Scaffold_415", "Scaffold_693", "Scaffold_1062", "Scaffold_1063", "Scaffold_1064", "Scaffold_1065")

z[scaffold %in% scaffolds_of_interest] -> zz

# Count the number of "NA" occurrences per row
zz[, sum := apply(zz, MARGIN=1, function(x) sum(is.na(x)))]

# Select rows (SNPs) with fewer than 70 missing data points (# of samples missing that SNP)
zz[sum < 70] -> a

# Write to a csv file
write.csv(a, file="191015_main_GBS_SNPs_200_samples_DP5_filtered.csv", row.names=FALSE, col.names=TRUE)

# Save data
save(a, x, y, z, zz,  file="191015_main_GBS_filtered_SNPs.Rdata") 
