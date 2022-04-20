library(data.table)

# Read in data
cultivated <- fread("nucleotide_diversity_cultivated.sites.pi")
natural_stands <- fread("nucleotide_diversity_natural_stands.sites.pi")

# Make vector object of unique chromosomes
chromosomes <- unique(cultivated$CHROM)

j = 1
for(chrom in chromosomes){
cultivated[CHROM == chrom, CHROM_INDEX := j]
natural_stands[CHROM == chrom, CHROM_INDEX := j]
j = j+1
}

# Divide each position by 1e8 so that when we add positions for them to be plotted in a linear order, they are of reasonable magnitude
# We first did this for the XP-CLR scan
cultivated[, POS := POS/1e8]
natural_stands[, POS := POS/1e8]

# Transform positions so they will plot one after the other (on a genomic scale) rather than re-starting at 0 at the start of each new chromosome
for(i in c(2:17)){
cultivated[CHROM_INDEX == i, POS := POS + max(cultivated[CHROM_INDEX == i-1]$POS)]
natural_stands[CHROM_INDEX == i, POS := POS + max(natural_stands[CHROM_INDEX == i-1]$POS)]
}

# Use the same color scheme as the XP-CLR plot
#cultivated[CHROM_INDEX %in% c(1,3,5,7,9,11,13,15,17), COL := "#7a0019"]
#cultivated[CHROM_INDEX %in% c(2,4,6,8,10,12,14,16), COL := "#ffcc33"]

# Differentiate class by shape
cultivated[, PCH := 1]
natural_stands[, PCH := 2]

# Make vector containing midpoints of each chromosome for plotting chromosome names
# We can use either the cultivated or natural stands data.tables because the genomic positions are identical for each
midpoints = c()
for(i in c(1:17)){
midpoints <- append(midpoints, mean(cultivated[CHROM_INDEX == i]$POS))
}

combined <- rbind(cultivated, natural_stands)
combined[CHROM_INDEX %in% c(1,3,5,7,9,11,13,15,17), COL := "#7a0019"]
combined[CHROM_INDEX %in% c(2,4,6,8,10,12,14,16), COL := "#ffcc33"]

# Add information about populations to help with the plotting
combined[PCH == 1, CLASS := "cultivated"]
combined[PCH == 2, CLASS := "natural stands"]

# Round by position to 3 decimal points
combined[, POS := round(POS,3)]

for(i in unique(combined$POS)){
combined[CLASS == "cultivated" & POS == i, MEAN_PI := mean(PI)]
combined[CLASS == "natural stands" & POS == i, MEAN_PI := mean(PI)]
}

# Make the genome-wide plot
pdf("out.pdf", height = 10, width = 40)
combined[CLASS == "cultivated", plot(x = POS, y = MEAN_PI,
			xlab = "Chromosomes",
			ylab = "average nucleotide diversity (pi)",
			ylim = c(0,0.7),
			xaxt = 'n',
			col = "black",
			pch = PCH,
			type = "o",
			las = 1)]
combined[CLASS == "natural stands", lines(x = POS, y = MEAN_PI,
			xlab = "Chromosomes",
			ylab = "average nucleotide diversity (pi)",
			ylim = c(0,0.7),
			xaxt = 'n',
			col = "#00a54c",
			pch = PCH,
			type = "o",
			las = 1)]
axis(side = 1, at = midpoints, labels = c("ZPchr0001", "ZPchr0002", "ZPchr0003", "ZPchr0004", "ZPchr0005", "ZPchr0006", "ZPchr0007", "ZPchr0008", "ZPchr0009", "ZPchr0010", 
					 "ZPchr0011", "ZPchr0012", "ZPchr0013", "ZPchr0014", "ZPchr0015", "ZPchr0016", "ZPchr0458"))
dev.off()

# Save data
save(combined, file = "220420_nucleotide_diversity_data.Rdata")
