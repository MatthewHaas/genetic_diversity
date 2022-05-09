# wd: /home/jkimball/haasx092/TajimaD
library(data.table)

# Read in data
#cultivated <- fread("nucleotide_diversity_cultivated.sites.pi")
#natural_stands <- fread("nucleotide_diversity_natural_stands.sites.pi")
cultivated <- fread("nucleotide_diversity_cultivated_window.windowed.pi")
natural_stands <- fread("nucleotide_diversity_natural_stands_window.windowed.pi")


# Make a vector of chromosome names (will be the same in both, so it doesn't matter which data.table you select from)
chromosomes <- unique(cultivated$CHROM)

#ns <- natural_stands[CHROM == "ZPchr0001", aggregate(PI, list(POS %/% 1e6), FUN = mean)]

pdf("out.pdf")
par(mar = c(4, 4, 2, 10))
par(oma = c(0, 0, 0, 0))
for(i in chromosomes){
	if(i != "ZPchr0458"){
		ns <- as.data.table(natural_stands[, MID := apply(natural_stands[,.(BIN_START, BIN_END)],1,FUN=mean)])
		cm <- as.data.table(cultivated[, MID := apply(cultivated[,.(BIN_START, BIN_END)],1,FUN=mean)])
		cm[CHROM == i, plot(MID, PI, xlab = "position", ylab = "average nucleotide diversity (pi)", main = paste0("chromosome ", i), col = "#be0f34", type = "l", lwd = 2, las = 1)]
		ns[CHROM == i, lines(MID, PI, col = "#00a0df", lwd = 2)]
		legend("topright", inset = c(-0.4, 0.3), xpd = TRUE, legend = c("Cultivated", "Natural Stand"), col = c("#be0f34", "#00a0df"), lwd = 2, bty = "n")
		}
	else{
		cm[CHROM == "ZPchr0458", plot(MID, PI, xlab = "position", ylab = "average nucleotide diversity (pi)", main = paste0("chromosome ", i), col = "#be0f34", type = "l", lwd = 2, las = 1)]
		ns[CHROM == "ZPchr0458", lines(MID, PI, col = "#00a0df", lwd = 2)]
		legend("topright", inset = c(-0.4, 0.3), xpd = TRUE, legend = c("Cultivated", "Natural Stand"), col = c("#be0f34", "#00a0df"), lwd = 2, bty = "n")
	}
}
dev.off()
