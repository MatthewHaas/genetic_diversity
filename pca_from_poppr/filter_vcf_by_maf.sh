#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=15g,walltime=2:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e filtering_vcf_by_maf.err
#PBS -o filtering_vcf_by_maf.out
#PBS -N filtering_vcf_by_maf

cd /home/jkimball/haasx092/main_GBS/191126_samtools

# Scaffold_1
~/vcftools/bin/vcftools --gzvcf 191126_samtools_Scaffold_1.vcf.gz --maf 0.05  --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_1.recode_maf.vcf

# Scaffold_3
~/vcftools/bin/vcftools --gzvcf 191126_samtools_Scaffold_3.vcf.gz --maf 0.05  --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_3.recode_maf.vcf

# Scaffold_7
~/vcftools/bin/vcftools --gzvcf 191126_samtools_Scaffold_7.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_7.recode_maf.vcf

# Scaffold_9
~/vcftools/bin/vcftools --gzvcf 191126_samtools_Scaffold_9.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_9.recode_maf.vcf

# Scaffold_13
~/vcftools/bin/vcftools --gzvcf  191126_samtools_Scaffold_13.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_13.recode_maf.vcf

# Scaffold_18
~/vcftools/bin/vcftools --gzvcf  191126_samtools_Scaffold_18.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_18.recode_maf.vcf

# Scaffold_48
~/vcftools/bin/vcftools --gzvcf  191126_samtools_Scaffold_48.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_48.recode_maf.vcf

# Scaffold_51
~/vcftools/bin/vcftools --gzvcf  191126_samtools_Scaffold_51.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_51.recode_maf.vcf

# Scaffold_70
~/vcftools/bin/vcftools --gzvcf  191126_samtools_Scaffold_70.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_70.recode_maf.vcf

# Scaffold_93
~/vcftools/bin/vcftools --gzvcf  191126_samtools_Scaffold_93.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_93.recode_maf.vcf

# Scaffold_415
~/vcftools/bin/vcftools --gzvcf  191126_samtools_Scaffold_415.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_415.recode_maf.vcf

# Scaffold_693
~/vcftools/bin/vcftools --gzvcf  191126_samtools_Scaffold_693.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_693.recode_maf.vcf

# Scaffold_1062
~/vcftools/bin/vcftools --gzvcf  191126_samtools_Scaffold_1062.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_1062.recode_maf.vcf

# Scaffold_1063
~/vcftools/bin/vcftools --gzvcf 191126_samtools_Scaffold_1063.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_1063.recode_maf.vcf

# Scaffold_1064
~/vcftools/bin/vcftools --gzvcf 191126_samtools_Scaffold_1064.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_1064.recode_maf.vcf

# Scaffold_1065
~/vcftools/bin/vcftools --gzvcf 191126_samtools_Scaffold_1065.vcf.gz  --maf 0.05 --min-alleles 2 --max-alleles 2 --remove old_lake_samples_to_remove.txt --recode
mv out.recode.vcf Scaffold_1065.recode_maf.vcf

# Concatenate recoded scaffolds
module load bcftools
bcftools concat 'Scaffold_1.recode.vcf' 'Scaffold_3.recode.vcf' 'Scaffold_7.recode.vcf' 'Scaffold_9.recode.vcf' 'Scaffold_13.recode.vcf' 'Scaffold_18.recode.vcf' 'Scaffold_48.recode.vcf' 'Scaffold_51.recode.vcf' 'Scaffold_70.recode.vcf' 'Scaffold_93.recode.vcf' 'Scaffold_415.recode.vcf' 'Scaffold_693.recode.vcf' 'Scaffold_1062.recode.vcf' 'Scaffold_1063.recode.vcf' 'Scaffold_1064.recode.vcf' 'Scaffold_1065.recode.vcf' -o largest_scaffolds_bi_allelic_recoded.vcf.gz
