# purpose of this script is to calculate Nei's Diversity and Polymorphism Information Content with the R package snpReady
# useful vignette: https://cran.r-project.org/web/packages/snpReady/vignettes/snpReady-vignette.html
library(data.table)
library(impute) # probably not required to call this explicitly because it's a dependency of snpReady
library(snpReady)

# Read in data
# For snpReady to work, 2 different files are needed: a table with 4 columns (sample, marler, allele.1, allele.2); and
# and a matrix of genotypes: columns are MARKERS and rows are INDIVIDUALS. Genotypes are in nucleotide format (e.g., "CC", "CG", "GG", etc)
data <- fread("220406_snp_data_formatted_for_StAMPP.csv")

# Remove unnecessary columns
data[, V1 := NULL]
data[, [Pop := NULL]
data[, Ploidy := NULL]
data[, Format := NULL]

# Make vector object of sample names
sample_names <- data$Sample

# Now, we also need to remove the Sample column
data[, Sample := NULL]

# Convert data to matrix
data_m <- as.matrix(data)

# the `raw.data()` function converts the genotype data coded as AA, AB, BB back to 0, 1, 2
geno.ready <- raw.data(data = data_m, frame = "wide", base = TRUE, sweep.sample = 0.5, call.rate = 0.95, maf = 0.10, imput = FALSE)

# Convert "clean" data to new object
M <- geno.ready$M.clean

# Do popgen analyses (they are all under this umbrella)
# Before we can get the results we are looking for (namely, Nei's D and PIC) we need to define subgroups
popgen_res <- popgen(M = M)
