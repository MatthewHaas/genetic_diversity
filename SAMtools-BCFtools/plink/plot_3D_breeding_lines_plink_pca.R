library(data.table)
options(rgl.useNULL = TRUE)
options(rgl.printRglwidget = TRUE)
library(rgl) # required for 3D plot

x <- fread("plink_20percent_NA_pca_breeding_lines.eigenvec")
# Remove column 2 (redundant)
x[, V2 := NULL]

y <- fread("comma-separated_files/191021_main_GBS_sample_key.csv")

# set column names
setnames(x, c("sample", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10", "PC11", "PC12", "PC13",
              "PC14", "PC15", "PC16", "PC17", "PC18", "PC19", "PC20"))

setnames(y, c("sample", "ID", "simplified", "extended", "class"))

# Shorten sample name (change from directory path format) so that it can be merged with data table y
x[, sample := sub("/.+$", "", sample)]

v <- fread("plink_20percent_NA_pca_breeding_lines.eigenval")
# Calculate percent variation (note: I didn't bother renaming the columns to something informative since there is only one)
percentVar = c(PC1=v[1, V1] / sum(v$V1), PC2=v[2, V1] / sum(v$V1), PC3=v[3, V1] / sum(v$V1), PC4=v[4, V1] / sum(v$V1), PC5=v[5, V1] / sum(v$V1), PC6=v[6, V1] / sum(v$V1), PC7=v[7, V1] / sum(v$V1), PC8=v[8, V1] / sum(v$V1))

# Merge data tables
x[y, on="sample"] -> z

z[, pch := 16] # assign all samples pch = 16 to start
z[, col := "grey"] # assign all samples col = grey to start

# Itasca family
# Dovetail and Itasca 'haploid' were here originally, but were filtered out of PLINK results
# Dovetail in particular greatly affects PCA apperance (due to repeated selfing of those lines)
z[simplified == "Itasca-C12", col := "darkgoldenrod1"]
#z[simplified == "Itasca-C12", pch := 21]

# PM3E family
z[simplified == "PM3E", col := "hotpink"]
z[simplified == "PM3/7*K2EF", col := "hotpink"]
z[simplified == "PM3/7*K2EF", pch := 17]
z[simplified == "PM3/3*PBM-C3", col := "hotpink"]
z[simplified == "PM3/3*PBM-C3", pch := 18]

# 14S family
z[simplified == "14S-PS", col := "chocolate2"]
z[simplified == "14S*PS", col := "chocolate2"]
z[simplified == "14S*PS", pch := 17]
z[simplified == "14S*PM3/PBM-C3", col := "chocolate2"]
z[simplified == "14S*PM3/PBM-C3", pch := 18]
z[simplified == "14PD-C10", col := "chocolate2"]
z[simplified == "14PD-C10", pch := 15]

# K2 family
z[simplified == "K2EF-C16", col := "blue4"]
z[simplified == "K2EFBP-C1", col := "blue4"]
z[simplified == "K2EFBP-C1", pch := 17]
z[simplified == "K2B-C16", col := "blue4"]
z[simplified == "K2B-C16", pch := 18]
z[simplified == "VN/3*K2EF", col := "blue4"]
z[simplified == "VN/3*K2EF", pch := 15]
z[simplified == "VE/2*14WS/*4K2EF", col := "blue4"]
z[simplified == "VE/2*14WS/*4K2EF", pch := 13]

# GP family
z[simplified == "GPB/K2B-C2", col := "cyan4"] # Maybe this one should be with K2 family?
z[simplified == "GPP-1.20", col := "cyan4"]
z[simplified == "GPP-1.20", pch := 17]
z[simplified == "GPN-1.20", col := "cyan4"]
z[simplified == "GPN-1.20", pch := 18]

# Other cultivars
z[simplified == "FY-C20", col := "wheat4"]
z[simplified == "Barron", col := "firebrick1"]
z[simplified == "PBML-C20", col := "darksalmon"]
z[simplified == "PLaR-C20", col := "forestgreen"]
z[simplified == "KPVN-C4", col := "darkviolet"] # I'm not sure if there should be a better place to put this one?
z[simplified == "KSVN-C4", col := "darkviolet"]
z[simplified == "KSVN-C4", pch := 17]

# Make 3D PCA plot
# It's already interactive
plot3d(z$PC1, z$PC2, z$PC3,, xlab = "PC1", ylab = "PC2", zlab = "PC3", main = "Breeding Lines", col = z$col, forceClipregion = TRUE)

# Not sure what this does
#play3d(spin3d())
