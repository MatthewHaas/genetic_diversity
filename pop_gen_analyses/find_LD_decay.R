# Calculate LD decay
library(data.table)
library(tidyverse)
library(sommer) # needed for the LD.decay() function

# My markers are in 0,1,2 format (0=homozygous for the reference allele; 1=heterozygous; 2=homozygous for the alternate allele)
# Program asks for SNP data in -1,0,1 format. I have no clue why they chose such an odd format, but it seems like their functions are able to recognize 0,1,2 and convert it to -1,0,-1

# Read in SNP data. This will need to be converted to a matrix
data <- fread("210713_normalize_incl_nonbiallelic_imputed_zeros.csv")

# Read in map data. This can remain as a data.table (or data.frame if you are into that)
map_data <- fread("/panfs/roc/groups/1/jkimball/haasx092/genetic_diversity_map_data_for_LD_decay.csv")

# Change column names of map_data to suit needs of LD.decay() function
setnames(map_data, c("Locus", "LG", "Position"))

# Transpose data so that columns are markers and rows are individuals
data_t <- t(data)

# Convert data to matrix
data_t_m <- as.matrix(data_t)

# Convert data type back to numeric/integer from character. I thought it would help solve the issue of empty results. I was wrong-it didn't solve the problem--but also didn't appear to cause any problems.
class(data_t_m) <- "numeric"

# Set column names
colnames(data_t_m) <- map_data$Locus

# Create vector of individual names (based on row number)
named_samples = vector()
for(i in c(1:nrow(data_t_m))){
named_samples <- append(named_samples, paste0("Individual_", i))
}

# Set rownames
rownames(data_t_m) <- named_samples

map_data[, LG := sub("ZPchr", "", LG)]
map_data[, LG :=  as.numeric(map_data$LG)]
map_data[LG == 458, LG := 17]

# Calculate LD decay
LD.decay(data_t_m, map_data, unlinked = TRUE)


# Print session informationsessionInfo()
