# 20 January 2020
# This script is for generating a PCA plot from the VCF file filtered with VCFtools
# I am trying to replicate the PCA produced using PLINK

# Load required packages
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)

# Read in data (919 individuals, 16 scaffolds, 2,943 variants)
x <- read.vcfR("largest_scaffolds_max_missing_half.vcf")

# Convert to a genlight object (for poppr and adegenet)
gen_light_x <- vcfR2genlight(x)

# Create a distance matrix
dist <- dist(gen_light_x)

# Principal component analysis
# This step took a long time--adding cores may help
pca <- glPca(gen_light_x, nf=4, n.cores=20)

# Save data in case of a crash
save(x, gen_light_x, pca, file="200117_popgen_with_poppr.Rdata")

# Make into data.table
pca_scores <- as.data.table(pca$scores)

# Keep rownames
rownames(pca$scores) -> rownames
pca_scores[, sample := rownames]
# Clean up sample names
pca_scores[, sample := sub("/.+$", "", sample)]
# Reorder so sample names are the first column
setcolorder(pca_scores, c("sample", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7"))

# This way seems easier and results seem more reliable than other methods
percentVar <- pca$eig/sum(pca$eig)

# Read in sample names to help with coloring plot...
y <- fread("../191126_samtools/200117_sample_key_for_poppr.csv")
# Set column names to help with merging... 
setnames(y, c("sample", "ID", "simplified", "extended", "class"))

# Merge pca_scores with sample key
y[pca_scores, on="sample"] -> pca_scores

# For now color by sample (because there are 7) but for future plots, don't use this approach (1 color/sample)
# Color breeding lines grey
pca_scores[class == "Breeding line", col := "grey"]

# Pick colors for individual natural stand accessions 
# Same color scheme as before
pca_scores[simplified == "Aquatica_species", col := "red3"]
pca_scores[simplified == "Bass Lake", col := "red"]
pca_scores[simplified == "Big Fork River", col := "orange3"]
pca_scores[simplified == "Clearwater River", col := "orange"]
pca_scores[simplified == "Dahler Lake", col := "yellow3"]
pca_scores[simplified == "Decker Lake", col := "yellow"]
pca_scores[simplified == "Garfield Lake", col := "green3"]
pca_scores[simplified == "Latifolia", col := "black"]
pca_scores[simplified == "Mud Hen Lake", col := "green"]
pca_scores[simplified == "Necktie River", col := "blue4"]
pca_scores[simplified == "Ottertail River", col := "blue"]
pca_scores[simplified == "Phantom Lake", col := "violetred3"]
pca_scores[simplified == "Plantagenet", col := "violet"]
pca_scores[simplified == "Shell Lake", col := "purple4"]
pca_scores[simplified == "Upper Rice Lake", col := "purple"]

# Make a shape column. Circles for most, triangles for Aquatica
pca_scores[, pch := 16]
pca_scores[simplified == "Aquatica_species", pch := 17]

# Make the PCA plot
# format() necessary for the y label because the value for the present version is 19.0 and I wanted R to print the 0 after the decimal (so it wasn't just 19%)
pdf("200120_main_GBS_PCA.pdf")
pca_scores[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar[1]*100, digits=1), "%"), ylab=paste0("PC2: ", format(round(percentVar[2]*100, digits=1), nsmall=1), "%"), main=paste0("PCA for main GBS", "\n", "1,160 SNPs"), yaxt='n', pch=pch, col=col)]
pca_scores[, plot(PC3, PC4, xlab=paste0("PC3 ", round(percentVar[3]*100, digits=1), "%"), ylab=paste0("PC4: ", format(round(percentVar[4]*100, digits=1), nsmall=1), "%"), main=paste0("PCA for main GBS", "\n", "1,160 SNPs"), yaxt='n', pch=pch, col=col)]
axis(2, las=2)
#legend("topright", legen=c("14S-PS", "Garfield Lake", "Itasca-C12", "Latifolia", "Necktie Lake", "PM3E", "Upper Rice Lake"), col=c(1:7), pch=16, bty='n')
dev.off()
