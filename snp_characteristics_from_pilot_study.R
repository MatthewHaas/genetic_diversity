# 29 July 2019
# WD: /home/jkimball/haasx092/pilot_GBS/190627_samtools
# The purpose of this code is to provide basic SNP stats (# of SNPs per scaffold, density, distance between SNPs) for the Cultivated Wild Rice Field Day

# module load R/3.6.0

library(data.table)

# load data
load("190627_snp_filtering_q60.Rdata")

# Remove low-quality scamples
x[quality > 100] -> x

# Make a new column to search by without the HiRise scaffold information appended to the main scaffold ID.
x[, scaffold_trimmed := gsub("\\;.*$", "", scaffold)]

# Trim superfluous information from the end of the sample (the file name is identical to the directory name)
x[, sample := gsub("\\/.*$", "", sample)]

# Try out a single scaffold/chromosome and count the number of occurrences (how many samples possess this SNP?)
x[scaffold_trimmed == "Scaffold_9", .N, by="position"] -> a

# Define scaffolds
scaffolds = c(1, 3, 7, 9, 13, 18, 48, 51, 70, 93, 415, 693, 1062, 1063, 1064, 1065)

# Count the number of rows (of SNPs) for each scaffold...grouped by scaffold so there should be multiple samples per SNP
lapply(c(1, 3, 7, 9, 13, 18, 48, 51, 70, 93, 415, 693, 1062, 1063, 1064, 1065), function(i) {
	nrow(x[scaffold_trimmed == paste0("Scaffold_", i), .N, by="position"])
}) -> snp_count

# Name items in list "snp_count"
names(snp_count) <- c("Scaffold_1", "Scaffold_3", "Scaffold_7", "Scaffold_9", "Scaffold_13", "Scaffold_18", "Scaffold_48", "Scaffold_51", "Scaffold_70", "Scaffold_93", "Scaffold_415", 
"Scaffold_693", "Scaffold_1062", "Scaffold_1063", "Scaffold_1064", "Scaffold_1065")

# Write to a csv file
write.table(snp_count, file="snp_count.csv", append=T, sep=",")

# Group SNPs by position for each scaffold (same code as lines 28-30...)
lapply(scaffolds, function(i) {
x[scaffold_trimmed == paste0("Scaffold_", i), .N, by="position"]
}) -> a

# Name items in list "a" (SNPs grouped by position)
names(a) <- c("Scaffold_1", "Scaffold_3", "Scaffold_7", "Scaffold_9", "Scaffold_13", "Scaffold_18", "Scaffold_48", "Scaffold_51", "Scaffold_70", "Scaffold_93", "Scaffold_415", 
"Scaffold_693", "Scaffold_1062", "Scaffold_1063", "Scaffold_1064", "Scaffold_1065")

# Average SNP distance. This finds the difference (subtracts) the position (in bp) from a row and the one preceding it
lapply(1:nrow(a[[16]]), function(j){
a[[16]][j+1,1] - a[[16]][j,1] })-> snp_distances
		
# Turn list into a vector
unlist(snp_distances, recursive=TRUE, use.names=FALSE) -> snp_distances

# Stats
min(snp_distances, na.rm=T)
max(snp_distances, na.rm=T)
mean(snp_distances, na.rm=T)
median(snp_distances, na.rm=T)
# Important: Lines 48-59 could be re-written in a loop that iterates over each item in list "a" and outputs it in a way that preserves the data

# SNP density per chromosome was done in Excel by dividing total SNPs per scaffold (found using this script) and dividing by length of scaffold in Mbp

# Save data (note: not all objects are saved because they can be re-created using this script and/or they are temp objects that were continuously overwritten in this script (such as snp_distances)
save(a,x,y, file="190729_getting_SNP_stats_for_field_day.Rdata")