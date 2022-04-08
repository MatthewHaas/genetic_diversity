# purpose of this script is to calculate Nei's Diversity and Polymorphism Information Content with the R package snpReady
# useful vignette: https://cran.r-project.org/web/packages/snpReady/vignettes/snpReady-vignette.html
library(data.table)
library(impute) # probably not required to call this explicitly because it's a dependency of snpReady
library(snpReady)

# Read in data
# For snpReady to work, 2 different files are needed: a table with 4 columns (sample, marler, allele.1, allele.2); and
# and a matrix of genotypes: columns are MARKERS and rows are INDIVIDUALS. Genotypes are in nucleotide format (e.g., "CC", "CG", "GG", etc)
data <- fread("220406_snp_data_formatted_for_StAMPP.csv")

# Remove unnecessary columns
data[, V1 := NULL]
#data[, Pop := NULL]
data[, Ploidy := NULL]
data[, Format := NULL]

# Make vector object of population names
populations <- data$Pop

# Remove white space from population names
populations <- gsub(" ", "", populations)

# Make vector object of sample names
#sample_names <- data$Sample

# Now, we also need to remove the Sample column
data[, Sample := NULL]
# Remove Pop column name
data[, Pop := NULL]

# Convert data to matrix
data_m <- as.matrix(data)

rownames(data_m) <- populations

# the `raw.data()` function converts the genotype data coded as AA, AB, BB back to 0, 1, 2
geno.ready <- raw.data(data = data_m, frame = "wide", base = TRUE, sweep.sample = 0.5, call.rate = 0.95, maf = 0.10, imput = FALSE)

# Convert "clean" data to new object
M <- geno.ready$M.clean

# Define subgroups
subgroups <- as.matrix(c(rep("BassLake", 50), rep("ClearwaterRiver", 50), rep("DahlerLake", 50), rep("DeckerLake", 50), rep("GarfieldLake", 50), rep("MudHenLake", 10), rep("NecktieRiver", 50), rep("OttertailRiver", 50), rep("PhantomLake", 20), rep("Plantagenet", 50), rep("ShellLake", 50), rep("UpperRiceLake", 50)))

# Do popgen analyses (they are all under this umbrella)
# Before we can get the results we are looking for (namely, Nei's D and PIC) we need to define subgroups
popgen_res <- popgen(M = M, subgroups = subgroups)

# Save data
save(data, data_m, geno.ready, M, popgen_res, populations, sample_names, subgroups, file = "220407_snpReady_results.Rdata")



# Define where to find data for plotting
popgen_data <- as.data.table(cbind(BassLake = popgen_res$bygroup$BassLake$Markers$GD, ClearwaterRiver = popgen_res$bygroup$ClearwaterRiver$Markers$GD,
								   DahlerLake = popgen_res$bygroup$DahlerLake$Markers$GD, DeckerLake = popgen_res$bygroup$DeckerLake$Markers$GD,
								   GarfieldLake = popgen_res$bygroup$GarfieldLake$Markers$GD, MudHenLake = popgen_res$bygroup$MudHenLake$Markers$GD,
								   NecktieRiver = popgen_res$bygroup$NecktieRiver$Markers$GD, OttertailRiver = popgen_res$bygroup$OttertailRiver$Markers$GD,
								   PhantomLake = popgen_res$bygroup$PhantomLake$Markers$GD, Plantagenet = popgen_res$bygroup$Plantagenet$Markers$GD,
								   ShellLake = popgen_res$bygroup$ShellLake$Markers$GD, UpperRiceLake = popgen_res$bygroup$UpperRiceLake$Markers$GD))

