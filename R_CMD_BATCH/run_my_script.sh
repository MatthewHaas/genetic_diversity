#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=30g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e my_script.err
#PBS -o my_script.out
#PBS -N my_script

cd /home/jkimball/haasx092/main_GBS
module load R/3.6.0
R script my_script.R
