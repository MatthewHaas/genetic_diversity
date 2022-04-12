# purpose of this script is to calculate Nei's Diversity and Polymorphism Information Content with the R package snpReady
# useful vignette: https://cran.r-project.org/web/packages/snpReady/vignettes/snpReady-vignette.html
library(data.table)
library(impute) # probably not required to call this explicitly because it's a dependency of snpReady
library(snpReady)

# Read in data
# For snpReady to work, 2 different files are needed: a table with 4 columns (sample, marler, allele.1, allele.2); and
# and a matrix of genotypes: columns are MARKERS and rows are INDIVIDUALS.)
cultivated <- fread("cultivated_formatted_for_StAMPP.csv")

# Remove unnecessary columns
cultivated[, V1 := NULL]
cultivated[, Ploidy := NULL]
cultivated[, Format := NULL]

# Make vector object of population names
cultivated_pops <- cultivated$Pop

# Now, we also need to remove the Sample column
cultivated[, Sample := NULL]
# Remove Pop column name
cultivated[, Pop := NULL]

# Convert data to matrix
cultivated_m <- as.matrix(cultivated)

rownames(cultivated_m) <- cultivated_pops

# the `raw.data()` function converts the genotype data coded as AA, AB, BB back to 0, 1, 2
cult.geno.ready <- raw.data(data = cultivated_m, frame = "wide", base = TRUE, sweep.sample = 0.5, call.rate = 0.95, maf = 0.10, imput = FALSE)

# Convert "clean" data to new object
cult_M <- cult.geno.ready$M.clean

# Define subgroups
cult_subgroups <- as.matrix(c(rep("14S_PS", 5), rep("Barron", 25), rep("FY_C20", 29), rep("Itasca_C12", 31), rep("Itasca_C20", 11), rep("K2EF_C16", 20), rep("PM3E", 17)))

# Do popgen analyses (they are all under this umbrella)
# Before we can get the results we are looking for (namely, Nei's D and PIC) we need to define subgroups
cult_popgen_res <- popgen(M = cult_M, subgroups = cult_subgroups)

# Define where to find data for plotting
# For some reason, R does not like the 14S-PS one. Maybe because it starts with a number?
# 14S_PS = cult_popgen_res$bygroup$14S_PS$Markers$GD,
cult_popgen_data <- as.data.table(cbind(
								   Barron = cult_popgen_res$bygroup$Barron$Markers$GD,
								   FY_C20 = cult_popgen_res$bygroup$FY_C20$Markers$GD,
								   Itasca_C12 = cult_popgen_res$bygroup$Itasca_C12$Markers$GD,
								   Itasca_C20 = cult_popgen_res$bygroup$Itasca_C20$Markers$GD,
								   K2EF_C16 = cult_popgen_res$bygroup$K2EF_C16$Markers$GD,
								   PM3E = cult_popgen_res$bygroup$PM3E$Markers$GD))

# build data table for plotting purposes
# first build individual data.tables for each population...
Barron_data <- as.data.table(cbind(population = rep("Barron",length(cult_popgen_res$bygroup$Barron$Markers$GD)), GD = cult_popgen_res$bygroup$Barron$Markers$GD))
FY_C20_data <- as.data.table(cbind(population = rep("FY_C20",length(cult_popgen_res$bygroup$FY_C20$Markers$GD)), GD = cult_popgen_res$bygroup$FY_C20$Markers$GD))
Itasca_C12_data <- as.data.table(cbind(population = rep("Itasca_C12",length(cult_popgen_res$bygroup$Itasca_C12$Markers$GD)), GD = cult_popgen_res$bygroup$Itasca_C12$Markers$GD))
Itasca_C20_data <- as.data.table(cbind(population = rep("Itasca_C20",length(cult_popgen_res$bygroup$Itasca_C20$Markers$GD)), GD = cult_popgen_res$bygroup$Itasca_C20$Markers$GD))
K2EF_C16_data <- as.data.table(cbind(population = rep("K2EF_C16",length(cult_popgen_res$bygroup$K2EF_C16$Markers$GD)), GD = cult_popgen_res$bygroup$K2EF_C16$Markers$GD))
PM3E_data <- as.data.table(cbind(population = rep("PM3E",length(cult_popgen_res$bygroup$PM3E$Markers$GD)), GD = cult_popgen_res$bygroup$PM3E$Markers$GD))

# now use `rbind()` to put them all into a single data.table
cult_geneDiversityData <- rbind(Barron_data, FY_C20_data, Itasca_C12_data, Itasca_C20_data, K2EF_C16_data, PM3E_data)

cult_poplist = c("Barron", "FY_C20", "Itasca_C12", "Itasca_C20", "K2EF_C16", "PM3E")

# Add a population index column so we can make a boxplot
j = 1
for(i in cult_poplist){
cult_geneDiversityData[population == i, population_index := j]
j = j + 1
}

# The gene diversity data (in the column GD) is currently a character string nand needs to be converted to numeric otherwise `boxplot()` won't work
cult_geneDiversityData[, GD := as.numeric(cult_geneDiversityData$GD)]

pdf("cultivated_nei_gene_diversity.pdf")
boxplot(GD ~ population_index, data = cult_geneDiversityData,
		xaxt = "n",
		xlab = "Population",
		ylab = "Nei's Gene Diversity",
		las = 1,
		border = "black")

# Add labels
text(x = 1:length(cult_poplist),
     ## Move labels to just below bottom of chart.
     y = par("usr")[3] - 0.01,
     ## Use names from the data list.
     labels = c("Barron (25)", "FY-C20 (29)", "Itasca-C12 (31)", "Itasca-C20 (11)", "K2EF-C16 (20)", "PM3E (17)"),
     ## Change the clipping region.
     xpd = NA,
     ## Rotate the labels by 35 degrees.
     srt = 35,
     ## Adjust the labels to almost 100% right-justified.
     adj = 0.965,
     ## Decrease label size.
     cex = 0.7,
     # Color axis labels
     col = "black")
dev.off()
