library(adegenet)
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)
library(igraph)

load("natural_stand_tree_dp4.Rdata")

# Load the gl2gi (genlight to genind object; from dartR package but it had difficulties installing so I saved the required function separately under the name gl2gi.R)
source(gl2gi.R)

# Make genind object
gen_ind_x <- gl2gi(gen_light_x)

# Save the genind object (as prompted by the output of gl2gi)
save(gen_ind_x, file = "natural_stands_genind_obj.Rdata")

# Find Prevosti's distance
prevosti <- prevosti.dist(gen_ind_x)

# Some color stuff...
# Define col2hex() function (from: https://rdrr.io/cran/gplots/src/R/col2hex.R)
col2hex <- function(cname) {
    colMat <- col2rgb(cname)
    rgb(red=colMat[1,]/255, green=colMat[2,]/255,blue=colMat[3,]/255)
}

# Define my colors because we want to make it match the colors used in the PCA plots
# Not sure the conversion to HEX is strictly necessary since the error message I received had another cause, but it doesn't hurt to keep it, so I am leaving it in
myColors = c("red", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "red3")

hexColorList <- vector() # initiate empty vector
for (color in myColors){
	hexColor = col2hex(color)
	hexColorList <- c(hexColorList, hexColor)
}

# Make the plot
pdf("natural_stands_prevosti.pdf")
plot(nj(prevosti), main = "Prevosti", type = "unrooted", edge.color=hexColorList[pop(gen_ind_x)], show.tip.label = FALSE)
add.scale.bar(lcol = "red", length = 0.1)
dev.off()
