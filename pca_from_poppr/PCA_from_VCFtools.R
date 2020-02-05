# 30 January 2020
# Updated 4 February 2020
# This script is for generating a PCA plot from the VCF file created using imputed SNPs (using Beagle)
# I am trying to replicate the PCA produced using PLINK

# Load required packages
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)

# Read in data (919 individuals, 16 scaffolds, 2,943 variants)
x <- read.vcfR("largest_scaffolds_imputed.vcf.gz")

# Convert to a genlight object (for poppr and adegenet)
gen_light_x <- vcfR2genlight(x)

# Principal component analysis
# This step took a long time--adding cores may help
pca <- glPca(gen_light_x, nf=4, n.cores=24)

# Save data in case of a crash
#save(x, gen_light_x, pca, file="200123_popgen_with_poppr.Rdata")

# Make into data.table
pca_scores <- as.data.table(pca$scores) # Dividing the data by 100 ((pca$scores)/100) would put it on the same scale/magnitude as plink

# Keep rownames
rownames(pca$scores) -> rownames
pca_scores[, sample := rownames]
# Clean up sample names
pca_scores[, sample := sub("/.+$", "", sample)]
# Reorder so sample names are the first column
setcolorder(pca_scores, c("sample", "PC1", "PC2", "PC3", "PC4"))

# This way seems easier and results seem more reliable than other methods
# Eigenvalue calculation was correct before. What PLINK does differently is that it only considers the top 20 eigenvalues.
# poppr considers all of them. I will write R code that only keeps the top 20 here...
# percentVar <- pca$eig/sum(pca$eig)
v <- pca$eig[1:20]
v <- as.data.table(v)
percentVar <- c(PC1=v[1,v]/sum(v$v), PC2=v[2,v]/sum(v$v), PC3=v[3,v]/sum(v$v), PC4=v[4,v]/sum(v$v))

# Read in sample names to help with coloring plot...
y <- fread("/home/jkimball/haasx092/main_GBS/191126_samtools/200117_sample_key_for_poppr.csv")
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
pdf("200204_main_GBS_PCA_from_poppr.pdf", height=12, width=16)
pca_scores[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar[1]*100, digits=1), "%"), ylab=paste0("PC2: ", format(round(percentVar[2]*100, digits=1), nsmall=1), "%"), main=paste0("PCA for main GBS", "\n", "5771 SNPs"), yaxt='n', pch=pch, col=col, cex=1.5)]
axis(2, las=2)
pca_scores[, plot(PC3, PC4, xlab=paste0("PC3 ", round(percentVar[3]*100, digits=1), "%"), ylab=paste0("PC4: ", format(round(percentVar[4]*100, digits=1), nsmall=1), "%"), main=paste0("PCA for main GBS", "\n", "5771 SNPs"), yaxt='n', pch=pch, col=col, cex=1.5)]
axis(2, las=2)
#legend("topright", legen=c("14S-PS", "Garfield Lake", "Itasca-C12", "Latifolia", "Necktie Lake", "PM3E", "Upper Rice Lake"), col=c(1:7), pch=16, bty='n', cex=1.2)
dev.off()

# Save data
save(x, gen_light_x, pca, file="200204_popgen_with_poppr_imputed.Rdata")

