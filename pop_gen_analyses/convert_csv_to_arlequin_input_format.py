import sys
import os

infile = open(sys.argv[1], 'r')
outfile = open(sys.argv[2], 'w')

allele1 = list()
allele2 = list()

data = infile.readlines()

firstline = True
secondline = True
thirdline = True
fourthline = True
fifthline = True
for line in data:
    if firstline:
        firstline = False
        continue
    if secondline:
        secondline = False
        continue
    if thirdline:
        thirdline = False
        line = line.split(',')
        snpID = list()
        for char in line[1:]:
            snpID.append(char)
        continue
    if fourthline:
        fourthline = False
        line = line.split(',')
        refAllele = list()
        for char in line[1:]:
            refAllele.append(char)
        continue
    if fifthline:
        fifthline = False
        line = line.split(',')
        altAllele = list()
        for char in line[1:]:
            altAllele.append(char)
        continue
    line = line.split(',')
    index = 0
    for char in line[5:]:
        if char == '0':
            allele1.append(refAllele[index])
            allele2.append(refAllele[index])
            name = snpID[index]
            index += 1
        elif char == '1':
            allele1.append(refAllele[index])
            allele2.append(altAllele[index])
            name = snpID[index]
            index += 1
        elif char == '2':
            allele1.append(altAllele[index])
            allele2.append(altAllele[index])
            name = snpID[index]
            index += 1
        elif char == 'NA':
            allele1.append(str('?'))
            allele2.append(str('?'))
            name = snpID[index]
            index += 1
    outfile.write(name + ' 1 ' + ' '.join(allele1) + '\n')
    outfile.write(' '.join(allele2) + '\n')
    del allele1[:] # too bad can't use clear() method
    del allele2[:] # too bad can't use clear() method
outfile.close()
