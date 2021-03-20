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

z[, pch := 16] # assign all samples pch = 16 to start
z[, col := "grey"] # assign all samples col = grey to start

# Itasca family
# Dovetail and Itasca 'haploid' were here originally, but were filtered out of PLINK results
# Dovetail in particular greatly affects PCA apperance (due to repeated selfing of those lines)
z[extended == "Itasca-C12", col := "firebrick"]
z[extended == "Itasca-C12 Dur", col := "darkorange2"]
z[extended == "Itasca-C12GWDCO6", col := "gold"]
z[extended == "Itasca-C12GWK2", col := "chartreuse4"]
z[extended == "ItascaC12DUR", col := "dodgerblue" ]
z[extended == "ItascaC12IMLPG3", col := "darkorchid1"]
z[extended == "ItascaC12IMLS7", col := "darkorchid4"]

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
par(mar = c(4, 4, 2, 16))
plot(arg1, arg2, xlab = paste0(arg3, round(percentVar[arg4]*100), "%"),
                     ylab = paste0(arg5, round(percentVar[arg6]*100), "%"),
                     main = "Itasca-C12",
                     pch = pch,
                     col = col,
                     cex = 1.5,
                     yaxt = 'n')
axis(2, las = 1)

par(oma = c(0, 0, 0, 0))
legend("topright", inset = c(-0.2,0.3), xpd = TRUE,
                legend = c("Itasca-C12", "Itasca-C12 Dur", "Itasca-C12GWDCO6", "Itasca-C12GWK2", "Itasca-C12DUR", "Itasca-C12IMLPG3", "Itasca-C12IMLS7"),
                pch = c(16, 16, 16, 16, 16, 16, 16),
                col = c("firebrick", "darkorange2", "gold", "chartreuse4", "dodgerblue", "darkorchid1", "darkorchid4"),
                ncol = 1,
                cex = 1.2)
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
