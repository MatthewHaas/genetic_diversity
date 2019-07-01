# 1 July 2019
# Making a PCA plot from vcf files

# Load required packages
library(vcfR)
library(poppr) # this package required many steps to install
library(ape)
library(RColorBrewer)
library(data.table)

# Read in data
# For now this is only the biggest scaffold (test run), but should use all (or at least the biggest) to get a better idea of structure
x <- read.vcfR("190627_samtools_Scaffold_48;HRSCAF=1451.vcf.gz")

# Convert to a genlight object (for pooppr and adegenet)
gen_light_x <- vcfR2genlight(x)

# Create a distance matrix
dist <- dist(gen_light_x)

# Principal component analysis
# This step took a long time (expected for ~230,000 SNPs and 8 PCs)
pca <- glPca(gen_light_x, nf=8)

# Make into data.table
pca_scores <- as.data.table(pca$scores)

# Keep rownames
rownames(pca$scores) -> rownames
pca_scores[, sample := rownames]
# Clean up sample names
pca_scores[, sample := sub("/.+$", "", sample)]
# Reorder so sample names are the first column
setcolorder(pca_scores, c("sample", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7"))

# Finally, we need to find the percent variance that is explained by a factor. 
# The factor loadings calculated by glPca are analagous to Pearson's r
# The squared factor loading is the percent variance explained by the factor
# This approach doesn't seem to produce reasonable values (too small)--leaving for now to come back to later
pca_loadings <- as.data.table(pca$loadings)
pca$loadings^2 -> pca_loadings_squared
pca_loadings_squared <- as.data.table(pca_loadings_squared)
# percentVar[1] <- sum(pca_loadings_squared[,1]/nrow(pca$loadings))

# Percent Variance can also be found by dividing the factor's eigenvalue by the number of variables (# of genes)
# This way seems easier
percentVar <- pca$eig/nrow(pca$loadings)

# For now color by sample (because there are 7) but for future plots, don't use this approach (1 color/sample)
pca_scores[, col := c(1:7)]

# Make the PCA plot
# signif() digits are different so that they will be the same in the plot (to the hundreths place)--likely due to % variance for PC2 being less than 1
pdf("190701_pilot_GBS_PCA.pdf")
pca_scores[, plot(PC1, PC2, xlab=paste0("PC1: ", signif(percentVar[1]*100, digits=3), "%"), ylab=paste0("PC2: ", signif(percentVar[2]*100, digits=2), "%"), main="PCA for pilot GBS", yaxt='n', pch=16, col=col)]
axis(2, las=2)
legend("topright", legen=c("14S-PS", "Garfield Lake", "Itasca-C12", "Latifolia", "Necktie Lake", "PM3E", "Upper Rice Lake"), col=c(1:7), pch=16, bty='n')
dev.off()