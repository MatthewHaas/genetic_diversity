# README for FreeBayes 

The first step in the FreeBayes variant calling pipeline is to add read groups (RGs) to the BAM files since they were not already included in them after the alignment step performed using BWA-MEM (Burrows-Wheeler Aligner Maximal Exact Match).

The script [add_RGs_to_bams.sh](add_RGs_to_bams.sh) iterates over the file [200312_sample_list.txt](200312_sample_list.txt) in order to add the RGs to each BAM file. These files are being written to ```/scratch.global/haasx092``` so they won't count against our group quota but note that they will be deleted after 30 days so would need to be regenerated if we wanted to use them again. Once we have the VCF files, that shouldn't be necessary. A better approach might have been to use a SLURM array, but the *for loop* approach still finished in under 24 hours.

Afterwards, you can check that the RGs have been added using the following code:<br>
```samtools view -H Sample_0001_with_RGs.bam | grep "^@RG"```

Note: In order to use this code you need to have typed ```module load samtools``` for the system to recognize the ```samtools``` command. You also need to be in the correct working directory. In this case, it was run in ```/scratch.global/haasx092```.

You can then merge the BAM files containing RGs into a single large BAM file with the script [merge_bams_with_RGs.sh](merge_bams_with_RGs.sh). I did this to facilitate the actual variant-calling step. I thought the code would be easier to understand if there was one large BAM file rather than listing ~1000 separate BAM files to be fed into FreeBayes.

The variant-calling step is done with the script [run_freebayes.sh](run_freebayes.sh).
