# 14 November 2019
# WD: /home/jkimball/haasx092/main_GBS
# The purpose of this code is to *test* working with, filtering, and rearranging main_GBS SNP data in R using R CMD BATCH

library(data.table)
library(reshape2)

fread("191114_normalize.tsv") -> x

setnames(x, c("scaffold", "position", "ref", "alt", "quality", "sample", "GT", "V8", "DP", "DV"))
x[, V8 := NULL]
x[, sample := sub("/.+$", "", sample)]
x[, scaffold := sub(";.+$", "", scaffold)]

x[DP >= 8] -> y

# Change from long format to wide format
dcast(y, scaffold + position ~ sample, value.var="GT") -> yy
# Put back into data table format
yy <- as.data.table(yy)

yy[, sum := apply(yy, MARGIN=1, function(x) sum(is.na(x)))]

yy[sum < 100] -> z

save(z, file="191114_R_CMD_BATCH_test.Rdata")
