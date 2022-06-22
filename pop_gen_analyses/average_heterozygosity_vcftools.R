library(data.table)

# Set working directory
setwd("~/Documents/wild_rice/genetic_diversity/Data/Inbreeding/")

# Read in data
data <- fread("heterozygosity_inbreeding_by_individual_SAMtools-BCFtools_pipeline_incl_nonbiallelic_snps.csv")

# Define populations
# Commenting this out because we changed the way we were defining the order of the populations (which was intially strictly alphanumerically without regard for cultivated/natural stand status). Trying to preserve the record of that initial work.
#populations <- unique(data$SAMPLE_ID)

# Re-define the `populations` vector with all of the cultivated varieties (without GPP/GPN) grouped together and with all of the natural stands grouped together (both still organized alphanumerically)
populations <- c("14PD-C10", "14S*PM3/PBM-C3", "14S*PS", "Barron", "FY-C20", "Itasca-C12", "Itasca-C20", "K2B-C16", "K2EFBP-C1", "K2EF-C16", "KPVN-C4", "KSVN-C4",
						   "PLaR-C20", "PM3/3*PBM-C3", "PM3/7*K2EF", "PM3E", "VE/2*14WS/*4K2EF", "VN/3*K2EF", "Bass Lake", "Clearwater River", "Dahler Lake", "Decker Lake",
						   "Garfield Lake", "Mud Hen Lake", "Necktie River", "Ottertail River", "Phantom Lake", "Plantagenet", "Shell Lake", "Upper Rice Lake", "Zizania aquatica")

# Create population index column in the data so that we can make a box plot. (The `boxplot()` function won't work on non-numeical characters)
j = 1
for(i in populations){
  data[SAMPLE_ID == i, population_index := as.numeric(j)]
  j = j + 1
}

# Make the background a nice shade of grey to make it easier to see some of the bright colors (especially yellow)
#par(bg = "#E1E1E1")

# Make plot
boxplot(F ~ population_index, data = data,
        xaxt = "n",
        xlab = "Population",
        ylab = "Inbreeding coefficient", # this was initially labeled "average expected heterozygosity"
        las = 1,
		col = "#E1E1E1",
        border = c(rep("black", 18), "red", "orange", "yellow3", "yellow", "green3","green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "red3"))

# Add labels
text(x = 1:length(populations),
     ## Move labels to just below bottom of chart.
     y = par("usr")[3] - 0.05,
     ## specify population/sample names and how many individuals each population had
     ## We could have used the `populations` list (and we initially did) but then wanted to add info about how many individuals each pop had.. so we must specify them literally
     labels = c("14PD-C10 (2)", "14S*PM3/PBM-C3 (3)", "14S*PS (5)", "Barron (25)", "FY-C20 (29)", "Itasca-C12 (31)", "Itasca-C20 (11)", "K2B-C16 (4)", "K2EFBP-C1 (5)", "K2EF-C16 (20)", "KPVN-C4 (4)", "KSVN-C4 (5)", "PLaR-C20 (4)", "PM3/3*PBM-C3 (6)", "PM3/7*K2EF (3)", "PM3E (17)", "VE/2*14WS/*4K2EF (2)", "VN/3*K2EF (4)", "Bass Lake (50)", "Clearwater River (50)", "Dahler Lake (50)", "Decker Lake (50)", "Garfield Lake (50)", "Mud Hen Lake (10)", "Necktie River (50)", "Ottertail River (50)", "Phantom Lake (20)", "Lake Plantagenet (50)", "Shell Lake (50)", "Upper Rice Lake (50)", "Zizania aquatica (50)"),
     ## Change the clipping region.
     xpd = NA,
     ## Rotate the labels by 35 degrees.
     srt = 35,
     ## Adjust the labels to almost 100% right-justified.
     adj = 0.965,
     ## Increase label size.
     cex = 0.7,
     # Color axis labels (natural stands) to match colors in the plot
     col = c(rep("black", 18), "red", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple", "red3"))
