# Load required packages
library(adegenet)
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)

# Read in genotype data
x <- read.vcfR("filt_20_NA_vcf_files_concat_short_sample_names.vcf") # use head(x) to explore

# Read in population data (modified from original sample CSV file to contain only the 919 samples in the VCF file)
pop.data <- read.table("main_gbs_919_indv.csv", sep = ",", header = TRUE)

# Confirm that all sammples in the VCF and the population data frame are included
all(colnames(x@gt)[-1] == pop.data$sample_number) # returns true

# Convert to a genlight object (for poppr and adegenet)
gen_light_x <- vcfR2genlight(x)

# Make a distance matrix
genLightX.dist <- dist(gen_light_x)

# Fix ploidy issue
ploidy(gen_light_x) <- 2

pop(gen_light_x) <- pop.data$sample_id

# Make a tree (note: this step took a few minutes. Not sure if it would crash if dataset were larger. Ultimately a good idea to run within a shell script submitted to SLURM)
tree <- aboot(gen_light_x, tree = "upgma", distance = bitwise.dist, sample = 100, showtree = F, cutoff = 50, quiet = T)

# Save progress
save(x, gen_light_x, genLightX.dist, tree, file = "210313_pop_gen_analysis.Rdata")

pdf("out.pdf", height = 100, width = 100)
cols <- brewer.pal(n = nPop(gen_light_x), name = "Spectral")
plot.phylo(tree, cex = 0.8, font = 2, adj = 0, tip.color =  cols[pop(gen_light_x)])
nodelabels(tree$node.label, adj = c(1.3, -0.5), frame = "n", cex = 0.8, font = 3, xpd = TRUE)
#legend(35,10,c("CA","OR","WA"),cols, border = FALSE, bty = "n")
legend('topleft', legend = c("CA","OR","WA"), fill = cols, border = FALSE, bty = "n", cex = 2)
axis(side = 1)
title(xlab = "Genetic distance (proportion of loci that are different)")
dev.off()


Mydata1 <- df2genind(x, ploidy = 2, ind.names = ind, pop = population, sep="")

vcfGenind <- vcf2genind("filt_20_NA_vcf_files_concat.vcf")

distgenEUCL <- dist(vcfGenind, method = "euclidean", diag = FALSE, upper = FALSE, p = 2)

# Make histogram
pdf("EUCLdist_Hist.pdf")
hist(distgenEUCL)
dev.off()

Mydata2 <-genind2loci(vcfGenind)

distgenEUCL <- dist(Mydata2, method = "euclidean", diag = FALSE, upper = FALSE, p = 2)

# session info
sink("sessionInfo.txt")
sessionInfo()
sink()
