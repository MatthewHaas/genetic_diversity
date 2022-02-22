# README Linkage Disequilibrium


The `LD.decay` function from the sommer R package requires that the genotype data are complete. The problem with GBS is that data are frequently missing. For this reason, we needed to impute the missing genotype data for this particular analysis. For most analyses, we did not use imputed data, but felt this was the best option for this particular analysis. To do the imputation with BEAGLE, we used the script [impute_with_beagle.sh](impute_with_beagle.sh).
