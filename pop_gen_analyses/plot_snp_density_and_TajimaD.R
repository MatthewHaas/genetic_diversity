library(data.table)

setwd("~/Documents/wild_rice")

x <- fread("snp_density_500k_bp_bins.txt") # SNP density
xx  <- fread("TajimaD_500k_bp_bins.txt") # Tajima D

chromosomes <- unique(x$CHROM)

# 500,000 bp bins
pdf("snp_density_500k_bp_bins.pdf", height = 20, width = 20)
layout(matrix(c(1,5,9,13,17,
                2,6,10,14,0,
                3,7,11,15,0,
                4,8,12,16,0), nrow = 5), widths = c(1,1,1,1))
par(oma = c(3,5,3,3))
par(mar = c(4,4,4,4))
for (chr in chromosomes){
xx[CHROM == chr, plot(BIN_START/500000, N_SNPS,
                     xlab = "bin (size=500,000 bp)",
                     ylab = "SNP count",
                     main = chr,
                     cex.lab = 1.5,
                     las = 1,
                     type = "l",
                     family = "serif")]
par(new = TRUE)
xx[CHROM == chr,plot(BIN_START/500000, TajimaD,
           xlab = "",
           ylab = "",
           xaxt = "n",
           yaxt = "n",
           pch = 16,
           col = "red")]
  axis(side = 4, las = 1, col.axis = "red")
  mtext("Tajima D", side = 4, cex.lab = 1.5, col = "red", family = "serif", line = 2)
}
dev.off()

# 1,000,000 bp bins

y <- fread("snp_density_1million_bp_bins.txt") # SNP density
yy <- fread("TajimaD_1million_bp_bins.txt") # Tajima D

chromosomes <- unique(y$CHROM) # Repetitive but running this again-just in case

pdf("snp_density_1million_bp_bins.pdf", height = 20, width = 20)
layout(matrix(c(1,5,9,13,17,
                2,6,10,14,0,
                3,7,11,15,0,
                4,8,12,16,0), nrow = 5), widths = c(1,1,1,1))
par(oma = c(3,5,3,3))
par(mar = c(4,4,4,4))
for (chr in chromosomes){
  yy[CHROM == chr, plot(BIN_START/1000000, N_SNPS,
                       xlab = "bin (size=1,000,000 bp)",
                       ylab = "SNP count",
                       main = chr,
                       cex.lab = 1.5,
                       las = 1,
                       type = "l",
                       family = "serif")]
  par(new = TRUE)
  xx[CHROM == chr,plot(BIN_START/500000, TajimaD,
                       xlab = "",
                       ylab = "",
                       xaxt = "n",
                       yaxt = "n",
                       pch = 16,
                       col = "red")]
  axis(side = 4, las = 1, col.axis = "red")
  mtext("Tajima D", side = 4, cex.lab = 1.5, col = "red", family = "serif", line = 2)
}
dev.off()
