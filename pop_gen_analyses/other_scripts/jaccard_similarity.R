# Load required packages
library(data.table)
library(tidyr)

args = commandArgs(trailingOnly = TRUE)

# Read in data
data <- fread(args[1])

# Define similarityCalc() function
similarityCalc <- function(a,b) {
	a = as.vector(as.matrix(data[V1 == i])[1,-1])
	b = as.vector(as.matrix(data[V1 == j])[1,-1])
	similarity = length(which(a == b))/length(a)
	return(similarity)
}

# Make a vector of sample names to iterate over
sample_names <- unique(data$V1)
# Make a duplicate vector so I can use tidyr's expand_grid() function to make a data.table with all possible pair-wise comparisons
sample_names_2 <- sample_names

# Note: when I ran this on my computer using Rstudio, the code ```tidyr:expand_grid()``` worked just fine; however, it failed when I used it on the Minnesota Supercomputing Institute's servers.
similarityTable <- as.data.table(tidyr::expand_grid(sample_names, sample_names_2))


for(i in sample_names){
	for(j in sample_names_2){
		similarityTable[sample_names == rep(i, length=.N) & sample_names_2 == rep(j, length=.N), similarity := similarityCalc(a, b)]
	}
}

write.csv(similarityTable, file = args[2])

