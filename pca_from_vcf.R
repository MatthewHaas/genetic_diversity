# 1 July 2019
# Making a PCA plot from vcf files

# Load required  modules
module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1

# Merge multiple vcf files into one
# module load bcftools
bcftools concat -o seventeen_largest_vcfs_merged.vcf.gz '190627_samtools_Scaffold_48;HRSCAF=1451.vcf.gz' '190627_samtools_Scaffold_70;HRSCAF=1591.vcf.gz' '190627_samtools_Scaffold_1064;HRSCAF=3428.vcf.gz'
'190627_samtools_Scaffold_415;HRSCAF=2522.vcf.gz' '190627_samtools_Scaffold_93;HRSCAF=1687.vcf.gz' '190627_samtools_Scaffold_18;HRSCAF=1069.vcf.gz'
'190627_samtools_Scaffold_13;HRSCAF=912.vcf.gz' '190627_samtools_Scaffold_1;HRSCAF=83.vcf.gz' '190627_samtools_Scaffold_1062;HRSCAF=3426.vcf.gz'
'190627_samtools_Scaffold_1065;HRSCAF=3429.vcf.gz' '190627_samtools_Scaffold_9;HRSCAF=810.vcf.gz' '190627_samtools_Scaffold_3;HRSCAF=502.vcf.gz'
'190627_samtools_Scaffold_1063;HRSCAF=3427.vcf.gz' '190627_samtools_Scaffold_7;HRSCAF=722.vcf.gz' '190627_samtools_Scaffold_693;HRSCAF=2950.vcf.gz'
'190627_samtools_Scaffold_51;HRSCAF=1459.vcf.gz'

# Load required packages
library(vcfR)
library(poppr) # this package required many steps to install. Need gdal version 2.3.2 and other modules to be installed at the start of each session
library(ape)
library(RColorBrewer)
library(data.table)

# Read in data
# For now this is only the biggest scaffold (test run), but should use all (or at least the biggest) to get a better idea of structure
x <- read.vcfR("seventeen_largest_vcfs_merged.vcf.gz")

# Convert to a genlight object (for poppr and adegenet)
gen_light_x <- vcfR2genlight(x)

# Create a distance matrix
dist <- dist(gen_light_x)

# Principal component analysis
# This step took a long time--adding cores may help
pca <- glPca(gen_light_x, nf=8, n.cores=10)

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

# For now color by sample (because there are 7) but for future plots, don't use this approach (1 color/sample)
pca_scores[, col := c(1:7)]

# Make the PCA plot
# format() necessary for the y label because the value for the present version is 19.0 and I wanted R to print the 0 after the decimal (so it wasn't just 19%)
pdf("190705_pilot_GBS_PCA.pdf")
pca_scores[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar[1]*100, digits=1), "%"), ylab=paste0("PC2: ", format(round(percentVar[2]*100, digits=1), nsmall=1), "%"), main=paste0("PCA for pilot GBS", "\n", "17 largest scaffolds"), yaxt='n', pch=16, col=col)]
axis(2, las=2)
legend("topright", legen=c("14S-PS", "Garfield Lake", "Itasca-C12", "Latifolia", "Necktie Lake", "PM3E", "Upper Rice Lake"), col=c(1:7), pch=16, bty='n')
dev.off()

# Save data from this session. Would take a long time to re-create
save(x, gen_light_x, dist, rownames, pca, pca_scores, percentVar, file="190705_pca_from_vcfs.Rdata")
