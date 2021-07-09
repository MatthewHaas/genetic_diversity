import sys
import os
import re

sampleName = os.environ['var'] # this is to get the number of times the script has been run, which is a proxy for sample number

infile = open(sys.argv[1], 'r') # flagstat output file(s)--one at at a time
outfile = open (sys.argv[2], 'a') # single file containing mapping rate for each sample flagstat was run on

data = infile.readlines()

firstline = True
secondline = True
thirdline = True
fourthline = True
fifthline = True
for line in data:
    if firstline:
        line = line.rstrip()
        line = line.split(' ')
        QCpassedreads = line[0]
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
        continue
    if fifthline:
        line = line.rstrip()
        line = line.split(' ')
        mappedreads = line[0]
        percentageRaw = line[4]
        temporary = re.findall('[0-9]+\.[0-9]+\%', percentageRaw) # the percentage occurs after an opening parentheses. this searches for that
        percentage = temporary[0]
        fifthline = False
        continue
outfile.write(sampleName + '\t' + QCpassedreads + '\t' + mappedreads + '\t' + percentage + '\n')
outfile.close()
