# 9 June 2019
# Purpose of this script is to plot DV/DP ratios to check for ploidy
load("190607_snp_filtering.Rdata")

# Make a data.table of sample names
unique(y[,sample]) -> samples
samples <- as.data.table(samples)

# Open plotting device
pdf("190609_pilot_GBS_samples_dv-dp_ratio.pdf")


for(i in 1:nrow(samples)){
y[sample == as.character(samples[i]) & quality > 100] -> z

d <- density(z$ratio)

plot(d, type= "l", main = samples[i] , xlab = "DV/DP ratio", ylab="frequency", yaxt="n")
axis(2, las=2)
abline(v=0, col="red")
abline(v=0.5, col="red")
abline(v=1.0, col="red")
}
dev.off()
