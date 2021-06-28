# Set working directory
setwd('/Users/haasx092/Documents/wild_rice/genetic_diversity/Data/variants_called_WITHOUT_genome')

# Load required packages
library(data.table)

# Read in data
x <- fread('out.weir_7_MILLION.fst')

# Select SNPs which are greater than zero
y <- x[WEIR_AND_COCKERHAM_FST > 0]
 
# Results in 22,966 SNPs (out of 52,267 SNPs on 27,355 contigs)

# Add a column for row number
y$rowNum <- seq.int(nrow(y))

pdf('Fst_values_from_pilot_7_million.pdf')
y[, plot(x = rowNum, y = WEIR_AND_COCKERHAM_FST, main = paste0("Fst distribution filtered for Fst > 0", "\n", "pilot 7M"), las = 1)]
dev.off()
