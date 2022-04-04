# purpose of this is to make plot that shows the correlation between different heterozygosity calcuation methods (VCFtools vs PLINK)
# wd:/home/jkimball/haasx092/plink_incl_nonbiallelic_snps
library(data.table)

# Read in data (using full paths for absolute clarity even though it isn't technically needed for the plink data given our current working directory)
vcftools <- fread("/home/jkimball/haasx092/TajimaD/out.het")
plink <- fread("/home/jkimball/haasx092/plink_incl_nonbiallelic_snps/plink.het")

# Read in key
key <- fread("/home/jkimball/haasx092/plink_incl_nonbiallelic_snps/191021_main_GBS_sample_key_PBML-C20_renamed.csv")

# Remove unnecessary/duplicate column
plink[, FID := NULL]

# change column names so they can be merged (and make it obvious which columns belong to which program....all while making the suit my style and proper computational practices)
setnames(vcftools, c("sample_number", "OHOM_vcf", "EHOM_vcf", "NNM_vcf", "F_vcf"))
setnames(plink, c("sample_number", "OHOM_plink", "EHOM_plink", "NNM_plink", "F_plink"))

# Merge heterozygosity results
merged <- plink[vcftools, on = "sample_number"]

# clean up sample numbers
merged[, sample_number := sub("/.+$", "", sample_number)]

# Merge with key
merged <- merged[key, on = "sample_number"]

# Check unique sample identifiers so we can filter out the ones we don't want to keep
unique(merged$sample_ID_simplified)

samples_to_exclude <- c("Garfield Lake Old", "Shell Lake Old", "Big Fork River", "unknown", "Dovetail", "Johnson X Dora F4", "Itasca Haploid", "Latifolia")

filtered <- merged[!(sample_ID_simplified %in% samples_to_exclude)]

# Remove samples where there is no F value for either method (turns out this is just the pilot samples)
# There are 6 additional samples that are missing F values from plink, but have values for VCFtools---I think these are low-quality samples due to low genotyping
filt_no_pilot <- filtered[!is.na(F_plink) & !is.na(F_vcf)]

pdf("correlation_between_heterozygosity_calculation_methods.pdf")
filt_no_pilot[, plot(x = F_plink, y = F_vcf,
					 xlab = "Average heterozygosity (plink)",
					 ylab = "Average heterozygosity (VCFtools)", 
					 las = 1,
					 pch = 16)]
dev.off()

# Save data
save(filtered, filt_no_pilot, key, merged, plink, vcftools, samples_to_exclude, file = "220404_heterozygosity_calculation_correlation.Rdata")
