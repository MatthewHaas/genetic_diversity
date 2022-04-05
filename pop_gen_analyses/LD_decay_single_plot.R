# this script is to make a genome-wide LD plot
library(data.table)
library(sommer) # the `sommer` package probably isn't necessary because we've already used the `LD.decay()` function-but might as well load it for consistency

# Load results from previous analysis (from the `LD_decay_separate_classes.R` script_)
load("220401_LD_decay_separate_classes.Rdata")

# Convert results to data.table foramt
data <- as.data.table(cultivated_results_linked$all.LG)

# Filter for significant data (p < 0.001)
# Note: right now, this only contains the results for the cultivated class of NWR. Ultimately, we will want to feature both classes in the same plot
sig <- data[p < 0.001]
sig <- sig[r2 < 1] # trying to improve loess curve

# Apply loess function--takes a few minutes, so be patient :)
# Also a first initial note: the loess curve is just a straight vertical line at x = 0
# The predicted values are less than 1 (which makes sense given that we are working with R^2..but how to get it to go the length of the x-axis?)
loess_values <- loess(sig$r2 ~ sig$d)
xvals <- seq(min(sig$d), max(sig$d), (max(sig$d) - min(sig$d))/1e6)

# other good green color: "#00a54c"

pdf("out.pdf")
sig[, plot(x = d, y = r2, xlab = "Distance",
						  ylab = expression("R"^"2"),
						  pch = 16,
						  col = "#a3aaad",
						  las = 1)]
sig[, lines(xvals, predict(loess_values, xvals), col = "#235e39", lwd = 2)]
dev.off()
