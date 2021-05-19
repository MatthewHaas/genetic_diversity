# Purpose of this script is to get the geographic (physical) distance between two lakes for the Mantel test to see if geographic distance is related to genetic distance

# Load required pacakges
library(data.table)
library(geosphere)

# Read in data
data <- fread("191106_wild_rice_samples.csv")
