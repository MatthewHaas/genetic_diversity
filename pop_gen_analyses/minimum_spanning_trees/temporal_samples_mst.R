library(adegenet)
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)
library(igraph)

load("temporal_samples_tree_dp4.Rdata", height = 30, width = 30)
rubi.dist <- bitwise.dist(gen_light_x)
rubi.msn <- poppr.msn(gen_light_x, rubi.dist, showplot = FALSE, include.ties = T)

node.size <- rep(2, times = nInd(gen_light_x))
names(node.size) <- indNames(gen_light_x)
vertex.attributes(rubi.msn$graph)$size <- node.size

set.seed(55)
pdf("temporal_samples_minimum_spanning_network.pdf", height = 30, width = 30)
plot_poppr_msn(gen_light_x, rubi.msn , palette =c("green3", "burlywood", "purple4", "hotpink"), gadj = 20)
dev.off()
