# 22 October 2019
# WD: /home/jkimball/haasx092/main_GBS/191021_samtools
# The purpose of this code is to visualize the old and new samples from Garfield Lake and Shell Lake.

# On command line (note: "some_vcfs_merged.vcf.gz" represents part of the 17 largest scaffolds; bcftools concat aborted partway through the concatenation process)
plink --vcf some_vcfs_merged.vcf.gz --double-id --maf 0.05 --allow-extra-chr --recode --out myplink


# Make new object for Garfield and Shell Lakes (both old and new)
plink --pca --file myplink --keep Garfield_and_Shell_Lakes_Old_and_New.txt --allow-extra-chr -out myplink_GarfieldShell_pca

# Code for Garfield and Shell Lakes (Old and New)

# Read in eigenvectors to plot PCA
x <- fread("myplink_GarfieldShell_pca.eigenvec")

# Remove column 2 (redundant)
x[, V2 := NULL]

# Load in sample key
y <- fread("~/main_GBS/191021_main_GBS_sample_key.csv")

# set column names
setnames(x, c("sample", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10", "PC11", "PC12", "PC13",
			"PC14", "PC15", "PC16", "PC17", "PC18", "PC19", "PC20"))

setnames(y, c("sample", "ID", "simplified", "extended", "class"))

# Shorten sample name (change from directory path format) so that it can be merged with data table y
x[, sample := sub("/.+$", "", sample)]

# Keep only the samples we are interested for this analysis
y[simplified == "Garfield Lake" | simplified == "Garfield Lake Old" | simplified == "Shell Lake" | simplified == "Shell Lake Old"] -> y

# Read in eigenvalues (to determine % variation explained by each PC)
v <- fread("myplink_GarfieldShell_pca.eigenval")


# Calculate percent variation (note: I didn't bother renaming the columns to something informative since there is only one)
percentVar = c(PC1=v[1, V1] / sum(v$V1), PC2=v[2, V1] / sum(v$V1), PC3=v[3, V1] / sum(v$V1), PC4=v[4, V1] / sum(v$V1), PC5=v[5, V1] / sum(v$V1), PC6=v[6, V1] / sum(v$V1), PC7=v[7, V1] / sum(v$V1), PC8=v[8, V1] / sum(v$V1))

# Merge data tables
x[y, on="sample"] -> z

# Assign colors (doing it this way rather than with z[, col := .GRP, by="simplified] so I can make the colors in a specific order)
z[simplified == "Garfield Lake", col := 1]
z[simplified == "Garfield Lake Old", col := 2]
z[simplified == "Shell Lake", col := 3]
z[simplified == "Shell Lake Old", col := 4]


pdf("191022_main_gbs_garfield_and_shell_lakes_only.pdf", height=12, width=16)
z[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar[1]*100), "%"), ylab=paste0("PC2: ", round(percentVar[2]*100), "%"), main="main GBS", pch=16, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)

par(oma=c(0,0,0,0))
legend("bottomright", legend=c("Garfield Lake", "Garfield Lake Old", "Shell Lake", "Shell Lake Old"), pch=16, col=c(1:4), cex=1.5)

z[, plot(PC2, PC3, xlab=paste0("PC2: ", round(percentVar[2]*100), "%"), ylab=paste0("PC3: ", round(percentVar[3]*100), "%"), main="main GBS", pch=16, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)

par(oma=c(0,0,0,0))
legend("bottomright", legend=c("Garfield Lake", "Garfield Lake Old", "Shell Lake", "Shell Lake Old"), pch=16, col=c(1:4), cex=1.5)

z[, plot(PC3, PC4, xlab=paste0("PC3: ", round(percentVar[3]*100), "%"), ylab=paste0("PC4: ", round(percentVar[4]*100), "%"), main="main GBS", pch=16, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)

par(oma=c(0,0,0,0))
legend("bottomright", legend=c("Garfield Lake", "Garfield Lake Old", "Shell Lake", "Shell Lake Old"), pch=16, col=c(1:4), cex=1.5)

z[, plot(PC4, PC5, xlab=paste0("PC4: ", round(percentVar[4]*100), "%"), ylab=paste0("PC5: ", round(percentVar[5]*100), "%"), main="main GBS", pch=16, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)

par(oma=c(0,0,0,0))
legend("bottomright", legend=c("Garfield Lake", "Garfield Lake Old", "Shell Lake", "Shell Lake Old"), pch=16, col=c(1:4), cex=1.5)

z[, plot(PC5, PC6, xlab=paste0("PC5: ", round(percentVar[5]*100), "%"), ylab=paste0("PC6: ", round(percentVar[6]*100), "%"), main="main GBS", pch=16, col=col, cex=1.5, yaxt='n')]
axis(2, las=1)

par(oma=c(0,0,0,0))
legend("bottomright", legend=c("Garfield Lake", "Garfield Lake Old", "Shell Lake", "Shell Lake Old"), pch=16, col=c(1:4), cex=1.5)
dev.off()
