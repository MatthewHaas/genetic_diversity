# WD: /home/jkimball/haasx092/trees_for_diversity_study

# Load required packages
library(data.table)
library(reshape2)

# Load data (containing genetic distance)
load("natural_stand_and_breeding_lines_tree.Rdata")

# Convert to matrix
data <- as.matrix(genLightX.dist)

# Convert to long foramt
data_long <- melt(data)

# Write long-format data to CSV format
write.csv(data_long, file = "211025_genetic_dist_natural_stands_and_breeding_lines.csv")

# Save data
save(genLightX.dist, data_long, file = "211025_genetic_dist_natural_stands_and_breeding_lines.Rdata")
