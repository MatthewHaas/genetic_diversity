# Load required packages
library(data.table)

# Read in data
data <- fread(snp_file.csv)

# Make vectors for each sample containing SNP data
Sample_0001 <- as.vector(as.matrix(data[1])[1,-1])
Sample_0002 <- as.vector(as.matrix(data[2])[1,-1])
Sample_0003 <- as.vector(as.matrix(data[3])[1,-1])

# Define Jaccard Similarity function
jaccard <- function(a, b) {
    intersection = length(intersect(a, b))
    union = length(a) + length(b) - intersection
    return (intersection/union)
}

# Find Jaccard Similarity between the two sets 
jaccard(a, b)
