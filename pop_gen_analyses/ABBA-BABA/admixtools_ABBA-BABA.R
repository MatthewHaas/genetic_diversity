library(admixtools)
library(tidyverse)

# load data
geno = read_plink("plink_modified")

# assign cluster membership
cluster1 <- scan("cluster_1.txt", character())
aquatica <- scan("aquatica.txt", character())
cultivated <- scan("cultivated_material.txt", character())
cluster4 <- scan("cluster_4.txt", character())

# run d-statistics
f4(geno, natural_stand_1, aquatica, cultivated, natural_stand_2)
