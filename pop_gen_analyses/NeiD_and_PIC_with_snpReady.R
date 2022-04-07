# purpose of this script is to calculate Nei's Diversity and Polymorphism Information Content with the R package snpReady
# useful vignette: https://cran.r-project.org/web/packages/snpReady/vignettes/snpReady-vignette.html
library(data.table)
library(impute) # probably not required to call this explicitly because it's a dependency of snpReady
library(snpReady)

# Read in data
# For snpReady to work, 2 different files are needed: a table with 4 columns (sample, marler, allele.1, allele.2); and
# and a matrix of genotypes: columns are MARKERS and rows are INDIVIDUALS. Genotypes are in nucleotide format (e.g., "CC", "CG", "GG", etc)
data <- fread("220406_snp_data_formatted_for_StAMPP.csv")
