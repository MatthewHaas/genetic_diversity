# gbs_pipeline
This repository contains all of the scripts that were used to develop the genotyping-by-sequencing (GBS) pipeline for the wild rice (_Zizania palustris_ L.) breeding and conservation program at the University of Minnesota.

## awk_filtering_scripts (directory)
These scripts are short and simple awk commands to pre-filter the tab-separated (TSV) files that contain the output of the normalize.awk script. The normalize.awk script can be found in this repository and is used to extract SNP information from the VCF files.

## umgc_pilot_study (directory)
These scripts are for the (partial) re-analysis of the pilot GBS study conducted by the University of Minnesota Genomics Center (UMGC). I say partial because I start the re-analysis from the VCF files produced by their pipeline. For their pipeline, they used a program called stacks (http://catchenlab.life.illinois.edu/stacks/). The reference genome of _Zizania palustris_ was not used in this pipeline. I was mostly interested in pulling some stats out of the files and re-creating the PCA plot to meet my style preferences. The paper was accepted for publication in Conservation Genetics Resources.

## 190515_cutadapt_pilot_GBS
This file is the "complete" GBS pipeline that was initiated on 15 May 2019. It can be broken down into a few major steps:
1. Removing adapter content with cutadapt
2. Running fastQC on trimmed reads
3. Aligning trimmed fastq reads to the genome with bwa-mem
  - Indexing genome
  - Performing alignment
  - Sorting BAM files
4. SNP calling with samtools mpileup/bcftools
  - There are two parameters to pay especially close attention to.
    - The -q option for samtools mpileup allows us to specify a _minimum_ mapping quality. A minimum mapping quality value of 20 might be "standard", but I used a value of 60 for some interations of the experiment which might be a little too stringent and results in otherwise useful SNPs being filtered out of the dataset. (Reference: http://www.htslib.org/doc/samtools-1.2.html)
    - The -m option for bcftools call stands for the _multiallelic caller_. It is an alternative method for multi-allelic and rare-varient calling that overcomes known limitations to the -c option which stands for _consensus_ caller. The consensus caller is the original option. Because these options conflict with each other, only one can be used at a time.(Reference: https://samtools.github.io/bcftools/bcftools.html)
5. Pulling the SNP information out of the VCF files and into usable format
  - The script "normalize.awk" extracts the following information from the VCF files: 1) scaffold, 2) position, 3) reference allele, 4) alternate allele, 5) base quality score, 6) sample identifier (path to BAM file), 7) genotype call (0, 1, or 2), 8) read depth (DP) at site, and 9) depth of the varient (DV) allele at the site.
