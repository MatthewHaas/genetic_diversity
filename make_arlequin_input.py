'''
This script takes a SNP matrix in CSV format as an argument and converts the SNP calls into to an Arlequin-style file (which requires 2 lines for each haplotype).
It is a bit complicated because the first line should have a haplotype identifer/sample name, followed by a space, the frequency of the haplotype (1 in this case), another space, and finally a series of allele calls. The second line should only be allele calls, but it seems to need spaces where the first line has the haplotype ID and frequency.
The first three lines are skipped because they contain information that are not relevant to the output.
The fourth line contains the reference allele calls which are put into a list called refAllele.
The fifth line contains the alternate allele calls which are ut into a list called altAllele.
The actual SNP calls begin on ths sixth line and the script iterates through each of these.
The first column (line[0]) contains the sample name and is stored in a list called sampleID to facilitate writting the haplotype identifer in the output.
If the SNP call is a 0, the respective refAllele is written to lists allele1 and allele2.
If the SNP call is a 1, the respective refAllele is written to allele1 while the respective altAllele is written to allele2.
If the SNP call is a 2, the respective altAllele is writteo to lists allele1 and allele2.
Missing data are written as a question mark (?) which is in accordance with Arlequin format.
At the end of each iteration of the for loop, the sampleID, frequency, and allele1 and allele2 lists are written to the output file (the Arlequin input style).
The lists allele1 and allele1 are cleared at the end of each iteration of the for loop so that they do not become exponentially larger and combine sammples/haplotypes.
'''
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
    line = line.strip()
    line = line.split(',')
    sampleID = list()
    for char in line:
        index = 0
        sampleID.append(line[0])
        if char == '0':
	    allele1.append(refAllele[index])
	    allele2.append(refAllele[index])
            index = index + 1
        elif char == '1':
	    allele1.append(refAllele[index])
	    allele2.append(altAllele[index])
            index = index + 1
        elif char == '2':
	    allele1.append(altAllele[index])
	    allele2.append(altAllele[index])
            index = index + 1
        elif char == 'NA':
	    allele1.append(str('?'))
	    allele2.append(str('?'))
            index = index + 1
    outfile.write(sampleID[index] + ' 1 ' + ' '.join(allele1) + '\n')
    outfile.write(' ' + ' ' + ' '.join(allele2) + '\n')
    del allele1[:] # too bad can't use clear() method
    del allele2[:] # too bad can't use clear() method
outfile.close()
