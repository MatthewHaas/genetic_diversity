"""This script was written to emulate the plots from the software program STRUCTURE by Pritchard et al. (2000). The main point of doing this is to annotate population membership below the plot rather than take the output files from STRUCTURE and add the annotations in PowerPoint. The input file should be in comma-separated value (CSV) format. Each file regardless of K value should have some columns in common. The first few columns are: 1) Label (assigned by STRUCTURE), 2) Sample_name, 3)
Sample_identity, 4) Class (Natural stand or Cultivated/breeding line), and 5) percent_missing. The next few columns are optional/variable, but a minimum of two (so, K=2) are required. Columns 6-7 for K=2 (more if K>2) are: 6) Cluster_1 and 7) Cluster_2. For K populations higher than 2, there would also be Cluster_3 up to Cluster_6. The script is not written to expect K values higher than K=6. Following these cluster assignment columns, there are two additional required columns: 8) Most_likely (most likely population membership based on max
value in variable cluster columns) and 9) Likelihood (probability that the sample belongs to the cluster in the Most_likely column). Some of these columns are not actually used by the program (Label & percent_missing to be exact). However, the flow of logic used in this code depends on their inclusion. I retained these 'excess' columns from the STRUCTURE ouput to be able to go back and re-confirm my analysis (especially the identity of any given sample--the plots are sorted first by cluster assignment and second by likelihood (in
descending order)), I figured that with a consistent file format, it was easier to have the script 'know' what the value of K is rather than making 'extra' work to specify K values for anyone else who may use this script in the future. --Matthew Haas (13 September 2021)"""

import sys
import os
#import argparse
import pandas as pd
import matplotlib.pyplot as plt

#parser = argparse.ArgumentParser()

#parser.add_argument('--pops', '-k', help = 'How many K populations do you expect?', type = str)

#args = parser.parse_args()

#print(parser.format_help())

