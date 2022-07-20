# wd: /home/jkimball/haasx092/combined_sweep_figure
library(data.table)

# Load nucleotide diversity data
load("/home/jkimball/haasx092/TajimaD/220420_nucleotide_diversity_data.Rdata")
# "combined" as an object name conflicts with the name of the object in the XP-CLR data, so I'm renaming it here
combined -> nucleotideDiv

# Load Fst data
load("/home/jkimball/haasx092/Fst_vcftools/220622_Fst_genome-wide_plot_cultivated_vs_natural_stands.Rdata")

# Load XP-CLR data
load("/home/jkimball/haasx092/XP-CLR/220420_XP-CLR_plotting_data.Rdata")

# Make midpoint vectors (one is needed for each sub-panel)
nucleotide_mids = c()
for(i in c(1:17)){
nucleotide_mids <- append(nucleotide_mids, mean(nucleotideDiv[CHROM_INDEX == i]$POS))
}

Fst_mids = c()
for(i in c(1:16)){
Fst_mids <- append(Fst_mids, mean(Fst[CHROM_INDEX == i]$POS))
}

XPCLR_mids = c()
for(i in c(1:17)){
XPCLR_mids <- append(XPCLR_mids, mean(combined[chr_num == i]$genetic_pos))
}

# Define chromosome boundaries for the nucleotide diversity plot
chr_bounds = c()
for(i in c(1:17)){
chr_bounds <- append(chr_bounds, max(nucleotideDiv[CHROM_INDEX == i]$POS))
}
# Make combined plot
pdf("220720_combined_sweep_figure.pdf", height = 15, width = 25)
par(oma = c(1,2,1,1))
par(mar = c(2,6,2,2))
layout(matrix(c(1,2,3), ncol = 1))
# Start with the nucleotide diversity figure
nucleotideDiv[CLASS == "cultivated", plot(x = POS, y = MEAN_PI,
			xlab = "Chromosomes",
			ylab = "average nucleotide diversity (pi)",
			ylim = c(0,0.7),
			xaxt = 'n',
			col = "#be0f34",
			pch = PCH,
			type = "o",
			cex.axis = 1.5,
			cex.lab = 1.5,
			las = 1)]
nucleotideDiv[CLASS == "natural stands", lines(x = POS, y = MEAN_PI,
			xlab = "Chromosomes",
			ylab = "average nucleotide diversity (pi)",
			ylim = c(0,0.7),
			xaxt = 'n',
			col = "#00a0df",
			pch = PCH,
			type = "o",
			las = 1)]
axis(side = 1, cex.axis = 2, at = nucleotide_mids, labels = c("ZPchr0001", "ZPchr0002", "ZPchr0003", "ZPchr0004", "ZPchr0005", "ZPchr0006", "ZPchr0007", "ZPchr0008", "ZPchr0009", "ZPchr0010", "ZPchr0011", "ZPchr0012", "ZPchr0013", "ZPchr0014", "ZPchr0015", "ZPchr0016", "ZPchr0458"))
abline(v = chr_bounds, col = "#a3aaad")
# Now, Fst
Fst[,plot(x = POS, y = WEIR_AND_COCKERHAM_FST,
			xlab = "Chromosomes",
			ylab = "Weir and Cockerham Fst",
			ylim = c(0,0.7),
			xaxt = 'n',
			col = COL,
			pch = 16,
	  		cex.axis = 1.5,
			cex.lab = 1.5,
			las = 1)]
axis(side = 1, cex.axis = 2, at = Fst_mids, labels = c("ZPchr0001", "ZPchr0002", "ZPchr0003", "ZPchr0004", "ZPchr0005", "ZPchr0006", "ZPchr0007", "ZPchr0008", "ZPchr0009", "ZPchr0010", "ZPchr0011", "ZPchr0012", "ZPchr0013", "ZPchr0014", "ZPchr0015", "ZPchr0016"))
# Last but not least, it's time for the XP-CLR plot
combined[, plot(x = genetic_pos, y = XPCLR_score,
			xlab = "Chromosomes",
			ylab = "XP-CLR score",
			ylim = c(0,110),
			xaxt = 'n',
			col = col,
			cex.axis = 1.5,
			cex.lab = 1.5,
			las = 1)]
axis(side = 1, cex.axis = 2, at = XPCLR_mids, labels = c("ZPchr0001", "ZPchr0002", "ZPchr0003", "ZPchr0004", "ZPchr0005", "ZPchr0006", "ZPchr0007", "ZPchr0008", "ZPchr0009", "ZPchr0010", "ZPchr0011", "ZPchr0012", "ZPchr0013", "ZPchr0014", "ZPchr0015", "ZPchr0016", "ZPchr0458"))
dev.off()
