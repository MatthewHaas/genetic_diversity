library(data.table)
library(StAMPP)

# Load data
load("220406_snp_data_formatted_for_StAMPP.Rdata")

# Convert data to allele frequency data
ns.freq <- stamppConvert(data_t, "r")

# Find Nei's D (only gives population vs. population values)
NeisD_ns_results <- stamppNeisD(ns.freq, pop = TRUE)

# Do Fst (we already did it in VCFtools---but doesn't hurt to have another method!)
Fst_ns_results <- stamppFst(ns.freq)

# Write Nei's D results to CSV file
write.csv(NeisD_ns_results, file = "220406_NeiD_StAMPP_method_natural_stands.csv")

# Write the Fst results to CSV file (note: there are also p-values and bootstraps within the same object (Fst_ns_results))
write.csv(Fst_ns_results$Fsts, file = "220406_Fst_StAMPP_method_natural_stands.csv")

# Save data
save(Fst_ns_results, NeisD_ns_results, file = "220406_natural_stands_StAMPP_results.Rdata")
