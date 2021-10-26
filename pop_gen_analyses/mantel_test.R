library(data.table)
library(ade4)

# Load data
geo <- fread("geo_distances_incl_ItascaC12.csv")
genet <- fread("genetic_distances_incl_ItascaC12.csv")

# Convert to distance object
geo <- dist(geo)
genet <- dist(genet)

# Conduct Mantel test
mantel <- mantel.rtest(geo, genet, nrepet = 9999)

# Make plots
pdf("211025_mantel_test_incl_ItascaC12.pdf")
plot(mantel, xlab = "Simulated correlation", main = "Mantel test", las = 1)
dev.off()

pdf("211025_dotplot_for_mantel_incl_ItascaC12.pdf")
plot(geo, genet, xlab = "Geographic distance", ylab = "Genetic distance", main = "Correlation between genetic and geographical distance", las = 1, pch = 16)
dev.off()
