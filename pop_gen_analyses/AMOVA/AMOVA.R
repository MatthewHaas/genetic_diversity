# 23 September 2021
# WD: /home/jkimball/haasx092/AMOVA
# Purpose of this code is to perform an AMOVA (analysis of molecular variance)

# Load required packages
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(data.table)

args = commandArgs(trailingOnly = TRUE)

x <- read.vcfR(args[1])

# Load sample key--updated key has STRUCTURE populations defined
#y <- fread("~/main_GBS/191021_main_GBS_sample_key.csv")
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
setnames(y, c("sample", "population", "class", "STRUCTURE_K3", "STRUCTURE_K4", "STRUCTURE_K5"))

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
y[sample != "Sample_0975"] -> y # Remove this one due to missing data

y[population != "Big Fork River"] -> y # Remove "Big Fork River" samples
y[population != "Garfield Lake Old"] -> y # Remove old (2010) Garfield Lake (temporal) samples
y[population != "Shell Lake Old"] -> y # Remove old (2010) Shell Lake (temporal) samples
# Not sure if this function actually did anything??
strata(gen_light_x, formula = ~population, value = y)

# Add strata to the GENLIGHT object gen_light_x
strata(gen_light_x) <- y

# Get the names to agree with one another
# Turns out, this didn't do anything...but I think the issue might be that I need to ID the samples in a different manner
for (i in y$sample){
y[sample == i, sample := paste0(i, "/", i, "_sorted.bam")]
}

# Make a genlight object for natural stands only
natural_stand_gl <-  gen_light_x[gen_light_x@strata$class != "Breeding line"]
natural_stand_table <- y[class == "Natural stand"]
strata(natural_stand_gl, formula = ~population, value = natural_stand_table)

# Do the same for cultivated material
cultivated_gl <- gen_light_x[gen_light_x@strata$class != "Natural stand"]
cultivated_table <- y[class == "Breeding line"]
strata(cultivated_gl, formula = ~population, value = cultivated_table)

# Run AMOVAs
# quasieuclid method is the default correction for non-euclidean distance, but is explicitly included to remove all doubt from the mind of anyone who may read this code
natural_stand_results <- poppr.amova(natural_stand_gl, hier = ~population, algorithm = "farthest_neighbor", within = FALSE, method = "ade4", correction = "quasieuclid")
cultivated_results <- poppr.amova(cultivated_gl, hier = ~population, algorithm = "farthest_neighbor", within = FALSE, method = "ade4", correction = "quasieuclid")
natural_stand_v_cultivated_results <-poppr.amova(gen_light_x, hier = ~class, algorithm = "farthest_neighbor", within = FALSE, method = "ade4", correction = "quasieuclid")
STRUCTURE_K5_results <- poppr.amova(gen_light_x, hier = ~STRUCTURE_K5, algorithm = "farthest_neighbor", within = FALSE, method = "ade4", correction = "quasieuclid")

# print out results of AMOVA
print("natural_stand results:")
natural_stand_results
print("cultivated results:")
cultivated_results
print("natural_stand vs. cultivated results:")
natural_stand_v_cultivated_results
print("STRUCTURE_K5_results:")
STRUCTURE_K5_results

# significance testing
set.seed(999)
natural_stand_results_signif <- randtest(natural_stand_results, nrepet = 999)
cultivated_results_signif <- randtest(cultivated_results, nrepet = 999)
natural_stand_v_cultivated_results_signif <- randtest(natural_stand_v_cultivated_results, nrepet = 999)
STRUCTURE_K5_results_signif <- randtest(STRUCTURE_K5_results, nrepet = 999)


# plot results of significance testing
plot(natural_stand_results_signif)
plot(cultivated_results_signif)
plot(natural_stand_v_cultivated_results_signif)
plot(STRUCTURE_K5_results_signif)

# print out results of significance testing
print("natural stand results significance:")
natural_stand_results_signif
print("cultivated results significance:")
cultivated_results_signif
print("natural stands vs cultivated  significance:")
natural_stand_v_cultivated_results_signif
print("STRUCTURE_K5_results significance:")
STRUCTURE_K5_results_signif
