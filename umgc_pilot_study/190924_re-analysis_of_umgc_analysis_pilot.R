# 24 September 2019
# The purpose of this code is to prepare tables and figures for the Conservation Genetics paper using pilot_GBS study data that were previously analyzed by the UMGC.
# WD: /home/jkimball/haasx092/umgc_pilot_study

# These modules must be loaded before opening R
module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1

# R as well, naturally
module R/3.6.0

# Switch to R and load required packages
library(vcfR)
library(poppr) # this package required many steps to install. Need gdal version 2.3.2 and other modules to be installed at the start of each session
library(ape)
library(RColorBrewer)
library(data.table)

# Read in data from each vcf file separately
x_half_million <- read.vcfR("variants_0.5M.vcf.gz")
x_one_million <- read.vcfR("variants_1M.vcf.gz")
x_two_million <- read.vcfR("variants_2M.vcf.gz")
x_four_million <- read.vcfR("variants_4M.vcf.gz")
x_seven_million <- read.vcfR("variants_7M.vcf.gz")

# Save data (even though this is not a good stopping point)
save(x_half_million, x_one_million, x_two_million, x_four_million, x_seven_million, file="190924_re-analysis_of_umgc_analysis_pilot.Rdata")

# Started here on 25 September 2019
gl_half_mil <- vcfR2genlight(x_half_million)
pca_half_mil <- glPca(gl_half_mil, nf=8, n.cores=10)
pca_half_mil_scores <- as.data.table(pca_half_mil$scores)
c("14S-PS", "FY-C20", "Garfield Lake", "Itasca-C12", "Latifolia", "Necktie River", "PM3E", "Upper Rice Lake") -> rownames_half_mil
pca_half_mil_scores[, sample := rownames_half_mil]
pca_half_mil_scores[, sample := sub("/.+$", "", sample)]
setcolorder(pca_half_mil_scores, c("sample", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7"))
percentVar_half_mil <- pca_half_mil$eig/sum(pca_half_mil$eig)
pca_half_mil_scores[, col := c(1:8)]

gl_one_mil <- vcfR2genlight(x_one_million)
pca_one_mil <- glPca(gl_one_mil, nf=8, n.cores=10)
pca_one_mil_scores <- as.data.table(pca_one_mil$scores)
c("14S-PS", "FY-C20", "Garfield Lake", "Itasca-C12", "Latifolia", "Necktie River", "PM3E", "Upper Rice Lake") -> rownames_one_mil
pca_one_mil_scores[, sample := rownames_one_mil]
pca_one_mil_scores[, sample := sub("/.+$", "", sample)]
setcolorder(pca_one_mil_scores, c("sample", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7"))
percentVar_one_mil <- pca_one_mil$eig/sum(pca_one_mil$eig)
pca_one_mil_scores[, col := c(1:8)]

gl_two_mil <- vcfR2genlight(x_two_million)
pca_two_mil <- glPca(gl_two_mil, nf=8, n.cores=10)
pca_two_mil_scores <- as.data.table(pca_two_mil$scores)
c("14S-PS", "FY-C20", "Garfield Lake", "Itasca-C12", "Latifolia", "Necktie River", "PM3E", "Upper Rice Lake") -> rownames_two_mil
pca_two_mil_scores[, sample := rownames_two_mil]
pca_two_mil_scores[, sample := sub("/.+$", "", sample)]
setcolorder(pca_two_mil_scores, c("sample", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7"))
percentVar_two_mil <- pca_two_mil$eig/sum(pca_two_mil$eig)
pca_two_mil_scores[, col := c(1:8)]

gl_four_mil <- vcfR2genlight(x_four_million)
pca_four_mil <- glPca(gl_four_mil, nf=8, n.cores=10)
pca_four_mil_scores <- as.data.table(pca_four_mil$scores)
c("14S-PS", "FY-C20", "Garfield Lake", "Itasca-C12", "Latifolia", "Necktie River", "PM3E", "Upper Rice Lake") -> rownames_four_mil
pca_four_mil_scores[, sample := rownames_four_mil]
pca_four_mil_scores[, sample := sub("/.+$", "", sample)]
setcolorder(pca_four_mil_scores, c("sample", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7"))
percentVar_four_mil <- pca_four_mil$eig/sum(pca_four_mil$eig)
pca_four_mil_scores[, col := c(1:8)]

gl_seven_mil <- vcfR2genlight(x_seven_million)
pca_seven_mil <- glPca(gl_seven_mil, nf=8, n.cores=10)
pca_seven_mil_scores <- as.data.table(pca_seven_mil$scores)
c("14S-PS", "FY-C20", "Garfield Lake", "Itasca-C12", "Latifolia", "Necktie River", "PM3E", "Upper Rice Lake") -> rownames_seven_mil
pca_seven_mil_scores[, sample := rownames_seven_mil]
pca_seven_mil_scores[, sample := sub("/.+$", "", sample)]
setcolorder(pca_seven_mil_scores, c("sample", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7"))
percentVar_seven_mil <- pca_seven_mil$eig/sum(pca_seven_mil$eig)
pca_seven_mil_scores[, col := c(1:8)]

# Make the PDF
pdf("out.pdf")
pca_half_mil_scores[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar_half_mil[1]*100, digits=1), "%"), ylab=paste0("PC2: ", format(round(percentVar_half_mil[2]*100, digits=1), nsmall=1), "%"), main="0.5 Million", yaxt='n', pch='')]
pca_half_mil_scores[, text(PC1, PC2, paste(sample), cex=0.45)]
axis(2, las=2)
#legend("topright", legen=c("14S-PS", "FY-C20", "Garfield Lake", "Itasca-C12", "Latifolia", "Necktie River", "PM3E", "Upper Rice Lake"), col=c(1:8), pch=16, bty='n')

pca_one_mil_scores[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar_one_mil[1]*100, digits=1), "%"), ylab=paste0("PC2: ", format(round(percentVar_one_mil[2]*100, digits=1), nsmall=1), "%"), main="1 Million", yaxt='n', pch='')]
pca_one_mil_scores[, text(PC1, PC2, paste(sample), cex=0.45)]

pca_two_mil_scores[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar_two_mil[1]*100, digits=1), "%"), ylab=paste0("PC2: ", format(round(percentVar_two_mil[2]*100, digits=1), nsmall=1), "%"), main="2 Million", yaxt='n', pch='')]
pca_two_mil_scores[, text(PC1, PC2, paste(sample), cex=0.45)]

pca_four_mil_scores[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar_four_mil[1]*100, digits=1), "%"), ylab=paste0("PC2: ", format(round(percentVar_four_mil[2]*100, digits=1), nsmall=1), "%"), main="4 Million", yaxt='n', pch='')]
pca_four_mil_scores[, text(PC1, PC2, paste(sample), cex=0.45)]

pca_seven_mil_scores[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar_seven_mil[1]*100, digits=1), "%"), ylab=paste0("PC2: ", format(round(percentVar_seven_mil[2]*100, digits=1), nsmall=1), "%"), main="7 Million", yaxt='n', pch='')]
pca_seven_mil_scores[, text(PC1, PC2, paste(sample), cex=0.45)]
axis(2, las=2)
dev.off()

# Save *all* of the objects from this R session
save.image(file="190925_re-analysis_of_umgc_analysis_pilot.Rdata")
