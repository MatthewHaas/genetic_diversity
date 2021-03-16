# README for depth_4

These scripts were created to make the PCA plots using PLINK after the VCF files were filtered so that the depth was a minumum of 4 reads per locus rather than 6 reads per locus using the ```--minDP``` option in VCFtools. The main reason for doing this was to increase the number of SNPs to see if it would improve clustering of samples (especially for the breeding lines) or increase the % variance explained by each principal component.

The script [filter_with_vcftools_dp4.sh](filter_with_vcftools_dp4.sh) was used to do the filtering and [concat_filtered_vcfs_dp4.sh](concat_filtered_vcfs_dp4.sh) was used to concatenate the 17 main scaffolds into a single file. The concatenated file was then used as input for the following three shell scripts that create the PLINK objects needed to make the PCA plots in R. There was another filtering option set in all three of these (```--mind```) which was set to ```--mind 0.20``` which corresponds to an 80% complete genotyping rate.
* [run_plink_20percent_NA_breeding_lines_dp4.sh](run_plink_20percent_NA_breeding_lines_dp4.sh)
* [run_plink_20percent_NA_natural_stands_dp4.sh](run_plink_20percent_NA_natural_stands_dp4.sh)
* [run_plink_20percent_NA_temporal_dp4.sh](run_plink_20percent_NA_temporal_dp4.sh)

After the PLINK objects were made, the following scripts were used to generate PCA plots using the same R scripts as previously used.

* [run_plot_breeding_lines_plink_pca_dp4.sh](run_plot_breeding_lines_plink_pca_dp4.sh)
* [run_plot_natural_stands_plink_pca_dp4.sh](run_plot_natural_stands_plink_pca_dp4.sh)
* [run_plot_temporal_plink_pca_dp4.sh](run_plot_temporal_plink_pca_dp4.sh)

We were also interested in seeing if changing the ```--mind``` option in PLINK would do anything. The parameter was set to ```--mind 0.99``` which corresponds to a complete genotyping rate of 1%. As it turns out, it doesn't affect the output that much. This isn't terribly surprising since the dataset was already filtered (with VCFtools) so that there was a maximum 20% genotyping rate (meaning an 80% complete genotyping rate). The following three scripts are nearly the same as the ones used for the ```--mind 0.20``` option. "mind_099" was added to the script name to differentiate.

* [run_plink_20percent_NA_breeding_lines_dp4_mind_099.sh](run_plink_20percent_NA_breeding_lines_dp4_mind_099.sh)
* [run_plink_20percent_NA_natural_stands_dp4_mind_099.sh](run_plink_20percent_NA_natural_stands_dp4_mind_099.sh)
* [run_plink_20percent_NA_temporal_dp4_mind_099.sh](run_plink_20percent_NA_temporal_dp4_mind_099.sh)

The PCA plots (for the ```--mind 0.99``` variation) were made with these scripts:
* [run_plot_breeding_lines_plink_pca_dp4_mind_099.sh](run_plot_breeding_lines_plink_pca_dp4_mind_099.sh)
* [run_plot_natural_stands_plink_pca_dp4_mind_099.sh](run_plot_natural_stands_plink_pca_dp4_mind_099.sh)
* [run_plot_temporal_plink_pca_dp4_mind_099.sh](run_plot_temporal_plink_pca_dp4_mind_099.sh)
