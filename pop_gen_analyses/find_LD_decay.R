# Calculate LD decay
library(data.table)
library(tidyverse)
library(sommer) # needed for the LD.decay() function

# My markers are in 0,1,2 format (0=homozygous for the reference allele; 1=heterozygous; 2=homozygous for the alternate allele)
# Program asks for SNP data in -1,0,1 format. I have no clue why they chose such an odd format, but it seems like their functions are able to recognize 0,1,2 and convert it to -1,0,-1

# Read in SNP data. This will need to be converted to a matrix
# But first make sure to use `colClasses = 'string'` so that you can use the `mutate_if` function  to easily do the "find and replace"
data <- fread("211202_gbs_nov_2021_snps_10percent_miss_dp6_maf05_no_row_or_col_names.csv", colClasses = 'string')

# Read in map data. This can remain as a data.table (or data.frame if you are into that)
map_data <- fread("reneth_gbs_map_data.csv")

# Change column names of map_data to suit needs of LD.decay() function
setnames(map_data, c("Locus", "LG", "Position"))

data <- as_tibble(data) # convert data.table to tibble in order to do the "find and replace"

# Convert to -1,0,1 format; requires tidyverse
data <- data %>% mutate_if(is.character, str_replace_all, pattern = '0', replacement = '-1')
data <- data %>% mutate_if(is.character, str_replace_all, pattern = '1', replacement = '0')
data <- data %>% mutate_if(is.character, str_replace_all, pattern = '2', replacement = '1')

# Transpose data so that columns are markers and rows are individuals
data_t <- t(data)

# Convert data to matrix
data_t_m <- as.matrix(data_t)

# Convert data type back to numeric/integer from character. I thought it would help solve the issue of empty results. I was wrong-it didn't solve the problem--but also didn't appear to cause any problems.
class(data_t_m) <- "numeric"

# Set column names
colnames(data_t_m) <- map_data$Locus

# Calculate LD decay
LD.decay(data_t_m, map_data)