def makePlot(K):
    #colorsAll = ['red', 'lime', 'blue', 'yellow', 'fuchsia', 'cyan'] # these were the original colors that were chosen to emulate the colors used in STRUCTURE
    colorsAll = ['#e935a1', '#00e3ff', '#e1562c', '#537eff', '#00cb85', 'red', 'lime', 'blue',  'yellow', 'fuschia', 'cyan', 'black', 'brown', 'grey'] # new colors chosen for new STRUCTURE plots (need to get up to 15 since we potentially have that many clusters)
    if K == 2:
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([]) # hide x-axis tick marks
        plt.yticks(fontsize = 18)
        plt.bar(df['Sample_name'], df['Cluster_1'], color = colorsAll[0], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_2'], bottom = df['Cluster_1'], color = colorsAll[1], width = 1)
        plt.ylabel('Population membership probability', fontsize = 18)
        plt.savefig(sys.argv[2])
    elif K == 3:
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([])
        plt.yticks(fontsize = 18)
        plt.bar(df['Sample_name'], df['Cluster_1'], color = colorsAll[0], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_2'], bottom = df['Cluster_1'], color = colorsAll[1], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_3'], bottom = df['Cluster_2'] + df['Cluster_1'], color = colorsAll[2], width = 1)
        plt.ylabel('Population membership probability', fontsize = 18)
        plt.savefig(sys.argv[2])
    elif K == 4:
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([])
        plt.yticks(fontsize = 18)
        plt.bar(df['Sample_name'], df['Cluster_1'], color = colorsAll[0], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_2'], bottom = df['Cluster_1'], color = colorsAll[1], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_3'], bottom = df['Cluster_2'] + df['Cluster_1'], color = colorsAll[2], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_4'], bottom = df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[3], width = 1)
        plt.ylabel('Population membership probability', fontsize = 18)
        plt.savefig(sys.argv[2])
    elif K == 5:
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([])
        plt.yticks(fontsize = 18)
        plt.bar(df['Sample_name'], df['Cluster_1'], color = colorsAll[0], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_2'], bottom = df['Cluster_1'], color = colorsAll[1], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_3'], bottom = df['Cluster_2'] + df['Cluster_1'], color = colorsAll[2], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_4'], bottom = df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[3], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_5'], bottom = df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[4], width = 1)
        plt.ylabel('Population membership probability', fontsize = 18)
        plt.savefig(sys.argv[2])
    elif K == 6:
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([])
        plt.yticks(fontsize = 18)
        plt.bar(df['Sample_name'], df['Cluster_1'], color = colorsAll[0], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_2'], bottom = df['Cluster_1'], color = colorsAll[1], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_3'], bottom = df['Cluster_2'] + df['Cluster_1'], color = colorsAll[2], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_4'], bottom = df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[3], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_5'], bottom = df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[4], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_6'], bottom = df['Cluster_5'] + df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[5], width = 1)
        plt.ylabel('Population membership probability', fontsize = 18)
        plt.savefig(sys.argv[2])
    elif K == 14:
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([])
        plt.yticks(fontsize = 18)
        plt.bar(df['Sample_name'], df['Cluster_1'], color = colorsAll[0], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_2'], bottom = df['Cluster_1'], color = colorsAll[1], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_3'], bottom = df['Cluster_2'] + df['Cluster_1'], color = colorsAll[2], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_4'], bottom = df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[3], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_5'], bottom = df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[4], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_6'], bottom = df['Cluster_5'] + df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[5], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_7'], bottom = df['Cluster_6'] + df['Cluster_5'] + df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[5], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_8'], bottom = df['Cluster_7'] + df['Cluster_6'] + df['Cluster_5'] + df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[5], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_9'], bottom = df['Cluster_8'] + df['Cluster_7'] + df['Cluster_6'] + df['Cluster_5'] + df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[5], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_10'], bottom = df['Cluster_9'] + df['Cluster_8'] + df['Cluster_7'] + df['Cluster_6'] + df['Cluster_5'] + df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[5], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_11'], bottom = df['Cluster_10'] + df['Cluster_9'] + df['Cluster_8'] + df['Cluster_7'] + df['Cluster_6'] + df['Cluster_5'] + df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[5], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_12'], bottom = df['Cluster_11'] + df['Cluster_10'] + df['Cluster_9'] + df['Cluster_8'] + df['Cluster_7'] + df['Cluster_6'] + df['Cluster_5'] + df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[5], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_13'], bottom = df['Cluster_12'] + df['Cluster_11'] + df['Cluster_10'] + df['Cluster_9'] + df['Cluster_8'] + df['Cluster_7'] + df['Cluster_6'] + df['Cluster_5'] + df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[5], width = 1)
        plt.bar(df['Sample_name'], df['Cluster_14'], bottom = df['Cluster_13'] + df['Cluster_12'] + df['Cluster_11'] + df['Cluster_10'] + df['Cluster_9'] + df['Cluster_8'] + df['Cluster_7'] + df['Cluster_6'] + df['Cluster_5'] + df['Cluster_4'] + df['Cluster_3'] + df['Cluster_2'] + df['Cluster_1'], color = colorsAll[5], width = 1)
        plt.ylabel('Population membership probability', fontsize = 18)
        plt.savefig(sys.argv[2])
    else:
        print('Not an acceptable value of K!')

def emulateStructure(df):
    if len(df.columns) == 7:
        makePlot(K = 2)
        print('Analysis completed assuming K=2 populations.')
    elif len(df.columns) == 8:
        makePlot(K = 3)
        print('Analysis completed assuming K=3 populations.')
    elif len(df.columns) == 9:
        makePlot(K = 4)
        print('Analysis completed assuming K=4 populations.')
    elif len(df.columns) == 10:
        makePlot(K = 5)
        print('Analysis completed assuming K=5 populations.')
    elif len(df.columns) == 11:
        makePlot(K = 6)
        print('Analysis completed assuming K=6 populations.')
    elif len(df.columns) == 19:
        makePlot(K = 14)
        print('Analysis completed assuming K=14 populations.')
    #elif len(df.columns) > 12:
    #    print('You might have more than K = 6 populations in your input file.')
    else:
        print('Something is wrong with your input file.')

df = pd.read_csv(sys.argv[1])
emulateStructure(df)
