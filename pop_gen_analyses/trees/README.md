# README for trees

There are three text files in this directory:
1) [breeding_lines_for_vcftools_filt.txt](breeding_lines_for_vcftools_filt.txt)
2) [natural_stands_for_vcftools_filt.txt](natural_stands_for_vcftools_filt.txt)
3) [temporal_samples_for_vcftools_filt.txt](temporal_samples_for_vcftools_filt.txt)

These files were used to retain only the samples that are part of the subpopulations named in the filename. This was done using VCFtools using these scripts:
1) [filter_with_vcftools_by_ind_breeding_lines.sh](filter_with_vcftools_by_ind_breeding_lines.sh)
2) [filter_with_vcftools_by_ind_natural_stands.sh](filter_with_vcftools_by_ind_natural_stands.sh)
3) [filter_with_vcftools_by_ind_temporal_samples.sh](filter_with_vcftools_by_ind_temporal_samples.sh)
