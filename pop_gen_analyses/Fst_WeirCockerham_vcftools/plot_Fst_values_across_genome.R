# wd: /home/jkimball/haasx092/Fst_vcftools
library(data.table)

# Read in data
x <- fread("out.weir.fst")

# Define unique chromosomes
chromosomes <- unique(x$CHROM)

j = 1
for(chrom in chromosomes){
x[CHROM == chrom, CHROM_INDEX := j]
j = j+1
}

# Divide each position by 1e8 so that when we add positions for them to be plotted in a linear order, they are of reasonable magnitude
# We first did this for the XP-CLR scan
x[, POS_new := POS/1e8]

# Transform positions so they will plot one after the other (on a genomic scale) rather than re-starting at 0 at the start of each new chromosome
for(i in c(2:17)){
x[CHROM_INDEX == i, POS_new := POS_new + max(x[CHROM_INDEX == i-1]$POS_new)]
}

# Make vector containing midpoints of each chromosome for plotting chromosome names
# We can use either the cultivated or natural stands data.tables because the genomic positions are identical for each
midpoints = c()
for(i in c(1:17)){
midpoints <- append(midpoints, mean(x[CHROM_INDEX == i]$POS_new))
}

x[CHROM_INDEX %in% c(1,3,5,7,9,11,13,15,17), COL := "#7a0019"]
x[CHROM_INDEX %in% c(2,4,6,8,10,12,14,16), COL := "#ffcc33"]

# Make plots
pdf("out.pdf", height = 10, width = 40)
x[, plot(POS_new, WEIR_AND_COCKERHAM_FST,
                     xlab = "genomic position",
                     ylab = "Fst",
                     cex.lab = 1.5,
					 cex = 1.3,
                     las = 1,
					 pch = 16,
					 col = COL,
                     family = "serif")]
axis(side = 1, at = midpoints, labels = c("ZPchr0001", "ZPchr0002", "ZPchr0003", "ZPchr0004", "ZPchr0005", "ZPchr0006", "ZPchr0007", "ZPchr0008", "ZPchr0009", "ZPchr0010", 
					 "ZPchr0011", "ZPchr0012", "ZPchr0013", "ZPchr0014", "ZPchr0015", "ZPchr0016", "ZPchr0458"))
dev.off()

# Save data
save(chrom, chromosomes, midpoints, x, file = "220622_Fst_genome-wide_plot_cultivated_vs_natural_stands.Rdata")
