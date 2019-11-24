# 23 November 2019
# WD: /home/jkimball/haasx092/main_GBS/191122_samtools
# This code takes in the tab-separated (TSV) file generated on 22 November 2019 (& subsequently filtered for a minimum depth of which reduced
# the size of the file from 86G to 18G).

# Load required libraries
library(data.table)
library(reshape2)
# Read in the data, give column names, and remove a unnecessary/empty column
fread("191122_normalize_filtered.tsv") -> x
setnames(x, c("scaffold", "position", "ref", "alt", "quality", "sample", "GT", "V8", "DP", "DV"))
x[, V8 := NULL]
# Clean up sample names by stripping the "relative path" style, leaving only the sample name.
# The sample names will be turned into column names for part of the analysis, so this will make it cleaner.
x[, sample := sub("/.+$", "", sample)]
# Do the same for the scaffold column.
x[, scaffold := sub(";.+$", "", scaffold)]
# Name scaffolds of interest
scaffolds_of_interest = c("Scaffold_1", "Scaffold_3", "Scaffold_9", "Scaffold_13", "Scaffold_18", "Scaffold_48", "Scaffold_51", "Scaffold_70", "Scaffold_93", "Scaffold_415", "Scaffold_693", "Scaffold_1062", "Scaffold_1063", "Scaffold_1064", "Scaffold_1065")
# Retain only scaffolds of interest
x[scaffold %in% scaffolds_of_interest] -> y
# Filter on depth. At least 6 reads should be present
y[DP >=6] -> yy
# Filter based on genotype. Keep all homozygous calls but filter out heterozygotes with less than 3 ALT alleles
yy[GT==0 | GT == 2 | (GT==1 & DV >= 3)] -> z
# Convert from long format to wide format
dcast(z, scaffold + position + ref + alt ~ sample, value.var="GT") -> zz
zz <- as.data.table(zz)
# Count number of NA values (missing individuals) per SNP
zz[, sum := apply(zz, MARGIN=1, function(x) sum(is.na(x)))]
# Filter based on the number of NA values
zz[sum <= 200] -> a
# Write the filtered SNP table to a file
write.csv(a, file="191123_main_gbs_snps_filtered.csv", row.names=FALSE, col.names=TRUE)
# Save data (especially the most important ones--so I can retrieve lower depth--5 to 9 reads-- if necessary)
save(a, y, scaffolds_of_interest, file="191123_main_gbs_snps_filtered.Rdata")
