# 28 January 2020
# Done in Rstudio on my Desktop (~/wild_rice/main_GBS/data)
# Plots the effect of varying Hardy-Weinberg Equilibrium (hwe) thresholds on Fst values in VCFtools. It is for an average depth of 6 and a max missing flag of 0.85 (allowing 15% missing data).

# Load required packages
library(data.table)

# Read in data
x <- fread("effect_of_hwe_on_fst.csv")

# Assign color based on whether the Fst value is the "mean" or "weighted" value as given by VCFtools
x[fst_class == "mean", col := "red"]
x[fst_class == "weighted", col := "blue"]

# Make the plot
pdf("Effect_of_hwe_on_Fst.pdf")
par(mar=c(5,5,5,5))
x[fst_class == "mean", plot(hwe, fst, type='l', col=col, ylim=c(0.035, 0.100), yaxt='n', main=paste0("Effect of Hardy-Weinberg on Fst Values", "\n", "depth=6, max-missing 15%, minor allele count=250"), ylab="Fst value", xlab="Hardy-Weinberg Equilibium (hwe) threshold")]
x[fst_class == "weighted", lines(hwe, fst, type='l', col=col)]
legend("topright", col=c("red", "blue", "black"), legend=c("mean Fst", "weighted Fst", "# SNPs"), lty=c(1,1,0), pch=c(NA, NA, 16))
# The axes won't behave how I want them to. I can get the x-axis to decrease, but then the SNPs don't correstpond to the correct values on the x-axis. So I think labeling the value on the x-axis is the easiest solution.
text(0.0225, 0.10, "hwe=0.0001; 651 SNPs")
text(0.0225, 0.077, "hwe=0.001; 465 SNPs")
text(0.03, 0.055, "hwe=0.01; 284 SNPs")
text(0.07, 0.04, "hwe=0.05; 162 SNPs")
text(0.08, 0.035, "hwe=0.10; 121 SNPs")

axis(2, las=2)
par(new=TRUE)
x[, plot(hwe, num_snps, pch=16, axes=FALSE, xlab=NA, ylab=NA)]
axis(4, las=2)
mtext(side=4, line=3, "Number of SNPs", cex=0.75)
dev.off()