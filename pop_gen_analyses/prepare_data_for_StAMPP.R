# Purpose of thie script is to prepare SNP data for use in the R package StAMPP (for Nei's diversity & maybe Fst)
library(data.table)

# Set working directory
setwd("~/Documents/wild_rice/genetic_diversity") # path is specific to my mac laptop

# Read in data and key
data <- fread("220401_natural_stand_only_for_LD_decay.csv")
key <- fread("../comma-separated_files/191021_main_GBS_sample_key_PBML-C20_renamed.csv")

# Create new column with SNP ID
data[, snp_id := paste0(scaffold, "_", position)]

snp_ids <- data$snp_id

# Remove unnecessary columns (now that scaffold & position are now combined, they are no onger needed)
data[, V1 := NULL]
data[, scaffold := NULL]
data[, position := NULL]
data[, ref := NULL]
data[, alt := NULL]
data[, snp_id := NULL] # we can remove this column, too--because we saved the IDs to a vector object called `snp_ids`

# Save sample names to a vector object so we don't need to worry about keeping rownames after converting matrix to data.table
# The reason: we'll want to use the snp_ids vector object to assign column names to the data.table and having an extra row will throw things off
# We'll simply add it back later
sample_names <- colnames(data)

# Transpose data
data_t <-t(data)

# Convert genotype coding from {0,1,2} format to {AA,AB,BB} format
# I think the StAMPP package was written with SNP chip data in mind (thus the format) but using the conversion scheme that I did here (0=AA, 1=AB, 2=BB) shouldn't affect the results
data_t[data_t == 0] <- "AA"
data_t[data_t == 1] <- "AB"
data_t[data_t == 2] <- "BB"

# Convert back to data.table
data_t <- as.data.table(data_t)

# You can check the results of this conversion by running the code below (uncomment first)--only to confirm that the structure is now a data.table
# data_t[1:10,1:10] 

# Assign snp_ids to column names
colnames(data_t) <- snp_ids

# Create new column called Sample containing sample names
data_t[, Sample := sample_names]

# Add population info
for(i in sample_names){
  data_t[Sample == i, Pop := key[sample_number == i]$sample_ID_simplified]
}

# Add ploidy column
data_t[, Ploidy := 2]

# Add format column
data_t[, Format := "BiA"]

# Rearrange columns so they are in the proper order
setcolorder(data_t, c("Sample", "Pop", "Ploidy", "Format", snp_ids))

# Write to CSV
write.csv(data_t, file = "220406_snp_data_formatted_for_StAMPP.csv")

# Save data
save(data, data_t, key, sample_names, snp_ids, file = "220406_snp_data_formatted_for_StAMPP.Rdata")
