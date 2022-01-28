# _D_-statistics (ABBA-BABA analysis)

For this analysis, I was working in `/home/jkimball/haasx092/ABBA-BABA`

# Directory
1. [Dsuite](#Dsuite)
2. [AdmixTools](#AdmixTools)

# Dsuite
THe first program that I tried for ABBA-BABA/_D_-statistics is called [Dsuite](https://github.com/millanek/Dsuite).

It was relatively easy to install using instructions from the authors' GitHub page.
```bash
$ git clone https://github.com/millanek/Dsuite.git
$ cd Dsuite
$ make
```
I installed it into a directory called `ABBA-BABA` within my home directory, so the full path to the program is:
```bash
/home/jkimball/haasx092/ABBA-BABA/Dsuite/Buid/Dsuite
```
It can be called within a script with ` ~/ABBA-BABA/Dsuite/Build/Dsuite` for short.

In order to get the sample names out of my `VCF` file so that I could assign them population membership for the D-statistics (ABBA-BABA) analysis, I used the following line of code:
```bash
bcftools query -l biallelic_snps_only.recode.vcf > sample_names_from_vcf.txt
```

I wrote the script [prep_sample_list_for_ABBA-BABA.py](prep_sample_list_for_ABBA-BABA.py) to process the file [sample_names_from_vcf.txt](sample_names_from_vcf.txt) and convert it into the format needed to run Dsuite. For example, the sample names from the `VCF` file look like `Sample_0001/Sample_0001_sorted.bam`, but in the key the sample is just listed as `Sample_0001`. The goal of the script is to connect each sample name to its population assignment from STRUCTURE where _K_=4. As of 4 January 2022, the script does a good job of making the file, except I should update it so that _Zizania aquatica_ samples are labeled as "Outgroup" and samples that don't belong to any population ("None") are labeled as "xxx" so they aren't included in the ABBA-BABA analysis. These correspond to the old/2010 temporal samples so we don't want to include them here. Otherwise, these changes can be made manually but it is better to do it in a robust, reproducible way.

This is a preview of what the file should look like. The complete file can be found [here](sample_list_with_key.txt).
```bash
Sample_0001/Sample_0001_sorted.bam  Natural_stand_2
Sample_0002/Sample_0002_sorted.bam  Natural_stand_2
Sample_0003/Sample_0003_sorted.bam  Natural_stand_2
Sample_0004/Sample_0004_sorted.bam  Natural_stand_2
Sample_0005/Sample_0005_sorted.bam  Natural_stand_2
```

The actual analysis was carried out using the script [run_Dsuite_ABBA-BABA.sh](run_Dsuite_ABBA-BABA.sh).

The results suggest that there have been no introgressions.

# AdmixTools
## Installation
I also used [AdmixTools2](https://github.com/uqrmaie1/admixtools) for the ABBA-BABA/_D_-statistics analysis. The original AdmixTools can be found [here](https://github.com/DReichLab/AdmixTools/tree/master/src). I chose to go with AdmixTools2 because it has the same functionality but is more user-friendly, thanks to the R interface. **Note:** I did the installation and carried out the analysis on the Minnesota Supercomputing Institute servers rather than on my personal device.

I followed the instructions to install AdmixTools [here](https://github.com/uqrmaie1/admixtools). Initially, I had issues getting `tidyverse` and `plotly` installed. The final solution that enabled me to install them was to switch from `R/3.6.0` to `R/4.1.0`.

Since I did not already have these R packages installed, I needed to install them so that I could use them in my analysis. The `Rcpp` package was already installed.
```R
install.packages("tidyverse")
install.packages("igraph")
install.packages("plotly")
```
**Note:** the R package `devtools` is also requried, but I didn't need to install it because it was already installed.
```R
devtools::install_github("uqrmaie1/admixtools")
library("admixtools")
```
**Note:** You do not need to carry out these installation steps every time you open R. Once they are installed, you're good to go.

## Getting the program up and running

AdmixTools can take genotype data in binary plink format. In order to convert my existing plink files into binary format, I used the following code. Make sure you use `module load plink` first!
```bash
plink --file plink_incl_nonbiallelic --make-bed --allow-extra-chr --out plink_binary
```

Perhaps a more descriptive name would be useful, but for now I just wanted to get this up and working. Inside your R script, you can use the following command to load the genotypic data:
```R
geno = read_plink("plink_binary")
```
Voilà! Works like a charm.

Calculate allele frequencies.
```R
afs = plink_to_afs("plink_binary")
```

_D_-statistics are calculated with the following code:
```R
out = f4(data, f4mode = FALSE)
```

One of the challenges here is how to assign population membership. It was relatively simple with Dsuite but is not as clear with AdmixTools. I think this is because they assume population/family membership is already embedded into the plink data which it is not for me. However, I think I can assign population membership within R. I used the following code to pull population membership from a text file because the sample names are long and convoluted. This is something that could be addressed by shortening the sample names within the VCF file before converting to a plink object, but for now this is what I am doing to solve the issue.
```R
cluster1 <- scan("cluster_1.txt", character())
aquatica <- scan("aquatica.txt", character())
cultivated <- scan("cultivated_material.txt", character())
cluster4 <- scan("cluster_4.txt", character())
```

I may have a problem with my approach. It's currently not working, so something is off with my understanding. The `sure = TRUE` setting was suggested by the program, but it needs to be submtited to the queue because it consumes too much memory. Casts doubt on whether this is actually what I want to do.
```R
f4(geno, cluster1, aquatica, cultivated, cluster4, f4mode = FALSE, sure = TRUE)
```
