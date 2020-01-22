# README

These files were used for creating PCA plots for the main_GBS project using PLINK. Most were saved as standard text files because even though they are mostly R code, there are a few lines at the beginning of each script that are command-line. Some of these files are configuration files and even though they are not technically code were added here as another backup.

## 191022_main_gbs_garfield_and_shell_lakes_only.R

## 191022_main_gbs_old_lake_and_dovetail_samples_removed.R

## 191028_main_gbs_pca_plot.R

## Garfield_and_Shell_Lakes_Old_and_New.txt
A configuration file listing samples (both old...2010... and new...2018...) from Garfield and Shell Lakes.
This config file is useful for making a PCA comparing only these samples for the temporal diversity project.

## Old_Lake_and_Dovetail_samples_to_remove_from_plink.txt
A configuration file that lists old lake samples (Garfield and Shell Lakes from 2010) as well as the Dovetail samples so that they can be removed from consideration when using PLINK so that they don't create a skewed PCA. Note: it was really only the Dovetail samples that were skewing the PCA (causing compression of most of the samples). We also removed the old lake samples because, for this project, we are interested in the present-day diversity. The old lake samples were included for a temporal diversity comparison and have their own plot.

## breeding_lines.txt
A configuration file listing all of the samples that are breeding lines.

## create_snp_list_from_plink

## plink_for_main_GBS

## plink_pca_from_191126_data.txt

## plink_pca_no_old_lake_dovetail_or_latifolia.txt

## plink_pca_no_old_lake_dovetail_or_pilot_samples.txt
