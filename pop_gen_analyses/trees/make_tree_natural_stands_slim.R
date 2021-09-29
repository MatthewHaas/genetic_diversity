# Load required packages
library(adegenet)
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)

args = commandArgs(trailingOnly = TRUE)

# Read in genotype data
x <- read.vcfR(args[1]) # use head(x) to explore

# Read in population data (modified from original sample CSV file to contain only the 919 samples in the VCF file)
pop.data <- read.table(args[2], sep = ",", header = TRUE)

# Confirm that all sammples in the VCF and the population data frame are included
all(colnames(x@gt)[-1] == pop.data$sample_number) # returns true

# Convert to a genlight object (for poppr and adegenet)
gen_light_x <- vcfR2genlight(x)

# Make a distance matrix
genLightX.dist <- dist(gen_light_x)

# Fix ploidy issue
ploidy(gen_light_x) <- 2

pop(gen_light_x) <- pop.data$sample_id

# Make a tree (note: this step took a few minutes. Not sure if it would crash if dataset were larger. Ultimately a good idea to run within a shell script submitted to SLURM)
tree <- aboot(gen_light_x, tree = "upgma", distance = bitwise.dist, sample = 100, showtree = F, cutoff = 50, quiet = T)

# Change tip labels to have sample ids rather than sample number
tree$tip.label <- as.character(pop.data$sample_id)

# Save progress
save(x, gen_light_x, genLightX.dist, tree, pop.data, file = args[3])

# Define col2hex() function (from: https://rdrr.io/cran/gplots/src/R/col2hex.R)
col2hex <- function(cname) {
    colMat <- col2rgb(cname)
    rgb(red=colMat[1,]/255, green=colMat[2,]/255,blue=colMat[3,]/255)
}

# Define my colors because we want to make it match the colors used in the PCA plots
# Not sure the conversion to HEX is strictly necessary since the error message I received had another cause, but it doesn't hurt to keep it, so I am leaving it in
# 27 September 2021 note: I had to switch "green" and "violet" because when I switched 'Plantagenet' to 'Lake Plantagenet', the colors on the plot were wrong--this will make them correct
myColors = c("red", "orange", "yellow3", "yellow", "green3", "violet", "green", "blue4", "blue", "violetred3", "purple4", "purple", "red3")

hexColorList <- vector() # initiate empty vector
for (color in myColors){
        hexColor = col2hex(color)
        hexColorList <- c(hexColorList, hexColor)
}

pdf(args[4], height = 30, width = 15)
plot.phylo(tree, cex = 1.5, font = 2, adj = 0, tip.color =  hexColorList[pop(gen_light_x)])
nodelabels(tree$node.label, adj = c(1.3, -0.5), frame = "n", cex = 0.8, font = 3, xpd = TRUE)
axis(side = 1)
title(xlab = "Genetic distance (proportion of loci that are different)")
dev.off()
