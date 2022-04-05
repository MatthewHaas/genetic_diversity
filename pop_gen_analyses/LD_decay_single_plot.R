# this script is to make a genome-wide LD plot
library(data.table)
library(sommer) # the `sommer` package probably isn't necessary because we've already used the `LD.decay()` function-but might as well load it for consistency

# Load results from previous analysis (from the `LD_decay_separate_classes.R` script_)
load("220401_LD_decay_separate_classes.Rdata")

# Convert results to data.table foramt
data <- as.data.table(cultivated_results_linked$all.LG)

# Filter for significant data (p < 0.01)
# Note: right now, this only contains the results for the cultivated class of NWR. Ultimately, we will want to feature both classes in the same plot
sig <- data[p < 0.01]


# Apply loess function--takes a few minutes, so be patient :)
loess_values <- loess(sig$r2 ~ sig$d)

# other good green color: "#00a54c"

pdf("out.pdf")
sig[, plot(x = d, y = r2, xlab = "Distance",
						  ylab = expression("R"^"2"),
						  pch = 16,
						  col = "#a3aaad",
						  las = 1)]
sig[, lines(predict(loess_values), col = "#235e39", lwd = 2)]
dev.off()
