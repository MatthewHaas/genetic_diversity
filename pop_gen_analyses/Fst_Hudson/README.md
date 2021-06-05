# README for Fst_Hudson

These scripts are for calculating _F<sub>ST</sub>_ values using the Hudson method.

The comma-separated value (CSV) files are contain the single nucleotide polymorphism (SNP) data. There are Excel equivalents that contain the sample names/identities for each row because the CSV files cannot be accepted by the R functions described here.<br><br>
:dna: 0 is homozygous for the reference allele (0) or AA<br>
:dna: 1 is heterozygous (1) or AB<br>
:dna: 2 is homozygous for the alternate allele (2) or BB<br><br>

Rows represent individuals and columns represent SNPs. There are 1,162 SNPs and (mostly) 100 indiviuals. The 1,162 SNP count is less than the original total number of SNPs, but this number represents the SNPs with the highest levels of heterozygosity. Mud Hen and Phantom Lakes (both from Wisconsin) have fewer than 50 samples (10 and 20, respectively) because they were independently collected by a different person at a different time than all of the other natural stand populations.

## Workflow
The R scripts follow a basic pattern:<br>
1. Data (CSV files) are loaded into the R statistical environment.
2. The data are converted to a matrix (although this step isn't strictly necessary).
3. The [```fst.hudson()```](fst_hudson_function.R) function from the [KRIS](https://rdrr.io/cran/KRIS/man/KRIS-package.html) package is used to calculate _F<sub>ST</sub>_ values using the Hudson Method.
4. _F<sub>ST</sub>_ values and the name of the CSV file being examined are written (appended to) a text file using the ```write.table()``` function with the ```append = TRUE``` option (so that the script can be run in a loop and not have new results overwrite previous results).

The shell scripts run the aforementioned R script and use a for loop to iterate over a text file which was created using the general form ```ls [natural_stand_name]*csv > [natural_stand_name]_comparison_csv_sample_list.txt```.<br>

Most of the pairwise comparisons were performed using the script [```hudson_Fst.R```](hudson_Fst.R). It follows an assumption that the first 50 rows (1-50) belong to population 1 (the first population mentioned in the file name) and the second 50 rows (51-100) belong to population 2 (the second population mentioned in the file name).<br>

The loop looks like:
```
for file in $(cat [natural_stand_name]_comparison_csv_sample_list.txt);
do
Rscript hudon_Fst.R $file [natural_stand_name]_Fst_pairwise_comparisonstxt
done
```

Because of the way I set up the population comparisons, for some of the comparisons featuring Mud Hen Lake and Phantom Lake  (with 10 and 20 lakes, respectively where these lakes are "population 2"), the _F<sub>ST</sub>_ calculations don't seem to be affected since any spare rows from 61-100 or 71-100 are not available (NA). However, for the comparisons where Mud Hen Lake or Phantom Lake are the first partner in the comparison, special scripts were required. Otherwise, the populations would be mixed. For comparisons involving Mud Hen Lake, population 1 is represented by rows 1-10 and population 2 is represented by rows 11-60. For comparisons involving Phantom Lake, population 1 is represented by rows 1-20 and population 2 is represented by rows 21-70. For these reasons, the scripts [```hudson_Fst_mudhen.R```](hudson_Fst_mudhen.R) and [```hudson_Fst_phantom.R```](hudson_Fst_phantom.R) were used for these comparisons.

## References
Bhatia, G., Patterson, N., Sankararaman, S., and Price, A.L. (2013). Estimating and interpreting FST: The impact of rare variants. _Genome Res_ **23**:1514-1521.<br>
Hudson, R.R., Slatkin, M., and Maddison, W.P. (1992). Estimation of levels of gene flow from DNA sequence data. _Genetics_ **132**:583-589.
