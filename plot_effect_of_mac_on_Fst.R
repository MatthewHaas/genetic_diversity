# 24 January 2020
# Done in Rstudio on my Desktop (~/wild_rice/main_GBS/results)
# In its current form, this plot is the general form how I want all of the plots to look for the effect of minor allele count (mac) on Fst values in VCFtools. It is for an average depth of 6 and a max missing flag of 0.85 (allowing 15% missing data). The next step is to make a multi-panel plot to show the change in Fst values for different depths (4, 6, and 8) as well as differeing missing data levels (15, 25, and not specified).

# Load required packages
library(data.table)

# Read in data
x <- fread("Fst_variables_long_format.csv")

# Assign color based on whether the Fst value is the "mean" or "weighted" value as given by VCFtools
x[Fst_class == "mean", col := "red"]
x[Fst_class == "weighted", col := "blue"]

# Make the plot
pdf("Effect_of_mac_on_Fst.pdf")
par(mar=c(5,5,2,5))
x[dp == 6 & missing_percent == 15 & Fst_class == "mean", plot(mac, Fst, type='l', col=col, ylim=c(0.085, 0.100), yaxt='n', main="Effect of minor allele count on Fst with VCFtools", ylab="Fst value", xlab="Minor Allele Count (mac)")]
x[dp == 6 & missing_percent == 15 & Fst_class == "weighted", lines(mac, Fst, type='l', col=col)]
legend("bottomleft", col=c("red", "blue", "black"), legend=c("mean Fst", "weighted Fst", "# SNPs"), lty=c(1,1,0), pch=c(NA, NA, 16))
axis(2, las=2)

par(new=TRUE)
x[dp == 6 & missing_percent == 15, plot(mac, num_snps, pch=16, axes=FALSE, xlab=NA, ylab=NA)]
axis(4, las=2)
mtext(side=4, line=3, "Number of SNPs")
dev.off()