#!/bin/bash -l
#PBS -l nodes=1:ppn=24,mem=20g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e launch_fst_with_hierfstat.err
#PBS -o launch_fst_with_hierfstat.out
#PBS -N launch_fst_with_hierfstat

cd /home/jkimball/haasx092/main_GBS/hierfstat

module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1
module load R/3.6.0

Rscript fst_with_hierfstat.R

