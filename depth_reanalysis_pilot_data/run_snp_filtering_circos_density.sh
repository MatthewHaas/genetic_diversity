 #!/bin/bash -l
 #PBS -l nodes=1:ppn=8,mem=22g,walltime=24:00:00
 #PBS -m abe
 #PBS -M haasx092@umn.edu
 #PBS -e filter_snps_circos.err
 #PBS -o filter_snps_circos.out
 #PBS -N filter_snps_circos

 cd /home/jkimball/haasx092/pilot_GBS/200511_samtools
 
 module load R/3.6.0
 
 Rscript snp_filtering_for_circos_density_plot.R
