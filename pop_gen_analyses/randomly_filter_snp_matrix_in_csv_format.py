import random
import sys
import os

with open(sys.argv[1], 'r') as infile:
    lines = [line for line in infile]
    randomLines = random.sample(lines, 8000)

firstline = True
for line in open(sys.argv[1], 'r'):
    if firstline:
        header = line
        print(header)
        firstline = False
        continue
    else:
        break

with open(sys.argv[2], 'w') as outfile:
    outfile.write(header)
    outfile.write(''.join(randomLines))

outfile.close()
