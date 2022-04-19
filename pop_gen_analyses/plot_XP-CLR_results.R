# The perl one-liner below replaced the single whitespace characters in the map file with tab characters--I don't think this was strictly necessary
# perl -p -i -e 's/ /\t/g' nwr_map_data.snp

# The following line contains the headers of the XP-CLR output file
# chr# grid# #ofSNPs_in_window physical_pos genetic_pos XPCLR_score max_s
# Important to note that the genomic position is column 4 and the XP-CLR score is column 6

library(data.table)

chr1 <- fread("xp-clr_results_chr1.xpclr.txt")
chr2 <- fread("xp-clr_results_chr2.xpclr.txt")
chr3 <- fread("xp-clr_results_chr3.xpclr.txt")
chr4 <- fread("xp-clr_results_chr4.xpclr.txt")

setnames(chr1, c("chr_num", "grid_num", "num_snps_in_window", "physical_pos", "genetic_pos", "XPCLR_score", "max_s"))
setnames(chr2, c("chr_num", "grid_num", "num_snps_in_window", "physical_pos", "genetic_pos", "XPCLR_score", "max_s"))
setnames(chr3, c("chr_num", "grid_num", "num_snps_in_window", "physical_pos", "genetic_pos", "XPCLR_score", "max_s"))
setnames(chr4, c("chr_num", "grid_num", "num_snps_in_window", "physical_pos", "genetic_pos", "XPCLR_score", "max_s"))

pdf("out.pdf")
chr1[, plot(x = physical_pos, y = XPCLR_score,
			xlab = "Physical Position (Mb)",
			ylab = "XP-CLR score",
			las = 1)]
chr2[, plot(x = physical_pos, y = XPCLR_score,
			xlab = "Physical Position (Mb)",
			ylab = "XP-CLR score",
			las = 1)]
chr3[, plot(x = physical_pos, y = XPCLR_score,
			xlab = "Physical Position (Mb)",
			ylab = "XP-CLR score",
			las = 1)]
chr4[, plot(x = physical_pos, y = XPCLR_score,
			xlab = "Physical Position (Mb)",
			ylab = "XP-CLR score",
			las = 1)]
dev.off()
