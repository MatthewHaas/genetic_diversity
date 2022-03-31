# Load required package.
library(data.table)

args = commandArgs(trailingOnly = TRUE)

# Read in eigenvectors to plot PCA
x <- fread(args[1])

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

# Read in eigenvalues (to determine % variation explained by each PC)
v <- fread(args[2])


# Calculate percent variation (note: I didn't bother renaming the columns to something informative since there is only one)
percentVar = c(PC1=v[1, V1] / sum(v$V1), PC2=v[2, V1] / sum(v$V1), PC3=v[3, V1] / sum(v$V1), PC4=v[4, V1] / sum(v$V1), PC5=v[5, V1] / sum(v$V1), PC6=v[6, V1] / sum(v$V1), PC7=v[7, V1] / sum(v$V1), PC8=v[8, V1] / sum(v$V1))

# Merge data tables
x[y, on="sample"] -> z

# Pick colors for individual natural stand accessions 
z[simplified == "Aquatica_species", col := "red3"]
z[simplified == "Bass Lake", col := "red"]
#z[simplified == "Big Fork River", col := "orange3"]
z[simplified == "Clearwater River", col := "orange"]
z[simplified == "Dahler Lake", col := "yellow3"]
z[simplified == "Decker Lake", col := "yellow"]
z[simplified == "Garfield Lake", col := "green3"]
#z[simplified == "Latifolia", col := "black"]
z[simplified == "Mud Hen Lake", col := "green"]
z[simplified == "Necktie River", col := "blue4"]
z[simplified == "Ottertail River", col := "blue"]
z[simplified == "Phantom Lake", col := "violetred3"]
z[simplified == "Plantagenet", col := "violet"]
z[simplified == "Shell Lake", col := "purple4"]
z[simplified == "Upper Rice Lake", col := "purple"]

# And color breeding lines grey
z[class == "Breeding line", col := "grey"]

# Add symbols to make some lines stand out better (circles-16 for most, triangles-17 for others)
z[, pch := 16]
z[simplified == "Aquatica_species" | simplified == "AquaticaSpecies", pch := 17]

# Define a custom plotting function
# arg1 = PC to plot on x-axis (column name)
# arg2 = PC to plot on y-axis (column name)
# arg3 = string that is part of the x-axis label, specifying the PC used in arg1 (e.g., "PC1: "). Be sure to include the space!
# arg4 = integer specifying which PC is plotted along the x-axis (e.g., 1)
# arg5 = string that is part of the y-axis label, specifying the PC used in arg2 (e.g., "PC2: "). Be sure to include the space!
# arg6 = integer specifying which PC is plotted along the y-axis (e.g., 2)
# pch = plotting character parameter (in the context of this script, you only need to inclue the pch as an argument in the function (written just like that: pch -no quotes- because it's a column in the data table, just like PC1, PC2, etc)
# col = color parameter (same situation as pch)
plot_pcs <- function(arg1, arg2, arg3, arg4, arg5, arg6, pch, col){
par(mar = c(4, 8, 2, 19))
plot(arg1, arg2, xlab = paste0(arg3, round(percentVar[arg4]*100), "%"), 
		     ylab = "",
		     main = "",
		     pch = pch,
		     col = col,
		     cex = 2,
		     cex.lab = 2,
		     cex.axis = 2,
	             las = 1)
#axis(2, las = 1, cex.lab = 2, cex.axis = 2)
mtext(paste0(arg5, round(percentVar[arg6]*100), "%"), outer = FALSE, side = 2, line = 5.5, cex = 2)

par(oma = c(1, 1, 0, 1))
legend("topright", inset = c(-0.32,0.3), xpd = TRUE,
		legend = c(expression(italic("Z. aquatica")), "Bass Lake", "Clearwater River", "Dahler Lake", "Decker Lake", "Garfield Lake",
			"Mud Hen Lake", "Necktie River", "Ottertail River", "Phantom Lake", "Plantagenet", "Shell Lake", "Upper Rice Lake", "Breeding Line"),
		pch = c(17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16),
		col = c("red3", "red", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "grey"),
		ncol = 1,
		bty = 'n',
		cex = 2)		
}

# Make the plot
pdf(args[3], height=12, width=16)
z[, plot_pcs(PC1, PC2, "PC1: ", 1, "PC2: ", 2, pch, col)] 
z[, plot_pcs(PC2, PC3, "PC2: ", 2, "PC3: ", 3, pch, col)]
z[, plot_pcs(PC3, PC4, "PC3: ", 3, "PC4: ", 4, pch, col)]
z[, plot_pcs(PC4, PC5, "PC4: ", 4, "PC5: ", 5, pch, col)]
z[, plot_pcs(PC5, PC6, "PC5: ", 5, "PC6: ", 6, pch, col)]
dev.off()

# Save data
save(v, x, y, z, percentVar, file=args[4])
