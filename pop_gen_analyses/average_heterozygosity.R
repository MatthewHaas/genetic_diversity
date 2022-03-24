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
     ## Use names from the data list.
     labels = populations,
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
       