# build data table for plotting purposes
# first build individual data.tables for each population...
bassLake_data <- as.data.table(cbind(population = rep("BassLake",length(popgen_res$bygroup$BassLake$Markers$GD)), GD = popgen_res$bygroup$BassLake$Markers$GD))
clearwaterRiver_data <- as.data.table(cbind(population = rep("ClearwaterRiver",length(popgen_res$bygroup$ClearwaterRiver$Markers$GD)), GD = popgen_res$bygroup$ClearwaterRiver$Markers$GD))
dahlerLake_data <- as.data.table(cbind(population = rep("DahlerLake",length(popgen_res$bygroup$DahlerLake$Markers$GD)), GD = popgen_res$bygroup$DahlerLake$Markers$GD))
deckerLake_data <- as.data.table(cbind(population = rep("DeckerLake",length(popgen_res$bygroup$DeckerLake$Markers$GD)), GD = popgen_res$bygroup$DeckerLake$Markers$GD))
garfieldLake_data <- as.data.table(cbind(population = rep("GarfieldLake",length(popgen_res$bygroup$GarfieldLake$Markers$GD)), GD = popgen_res$bygroup$GarfieldLake$Markers$GD))
mudhenLake_data <- as.data.table(cbind(population = rep("MudHenLake",length(popgen_res$bygroup$MudHenLake$Markers$GD)), GD = popgen_res$bygroup$MudHenLake$Markers$GD))
necktieRiver_data <- as.data.table(cbind(population = rep("NecktieRiver",length(popgen_res$bygroup$NecktieRiver$Markers$GD)), GD = popgen_res$bygroup$NecktieRiver$Markers$GD))
ottertailRiver_data <- as.data.table(cbind(population = rep("OttertailRiver",length(popgen_res$bygroup$OttertailRiver$Markers$GD)), GD = popgen_res$bygroup$OttertailRiver$Markers$GD))
phantomLake_data <- as.data.table(cbind(population = rep("PhantomLake",length(popgen_res$bygroup$PhantomLake$Markers$GD)), GD = popgen_res$bygroup$PhantomLake$Markers$GD))
plantagenet_data <- as.data.table(cbind(population = rep("Plantagenet",length(popgen_res$bygroup$Plantagenet$Markers$GD)), GD = popgen_res$bygroup$Plantagenet$Markers$GD))
shellLake_data <- as.data.table(cbind(population = rep("ShellLake",length(popgen_res$bygroup$ShellLake$Markers$GD)), GD = popgen_res$bygroup$ShellLake$Markers$GD))
upperriceLake_data <- as.data.table(cbind(population = rep("UpperRiceLake",length(popgen_res$bygroup$UpperRiceLake$Markers$GD)), GD = popgen_res$bygroup$UpperRiceLake$Markers$GD))

# now use `rbind()` to put them all into a single data.table
geneDiversityData <- rbind(bassLake_data, clearwaterRiver_data, dahlerLake_data, deckerLake_data, garfieldLake_data, mudhenLake_data, necktieRiver_data, ottertailRiver_data, phantomLake_data, plantagenet_data, shellLake_data, upperriceLake_data)

# make population list to iterate over so we can create a population index in the geneDiversityData data.table
# I could have just used `unique(populations)` for the for loop to iterate through, but then it doesn't put the populations in alphabetical order ;)
poplist = c("BassLake", "ClearwaterRiver", "DahlerLake", "DeckerLake", "GarfieldLake", "MudHenLake", "NecktieRiver", "OttertailRiver", "PhantomLake", "Plantagenet", "ShellLake", "UpperRiceLake")

# Add a population index column so we can make a boxplot
j = 1
for(i in poplist){
geneDiversityData[population == i, population_index := j]
j = j + 1
}

# The gene diversity data (in the column GD) is currently a character string nand needs to be converted to numeric otherwise `boxplot()` won't work
geneDiversityData[, GD := as.numeric(geneDiversityData$GD)]

