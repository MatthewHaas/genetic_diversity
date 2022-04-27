library(data.table)
library(rlist) # needed for the `list.rbind()` function

# Make a list of fienames to read in
#filelist = list.files(pattern = "*.txt") # the original results (includes all cultivated material, even non-cultivars)
#filelist = list.files(pattern = "xp-clor_results_2*.txt") # includes only the following cultivars: Barron, Itasca-C12, Itasca-C20, FY-C20, K2 (mostly to check if we could ID shattering loci)
filelist = list.files(pattern = "xp-clor_results_3*.txt") # switched the order of input files in shell script (so that natural stands were first) to see how that impacted the analysis


# Make a list of data.tables
datalist = lapply(filelist, function(x) fread(x, header=F))

# Apply column names to each table in the list
lapply(datalist, function(x) setnames(x, c("chr_num", "grid_num", "num_snps_in_window", "physical_pos", "genetic_pos", "XPCLR_score", "max_s")))

# Assign chromosome names to each item in list
names(datalist) <- c("ZPchr0001", "ZPchr0002", "ZPchr0003", "ZPchr0004", "ZPchr0005", "ZPchr0006", "ZPchr0007", "ZPchr0008", "ZPchr0009", "ZPchr0010", 
					 "ZPchr0011", "ZPchr0012", "ZPchr0013", "ZPchr0014", "ZPchr0015", "ZPchr0016", "ZPchr0458")

# Make one mega-table that contains all of the chromosomes in a single data table
combined <- list.rbind(datalist)

# Add color column
combined[chr_num %in% c(1,3,5,7,9,11,13,15,17), col := "#7a0019"] # odd-numbered chromosomes are maroon
combined[chr_num %in% c(2,4,6,8,10,12,14,16), col := "#ffcc33"] # even-numbered chromosomes are gold

# To get the manhattan-plot effect, we need to increase each subsequent genetic position by the maximum value of chr1 (and then do the same for each subsequent chromosome)
# This is why I'm opting to use the genetic position rather than physical... to keep the numbers on a more or less "sane" scale
# Purposely skipping chr1 because we don't want to alter those values (special case)
for(i in c(2:17)){
combined[chr_num == i, genetic_pos := genetic_pos + max(combined[chr_num == i-1]$genetic_pos)]
}

# Make vector containing midpoints of each chromosome for plotting chromosome names
midpoints = c()
for(i in c(1:17)){
midpoints <- append(midpoints, mean(combined[chr_num == i]$genetic_pos))
}


# Plotting genetic position rather than physical position shouldn't change the scale at all; it will just make the numbers easier to work with.

# Make the genome-wide plot
pdf("out.pdf", height = 10, width = 40)
combined[, plot(x = genetic_pos, y = XPCLR_score,
			xlab = "Chromosomes",
			ylab = "XP-CLR score",
			ylim = c(0,110),
			xaxt = 'n',
			col = col,
			las = 1)]
axis(side = 1, at = midpoints, labels = c("ZPchr0001", "ZPchr0002", "ZPchr0003", "ZPchr0004", "ZPchr0005", "ZPchr0006", "ZPchr0007", "ZPchr0008", "ZPchr0009", "ZPchr0010", 
					 "ZPchr0011", "ZPchr0012", "ZPchr0013", "ZPchr0014", "ZPchr0015", "ZPchr0016", "ZPchr0458"))
dev.off()

# Save data
save(filelist, datalist, combined, midpoints, file = "220420_XP-CLR_plotting_data.Rdata")
