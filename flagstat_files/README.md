# README for flagstat_files

Files for checking BAM files for alignment statistics

The flagstat tool from SAMtools is run using the script [run_flagstat.sh](run_flagstat.sh). The output is written to files for each of the 1,054 samples in the directory structure so I wrote the python script [parse_flagstat_files.py](parse_flagstat_files.py) to extract information (QC-passed reads, mapped reads, and % mapped reads) from each of these output files and is written to a summary file. Each new sample is appended to the end of the existing summary script, so if you run it more than once, you will get duplicated information. The script [run_parse_flagstat_files.sh](run_parse_flagstat_files.sh) runs this python script. It starts out by writing a header line with column names before iterating through a text file via a ```for loop``` to provide unique input file names for the python script.
