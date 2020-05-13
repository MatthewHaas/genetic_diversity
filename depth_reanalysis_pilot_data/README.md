# README for depth_reanalysis_pilot_data

## normalize.awk
Helper script for pulling SNP calls out of VCF format and putting into a tab-separated (TSV) file.

## run_normalize.sh
Shell script that runs the _normalize.awk_ script

## run_snp_filtering_circos_density.sh
Shell script that runs R code for filtering SNP calls using the _scythe_mpileup.sh_ and _run_normalize.sh_ scripts

## scythe_mpileup.sh
This script has been used before for the main GBS project. Here, I apply it to re-analyze the pilot GBS data (call SNPs) for the pilot GBS project using the reference genome.

## snp_filtering_for_circos_density_plot.R
R code for filtering SNPs called using the scripts above. The purpose of this SNP density calculation is to put it into the circos plot for the genome paper.
