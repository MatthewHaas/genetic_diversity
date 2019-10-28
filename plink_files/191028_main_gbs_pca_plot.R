# 28 October 2019
# WD: /home/jkimball/haasx092/main_GBS/191021_samtools
# The purpose of this code is to improve the PCA plot created on 22 October.
# The last version of this script was 191022_main_gbs_old_lake_and_dovetail_samples_removed.R.
# Some incorrectly labeled samples are now correct and aquatica samples are now triangles rather than circles.

# Load required package
library(data.table)

# Load previously saved data
load("191022_main_gbs_natural_stands_no_old_samples_or_dovetail.Rdata")

# Load in *updated* sample key (5 Dahler Lake samples were previously mislabeled as Bass Lake)
y <- fread("~/main_GBS/191021_main_GBS_sample_key.csv")

# Set column names
setnames(y, c("sample", "ID", "simplified", "extended", "class"))

# Merge data tables
x[y, on="sample"] -> z

# Color breeding lines grey
z[class == "Breeding line", col := "grey"]

# Pick colors for individual natural stand accessions 
# Same color scheme as before
z[simplified == "Aquatica_species", col := "red3"]
z[simplified == "Bass Lake", col := "red"]
z[simplified == "Big Fork River", col := "orange3"]
z[simplified == "Clearwater River", col := "orange"]
z[simplified == "Dahler Lake", col := "yellow3"]
z[simplified == "Decker Lake", col := "yellow"]
z[simplified == "Garfield Lake", col := "green3"]
z[simplified == "Latifolia", col := "black"]
z[simplified == "Mud Hen Lake", col := "green"]
z[simplified == "Necktie River", col := "blue4"]
z[simplified == "Ottertail River", col := "blue"]
z[simplified == "Phantom Lake", col := "violetred3"]
z[simplified == "Plantagenet", col := "violet"]
z[simplified == "Shell Lake", col := "purple4"]
z[simplified == "Upper Rice Lake", col := "purple"]

# Add symbols to make some lines stand out better (circles-16 for most, triangles-17 for other Zizania species)
z[, pch := 16]
z[simplified == "Latifolia", pch := 17]
z[simplified == "Aquatica_species", pch := 17]

# Set order so that natural stand material is plotted last (on top of the grey breeding lines)
z[order(ID)] -> z

# Make the plot... it might help to copy+paste this in segments to make sure all of the code (especially parentheses and brackets) is properly read by/accepted into the R environment. When I tried to do it all at once, it did not work properly. Instead of a prompt, I got a "+" indicating that something was missing. Nothing is actually missing.
pdf("191028_main_gbs_natural_stands_no_old_samples_or_dovetail.pdf", height=12, width=16)
z[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar[1]*100), "%"), ylab=paste0("PC2: ", round(percentVar[2]*100), "%"), pch=pch, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)
par(oma=c(0,0,0,0))
legend("topleft", legend=c("Aquatica species", "Bass Lake", "Big Fork River", "Clearwater River", "Dahler Lake", "Decker Lake", "Garfield Lake", "Mud Hen Lake", "Necktie River", "Ottertail River", "Phantom Lake", "Plantagenet", "Shell Lake", "Upper Rice Lake", "Latifolia", "Breeding Line"), pch=c(17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 16), col=c("red3", "red", "orange3", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "black", "grey"), ncol=3, cex=1.2)

z[, plot(PC2, PC3, xlab=paste0("PC2: ", round(percentVar[2]*100), "%"), ylab=paste0("PC3: ", round(percentVar[3]*100), "%"), pch=pch, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)
par(oma=c(0,0,0,0))
legend("topright", legend=c("Aquatica species", "Bass Lake", "Big Fork River", "Clearwater River", "Dahler Lake", "Decker Lake", "Garfield Lake", "Mud Hen Lake", "Necktie River", "Ottertail River", "Phantom Lake", "Plantagenet", "Shell Lake", "Upper Rice Lake", "Latifolia", "Breeding Line"), pch=c(17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 16), col=c("red3", "red", "orange3", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "black", "grey"), ncol=3, cex=1.2)

z[, plot(PC3, PC4, xlab=paste0("PC3: ", round(percentVar[3]*100), "%"), ylab=paste0("PC4: ", round(percentVar[4]*100), "%"), pch=pch, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)
par(oma=c(0,0,0,0))
legend("bottomright", legend=c("Aquatica species", "Bass Lake", "Big Fork River", "Clearwater River", "Dahler Lake", "Decker Lake", "Garfield Lake", "Mud Hen Lake", "Necktie River", "Ottertail River", "Phantom Lake", "Plantagenet", "Shell Lake", "Upper Rice Lake", "Latifolia", "Breeding Line"), pch=c(17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 16), col=c("red3", "red", "orange3", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "black", "grey"), ncol=3, cex=1.2)

z[, plot(PC4, PC5, xlab=paste0("PC4: ", round(percentVar[4]*100), "%"), ylab=paste0("PC5: ", round(percentVar[5]*100), "%"), pch=pch, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)
par(oma=c(0,0,0,0))
legend("bottomleft", legend=c("Aquatica species", "Bass Lake", "Big Fork River", "Clearwater River", "Dahler Lake", "Decker Lake", "Garfield Lake", "Mud Hen Lake", "Necktie River", "Ottertail River", "Phantom Lake", "Plantagenet", "Shell Lake", "Upper Rice Lake", "Latifolia", "Breeding Line"), pch=c(17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 16), col=c("red3", "red", "orange3", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "black", "grey"), ncol=3, cex=1.2)

z[, plot(PC5, PC6, xlab=paste0("PC5: ", round(percentVar[5]*100), "%"), ylab=paste0("PC6: ", round(percentVar[6]*100), "%"), pch=pch, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)
par(oma=c(0,0,0,0))
legend("bottomleft", legend=c("Aquatica species", "Bass Lake", "Big Fork River", "Clearwater River", "Dahler Lake", "Decker Lake", "Garfield Lake", "Mud Hen Lake", "Necktie River", "Ottertail River", "Phantom Lake", "Plantagenet", "Shell Lake", "Upper Rice Lake", "Latifolia", "Breeding Line"), pch=c(17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 16), col=c("red3", "red", "orange3", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "black", "grey"), ncol=3, cex=1.2)

z[, plot(PC6, PC7, xlab=paste0("PC6: ", round(percentVar[6]*100), "%"), ylab=paste0("PC7: ", round(percentVar[7]*100), "%"), pch=pch, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)
par(oma=c(0,0,0,0))
legend("topleft", legend=c("Aquatica species", "Bass Lake", "Big Fork River", "Clearwater River", "Dahler Lake", "Decker Lake", "Garfield Lake", "Mud Hen Lake", "Necktie River", "Ottertail River", "Phantom Lake", "Plantagenet", "Shell Lake", "Upper Rice Lake", "Latifolia", "Breeding Line"), pch=c(17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 16), col=c("red3", "red", "orange3", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "black", "grey"), ncol=3, cex=1.2)
dev.off()

# Save data
save(v, x, y, z, percentVar, file="191028_main_gbs_old_lake_and_dovetail_samples_removed.Rdata")
