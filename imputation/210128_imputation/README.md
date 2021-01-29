# README
Imputation work started on 28 January 2021

One of the issues I have had when working to impute missing genotype data into the GBS-derived SNP calls is what I should use for a reference panel. There are no pre-existing reference panels so one option is to impute without a reference panel. Another option that I am exploring here is to use individuals from the same dataset I am trying to impute with a limited amount of missing data as the reference panel. According to the [Beagle](https://faculty.washington.edu/browning/beagle/beagle_5.1_08Nov19.pdf) version 5.1 documentation, the reference panel cannot have any missing samples. I thought that maybe it would impute the non-missing values, but the program won't run and returns an error value of 1. My next plan of action will be to further filter the samples that have a limited amount of missing data already so hopefully most of the other variants will be retained. This is achieved by adding the option ```--max-missing 1``` to the existing [filter_with_vcftools.sh](filter_with_vcftools.sh) script. according to the [VCFtools](http://vcftools.sourceforge.net/index.html) documentation, this excludes any site that has any missing data at all. Option ```filter_with_vcftools.sh``` added because a test run on Scaffold 51 seems to have ran into an issue with periods in the ```FILTER``` field. (The details were found in the log file, not the error file.)

To identify the individuals that I should use as the reference panel, I looked at the most recent ```CSV``` file containing my SNP calls and counted the number of "NA" calls out of 2,657 SNPs. This dataset was already filtered by positions so that a maximum of 300 individuals (out of 917 in the dataset) would be allowed to be missing for any given SNP.

The list of individuals used for the filtering can be found [here](samples_to_keep_for_ref_panel_fewer_than_200_missing.txt). The samples are ordered according to the number of NAs that were present in each individual. The ```--keep``` option of [VCFtools](http://vcftools.sourceforge.net/index.html) version 0.1.17 was used to retain only the individuals in that file. Each line looks like this: ```Sample_0507/Sample_0507_sorted.bam``` (which is the first time in the file) because ```Sample_0507``` which I used originally does not work. This is because it needs to match the form of the sample names in the ```VCF``` files.

[This](vcf_list_full_path.txt) text file was used to generate symlinks to the ```VCF``` files with the SNP calls with the following code:
```
for i in $(cat vcf_list_full_path.txt); 
do 
ln -s $i .
done
```

[This](vcf_list_short.txt) text file was used in the [filter_with_vcftools.sh](filter_with_vcftools.sh) script. It differs from the above text file because each line only contains the file name of each ```VCF``` file rather than the full path that was used to generate the symlinks. We need the different files because the script uses the following bits of code to remove the file extention from each input ```VCF``` file to facilitate adding ```_filtered``` to the output ```VCF``` file names. They also automatically get the extention ```.recode.vcf``` from VCFtools. I probably could have added a line of code to retain only the file name from each path, but this seemed to be more expedient.
```
STEM=$(echo ${i} | cut -f 1 -d ".")
```
and
```
--out filtered_vcf_files/${STEM}_filtered
```
