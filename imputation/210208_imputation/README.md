# README for 210208_imputation
The premise of this analysis was that we could:
1. Select a subset of the 919 individuals with the least amount of missing data and impute them with BEAGLE vesion 5.
2. Use the imputed dataset to serve as a reference panel for the remainder of the dataset.

There were some minor issues with formatting. Notably, the genotype allele separator in the VCF files is the forward slash (/), but the BEAGLE output separates the genotype alleles with the pipe symbol (|). It also lacks other output that is present in a typical VCF file like the depth of the variant, etc which are separated by a colon (:).  The [reformat_imputed_vcf.sh](reformat_imputed_vcf.sh) script was written to turn the pipe back to the foward slash so that the [normalize.awk](normalize.awk) script would work. The [normalize.awk](normalize.awk) script was also modified so that the genotype field (GT) would be written to the output because it didn't initially work like the original because of the absence of the other fields.

## Imputing with a reference panel
The script [impute_with_beagle_with_ref_and_filt_by_snp_pos.sh](impute_with_beagle_with_ref_and_filt_by_snp_pos.sh) was used to impute with a reference panel. The reference panel was selected based on having the least amount of missing data and was independently imputed before being used as a reference panel because BEAGLE won't permit any missing data in the reference panel.
