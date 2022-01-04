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
