# 26 September 2019
# WD: /home/jkimball/haasx092/umgc_pilot_study

# Load required package
library(data.table)

# Read in data (2 million read depth)
fread("190926_variants_filt_2M_normalize.tsv") -> x

# Set column names (I'm not sure what all of the columns are or if they are relevant because of the way the VCF was created by UMGC)
setnames(x, c("scaffold", "pos", "ref", "alt", "quality", "sample", "GT", "V8", "V9", "V10"))

# Save data as an R data file 
save(x, file="190926_variants_filt_2M_normalize.Rdata")