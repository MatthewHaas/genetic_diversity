# Load required packages
library(data.table)
library(reshape2)

# Load data (from R session that was run interactively)
load("191119_main_gbs_snps_natural_stands_only.Rdata")

# Name scaffolds of interest
scaffolds_of_interest = c("Scaffold_1", "Scaffold_3", "Scaffold_9", "Scaffold_13", "Scaffold_18", "Scaffold_48", "Scaffold_51", "Scaffold_70", "Scaffold_93", "Scaffold_415", "Scaffold_693", "Scaffold_1062", "Scaffold_1063", "Scaffold_1064", "Scaffold_1065")

y[scaffold %in% scaffolds_of_interest] -> yy

# I tried using a depth of 9, but there are no SNPs at that level with an acceptable amount of missing data
# Depth of 8 ... 
yy[DP == 8] -> yy

dcast(yy, scaffold + position ~ sample, value.var="GT") -> yyy
yyy <- as.data.table(yyy)

yyy[, sum := apply(yyy, MARGIN=1, function(x) sum(is.na(x)))]

yyy[sum <= 125] -> depth8

write.csv(depth8, file="191119_main_gbs_snps_natural_stands_only_dp8.csv", row.names=FALSE, col.names=TRUE)
