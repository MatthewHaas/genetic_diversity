# 21 February 2021
# WD: /home/jkimball/haasx092/main_GBS/imputation/210208_imputation

# Load required libraries
library(data.table)
library(reshape2)
args <- commandArgs(trailingOnly = TRUE)
# Read in the data, give column names, and remove a unnecessary/empty column
fread(args[1]) -> x
setnames(x, c("scaffold", "position", "snp_id", "ref", "alt", "quality", "sample", "GT"))
x[, V8 := NULL]
# Clean up sample names by stripping the "relative path" style, leaving only the sample name.
# The sample names will be turned into column names for part of the analysis, so this will make it cleaner.
x[, sample := sub("/.+$", "", sample)]
x[, scaffold := sub(";.+$", "", scaffold)]
# Name scaffolds of interest
scaffolds_of_interest = c("Scaffold_1", "Scaffold_3", "Scaffold_7", "Scaffold_9", "Scaffold_13", "Scaffold_18", "Scaffold_48",
                          "Scaffold_51", "Scaffold_70", "Scaffold_93", "Scaffold_415", "Scaffold_453", "Scaffold_693", "Scaffold_1062",
                         "Scaffold_1063", "Scaffold_1064", "Scaffold_1065")
# Retain only scaffolds of interest
x[scaffold %in% scaffolds_of_interest] -> y
# Filter based on genotype. Keep all homozygous calls but filter out heterozygotes with less than 3 ALT alleles
y -> z # removed filtering step, so adding this so the object names still work
# Convert from long format to wide format
dcast(z, scaffold + position + snp_id + ref + alt ~ sample, value.var="GT") -> zz
zz <- as.data.table(zz)
# Write the filtered SNP table to a file
write.csv(zz, file=args[2], row.names=FALSE, col.names=TRUE)
# Save data (especially the most important ones--so I can retrieve lower depth--5 to 9 reads-- if necessary)
save(zz, y, scaffolds_of_interest, file=args[3])
