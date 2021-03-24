library(adegenet)
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)
library(igraph)

# Natural stands
load("natural_stand_tree_dp4.Rdata")

# minimum spanning network
rubi.dist <- bitwise.dist(gen_light_x)
rubi.msn <- poppr.msn(gen_light_x, rubi.dist, showplot = FALSE, include.ties = T)

node.size <- rep(2, times = nInd(gen_light_x))
names(node.size) <- indNames(gen_light_x)
vertex.attributes(rubi.msn$graph)$size <- node.size

set.seed(55)
pdf("natural_stands_minimum_spanning_network.pdf", height=50, width=50)
plot_poppr_msn(gen_light_x, rubi.msn , palette = c("red", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "red3"), gadj = 20)
dev.off()
