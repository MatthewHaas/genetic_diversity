README for count_snps_in_genes

The GFF3 file that I used still contained the old scaffold names (Scaffold_1, Scaffold_3, etc) rather than the new chromosome names (ZPchr0001, ZPchr0002, etc). For this reason, prior to running [bedtools_find_snps_in_genes.sh](bedtools_find_snps_in_genes.sh), I needed to do a search + replace. I did this in ```vim```. First, I copied the file ```rice.gene_structures_post_PASA_updates.21917.reordered.gff3``` from the directory ```/home/jkimball/shared/WR_Annotation/NCBI_submission``` to my working directory so that I would not alter the original file. Once the file was copied, I opened it in ```vim``` and used the following commands to do a search + replace. (**Note:** Prior to using the commands, you have to type ESC followed by (SHIFT + ":").

```%s/\<Scaffold_1\>/ZPchr0009/g```<br>
```%s/\<Scaffold_3\>/ZPchr0003/g```<br>
```%s/\<Scaffold_7\>/ZPchr0015/g```<br>
```%s/\<Scaffold_9\>/ZPchr0011/g```<br>
```%s/\<Scaffold_13\>/ZPchr0001/g```<br>
```%s/\<Scaffold_18\>/ZPchr0004/g```<br>
```%s/\<Scaffold_48\>/ZPchr0006/g```<br>
```%s/\<Scaffold_51\>/ZPchr0016/g```<br>
```%s/\<Scaffold_70\>/ZPchr0010/g```<br>
```%s/\<Scaffold_93\>/ZPchr0002/g```<br>
```%s/\<Scaffold_415\>/ZPchr0012/g```<br>
```%s/\<Scaffold_453\>/ZPchr0458/g```<br>
```%s/\<Scaffold_693\>/ZPchr0014/g```<br>
```%s/\<Scaffold_1062\>/ZPchr0008/g```<br>
```%s/\<Scaffold_1063\>/ZPchr0007/g```<br>
```%s/\<Scaffold_1064\>/ZPchr0013/g```<br>
```%s/\<Scaffold_1065\>/ZPchr0005/g```<br>

After removing overlapping regions, I noticed that the number of SNPs in genes was still inflated. To rectify this, I used a simple ```awk``` one-liner to retain only lines in the file that say "gene" in the third column/field.<br>
```awk '{if($3 == "gene") print $0}' rice.gene_structures_no_overlap.gff > rice.gene_structures_no_overlap_genes_only.gff```

The following one-liner was then used to get a summary of the total number of SNPs in genes on a per-chromosome basis. The VCF file ```snps_in_genes.vcf``` is the output of [bedtools_find_snps_in_genes.sh](bedtools_find_snps_in_genes.sh)<br>
```grep -v "^#" snps_in_genes.vcf | cut -f 1 | sort | uniq -c```<br>
