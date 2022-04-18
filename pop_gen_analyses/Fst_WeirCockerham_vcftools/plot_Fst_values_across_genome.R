# wd: /home/jkimball/haasx092/Fst_vcftools
library(data.table)

# Read in data
x <- fread("out.weir.fst")

# Define unique chromosomes
chromosomes <- unique(x$CHROM)

# Make plots
pdf("out.pdf")
for (chr in chromosomes){
x[CHROM == chr, plot(POS %/% 1e6, WEIR_AND_COCKERHAM_FST,
                     xlab = "bin (size = 1 Mb)",
                     ylab = "Fst",
                     main = chr,
                     cex.lab = 1.5,
                     las = 1,
                     family = "serif")]}
dev.off()