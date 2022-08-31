#!/bin/bash

cd ~/Documents/wild_rice/genetic_diversity/Data/files_to_convert_to_arlequin

for infile in $(cat reformatted_natural_stand_snp_matricies.txt);
do
 STEM=$(echo $infile | cut -d "_" -f 1)
 echo $STEM
 python make_arlequin_input.py $infile ${STEM}.arp
done

