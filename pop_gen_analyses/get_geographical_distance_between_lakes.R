# Purpose of this script is to get the geographical (physical) distance between two lakes for the Mantel test to see if geographic distance is related to genetic distance

# Load required pacakges
library(data.table)
library(geosphere)

# Read in data
data <- fread("191106_wild_rice_samples.csv")

# Get geographical distance (output is in meters)
distm(c(data[Location == i]$Long, data[Location == i]$Lat), c(data[Location == 2]$Long, data[Location == 2]$Lat), fun = distHaversine)

# Make an empty table to write the geographical distance data into
geogrDist <- setNames(data.table(matrix(nrow=0, ncol=4)), c("lake_1", "lake_2", "dist_m", "dist_km"))

# Make a vector containing all lakes names to loop through
lakes <- data$Location

# Populate the geogrDist data.table
# Some warnings were returned that didn't affect the outcome, so I added ```use.names = FALSE``` to avoid these
# The warnings were because the columns dist_m and dist_km weren't recognized in both data.tables (don't know why), but the data printed to the CSV are correct
for (i in lakes){
  for (j in lakes){
      dist <- distm(c(data[Location == i]$Long, data[Location == i]$Lat), c(data[Location == j]$Long, data[Location == j]$Lat), fun = distHaversine)
      newrow <- data.table(lake_1 = i, lake_2 = j, dist_m = dist, dist_km = dist/1000)
      geogrDist = rbindlist(list(geogrDist, newrow), use.names = FALSE)
  }
}

# Write to CSV file
write.csv(geogrDist, file = "210519_geographical_distance_between_lakes.csv")

# Save data
save(data, geogrDist, lakes, file="210519_calculation_of_geographical_distance.Rdata")
