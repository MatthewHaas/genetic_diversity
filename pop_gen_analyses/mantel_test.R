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
pdf("220406_mantel_test_incl_ItascaC12.pdf")
plot(mantel, xlab = "Simulated correlation", main = "Mantel test", las = 1)
dev.off()

pdf("220406_dotplot_for_mantel_incl_ItascaC12_with_regression.pdf")
plot(geo, genet, xlab = "Geographic distance", ylab = "Genetic distance", main = "Correlation between genetic and geographical distance", las = 1, pch = 16)
abline(lm(genet ~ geo), col = "#00a54c", lwd = 2) # running the linear model by itself, e.g. `lm(genet ~ geo)` we find that the intercept is 78.225677 and the 2nd coefficient (geo) is 0.008665
text(x = 500, y = 76, "y = 78.22 + 0.0086x")
text(x = 500, y = 75, expression(italic("R")^"2" ~ " = 0.3981")) # The R^2 value came from running: `summary(lm(genet ~ geo))` -- it gives the R^2, coefficient, residuals, and more
dev.off()

# The code below this point (commented out) is old code--before I added the regression
# Make plots
#pdf("211019_mantel_test.pdf")
#plot(mantel, xlab = "Simulated correlation", main = "Mantel test", las = 1)
#dev.off()

#pdf("211019_dotplot_for_mantel.pdf")
#plot(geo, genet, xlab = "Geographic distance", ylab = "Genetic distance", main = "Correlation between genetic and geographical distance", las = 1, pch = 16)
#dev.off()
