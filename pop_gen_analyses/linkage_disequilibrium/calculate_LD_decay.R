# Calculate LD decay
library(data.table)
library(tidyverse)
library(sommer) # needed for the LD.decay() function

# My markers are in 0,1,2 format (0=homozygous for the reference allele; 1=heterozygous; 2=homozygous for the alternate allele)
# Program asks for SNP data in -1,0,1 format. I have no clue why they chose such an odd format, but it seems like their functions are able to recognize 0,1,2 and convert it to -1,0,-1

# Read in SNP data. This will need to be converted to a matrix
data <- fread("220221_imputed_no_col_or_row_names.csv")

# Read in map data. This can remain as a data.table (or data.frame if you are into that)
map_data <- fread("220221_imputed_map_data.csv")

# Change column names of map_data to suit needs of LD.decay() function
setnames(map_data, c("Locus", "LG", "Position"))

# Transpose data so that columns are markers and rows are individuals
data_t <- t(data)

# Convert data to matrix
data_t_m <- as.matrix(data_t)

# Convert data type back to numeric/integer from character. I thought it would help solve the issue of empty results. I was wrong-it didn't solve the problem--but also didn't appear to cause any problems.
class(data_t_m) <- "numeric"

# Set column names
colnames(data_t_m) <- map_data$Locus

# Create vector of individual names (based on row number)
named_samples = vector()
for(i in c(1:nrow(data_t_m))){
named_samples <- append(named_samples, paste0("Individual_", i))
}

# Set rownames
rownames(data_t_m) <- named_samples

map_data[, LG := sub("ZPchr", "", LG)]
map_data[, LG :=  as.numeric(map_data$LG)]
map_data[LG == 458, LG := 17]

# Calculate LD decay
results <- LD.decay(data_t_m, map_data, unlinked = TRUE)
results_linked <- LD.decay(data_t_m, map_data)

# Save results
save(results, results_linked, file = "220221_imputed_with_beagle_LD_results.Rdata")

# Make plots
pdf("linkage_disequilibrium_plots_imputed_with_beagle.pdf", height = 15, width = 15)
layout(matrix(c(1, 5, 9, 13, 17,
                2, 6, 10, 14, 0,
                3, 7, 11, 15, 0,
                4, 8, 12, 16, 0), nrow = 5), widths = c(1,1,1,1))
par(oma = c(3,6,3,0))
par(mar = c(4,4,4,2))
for (i in c(1:17)){
	if(i <= 15){
		data <- as.data.table(results_linked$by.LG[i])
	    data[, plot(x = d, y = r2, main = paste0("Chromosome ", i),
	                           xlab = "distance",
	                           ylab = "R^2",
	                           family = "serif",
	                           col = rgb(0.6, 0.2, 0.2, alpha = 0.75),
	                           pch = 16, 
	                           las = 1)]
	  }
	  if(i == 16){
	  	data <- as.data.table(results_linked$by.LG[i])
	    data[, plot(x = d, y = r2, main = paste0("Scaffold 51"),
	                           xlab = "distance",
	                           ylab = "R^2",
	                           family = "serif",
	                           col = rgb(0.6, 0.2, 0.2, alpha = 0.75),
	                           pch = 16,
	                           las = 1)]
	  }
	  if(i == 17){
	  	data <- as.data.table(results_linked$by.LG[i])
	    data[, plot(x = d, y = r2, main = paste0("Scaffold 458"),
	                           xlab = "distance",
	                           ylab = "R^2",
	                           family = "serif",
	                           col = rgb(0.6, 0.2, 0.2, alpha = 0.75),
	                           pch = 16,
	                           las = 1)]
	  }
}
dev.off()


# Print session information
sessionInfo()
