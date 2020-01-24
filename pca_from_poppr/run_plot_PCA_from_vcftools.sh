#!/bin/bash -l
#PBS -l nodes=1:ppn=24,mem=150g,walltime=48:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e run_PCA_from_VCFtools.err
#PBS -o run_PCA_from_VCFtools.out
#PBS -N run_PCA_from_VCFtools

cd /home/jkimball/haasx092/main_GBS/191126_samtools

# Load required  modules
module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1
module load R/3.6.0

Rscript PCA_from_VCFtools.R
