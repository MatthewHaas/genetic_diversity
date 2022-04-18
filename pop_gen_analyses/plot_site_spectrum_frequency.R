library(data.table)

# Alternate allele frequency (bins)--number refects first allele freq of that bin
# Originally, we used bin sizes of 0.10 but switched to 0.02-sized bins at the suggestion of a collaborator
x = seq(from = 0, to = 1, by = 0.02)

# Number of sites in each bin represented above
# These numbers (commented out) are from when the cultivated and natural stands were combined and include Big Fork River temporal samples, and Zizania aquatica
#y = c(1673, 1261, 768, 587, 679, 370, 161, 216, 145, 95, 0)
ns <- c(0, 133, 400, 534, 448, 379, 305, 254, 217, 200, 181, 140, 144, 151, 128, 116, 133, 120, 125, 120, 107, 154,
             143, 107, 136, 156, 80, 59, 52, 42, 49, 36, 34, 29, 29, 58, 28, 39, 41, 26, 29, 25, 39, 31, 45, 46, 32, 22, 8, 5, 1)


cm <- c(0, 398, 379, 269, 224, 236, 224, 237, 195, 192, 184, 184, 164, 154, 143, 115, 110, 119, 88, 90, 97, 119, 118, 116, 131,
             141, 95, 65, 26, 43, 45, 38, 48, 41, 24, 41, 40, 29, 30, 21, 18, 23, 29, 37, 24, 28, 37, 13, 17, 2, 0)


data_ns <- as.data.table(cbind(alt_freq = x, count = ns))
data_cm <- as.data.table(cbind(alt_freq = x, count = cm))



pdf("220418_site_spectrum_frequency_separate_classes.pdf", height = 10, width = 26)
par(oma = c(1,2,1,0))
par(mar = c(6,6,4,0))
layout(matrix(c(1, 2), nrow = 1), widths = c(10,10))
midpoints <- data_ns[, barplot(names = alt_freq, height = count,
               xlab = "Alternate (derived) allele frequency",
               ylab = "Number of sites",
               main = "Natural Stands",
               ylim = c(0,550),
               xaxt = 'n',
               las = 1,
               cex.main = 2,
               cex.lab = 1.75,
               cex.axis = 1.5,
               col = "#00a54c")]
text(x = midpoints,
     ## Move labels to just below bottom of chart.
     y = par("usr")[3] - 10,
     ## Use names from the data list.
     labels = seq(from = 0, to = 1, by = 0.02),
     ## Change the clipping region.
     xpd = NA,
     ## Rotate the labels by 35 degrees.
     srt = 65,
     ## Adjust the labels to almost 100% right-justified.
     adj = 0.965,
     ## Increase label size.
     cex = 1.2,
     # Color axis labels
     col = "black")
midpoints <- data_cm[, barplot(names = alt_freq, height = count,
                  xlab = "Alternate (derived) allele frequency",
                  ylab = "Number of sites",
                  main = "Cultivated",
                  ylim = c(0,550),
                  xaxt = 'n',
                  las = 1,
                  cex.main = 2,
                  cex.lab = 1.75,
                  cex.axis = 1.5,
                  col = "#00a54c")]
# Add labels
text(x = midpoints,
     ## Move labels to just below bottom of chart.
     y = par("usr")[3] - 10,
     ## Use names from the data list.
     labels = seq(from = 0, to = 1, by = 0.02),
     ## Change the clipping region.
     xpd = NA,
     ## Rotate the labels by 35 degrees.
     srt = 65,
     ## Adjust the labels to almost 100% right-justified.
     adj = 0.965,
     ## Increase label size.
     cex = 1.2,
     # Color axis labels
     col = "black")
dev.off()
