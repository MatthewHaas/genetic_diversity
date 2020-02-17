# README (imputation)

## The contents of this directory are for using BEAGLE to impute missing SNPs into the GBS data set for characterizing genetic diversity in _Zizania palustris_.

### Add_ID_to_VCF.py
A script written by Tom Kono to fill in the ID column of VCF files with unique identifiers.

### add_AD_field_with_GATK.txt
A script to add the AD (allele depth) field to a VCF file with GATK. The point of doing this is so that the R package polyRAD (for imputation) can work properly.

### add_IDs_to_vcf_files.sh
This is a PBS script that calls Tom's script _Add_ID_to_VCF.py_

### filter_with_vcftools.sh
This PBS script uses VCFtools to filter VCF files. Some of the filtering parameters should be considered fixed (bi-allic sites only; _e.g., --min-alleles 2_ & _--max-alleles 2_, minimum read depth of 6 _--minDP 6_, and no indels _--remove-indels_. The max missing rate of 25% _--max-missing 0.75_ (VCFtools missing parameters is reversed) is OK, a higher missing rate sometimes causes imputation to take much, much longer.

### impute_with_beagle.sh
This script was used to use BEAGLE to impute SNPs.
As of 29 January 2020, I am still practicing and getting to know how to use BEAGLE, so this is not the final version.

### plink_with_imputed_data.txt
Basic code for launching PLINK using imputed SNP data

### polyRAD.err
polyRAD error message. Keeping here to save message until I figure out how to solve it.

### polyRAD_script.R
R script for imputation with the package polyRAD

### setup_directory_for_imputation.txt
This is how the directory where I carried out the imputation steps was set up.

### steps_to_install_polyRAD.txt
Steps that were taken to install the R package polyRAD and get it up and running

### vcf_file_list.txt
A VCF file list that I used to loop through for imputation with BEAGLE
