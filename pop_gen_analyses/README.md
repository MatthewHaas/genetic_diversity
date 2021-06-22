# README

The script [convert_csv_to_arlequin_input_format.py](convert_csv_to_arlequin_input_format.py) was written to convert the SNP matrix from the comma-separated value (CSV) format to Arlequin input format. Arlequin requires somewhat unique formatting. For a diploid individual, each locus requires two lines. There needs to be a name for the haplotype, the number of individuals with that haplotype, followed by the SNP calls. The second line only need the SNP calls. For homozygous calls (0 or 1), the ref (0) or alt (2) calls are used for both lines.

The basic code for running the script is:<br>
```python convert_csv_to_arlequin_input_format.py BassLake_snp_matrix.csv BassLake_arlequin_input.arp```<br>
The script needs to be run for each lake.

The input files are:
* BassLake_snp_matrix.csv
* ClearwaterRiver_snp_matrix.csv
* DahlerLake_snp_matrix.csv
* DeckerLake_snp_matrix.csv
* GarfieldLake_snp_matrix.csv
* MudhenLake_snp_matrix.csv
* NecktieRiver_snp_matrix.csv
* OttertailRiver_snp_matrix.csv
* PhantomLake_snp_matrix.csv
* Plantagenet_snp_matrix.csv
* ShellLake_snp_matrix.csv
* UpperRiceLake_snp_matrix.csv
* ZizaniaAquatica_snp_matrix.csv

They were created by opening the original SNP matrix (with rows=SNPs and columsn=individuals) in Excel and separating the SNP data accrording to which lake/river they come from. The data were then transposed (so that rows=individuals and columns=SNPs) as required for Arlequin format.<br>

Some post-processing is required at the moment. For example, Arlequin format requires 2 rows for each haplotype, but only the first one needs a name and number of occurrence. So, I need to find a way to skip those first two columns/fields for the second row to ensure that the loci align properly. There are also extra loci for the last individual and I'm not quite sure why. <br>

I am considering each individual to have its own haplotype. We would likely see many shared haplotypes if we were using imputed data, but for now I haven't tried to reduce the number of haplotypes. I think there is too much missing data for the combination of haplotypes to be possible.

Arlequin can be difficult to work with sometimes. Here are the settings that I used to make it work:
* Each lake in its own group
    * e.g., Group 1 = Bass Lake, Group 2 = Clearwater River
* Population comparisons
    * :heavy_check_mark: Compute pairwise FST
* Genetic distance settings
    * :heavy_check_mark: Slatkin's distance
    * :heavy_check_mark: Reynold's distance
    * :heavy_check_mark: Compute pairwise differences (pi)
    * No. of permutations: 100
    * Significance level: 0.05
    * Use conventional F-statistics (haplotype frequencies only)
    * Pairwise difference
    * Gamma a value: 0 
* Population differentiation
    * :heavy_check_mark: Exact test of population differentiation
    * Exact test settings
        * No. of steps in Markov chain: 100,000
        * No. of dememorization steps: 10,000
        * :heavy_check_mark: Generate histogram and table
        * Significance level: 0.05
* Project Wizard
    * Data type: FREQUENCY
    * Genotypic data: NOT CHECKED
    * Known gametic phase: GREY AND NOT CHECKED
    * Recessive data: GREY AND NOT CHECKED
    * Controls:
        * No. of samples: 2
        * Locus separator: WHITESPACE
        * Missing data: ?
    * Optional sections
        * Include haplotype list: UNCHECKED
        * Include distance matrix: UNCHECKED
        * Include genetic structure: UNCHECKED
