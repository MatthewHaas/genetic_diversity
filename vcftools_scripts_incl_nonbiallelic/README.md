# README for vcftools_scripts_incl_nonbiallelic

During the course of our research, we found that we were missing variation that ought to be present in Northern Wild Rice (_Zizania palustris_). These scripts represent our work to include these non-biallelic variants in our analysis.

The script [filter_with_vcftools_incl_non_biallelic_snps.sh](filter_with_vcftools_incl_non_biallelic_snps.sh) was used to filter the variants so that sites with more than 2 alleles were permitted. The parameters include:
* --max-missing 0.80
* --min-alleles 2 
* --maf 0.05 
* --remove-indels 
* --minDP 4
