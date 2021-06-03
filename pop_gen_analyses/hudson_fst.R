# Load required packages
library(data.table)
library(KRIS)

# Read in data
data <- fread(filename)

# Convert to matrix
data_mat <- as.matrix(data)

# Calculate Fst using Hudson method
fst.hudson(data_mat, c(1:50), c(51:100))
