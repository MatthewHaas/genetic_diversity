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
#data[, Pop := NULL]
data[, Ploidy := NULL]
data[, Format := NULL]

# Make vector object of population names
populations <- data$Pop

# Remove white space from population names
populations <- gsub(" ", "", populations)

# Make vector object of sample names
#sample_names <- data$Sample

# Now, we also need to remove the Sample column
data[, Sample := NULL]
# Remove Pop column name
data[, Pop := NULL]

# Convert data to matrix
data_m <- as.matrix(data)

rownames(data_m) <- populations

# the `raw.data()` function converts the genotype data coded as AA, AB, BB back to 0, 1, 2
geno.ready <- raw.data(data = data_m, frame = "wide", base = TRUE, sweep.sample = 0.5, call.rate = 0.95, maf = 0.10, imput = FALSE)

# Convert "clean" data to new object
M <- geno.ready$M.clean

# Define subgroups
subgroups <- as.matrix(c(rep("BassLake", 50), rep("ClearwaterRiver", 50), rep("DahlerLake", 50), rep("DeckerLake", 50), rep("GarfieldLake", 50), rep("MudHenLake", 10), rep("NecktieRiver", 50), rep("OttertailRiver", 50), rep("PhantomLake", 20), rep("Plantagenet", 50), rep("ShellLake", 50), rep("UpperRiceLake", 50)))

# Do popgen analyses (they are all under this umbrella)
# Before we can get the results we are looking for (namely, Nei's D and PIC) we need to define subgroups
popgen_res <- popgen(M = M, subgroups = subgroups)

# Save data
save(data, data_m, geno.ready, M, popgen_res, populations, sample_names, subgroups, file = "220407_snpReady_results.Rdata")
