# Load required packages
library(data.table)

# Set working directory
setwd("~/Documents/wild_rice/genetic_diversity/Analysis/linkage_disequilibrium")

# Make a list of csv files to read into R
# Note: because there are no leading zeros in the file names,the filenames are not recognized in proper numerical order, but this can be fixed after we load the data (by sorting the resulting data.table)
all.files <- list.files(path = ".", pattern = "slidingwindow.csv")

# Read in data
myList <- lapply(all.files, fread)

# Put data into a single data.table
data <- rbindlist(myList)

# Sort the data table by the Locus1 (chromosome) column
data <- data[order(Locus1),]

# Remove all rows where the R^2 is NaN (not a number)
data <- na.omit(data, cols = 'R^2')

# Change chromosomes 16 and 17 to 51 and 458, respectively. This is for consistency between "chromosome" & "scaffold" names
data[Locus1 == 16, Locus1 := 51]
data[Locus1 == 17, Locus1 := 458]

# We should do this for Locus2 as well, for consistency.
data[Locus2 == 16, Locus1 := 51]
data[Locus2 == 17, Locus1 := 458]

# Make a vector of unique chromosome numbers to help us iterate through the data.table while we make the plots
chroms <- unique(data$Locus1)

# Change name of 'R^2' to "r2"
# Should have done this earlier because the caret/circumflex causes issues as a column name (which is why references to it are surrounded by single quotes in my code)
# Changing it now because it is causing even more difficulty when I try to reference it for plotting.
setnames(data, 'R^2', "r2")

# Make the plots
# The "if" statements are to control whether the word "chromosome" or "scaffold" is used in the plot title
pdf("linkage_disequilibrium_plots.pdf", height = 15, width = 15)
layout(matrix(c(1, 5, 9, 13, 17,
                2, 6, 10, 14, 0,
                3, 7, 11, 15, 0,
                4, 8, 12, 16, 0), nrow = 5), widths = c(1,1,1,1))
par(oma = c(3,6,3,0))
par(mar = c(4,4,4,2))
for(i in chroms){
  if(i <= 15){
    data[Locus1 == i, plot(x = Dist_bp, y = r2, main = paste0("Chromosome ", i),
                           xlab = "Chromosome position (bp)",
                           ylab = "R^2",
                           family = "serif",
                           col = rgb(0.6, 0.2, 0.2, alpha = 0.75),
                           pch = 16, 
                           las = 1)]
  }
  if(i == 51 | i == 458){
    data[Locus1 == i, plot(x = Dist_bp, y = r2, main = paste0("Scaffold ", i),
                           xlab = "Scaffold position (bp)",
                           ylab = "R^2",
                           family = "serif",
                           col = rgb(0.6, 0.2, 0.2, alpha = 0.75),
                           pch = 16,
                           las = 1)]
  }
}
dev.off()
