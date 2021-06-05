# README for Fst_Hudson

These scripts are for calculating _F<sub>ST</sub>_ values using the Hudson method.

The comma-separated value (CSV) files are contain the single nucleotide polymorphism (SNP) data.<br><br>
:dna: 0 is homozygous for the reference allele (0) or AA<br>
:dna: 1 is heterozygous (1) or AB<br>
:dna: 2 is homozygous for the alternate allele (2) or BB<br><br>

Rows represent individuals and columns represent SNPs. There are 1,162 SNPs and (mostly) 100 indiviuals. The 1,162 SNP count is less than the original total number of SNPs, but this number represents the SNPs with the highest levels of heterozygosity. Mud Hen and Phantom Lakes (both from Wisconsin) have fewer than 50 samples (10 and 20, respectively) because they were independently collected by a different person at a different time than all of the other natural stand populations.

## Workflow
The R scripts follow a basic pattern:<br>
1. Data (CSV files) are loaded into the R statistical environment.
2. The data are converted to a matrix (although this step isn't strictly necessary).
3. The ```fst.hudson()``` function from the [KRIS](https://rdrr.io/cran/KRIS/man/KRIS-package.html) package is used to calculate _F<sub>ST</sub>_ values using the Hudson Method.
4. _F<sub>ST</sub>_ values and the name of the CSV file being examined are written (appended to) a text file using the ```write.table()``` function and the ```append = TRUE``` option (so that the script can be run in a loop and not have new results overwrite previous results).

The shell scripts run the aforementioned R script and use a for loop to iterate over a text file which was created using the general form ```ls [natural_stand_name]*csv > [natural_stand_name]_comparison_csv_sample_list.txt```.<br>

The loop looks like:
```
for file in $(cat [natural_stand_name]_comparison_csv_sample_list.txt);
do
Rscript hudon_Fst.R $file [natural_stand_name]_Fst_pairwise_comparisonstxt
done
```

## References
Bhatia, G., Patterson, N., Sankararaman, S., and Price, A.L. (2013). Estimating and interpreting FST: The impact of rare variants. _Genome Res_ **23**:1514-1521.<br>
Hudson, R.R., Slatkin, M., and Maddison, W.P. (1992). Estimation of levels of gene flow from DNA sequence data. _Genetics_ **132**:583-589.
