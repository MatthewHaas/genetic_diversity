# Purpose of this script is to do LD analysis separately on Natural Stands and Cultivated Material
# Load required packages
library(data.table)
library(sommer)

# Read in imputed data
load("220221_imputed.Rdata")

# Long-formatted data are stored in the object called "yy"
# We want to be able to sort and filter based on whether samples belong to Natural Stands or Cultivated Material, so we need to read in some data to help with this
key <- fread("191021_main_GBS_sample_key_PBML-C20_renamed.csv")

# The next few steps are meant to replicate what `VLOOKUP()` could achieve in Excel
# Change first column of key to allow us to merge data.tables
setnames(key, "sample_number", "sample")

# Merge tables based on the sample column
merged <- merge(yy, key, on = "sample")

# Remove superfluous columns
# We'll want to remove some others later, but they might still be useful for now
merged[, ID := NULL]
merged[, sample_ID_extended := NULL]

# Check to make sure we only have the samples that we want to include
unique(merged[class == "Natural stand"]$sample_ID_simplified)

# From this, we can tell that the "old" Garfield and Shell Lake samples are included
# So is Big Fork River and Zizania aquatica. We'll want to filter those out
# Define samples to exclude
NS_to_exclude <- c("Garfield Lake Old", "Shell Lake Old", "Big Fork River", "Zizania aquatica")

# The next line simply verifies that the code works as expected
unique(merged[class == "Natural stand" & !(sample_ID_simplified %in% NS_to_exclude)]$sample_ID_simplified)

# Now, filter natural stands for real
natural_stands <- merged[class == "Natural stand" & !(sample_ID_simplified %in% NS_to_exclude)]

# Do the same for cultivated material ("breeding lines")
# It'll be easier to specify which ones we want to include rather than which ones we want to exclude
cultivated_to_keep <- c("14S*PS", "Barron", "FY-C20", "K2EF-C16", "Itasca-C12", "Itasca-C20", "PM3E")

# Again, we prove to ourselves that this approach works
unique(merged[class == "Breeding line" & sample_ID_simplified %in% cultivated_to_keep]$sample_ID_simplified)

cultivated <- merged[class == "Breeding line" & sample_ID_simplified %in% cultivated_to_keep]

# Convert natural stands to wide format
dcast(natural_stands, scaffold + position + snp_id + ref + alt ~ sample, value.var="GT") -> ns_wide

# Convert cultivated to wide wide format
dcast(cultivated, scaffold + position + snp_id + ref + alt ~ sample, value.var="GT") -> cm_wide

# Write separated data to their own CSV files
write.csv(ns_wide, file = "220401_natural_stand_only_for_LD_decay.csv")
write.csv(cm_wide, file = "220401_cultivated_only_for_LD_decay.csv")

## The next step was to remove the column names and row names so that we are left with only a matrix of 0s, 1s, and 2s. No row or column names.
## This is really where we get into the part of actually calculating LD/LD decay

# Read in cultivated (no zeros)
cm_dat <- fread("220401_cultivated_only_for_LD_decay_no_row_or_col_names.csv")

# Read in natural stands (no zeros)
ns_dat <- fread("220401_natural_stand_only_for_LD_decay_no_row_or_col_names.csv")

# Read in map data
map_data <- fread("/home/jkimball/haasx092/LD_decay/220401_map_data_for_LD_decay.csv")

# Change column names of map_data to suit needs of LD.decay() function
setnames(map_data, c("Locus", "LG", "Position"))

# Transpose data so that columns are markers and rows are individuals
cm_dat_t <- t(cm_dat)
ns_dat_t <- t(ns_dat)

# Convert data to matrix
cm_dat_t_m <- as.matrix(cm_dat_t)
ns_dat_t_m <- as.matrix(ns_dat_t)

# Convert data type back to numeric/integer from character. I thought it would help solve the issue of empty results. I was wrong-it didn't solve the problem--but also didn't appear to cause any problems.
class(cm_dat_t_m) <- "numeric"
class(ns_dat_t_m) <- "numeric"

# Set column names
colnames(cm_dat_t_m) <- map_data$Locus
colnames(ns_dat_t_m) <- map_data$Locus

# Set rownames
rownames(cm_dat_t_m) <- colnames(cm_wide[, c(6:143)])
rownames(ns_dat_t_m) <- colnames(ns_wide[,c(6:535)])

map_data[, LG := sub("ZPchr", "", LG)]
map_data[, LG :=  as.numeric(map_data$LG)]
map_data[LG == 458, LG := 17]

# Calculate LD decay (for cultivated)
cultivated_results <- LD.decay(cm_dat_t_m, map_data, unlinked = TRUE)
cultivated_results_linked <- LD.decay(cm_dat_t_m, map_data)

# Calculate LD decay (for natural stands)
natural_stands_results <- LD.decay(ns_dat_t_m, map_data, unlinked = TRUE)
natural_stands_results_linked <- LD.decay(ns_dat_t_m, map_data)


