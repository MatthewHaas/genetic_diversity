import sys
import os
import pandas as pd

# Read in sample names
sampleList = pd.read_csv('sample_names_from_vcf.txt', header = None)

# Rename the column to something meaningful even though it's the only one
sampleList.rename({0:'longName'}, axis = 1, inplace = True)

# Make a list with short sample names so we can match based on the key
shortNames = list(sampleList['longName'].str.replace(r'(/.*$)',''))

# Read in sample key containing population structure info
# Path is currently set for my laptop
sampleKey = pd.read_csv('~/Documents/210920_sample_key_with_population_structure.csv')

# Subset sample key to only keep the 2 columns we need so that we can make a dictionary
sampleKey2 = sampleKey[['sample_number', 'STRUCTURE_K4']]

# Make a dictionary out of the subsetted sample key
sampleKeyDict = dict(sampleKey2.values)

# Write to outfile
outfile = open('sample_list_with_key.txt', 'w')

for i in range(len(shortNames)):
    currentSample = shortNames[i]
    outfile.write(str(currentSample)+'/'+str(currentSample)+'_sorted.bam'+'\t'+sampleKeyDict[currentSample]+'\n')
outfile.close()
