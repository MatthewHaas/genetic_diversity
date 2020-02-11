# 11 February 2020
# WD: /home/jkimball/haasx092/main_GBS/hierfstat

# Needs to be submitted via a PBS script (launch_fst_with_hierfstat.sh)
# Otherwise will be killed for exceeding 15 minutes of user CPU time.

# Load required packages
library(data.table)
library(hierfstat)

# Read in data
x <- fread("191126_main_gbs_non-imputed_for_hierfstat.csv")

# Calculate Nei's Fst
y <- pairwise.neifst(x, diploid=TRUE)

# Write Fst table to a file
write.csv(y, file="200211_fst_from_hierfstat.csv", col.names=TRUE, row.names=TRUE, sep=",")

# Save data
save(x, y, file="200211_Fst_from_hierfstat.Rdata")
