# 26 September 2019
# WD: /home/jkimball/haasx092/umgc_pilot_study

# Load required packages
library(data.table)
library(reshape2)

# Read in data (2 million read depth)
fread("190926_variants_filt_2M_normalize.tsv") -> x

# Set column names (I'm not sure what all of the columns are or if they are relevant because of the way the VCF was created by UMGC)
setnames(x, c("scaffold", "pos", "ref", "alt", "quality", "sample", "GT", "V8", "V9", "V10"))

# Save data as an R data file 
save(x, file="190926_variants_filt_2M_normalize.Rdata")

# Convert from long format to wide format
y <- dcast(x, scaffold + pos ~ sample, value.var="GT")

# Convert back to data table format (using genotype "GT" as the variable value (vs ref or alt allele))
y <- as.data.table(y)

# Change colnames to fix accession names. I'm mostly interested in fixing NecktieLake (it is actually a river) but I am changing periods in accession names back to hyphens (although this is probably unnecessary since it doesn't change the meaning of the name)
setnames(y, c("scaffold", "pos", "14S-PS", "FY-C20", "GarfieldLake", "Itasca-C12", "NecktieRiver", "PM3E", "UpperRiceLake"))

# Create a csv file for export that can be used in downstream analyses and eventually deposited in a repository such as e!DAL
write.csv(y, file="190926_variants_filt_2M_normalize.csv", col.names=TRUE, row.names=FALSE)

# (Re)save the updated objects
save(x, y, file="190926_variants_filt_2M_normalize.Rdata")