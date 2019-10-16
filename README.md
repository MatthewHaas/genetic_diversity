# gbs_pipeline
This repository contains all of the scripts that were used to develop the genotyping-by-sequencing (GBS) pipeline for the wild rice (_Zizania palustris_ L.) breeding and conservation program at the University of Minnesota.

## awk_filtering_scripts (directory)
These scripts are short and simple awk commands to pre-filter the tab-separated (TSV) files that contain the output of the normalize.awk script. The normalize.awk script can be found in this repository and is used to extract SNP information from the VCF files.

## umgc_pilot_study (directory)
These scripts are for the (partial) re-analysis of the pilot GBS study conducted by the University of Minnesota Genomics Center (UMGC). I say partial because I start the re-analysis from the VCF files produced by their pipeline. For their pipeline, they used a program called stacks (http://catchenlab.life.illinois.edu/stacks/). The reference genome of _Zizania palustris_ was not used in this pipeline. I was mostly interested in pulling some stats out of the files and re-creating the PCA plot to meet my style preferences. The paper was accepted for publication in Conservation Genetics Resources.
