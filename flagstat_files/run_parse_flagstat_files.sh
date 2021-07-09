#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=48:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o run_parse_flagstat_files.out
#SBATCH -e run_parse_flagstat_files.err

cd /home/jkimball/haasx092/main_GBS

module load python3

# prepend header to our output file
echo $'sample_name\tQC_passed_reads\tmapped_reads\tpercentage_mapped' > flagstat_summary.txt

# iterate through flagstat output files and extract desired info (mapped reads + % mapped)
# loop also grabs the sample name (from shell/loop variable and exports it to python to write name to file w/ corresponding data)
for i in $(cat sample_list.txt); do
var=$(echo ${i})
export var
python  parse_flagstat_files.py ${i}/${i}_bam_flagstat_output.txt flagstat_summary.txt
done
