#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=8:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_Fst_hudson_mudhen.out
#SBATCH -e run_Fst_hudson_mudhen.err

cd /home/jkimball/haasx092/Fst_hudson

module load R/3.6.0

for file in $(cat mudhen_comparison_csv_sample_list.txt);
do
Rscript hudson_Fst_mudhen.R $file mudhen_Fst_pairwise_comparisons.txt
done
