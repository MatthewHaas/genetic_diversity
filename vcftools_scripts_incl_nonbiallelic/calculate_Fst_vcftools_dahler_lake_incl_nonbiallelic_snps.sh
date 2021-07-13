#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --mem=30g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH -p amdsmall
#SBATCH --account=jkimball
#SBATCH -o calculate_Fst_vcftools_dahler_lake_comparisons_incl_nonbiallelic.out
#SBATCH -e calculate_Fst_vcftools_dahler_lake_comparisons_incl_nonbiallelic.err

cd /home/jkimball/haasx092/Fst_vcftools

~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --weir-fst-pop dahler_lake.txt --weir-fst-pop decker_lake.txt
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --weir-fst-pop dahler_lake.txt --weir-fst-pop garfield_lake.txt
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --weir-fst-pop dahler_lake.txt --weir-fst-pop mudhen_lake.txt
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --weir-fst-pop dahler_lake.txt --weir-fst-pop necktie_river.txt
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --weir-fst-pop dahler_lake.txt --weir-fst-pop ottertail_river.txt
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --weir-fst-pop dahler_lake.txt --weir-fst-pop phantom_lake.txt
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --weir-fst-pop dahler_lake.txt --weir-fst-pop plantagenet.txt
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --weir-fst-pop dahler_lake.txt --weir-fst-pop shell_lake.txt
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --weir-fst-pop dahler_lake.txt --weir-fst-pop upper_rice_lake.txt
~/vcftools/bin/vcftools --gzvcf filt_20_NA_vcf_files_concat_incl_nonbiallelic_snps.vcf --weir-fst-pop dahler_lake.txt --weir-fst-pop zaquatica.txt
