# Load required packages
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)

# Load previously saved R data
load("natural_stands_genind_obj.Rdata")

# Read in sample data
y <- fread("~/main_GBS/191021_main_GBS_sample_key.csv")

# Remove unnecessary columns and rename columns for defined strata
y[, ID := NULL]
y[, sample_ID_extended := NULL]
setnames(y, c("sample", "population", "class"))

# subset genind object to only retain Z. aquatica and Bass Lake samples
aquatica_and_bass_lake_genind <- gen_ind_x[i=c(193:195, 204:206, 215:217, 226:228, 238:240, 250:252, 261:264, 273:286, 289:298, 301:310, 313:322, 325:333, 336:344, 347:354, 358:365)]

# Subset population key and change AquaticaSpecies/Aquatica_species to something more appropriate (Z. aquatica)
y <- y[population == "Bass Lake" | population == "AquaticaSpecies" | population == "Aquatica_species"]
y[population == "AquaticaSpecies", population := "Z aquatica"]
y[population == "Aquatica_species", population := "Z aquatica"]

# Add population info (strata) to genind object
strata(aquatica_and_bass_lake_genind) <- data.frame(y)

# Convert genind to genclone
aquatica_and_bass_lake_genclone <- as.genclone(aquatica_and_bass_lake_genind)

# Do the AMOVA
results <- poppr.amova(aquatica_and_bass_lake_genclone, ~ population, within = FALSE, clonecorrect = TRUE)

# next, get p-value
