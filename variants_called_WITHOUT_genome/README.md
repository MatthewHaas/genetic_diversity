# README for variants_called_WITHOUT_genome

Pilot SNP data from [Shao et al. 2020](https://link.springer.com/content/pdf/10.1007/s12686-019-01116-9.pdf) were originally called without the use of the NWR reference genome using the [stacks pipeline](https://catchenlab.life.illinois.edu/stacks/manual/#:~:text=Stacks%20is%20designed%20to%20work,read%20sequences%20from%20multiple%20samples.).
 The purpose of these scripts were to see if we could get _Fst_ values that were more in line with our expectations (~0.2-0.3) since the _Fst_ values with SNP data called using the reference genome are quite low. (~0.01-0.10).

_Fst_ values were calculated using [VCFtools](https://vcftools.github.io/index.html) for each of the following depths:
* [7 million](calculate_Fst_vcftools_umgc_called_snps_with_ref_7_MILLION.sh)
* [4 million](calculate_Fst_vcftools_umgc_called_snps_with_ref_4_MILLION.sh)
* [500,000](calculate_Fst_vcftools_umgc_called_snps_with_ref_500K.sh)

I then plotted the output from the 7 million analysis using a simple [R script]9plot_Fst_values_from_vcftools_SNPs_called_without_reference_using_stacks_7M.R) in Rstudio on my personal machine. It only shows _Fst_ values that are greater than zero because I filtered out nonsensical _Fst_ values (e.g., those less than 0).
