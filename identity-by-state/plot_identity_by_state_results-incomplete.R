library(data.table)

# Set working directory
setwd("~/Documents/wild_rice/genetic_diversity")

# Read in data
data <- fread("plink_ibs.mibs")

# Read in sample names
sample_names <- fread("plink_ibs.mibs.id", header = F)

# Assign sample names to row and column names of matrix
colnames(data) <- sample_names$V1
rownames(data) <- sample_names$V1


melt(data)[melt(upper.tri(data))$value,]