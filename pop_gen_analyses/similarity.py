from __future__ import division # this is so I get decimals using division rather than 0 which I got during my interactive testing of this script
from pandas import *
import sys
import os

# read in data
data = read_csv(sys.argv[1], 'r', header = None) # csv file with one column of sample names and multiple columns of genotype calls (one column per variant site)

# open output file
outfile = open(sys.argv[2], 'w') # csv file with two columns of sample names (to indicate the pairwise comparison being made) and one column with a similarity score

# Make a list of sample names
sampleNames = data[0].tolist()
# Make a duplicate list
sampleNames2 = sampleNames

# Make a csv file with two columns for sample names to prep for pairwise similarity comparisons
outfile.write('sampleName1' + ',' + 'sampleName2' + ',' + 'similarity' + '\n')


for sample in sampleNames:
    for sample2 in sampleNames2:
        a = data[data[0] == sample]
        b = data[data[0] == sample2]
        a = a.iloc[0,1:]
        b = b.iloc[0,1:]
        count = 0
        for i in range(1,5955):
            if a[i] == b[i]:
        	    count += 1
        similarity = round(count/5955, 4)
        outfile.write(str(sample) + ',' + str(sample2) + ',' + str(similarity) + '\n')
outfile.close()
