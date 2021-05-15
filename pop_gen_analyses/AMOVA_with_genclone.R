# Load required packages
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)
load("natural_stands_genind_obj.Rdata")
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
y[sample != "Sample_0837"] -> y # this is the "uknown" line
y[sample != "Sample_1045"] -> y # Itasca "haploid"
y[sample != "Sample_1039"] -> y # Itasca "haploid
y[sample != "Sample_0800"] -> y
y[sample != "Sample_0875"] -> y
y[sample != "Sample_0962"] -> y
y <- y[class == "Natural stand" & population != "Big Fork River" & population != "Garfield Lake Old" & population != "Shell Lake Old"]
genclone_x <- as.genclone(gen_ind_x)
results <- poppr.amova(genclone_x, ~population, clonecorrect = TRUE)
