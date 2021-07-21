# README for FreeBayes 

The first step in the FreeBayes variant calling pipeline is to add read groups (RGs) to the BAM files since they were not already included in them after the alignment step performed using BWA-MEM (Burrows-Wheeler Aligner Maximal Exact Match).

The script [add_RGs_to_bams.sh](add_RGs_to_bams.sh) iterates over the file [200312_sample_list.txt](200312_sample_list.txt) in order to add the RGs to each BAM file. These files are being written to ```/scratch.global/haasx092``` so they won't count against our group quota but note that they will be deleted after 30 days so would need to be regenerated if we wanted to use them again. Once we have the VCF files, that shouldn't be necessary. A better approach might have been to use a SLURM array, but the *for loop* approach still finished in under 24 hours.

Afterwards, you can check that the RGs have been added using the following code:<br>
```samtools view -H Sample_0001_with_RGs.bam | grep "^@RG"```

Note: In order to use this code you need to have typed ```module load samtools``` for the system to recognize the ```samtools``` command. You also need to be in the correct working directory. In this case, it was run in ```/scratch.global/haasx092```.

You can then merge the BAM files containing RGs into a single large BAM file with the script [merge_bams_with_RGs.sh](merge_bams_with_RGs.sh). I did this to facilitate the actual variant-calling step. I thought the code would be easier to understand if there was one large BAM file rather than listing ~1000 separate BAM files to be fed into FreeBayes.

**Note":** To make the [bams_to_merge.txt](bams_to_merge.txt) file, I used the ```ls /scratch.global/haasx092``` command to get the list of BAM files containing RGs and wrote it to a text file, but since I was actually working in a different directory (```/home/jkimball/haasx092/main_GBS```) I needed to specify the full path to those files. I used the search and replace function in _vim_ to acheive this. Once in vim (e.g., ```vi bams_to_merge.txt```), I typed:
1. Esc then Shift + ":" (simultaneously)
2. ```%s/Sample/\/scratch.global\/haasx092\/Sample/g``` (the "\" character in front of each "/" is important because it tells vim to take the character literally rather than its special case in the search/replace function (general form: ```%s/originalString/replacementString/g```)
3. Esc then Shift + ":" (simultaneously) followed by typing ```wq``` to save and hitting Enter to exit vim.

The variant-calling step is done with the script [run_freebayes.sh](run_freebayes.sh).

Filtering was done using VCFtools with the script [filter_with_vcftools.sh](filter_with_vcftools.sh).
