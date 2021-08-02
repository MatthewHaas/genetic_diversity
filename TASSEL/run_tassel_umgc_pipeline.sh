#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=180g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_tassel_umgc_pipeline.out
#SBATCH -e run_tassel_umgc_pipeline.err

cd /home/jkimball/haasx092/TASSEL

module load umgc
module load gopher-pipelines/1.8

tassel-pipeline --enzyme BtgI-TaqI --croplength 80 --fastqfolder /scratch.global/haasx092/inputFastqFilesForTASSEL --bwaindex /home/jkimball/shared/WR_Annotation/NCBI_submission/zizania_palustris_13Nov2018_okGsv_renamedNCBI2.fasta
