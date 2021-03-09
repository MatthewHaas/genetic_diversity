

The R script [plot_plink_pca.R](plot_plink_pca.R) takes output from [PLINK](https://zzz.bwh.harvard.edu/plink/index.shtml) version 1.90b6.10 and creates principal component analysis (PCA) plots. The shell script [run_plot_plink_pca.sh](run_plot_plink_pca.sh) launches it. The R script is written in a general way so that the input and output file names are taken from the shell script: ```args = commandArgs(trailingOnly = TRUE)``` at the start of the script and ```args[1]```, ```args[2]```, ```args[3]```, and ```args[4]``` in place of file names.
* ```args[1]``` is the eigenvector file (input)
* ```args[2]``` is the eivenvalue file (input)
* ```args[3]``` is a PDF file (output)
* ```args[4]``` is an Rdata file (output)
