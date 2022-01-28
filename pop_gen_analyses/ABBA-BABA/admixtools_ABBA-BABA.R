library(admixtools) # for this analysis, you should be using R version 4.1.0
library(tidyverse)

# load data
geno = read_plink("plink_binary")

# assign cluster membership
cluster1 <- scan("cluster_1.txt", character())
aquatica <- scan("aquatica.txt", character())
cultivated <- scan("cultivated_material.txt", character())
cluster4 <- scan("cluster_4.txt", character())

# run d-statistics
f4(geno, cluster1, aquatica, cultivated, cluster4, f4mode = FALSE, sure = TRUE)
