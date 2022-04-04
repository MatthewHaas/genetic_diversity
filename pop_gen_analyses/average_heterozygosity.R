library(data.table)

# Set working directory
setwd("~/wild_rice/main_GBS")

# Read in data
data <- fread("heterozygosity_by_individual_SAMtools-BCFtools_pipeline_incl_nonbiallelic_snps.csv")

# Define populations
populations <- unique(data$SAMPLE_ID)

# Create population index column in the data so that we can make a box plot. (The `boxplot()` function won't work on non-numeical characters)
j = 1
for(i in populations){
  data[SAMPLE_ID == i, population_index := as.numeric(j)]
  j = j + 1
}

# Make the background a nice shade of grey to make it easier to see some of the bright colors (especially yellow)
par(bg = "#E1E1E1")

# Make plot
boxplot(F ~ population_index, data = data,
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
     y = par("usr")[3] - 0.05,
     ## specify population/sample names and how many individuals each population had
     ## We could have used the `populations` list (and we initially did) but then wanted to add info about how many individuals each pop had.. so we must specify them literally
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
     ## Increase label size.
     cex = 0.7,
     # Color axis labels (natural stands) to match colors in the plot
     col = c("black", "black", "black", "red3", "black", "red", "orange", "yellow3", "yellow", "black", "green3",
             "black", "black", "black", "black", "black", "black", "black", "black", "black", "black", "green", "blue4",
             "blue", "violetred3", "violet", "black", "black", "black", "black", "purple4", "purple", "black", "black"))
       
