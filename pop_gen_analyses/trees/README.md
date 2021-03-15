# README for trees

There are three text files in this directory:
1) [breeding_lines_for_vcftools_filt.txt](breeding_lines_for_vcftools_filt.txt)
2) [natural_stands_for_vcftools_filt.txt](natural_stands_for_vcftools_filt.txt)
3) [temporal_samples_for_vcftools_filt.txt](temporal_samples_for_vcftools_filt.txt)

These files were used to retain only the samples that are part of the subpopulations named in the filename. This was done using VCFtools using these scripts:
1) [filter_with_vcftools_by_ind_breeding_lines.sh](filter_with_vcftools_by_ind_breeding_lines.sh)
2) [filter_with_vcftools_by_ind_natural_stands.sh](filter_with_vcftools_by_ind_natural_stands.sh)
3) [filter_with_vcftools_by_ind_temporal_samples.sh](filter_with_vcftools_by_ind_temporal_samples.sh)

There are three shell scripts that I ran to make the trees:
1) [run_make_tree_breeding_lines.sh](run_make_tree_breeding_lines.sh)
2) [run_make_tree_natural_stands.sh](run_make_tree_natural_stands.sh)
3) [run_make_tree_temporal_samples.sh](run_make_tree_temporal_samples.sh)

These scripts call their respective R scripts:
1) [make_tree_breeding_lines.R](make_tree_breeding_lines.R)
2) [make_tree_natural_stands.R](make_tree_natural_stands.R)
3) [make_tree_temporal_samples.R](make_tree_temporal_samples.R)

The ```run_make_tree``` shell scripts take two arguments. The first is the filtered/recoded VCF file that is created from the above VCFtools fitering scripts and the second argument is a CSV file containing details about population membership. These are:
1) [breeding_lines.csv](breeding_lines.csv)
2) [natural_stand_samples.csv](natural_stand_samples.csv)
3) [temporal_samples.csv](temporal_samples.csv)

The second two arguments in the ```run_make_tree``` scripts are the Rdata and PDF output files. The R scripts are virtually identical and only differ by the colors that I give to the samples. This is done to match the colors selected for the PCA plots. Ultimately, the same exact R script could be used if I added another argument to the shell script to input the colors, or perhaps more simply added data to the population CSV file specifying the desired colors.
