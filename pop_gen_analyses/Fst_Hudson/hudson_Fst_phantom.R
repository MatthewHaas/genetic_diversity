# Load required packages
library(data.table)
library(KRIS)

source("fst_hudson_function.R")

args = commandArgs(trailingOnly = TRUE)

# Read in data
data <- fread(args[1])

# Convert to matrix
data_mat <- as.matrix(data)

# Calculate Fst using Hudson method
# Modified for Phantom Lake as pop1 which only has 20 members
x <- fst.hudson(data_mat, c(1:20), c(11:70))

write.table(paste0(x, "\t", toString(args[1])), file=args[2], row.names = FALSE, col.names = FALSE, append = TRUE)