pdf("natural_stands_nei_gene_diversity.pdf")
boxplot(GD ~ population_index, data = geneDiversityData,
		xaxt = "n",
		xlab = "Population",
		ylab = "Nei's Gene Diversity",
		las = 1,
		border = c("red", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple"))

# Add labels
text(x = 1:length(poplist),
     ## Move labels to just below bottom of chart.
     y = par("usr")[3] - 0.01,
     ## Use names from the data list.
     labels = c("Bass Lake (50)", "Clearwater River (50)", "Dahler Lake (50)", "Decker Lake (50)", "Garfield Lake (50)", "Mud Hen Lake (10)", "Necktie River (50)", 	"Ottertail River (50)", "Phantom Lake (20)", "Lake Plantagenet (50)", "Shell Lake (50)", "Upper Rice Lake (50)"),
     ## Change the clipping region.
     xpd = NA,
     ## Rotate the labels by 35 degrees.
     srt = 35,
     ## Adjust the labels to almost 100% right-justified.
     adj = 0.965,
     ## Decrease label size.
     cex = 0.7,
     # Color axis labels (natural stands) to match colors in the plot
     col = c("red", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple"))
dev.off()

# Now do polymorphism information content (PIC)
bassLake_pic <- as.data.table(cbind(population = rep("BassLake",length(popgen_res$bygroup$BassLake$Markers$PIC)), PIC = popgen_res$bygroup$BassLake$Markers$PIC))
clearwaterRiver_pic <- as.data.table(cbind(population = rep("ClearwaterRiver",length(popgen_res$bygroup$ClearwaterRiver$Markers$PIC)), PIC = popgen_res$bygroup$ClearwaterRiver$Markers$PIC))
dahlerLake_pic <- as.data.table(cbind(population = rep("DahlerLake",length(popgen_res$bygroup$DahlerLake$Markers$PIC)), PIC = popgen_res$bygroup$DahlerLake$Markers$PIC))
deckerLake_pic <- as.data.table(cbind(population = rep("DeckerLake",length(popgen_res$bygroup$DeckerLake$Markers$PIC)), PIC = popgen_res$bygroup$DeckerLake$Markers$PIC))
garfieldLake_pic <- as.data.table(cbind(population = rep("GarfieldLake",length(popgen_res$bygroup$GarfieldLake$Markers$PIC)), PIC = popgen_res$bygroup$GarfieldLake$Markers$PIC))
mudhenLake_pic <- as.data.table(cbind(population = rep("MudHenLake",length(popgen_res$bygroup$MudHenLake$Markers$PIC)), PIC = popgen_res$bygroup$MudHenLake$Markers$PIC))
necktieRiver_pic <- as.data.table(cbind(population = rep("NecktieRiver",length(popgen_res$bygroup$NecktieRiver$Markers$PIC)), PIC = popgen_res$bygroup$NecktieRiver$Markers$PIC))
ottertailRiver_pic <- as.data.table(cbind(population = rep("OttertailRiver",length(popgen_res$bygroup$OttertailRiver$Markers$PIC)), PIC = popgen_res$bygroup$OttertailRiver$Markers$PIC))
phantomLake_pic <- as.data.table(cbind(population = rep("PhantomLake",length(popgen_res$bygroup$PhantomLake$Markers$PIC)), PIC = popgen_res$bygroup$PhantomLake$Markers$PIC))
plantagenet_pic <- as.data.table(cbind(population = rep("Plantagenet",length(popgen_res$bygroup$Plantagenet$Markers$PIC)), PIC = popgen_res$bygroup$Plantagenet$Markers$PIC))
shellLake_pic <- as.data.table(cbind(population = rep("ShellLake",length(popgen_res$bygroup$ShellLake$Markers$PIC)), PIC = popgen_res$bygroup$ShellLake$Markers$PIC))
upperriceLake_pic <- as.data.table(cbind(population = rep("UpperRiceLake",length(popgen_res$bygroup$UpperRiceLake$Markers$PIC)), PIC = popgen_res$bygroup$UpperRiceLake$Markers$PIC))

geneDiversityPIC <- rbind(bassLake_pic, clearwaterRiver_pic, dahlerLake_pic, deckerLake_pic, garfieldLake_pic, mudhenLake_pic, necktieRiver_pic, ottertailRiver_pic, phantomLake_pic, plantagenet_pic, shellLake_pic, upperriceLake_pic)

# Add a population index column so we can make a boxplot
j = 1
for(i in poplist){
geneDiversityPIC[population == i, population_index := j]
j = j + 1
}

# The gene diversity data (in the column PIC) is currently a character string nand needs to be converted to numeric otherwise `boxplot()` won't work
geneDiversityPIC[, PIC := as.numeric(geneDiversityPIC$PIC)]

pdf("natural_stands_population_information_content.pdf")
boxplot(PIC ~ population_index, data = geneDiversityPIC,
		xaxt = "n",
		xlab = "Population",
		ylab = "Polymorphism Information Content",
		las = 1,
		border = c("red", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple"))

# Add labels
text(x = 1:length(poplist),
     ## Move labels to just below bottom of chart.
     y = par("usr")[3] - 0.01,
     ## Use names from the data list.
     labels = c("Bass Lake (50)", "Clearwater River (50)", "Dahler Lake (50)", "Decker Lake (50)", "Garfield Lake (50)", "Mud Hen Lake (10)", "Necktie River (50)", 	"Ottertail River (50)", "Phantom Lake (20)", "Lake Plantagenet (50)", "Shell Lake (50)", "Upper Rice Lake (50)"),
     ## Change the clipping region.
     xpd = NA,
     ## Rotate the labels by 35 degrees.
     srt = 35,
     ## Adjust the labels to almost 100% right-justified.
     adj = 0.965,
     ## Decrease label size.
     cex = 0.7,
     # Color axis labels (natural stands) to match colors in the plot
     col = c("red", "orange", "yellow3", "yellow", "green3", "green", "blue4", "blue", "violetred3", "violet", "purple4", "purple"))
dev.off()
