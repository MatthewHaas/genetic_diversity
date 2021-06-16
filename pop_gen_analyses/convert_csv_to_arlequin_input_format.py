import sys
import os

infile = open(sys.argv[1], 'r')
outfile = open(sys.argv[2], 'w')

allele1 = list()
allele2 = list()

data = infile.readlines()

firstline = True
for line in data:
    if firstline:
        firstline = False
        continue
    line = line.split(',')
    for char in line[5:]:
        if char == '0':
            allele1.append(line[3])
            allele2.append(line[3])
        elif char == '1':
            allele1.append(line[3])
            allele2.append(line[4])
        elif char == '2':
            allele1.append(line[4])
            allele2.append(line[4])
        elif char == 'NA':
            allele1.append(str('?'))
            allele2.append(str('?'))
    outfile.write(' '.join(allele1) + '\n')
    outfile.write(' '.join(allele2) + '\n')
outfile.close()
