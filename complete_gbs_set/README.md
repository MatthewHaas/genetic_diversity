

The R script [plot_plink_pca.R](plot_plink_pca.R) takes output from [PLINK](https://zzz.bwh.harvard.edu/plink/index.shtml) version 1.90b6.10 and creates principal component analysis (PCA) plots. The shell script [run_plot_plink_pca.sh](run_plot_plink_pca.sh) launches it. The R script is written in a general way so that the input and output file names are taken from the shell script: ```args = commandArgs(trailingOnly = TRUE)``` at the start of the R script and ```args[1]```, ```args[2]```, ```args[3]```, and ```args[4]``` in place of file names.
* ```args[1]``` is the eigenvector file (input)
* ```args[2]``` is the eivenvalue file (input)
* ```args[3]``` is a PDF file (output)
* ```args[4]``` is an Rdata file (output)

The R script [plot_breeding_lines_plink_pca.R](plot_breeding_lines_plink_pca.R) is launched by the shell script [run_plot_breeding_lines_plink_pca.sh](run_plot_breeding_lines_plink_pca.sh) and is nearly identical to the R script/shell script combination above, except that it only plots Breeding Lines. The input is also slightly different. An independent PLINK run was performed with [run_plink_20percent_NA_breeding_lines.sh](run_plink_20percent_NA_breeding_lines.sh) so that only the Breeding Lines are retained and PCs are calculated without considering the Natural Stand materials. It uses the [breeding_lines.txt](breeding_lines.txt) file to tell PLINK which samples should be retained.

[make_3D_PCA.py](make_3D_PCA.py) was written to make a PCA plot of the breeding lines in 3 dimensions. It uses the same data from PLINK that goes into [plot_breeding_lines_plink_pca.R](plot_breeding_lines_plink_pca.R). The resulting figure looks OK, but at present lacks a legend. It appears to show that there is some separation along the 3rd PC. I think it is worthwhile to make a plot that does a better job of showing relative positions, such as one that is animated/rotates.

Another 3D plot was created in R using the script [plot_3D_breeding_lines_plink_pca.R](plot_3D_breeding_lines_plink_pca.R). It was run in R studio because the script would run on the server without an error, but I couldn't open the output file. This particular script differs from the one that I ran on the server in that it doesn't use ```args``` to pass input/output files from the shell script into the R script. As a result, there is no file name for an output name in this script. I just used the export function of R studio.
