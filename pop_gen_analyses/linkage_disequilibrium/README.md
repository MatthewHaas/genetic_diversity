# README Linkage Disequilibrium


The `LD.decay` function from the sommer R package requires that the genotype data are complete. The problem with GBS is that data are frequently missing. For this reason, we needed to impute the missing genotype data for this particular analysis. For most analyses, we did not use imputed data, but felt this was the best option for this particular analysis. To do the imputation with BEAGLE, we used the script [impute_with_beagle.sh](impute_with_beagle.sh).

After imputation, we needed to reformat the data. This is because the typical allele separator in VCF files is the forward slash (`/`) but this gets changed to the pipe character (`|`) by Beagle. I originally tried to simply modify the [normalize.awk](normalize.awk) script to accept the different allele separator, but it didn't work, so I opted to swtich the allele separator back to the forward slash. We did this with the script [reformat_imputed_vcf.sh](reformat_imputed_vcf.sh). In addition to the reformatted data, some minor changes to the `AWK` script were also required. The differences are shown below:

**Old**<br>
```awk
{
 for(i = 10; i <= NF; i++){
  split($i, a, ":")
  if(a[3] > 0)
   print $1, $2, $3, $4, $5, $6, s[i], h[a[1]], a[5], a[3], a[4]
 }
}
```

**New**<br>
```awk
{
 for(i = 10; i <= NF; i++){
  split($i, a, " ")
  print $1, $2, $3, $4, $5, $6, s[i], h[a[1]]
 }
}
```

The R script [filter_snps_and_make_wide_format.R](filter_snps_and_make_wide_format.R]) which was launched by the shell script [run_filter_snps_and_make_wide_format.sh](run_filter_snps_and_make_wide_format.sh) converts the `TSV` file that results from running [normalize.awk](normalize.awk)  to `CSV` format. **Note:** The imputed data lack fields like overall depth and depth of the variant, so the R script [filter_snps_and_make_wide_format.R](filter_snps_and_make_wide_format.R]) has been modified accordingly. 

Finally, I was able to run the `LD.decay()` function with the [calculate_LD_decay.R](calculate_LD_decay.R) script. I should make a shell script for it, but for now, I just ran it right on the command line with: `Rscript calculate_LD_decay.R` (don't forget to run `module load R/4.1.0`first!)
