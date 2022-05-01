library(data.table)
library(reshape2)

# Set working directory
setwd("~/Documents") # done on my mac laptop

# Read in data
data <- fread("220429_STRUCTURE_results_K=14_colored_by_population.csv")

# Change column names (so they are all uniform/don't have population references in column names)
setnames(data, c("sample_number", "sample_id", "cluster_1", "cluster_2", "cluster_3", "cluster_4", "cluster_5", "cluster_6", "cluster_7", "cluster_8", "cluster_9", "cluster_10", "cluster_11", "cluster_12", "cluster_13", "cluster_14"))

# Convert wide-format to long-format data.
data_long <- melt(data, id.vars = c("sample_number", "sample_id"), variable.name = "cluster", value.name = "likelihood")

# assign colors
data_long[, col := "grey"] # Default to grey mostly so we don't need to worry about individual cultivated material names

# Now do the natural stands
data_long[sample_id =="Bass Lake", col := "red"]
data_long[sample_id =="Clearwater River", col := "orange"]
data_long[sample_id =="Dahler Lake", col := "yellow3"]
data_long[sample_id =="Decker Lake", col := "yellow"]
data_long[sample_id =="Garfield Lake", col := "green3"]
data_long[sample_id =="Mud Hen Lake", col := "green"]
data_long[sample_id =="Necktie River", col := "blue4"]
data_long[sample_id =="Ottertail River", col := "blue"]
data_long[sample_id =="Phantom Lake", col := "violetred3"]
data_long[sample_id =="Plantgenet", col := "violet"]
data_long[sample_id =="Shell Lake", col := "purple4"]
data_long[sample_id =="Upper Rice Lake", col := "purple"]
data_long[sample_id =="Zizania aquatica", col := "red3"]

for(i in c(1:nrow(data_long))){
  data_
}

# order data
data_long[order(sample_number)] -> ordered

# make vector object of unique sample names
unique(data_long[cluster == "cluster_1"]$sample_number) -> unique_sample_numbers

# make index to help with plotting individuals on the x-axis...
j = 1
for(i in unique_sample_numbers){
  data_long[sample_number == i, sample_index := j]
  j = j + 1
}

clusters <- c("cluster_1", "cluster_2", "cluster_3", "cluster_4", "cluster_5", "cluster_6", "cluster_7", "cluster_8", "cluster_9", "cluster_10", "cluster_11", "cluster_12", "cluster_13", "cluster_14")

pdf("220430_structure_barplots_k=14_test_plot.pdf", height = 50, width = 100)
par(mar = c(30,30,2,2))
par(oma = c(0,0,5,5))
for(i in clusters){
  data_long[cluster == i, barplot(likelihood, ylab = "likelihood", xlab = i, col = col, las = 1, cex.lab = 15, cex.axis = 10)]
}
dev.off()