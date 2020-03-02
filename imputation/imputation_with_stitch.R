# 2 March 2020
# WD: /home/jkimball/haasx092/main_GBS
# Imputation using STITCH

# Load R
module load R/3.6.0

# Launch R
R
library(STITCH)

STITCH(chr = 'Scaffold_1;HRSCAF=83', 
	   nGen = 10000, 
	   posfile = 'path/to/posfile',
	   K = 4,
	   outputdir = '~/main_GBS/imputation/200302_stitch',
	   tempdir = NA,
	   bamlist = '~/main_GBS/190910_sorted_bam_files.txt',
	   reference = '/home/jkimball/mshao/genome_seq/zizania_palustris_13Nov2018_okGsv.fasta',
	   method = 'diploid',
	   output_format = 'bgvcf',
	   outputInputInVCFFormat = TRUE,
	   nCores = 4)