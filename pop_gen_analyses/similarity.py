from __future__ import division # this is so I get decimals using division rather than 0 which I got during my interactive testing of this script
from pandas import *
import sys
import os

# read in data
data = read_csv(sys.argv[1], 'r', header = None, delimiter = ',') # csv file with one column of sample names and multiple columns of genotype calls (one column per variant site)
# for example, 211101_snp_data_formatted_for_similarity.csv

# open output file
outfile = open(sys.argv[2], 'w') # csv file with two columns of sample names (to indicate the pairwise comparison being made) and one column with a similarity score
# for example, 21103_similarity_long_python_attempt2.csv

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
        total = 0
        for i in range(1,5955):
            if pd.isna(a[i]) or pd.isna(b[i]):
                #print('NaN spotted at position '+ str(i))
                continue
            elif a[i] == b[i]:
                if a[i] == 0 and b[i] == 0:
                    count += 1
                    total += 1
                elif a[i] == 2 and b[i] == 2:
                    count += 1
                    total += 1
                elif a[i] == 1 and b[i] == 1:
                    count += 1
                    total += 1
                elif pd.isna(a[i]) or pd.na(b[i]):
                    print('NaN spotted when a=b')
                    continue
                else:
                    print('something else')
                    continue
            elif a[i] != b[i]:
                #print(sample + ' is not equal to ' + sample2 + ' at position ' + str(i))
                total += 1
            else:
                print('no conditions met') # this was included to make sure the loop wasn't going here because I didn't expect it to
                continue
        similarity = round(count/total, 4)
        outfile.write(str(sample) + ',' + str(sample2) + ',' + str(similarity) + '\n')
                    
outfile.close()
