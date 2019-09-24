# 24 September 2019
# The purpose of this code is to prepare tables and figures for the Conservation Genetics paper using pilot_GBS study data that were previously analyzed by the UMGC.
# WD: /home/jkimball/haasx092/umgc_pilot_study

# These modules must be loaded before opening R
module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1

# R as well, naturally
module R/3.6.0

# Switch to R and load required packages
library(vcfR)
library(poppr) # this package required many steps to install. Need gdal version 2.3.2 and other modules to be installed at the start of each session
library(ape)
library(RColorBrewer)
library(data.table)

# Read in data from each vcf file separately
x_half_million <- read.vcfR("variants_0.5M.vcf.gz")
x_one_million <- read.vcfR("variants_1M.vcf.gz")
x_two_million <- read.vcfR("variants_2M.vcf.gz")
x_four_million <- read.vcfR("variants_4M.vcf.gz")
x_seven_million <- read.vcfR("variants_7M.vcf.gz")

# Save data (even though this is not a good stopping point)
save(x_half_million, x_one_million, x_two_million, x_four_million, x_seven_million, file="190924_re-analysis_of_umgc_analysis_pilot.Rdata")