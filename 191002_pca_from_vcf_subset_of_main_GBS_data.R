# 02 October 2019
# WD: /home/jkimball/haasx092/main_GBS/191001_samtools
# The purpose of this code is to generate a PCA plot for the first fifty samples (out of 1054) using only Scaffold 48
# I will of course need to do all of the data at once, but R is having a difficult time with it (the PCs here still took ~4 hours to compute)

# Load required  modules
module load R/3.6.0
module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1

# Switch to R and read in data
x <- read.vcfR('191001_samtools_Scaffold_48;HRSCAF=1451.vcf.gz')

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


# Load in data containing information about each sample
fread("~/main_GBS/191002_first_fifty_lines.csv") -> y

# Remove file name column (not necessary)
y[, Filename := NULL]

# Rename sample column name in data table (dt) pca_scores so that they match the sample column in dt y to allow for merging
setnames(pca_scores, "sample", "Sample_number")

# Merge data tables
pca_scores[y, on="Sample_number"] -> y

# Create color column (grouped by source.. aka the lake/river samples come from)
y[, col := .GRP, by="Source"]

pdf("191002_pca_from_vcf_subset_of_main_GBS_data.pdf")
y[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar[1]*100, digits=1), "%"), ylab=paste0("PC2: ", format(round(percentVar[2]*100, digits=1), nsmall=1), "%"), main=paste0("Samples 0001-0050", "\n", "Scaffold 48"), yaxt='n', pch=16, col=col)]
axis(2, las=2)
y[, legend("topleft", legend=c("Necktie River", "Clearwater River"), pch=16, col=c(1,2))]
dev.off()

# Save the data
save(x, y, dist, gen_light_x, pca, pca_scores, percentVar, rownames, file="191002_pca_from_vcf_subset_of_main_GBS_data.Rdata")
