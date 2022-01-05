# _D-statistics_ (ABBA-BABA analysis)

For this analysis, I was working in `/home/jkimball/haasx092/ABBA-BABA`

I am using a program called [Dsuite](https://github.com/millanek/Dsuite).

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

I wrote the script [prep_sample_list_for_ABBA-BABA.py](prep_sample_list_for_ABBA-BABA.py) to process the file [sample_names_from_vcf.txt](sample_names_from_vcf.txt) and convert it into the format needed to run Dsuite. For example, the sample names from the `VCF` file look like `Sample_0001/Sample_0001_sorted.bam`, but in the key the sample is just listed as `Sample_0001`. The goal of the script is to connect each sample name to its population assignment from STRUCTURE where _K_=4.

This is a preview of what the file should look like.
```bash
Sample_0001/Sample_0001_sorted.bam  Natural_stand_2
Sample_0002/Sample_0002_sorted.bam  Natural_stand_2
Sample_0003/Sample_0003_sorted.bam  Natural_stand_2
Sample_0004/Sample_0004_sorted.bam  Natural_stand_2
Sample_0005/Sample_0005_sorted.bam  Natural_stand_2
```

The actual analysis was carried out using the script [run_Dsuite_ABBA-BABA.sh](run_Dsuite_ABBA-BABA.sh).

The results suggest that there have been no introgressions.
