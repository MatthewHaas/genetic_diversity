# 11 March 2021
# WD: /home/jkimball/haasx092/main_GBS/210306_samtools
# Purpose of this code is to perform an AMOVA (analysis of molecular variance)

# Load required packages
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)

x <- read.vcfR("filt_20_NA_vcf_files_concat.vcf")

# Load sample key
y <- fread("210920_sample_key_with_population_structure.csv")

# Convert to a genlight object (for poppr and adegenet)
gen_light_x <- vcfR2genlight(x)
# Remove Itasca "haploid" samples
gen_light_x <- gen_light_x[indNames(gen_light_x) != "Sample_1039/Sample_1039_sorted.bam"]
gen_light_x <- gen_light_x[indNames(gen_light_x) != "Sample_1045/Sample_1045_sorted.bam"]

# Figure out which of the samples are "NA" for ploidy which is currently causing an error at the AMOVA stage
ploidy <- as.data.table(cbind(gen_light_x@ind.names, is.na(ploidy(gen_light_x))))
ploidy[V2 == "TRUE"] # Samples 800, 875, and 962
# Remove those samples
gen_light_x <- gen_light_x[indNames(gen_light_x) != "Sample_0800/Sample_0800_sorted.bam"]
gen_light_x <- gen_light_x[indNames(gen_light_x) != "Sample_0875/Sample_0875_sorted.bam"]
gen_light_x <- gen_light_x[indNames(gen_light_x) != "Sample_0962/Sample_0962_sorted.bam"]

# Remove unnecessary columns and rename columns for defined strata
y[, ID := NULL]
y[, sample_ID_extended := NULL]
setnames(y, c("sample", "population", "class"))

# Remove samples that are part of the overall GBS project, but are not in the subset being analyzed.
y[population != "Johnson X Dora F4"] -> y
y[population != "Dovetail"] -> y

# Remove pilot GBS samples
pilot_GBS <- c("Sample_1047", "Sample_1048", "Sample_1049", "Sample_1050", "Sample_1051", "Sample_1052", "Sample_1053", "Sample_1054")
y[!(sample %in% pilot_GBS)] -> y # This should be read as "sample not in pilot_GBS"

# One of the Itasca "haploids" was also removed from the subset being analyzed here..
y[sample != "Sample_0837"] -> y # this is the "uknown" line
y[sample != "Sample_1045"] -> y # Itasca "haploid"
y[sample != "Sample_1039"] -> y # Itasca "haploid
y[sample != "Sample_0800"] -> y
y[sample != "Sample_0875"] -> y
y[sample != "Sample_0962"] -> y

# Not sure if this function actually did anything??
strata(gen_light_x, formula = ~sample/population/class, value = y)

# Add strata to the GENLIGHT object gen_light_x
strata(gen_light_x) <- y

# Do the AMOVA
# A few notes: as of today (7 February 2020), all three algorithms and both methods are producing identical results.
# I would expect some variation between these different options, so more specific parameters are probably needed in this code to achieve different results.
poppr.amova(gen_light_x, hier = ~population/class, algorithm = "average_neighbor", method = "pegas")
