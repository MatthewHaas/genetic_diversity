# 27 January 2020
# WD: /home/jkimball/haasx092/main_GBS/191126_samtools
# The purpose of this code is to make plots of filtered allele frequencies across each scaffold

# Site frequency
# Keeps 4,564 out of 54,333 sites
# outputs to frequency_analysis.frq
~/vcftools/bin/vcftools --gzvcf largest_scaffolds_recoded.vcf.gz --maf 0.05 --min-alleles 2 --max-alleles 2 --remove-indels --freq --out frequency_analysis

# Switch to R

# Load required packages
library(data.table)

# Read in data
# An *warning* message is returned. There are 5 column names, but 6 columns of data.
# This is a result of the VCFtools output; easily fixed with "setnames"
x <- fread("frequency_analysis.frq")

# Fix column names
setnames(x, c("chrom", "pos", "n_alleles", "n_chr", "ref_freq", "alt_freq"))

# Strip unnecessary information from chromosome/scaffold names
x[, chrom := sub(";.+$", "", chrom)]

# Strip nucleotide identity from ref_freq and alt_freq
# They are informative elsewhere, but the goal here is to plot the frequency of the ref vs alt alleles.
x[, ref_freq := sub("^[ACGT]:", "", ref_freq)]
x[, alt_freq := sub("^[ACGT]:", "", alt_freq)]

scaffolds <- c("Scaffold_1", "Scaffold_3", "Scaffold_7", "Scaffold_9", "Scaffold_13", "Scaffold_18", "Scaffold_48", "Scaffold_51", "Scaffold_70", "Scaffold_93", "Scaffold_415", "Scaffold_693", "Scaffold_1062", "Scaffold_1063", "Scaffold_1064", "Scaffold_1065")

# Make the plot
pdf("200127_main_gbs_site_frequency_spectra.pdf", height=10, width=60)
for(i in scaffolds){
x[chrom == i, plot(pos, ref_freq, xlab="Position (bp)", ylab="Allele frequency", main=i, type="l", yaxt='n', col="red")]
axis(2, las=2)
x[chrom == i, lines(pos, alt_freq, col="blue")]
legend("topright", inset=c(0.005, 0), col=c("red", "blue"), lty=c(1,1), xpd=TRUE, bty='n', cex=2, legend=c("ref allele", "alt allele"))
}
dev.off()