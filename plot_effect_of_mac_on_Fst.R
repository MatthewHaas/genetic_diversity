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

depth=c(4,6,8)

# Make the plot
pdf("Effect_of_mac_on_Fst.pdf",height=6, width=12)
for(i in depth) {
layout(matrix(c(1,2,3), nrow=1, byrow=TRUE))
par(mar=c(5,5,2,5))
par(oma=c(0,0,10,0))
x[dp == i & missing_percent == 15 & Fst_class == "mean", plot(mac, Fst, type='l', col=col, ylim=c(0.035, 0.100), yaxt='n', main="Missing rate = 0.85 (15%)", ylab="Fst value", xlab="Minor Allele Count (mac)")]
x[dp == i & missing_percent == 15 & Fst_class == "weighted", lines(mac, Fst, type='l', col=col)]
legend("bottomleft", col=c("red", "blue", "black"), legend=c("mean Fst", "weighted Fst", "# SNPs"), lty=c(1,1,0), pch=c(NA, NA, 16))
axis(2, las=2)

par(new=TRUE)
x[dp == i & missing_percent == 15, plot(mac, num_snps, pch=16, axes=FALSE, xlab=NA, ylab=NA)]
axis(4, las=2)
mtext(side=4, line=3, "Number of SNPs", cex=0.75)

x[dp == i & missing_percent == 25 & Fst_class == "mean", plot(mac, Fst, type='l', col=col, ylim=c(0.035, 0.100), yaxt='n', main="Missing rate = 0.75 (25%)", ylab="Fst value", xlab="Minor Allele Count (mac)")]
x[dp == i & missing_percent == 25 & Fst_class == "weighted", lines(mac, Fst, type='l', col=col)]
legend("bottomleft", col=c("red", "blue", "black"), legend=c("mean Fst", "weighted Fst", "# SNPs"), lty=c(1,1,0), pch=c(NA, NA, 16))
axis(2, las=2)

par(new=TRUE)
x[dp == i & missing_percent == 25, plot(mac, num_snps, pch=16, axes=FALSE, xlab=NA, ylab=NA)]
axis(4, las=2)
mtext(side=4, line=3, "Number of SNPs", cex=0.75)

x[dp == i & missing_percent == "not_specified" & Fst_class == "mean", plot(mac, Fst, type='l', col=col, ylim=c(0.035, 0.100), yaxt='n', main="Missing rate not specified", ylab="Fst value", xlab="Minor Allele Count (mac)")]
x[dp == i & missing_percent == "not_specified" & Fst_class == "weighted", lines(mac, Fst, type='l', col=col)]
legend("bottomleft", col=c("red", "blue", "black"), legend=c("mean Fst", "weighted Fst", "# SNPs"), lty=c(1,1,0), pch=c(NA, NA, 16))
axis(2, las=2)

par(new=TRUE)
x[dp == i & missing_percent == "not_specified", plot(mac, num_snps, pch=16, axes=FALSE, xlab=NA, ylab=NA)]
axis(4, las=2)
mtext(side=4, line=3, "Number of SNPs", cex=0.75)

mtext(paste0("Effect of Minor Allele Count on Fst Values", "\n", "Depth = ", i), side=3, outer=TRUE, line=2, cex=2)
}
dev.off()