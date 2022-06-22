# Load required packages
library(adegenet)
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)

args = commandArgs(trailingOnly = TRUE)

# Read in genotype data
x <- read.vcfR(args[1]) # use head(x) to explore

# Read in population data (modified from original sample CSV file to contain only the 919 samples in the VCF file)
pop.data <- read.table(args[2], sep = ",", header = TRUE)

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

# Change tip labels to have sample ids rather than sample number
tree$tip.label <- as.character(pop.data$sample_id)

# Save progress
save(x, gen_light_x, genLightX.dist, tree, pop.data, file = args[3])

# Define col2hex() function (from: https://rdrr.io/cran/gplots/src/R/col2hex.R)
col2hex <- function(cname) {
    colMat <- col2rgb(cname)
    rgb(red=colMat[1,]/255, green=colMat[2,]/255,blue=colMat[3,]/255)
}

# Define my colors because we want to make it match the colors used in the PCA plots
# Not sure the conversion to HEX is strictly necessary since the error message I received had another cause, but it doesn't hurt to keep it, so I am leaving it in
# 28 September 2021 note: the order appears to be strange but it's to make sure all cultivated samples are colored grey and natural stands keep their original color
# The program sorts samples alphabetically, from 14S-PD & 14S-PS at the top to Zizania aquatica at the bottom. This took ~4 iterations to get right, but it works now!
myColors = c("grey", "grey", "grey", "grey", "red", "orange", "yellow3",  "yellow", "grey", "green3", "grey", "grey", "grey", "grey", "grey", "grey", "grey", "grey", "grey", "grey", "violet", "green", "blue4", "blue", "violetred3", "grey", "grey", "grey", "grey", "purple4", "purple", "grey", "grey", "red3")

hexColorList <- vector() # initiate empty vector
for (color in myColors){
        hexColor = col2hex(color)
        hexColorList <- c(hexColorList, hexColor)
}

# Initialize edge_colors vector with grey for each branch. Remember that `tree` is an object that was created above
# This makes the default color grey for each line (so that we don't need to specify all of the specific cultivars individually)
edge_colors <- rep("grey", Nedge(tree))

# Define which edges belong to which lake/river
# This will tell R which edges (branches) belong to which lake/river to correctly color them in the next step
BassLake <- which.edge(tree, "Bass Lake")
ClearwaterRiver <- which.edge(tree, "Clearwater River")
DahlerLake <- which.edge(tree, "Dahler Lake")
DeckerLake <- which.edge(tree, "Decker Lake")
GarfieldLake <- which.edge(tree, "Garfield Lake")
MudHenLake <- which.edge(tree, "Mud Hen Lake")
NecktieRiver <- which.edge(tree, "Necktie River")
OttertailRiver <- which.edge(tree, "Ottertail River")
PhantomLake <- which.edge(tree, "Phantom Lake")
Plantagenet <- which.edge(tree, "Lake Plantagenet")
ShellLake <- which.edge(tree, "Shell Lake")
UpperRiceLake <- which.edge(tree, "Upper Rice Lake")
Zaquatica <- which.edge(tree, "Z aquatica")

# Change colors for the natural stands to match PCA plots & collection map
# Once these are all done, each lake/river will be colored appropriately and the cultivated will remain grey
edge_colors[BassLake] <- "red"
edge_colors[ClearwaterRiver] <- "orange"
edge_colors[DahlerLake] <- "yellow3"
edge_colors[DeckerLake] <- "yellow"
edge_colors[GarfieldLake] <- "green3"
edge_colors[MudHenLake] <- "green"
edge_colors[NecktieRiver] <- "blue4"
edge_colors[OttertailRiver] <- "blue"
edge_colors[PhantomLake] <- "violetred3"
edge_colors[Plantagenet] <- "violet"
edge_colors[ShellLake] <- "purple4"
edge_colors[UpperRiceLake] <- "purple"
edge_colors[Zaquatica] <- "red3"

pdf(args[4], height = 75, width = 75) # original values were heigh=100 and width=15
plot.phylo(tree, cex = 1.5, font = 2, adj = 0, type = "fan", edge.color = edge_colors, tip.color =  hexColorList[pop(gen_light_x)])
nodelabels(tree$node.label, adj = c(1.3, -0.5), frame = "n", cex = 0.8, font = 3, xpd = TRUE)
axis(side = 1)
title(xlab = "Genetic distance (proportion of loci that are different)")
dev.off()
