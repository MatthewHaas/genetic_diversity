library(SeqArray)
library(SeqVarTools)
library(Rcpp)
source('/home/jkimball/haasx092/main_GBS/GBS_R_functions.R')

library(SNPRelate)
library(gdsfmt)

gds.fn <- 'snp_relate_practice.gds'

seqOpen(gds.fn)-> gds

(g <- read.gdsn(index.gdsn(gds, "genotype/data"), start=NULL, count=NULL))

g <- as.data.table(g)

write.csv(g, file="191115_snp_relate_practice.csv", row.names=TRUE, col.names=TRUE)

save(g, file="191115_snp_relate_practice.Rdata")
