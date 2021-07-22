#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=180g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_tassel-gbs.out
#SBATCH -e run_tassel-gbs.err

cd /home/jkimball/haasx092/TASSEL

FASTA='/home/jkimball/shared/WR_Annotation/NCBI_submission/zizania_palustris_13Nov2018_okGsv_renamedNCBI2.fasta'

# -Xms1006 and -Xmx180G necessary to include otherwise you will get "system doesn't have enough memory" message
# key file contains sample information
# the -e option is for the restriction enzymes. Our enzyme combination of BtgI-TaqI is unavailable, so we must use "ignore"
tassel-5-standalone/run_pipeline.pl -Xms100G -Xmx180G -FastqToTagCountPlugin -i ~/TASSEL/fastq -k key_file.txt -e ignore -o ~/TASSEL/output
