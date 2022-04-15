library(data.table)

# Alternate allele frequency (bins)--number refects first allele freq of that bin
x = c(0, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.0)

# Number of sites in each bin represented above
y = c(1673, 1261, 768, 587, 679, 370, 161, 216, 145, 95, 0)

data <- as.data.table(cbind(alt_freq = x, count = y))

pdf("220415_site_spectrum_frequency.pdf")
data[, barplot(names = alt_freq, height = count,
               xlab = "Alternate (derived) allele frequency",
               ylab = "Number of sites",
               las = 1,
               col = "#00a54c")]
dev.off()