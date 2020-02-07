# 6 February 2020
# WD: /home/jkimball/haasx092/main_GBS/imputation/200129_imputation
# Purpose of this code is to perform an AMOVA (analysis of molecular variance)

# Load required packages
library(poppr)
library(data.table)

# Load R package that contains the genlight object needed to do AMOVA
load("200204_popgen_with_poppr_imputed.Rdata")

# Load sample key
 y <- fread("~/main_GBS/191021_main_GBS_sample_key.csv")

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
y[sample != "Sample_1045"] -> y

# Not sure if this function actually did anything??
strata(gen_light_x, formula = ~sample/population/class, value = y)

# Add strata to the GENLIGHT object gen_light_x
strata(gen_light_x) <- y

# Do the AMOVA
# A few notes: as of today (7 February 2020), all three algorithms and both methods are producing identical results.
# I would expect some variation between these different options, so more specific parameters are probably needed in this code to achieve different results.
poppr.amova(gen_light_x, hier = ~population/class, algorithm = "average_neighbor", method = "pegas")