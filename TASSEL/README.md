# README for TASSEL

The script [structure_data_for_tassel.sh](structure_data_for_tassel.sh) iterates over the text file [sample_list.txt](sample_list.txt) in order to create symbolic links to make input files for the TASSEL-GBS pipeline. Format of input FASTQ file names was found on page 7 of [this](https://bytebucket.org/tasseladmin/tassel-5-source/wiki/docs/TasselPipelineGBS.pdf?rev=83ef75788923c481849e52272182800d066d6651) document.

The first script in the TASSEL-GBS pipeline is [run_tasselFastqToTagCount.sh](run_tasselFastqToTagCount.sh). The companion [key file](key_file.txt) is required for the script to run.
