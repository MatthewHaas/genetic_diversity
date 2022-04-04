# wd: /home/jkimball/haasx092/plink_incl_nonbiallelic_snps
# purpose: to try another method of calculating average heterozygosity because we don't believe VCFtools output
# plink command: `plink --het --file plink_incl_nonbiallelic --allow-extra-chr`
# now, move into R (version 3.6.0):

library(data.table)

# Read in data and key
data <- fread("plink.het")
key <- fread("191021_main_GBS_sample_key_PBML-C20_renamed.csv")

# Remove duplicate/redundant column
data[, FID := NULL]

# Trim unnecessary parts of sample names (the trailing part that is part of a the path to the BAM file)
# This will help us with pattern matching so we can use the key to get the same names
data[, IID := sub("/.+$", "", IID)]

# Change name of column containing sample numbers (IDs) in data file to allow merging with key
setnames(data, "IID", "sample_number")

# Merge tables
merged <- data[key, on = "sample_number"]

# Check which samples are present (this is a manual step as the results aren't saved anywhere--just here to make sure there is a record of it)
unique(merged$sample_ID_simplified)

# Use the output from the `unique()` function to make a vector object containing names we'll want to remove before proceeding further
# For now, we will be removing the Temporal Samples, but we will want to include those in a later plot/figure
samples_to_exclude <- c("Garfield Lake Old", "Shell Lake Old", "Big Fork River", "unknown", "Johnson X Dora F4", "Dovetail", "Itasca Haploid", "Latifolia")

# Might as well make the vector object to store the temportal samples to keep
temporal_samples <- c("Garfield Lake", "Garfield Lake Old", "Shell Lake", "Shell Lake Old")

# Remove unwanted samples
filtered <- merged[!(sample_ID_simplified %in% samples_to_exclude)]

# Make temporal-only table
temporal <- merged[sample_ID_simplified %in% temporal_samples]

# Remove samples with "NA" values from the filtered set
# There are 13 of them: 7 are from the pilot study but a further 6 are samples from this study which are completely lacking genotype data (1 Dahler Lake, 1 Barron, 2 FY-C20, 2 K2EF-C16)
filtered_no_NA <- filtered[!is.na(F)]

# Save data
save(data, filtered, filtered_no_NA, temporal, key, merged, samples_to_exclude, temporal_samples, file = "220404_average_heterozygosity_plink_results.Rdata")

## -- now we can recycle code from the first attempt at calculating average heterozygosity (using VCFtools) -- ##

# Create a vector object called populations (ordered alphabetically so populations will appear in the same order as they did in the one made with VCFtools)
populations <- unique(filtered_no_NA[order(sample_ID_simplified)]$sample_ID_simplified)

# Re-order to match the order they have for the VCFtools-heterozygosity plot
# Zizania aquatica appears where it does because it was originally called AquaticaSpecies during data collection, so it went before the "B"s like Barron and Bass Lake...
populations <- populations[c(1:3,34,4:33)]
# I also  noticed that Garfield Lake is out of place compared with the other "G"s (probably because they contain capital letters)
# This code will fix that
populations <- populations[c(1:10,14,11:13,15:34)]
# Phantom Lake and (Lake) Plantagenet are also out of order compared with the VCFtools-heterozygosity plot (again due to capitalization schemes among cultivars/breeding lines)
populations <- populations[c(1:24,29,30,25:28,31:34)]

# Create population index column in the data so that we can make a box plot. (The `boxplot()` function won't work on non-numeical characters)
j = 1
for(i in populations){
  filtered_no_NA[sample_ID_simplified == i, population_index := as.numeric(j)]
  j = j + 1
}

# We might still want to play around with the height and width to improve the look of the x-axis
pdf("average_heterozygosity_plink.pdf", height = 10, width = 10)
# Make the background a nice shade of grey to make it easier to see some of the bright colors (especially yellow)
par(bg = "#E1E1E1")

# Make plot
boxplot(F ~ population_index, data = filtered_no_NA,
        xaxt = "n",
        xlab = "Population",
        ylab = "Average Expected Heterozygosity",
        las = 1,
        border = c("black", "black", "black", "red3", "black", "red", "orange", "yellow3", "yellow", "black", "green3",
                   "black", "black", "black", "black", "black", "black", "black", "black", "black", "black", "green", "blue4",
                   "blue", "violetred3", "violet", "black", "black", "black", "black", "purple4", "purple", "black", "black"))

# Add labels
text(x = 1:length(populations),
     ## Move labels to just below bottom of chart.
     y = par("usr")[3] - 0.02,
     ## Use names from the data list.
     labels = c("14PD-C10 (2)", "14S*PM3/PBM-C3 (3)", "14S*PS (5)", "Zizania aquatica (50)", "Barron (25)", "Bass Lake (50)",
                "Clearwater River (50)", "Dahler Lake (50)", "Decker Lake (50)", "FY-C20 (29)", "Garfield Lake (50)", "GPB/K2B-C2 (3)",
                "GPN-1.20 (2)", "GPP-1.20 (6)", "Itasca-C12 (31)", "Itasca-C20 (11)", "K2B-C16 (4)", "K2EFBP-C1 (5)", "K2EF-C16 (20)", "KPVN-C4 (4)",
                "KSVN-C4 (5)", "Mud Hen Lake (10)", "Necktie River (50)", "Ottertail River (50)", "Phantom Lake (20)", "Lake Plantagenet (50)",
                "PLaR-C20 (4)", "PM3/3*PBM-C3 (6)", "PM3/7*K2EF (3)", "PM3E (17)", "Shell Lake (50)", "Upper Rice Lake (50)", "VE/2*14WS/*4K2EF (2)",
                "VN/3*K2EF (4)"),
     ## Change the clipping region.
     xpd = NA,
     ## Rotate the labels by 35 degrees.
     srt = 35,
     ## Adjust the labels to almost 100% right-justified.
     adj = 0.965,
     ## Decrease label size.
     cex = 0.7,
     # Color axis labels (natural stands) to match colors in the plot
     col = c("black", "black", "black", "red3", "black", "red", "orange", "yellow3", "yellow", "black", "green3",
             "black", "black", "black", "black", "black", "black", "black", "black", "black", "black", "green", "blue4",
             "blue", "violetred3", "violet", "black", "black", "black", "black", "purple4", "purple", "black", "black"))
dev.off()
