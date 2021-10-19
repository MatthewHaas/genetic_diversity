library(data.table)
library(ade4)

# Load data
geo <- fread("geo_distances.csv")
genet <- fread("genetic_distances.csv")

# Convert to distance object
geo <- dist(geo)
genet <- dist(genet)

# Conduct Mantel test
mantel <- mantel.rtest(geo, genet, nrepet = 9999)

# Make plots
pdf("211019_mantel_test.pdf")
plot(mantel, xlab = "Simulated correlation", main = "Mantel test", las = 1)
dev.off()

pdf("211019_dotplot_for_mantel.pdf")
plot(geo, genet, xlab = "Geographic distance", ylab = "Genetic distance", main = "Correlation between genetic and geographical distance", las = 1, pch = 16)
dev.off()
