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

def assignClusterMembership(K):
    existing_IDs = [] # make empty list to store cluster IDs
    global clusterA, clusterB, clusterC, clusterD, clusterE, clusterF # declare global variables here rather than in each if/elif statement
    if K == 2:
        clusterA = dfSorted[(dfSorted['Most_likely'] == 'Cluster_1') & (dfSorted['Likelihood'] > 0.6)].Class.mode()
        existing_IDs.append(clusterA[0])
        clusterB = dfSorted[(dfSorted['Most_likely'] == 'Cluster_2') & (dfSorted['Likelihood'] > 0.6)].Class.mode()
        existing_IDs.append(clusterB[0])
        for cluster in [clusterA, clusterB]:
            if cluster[0] == 'Natural stand':
                cluster[0] = 'Natural stand I'
            elif cluster[0] == 'Breeding line':
                cluster[0] = 'Cultivated material and Natural stand' # mention both to be most accurate
        return clusterA, clusterB
    elif K == 3:
        clusterA = dfSorted[(dfSorted['Most_likely'] == 'Cluster_1')].Class.mode()
        existing_IDs.append(clusterA[0])
        clusterB = dfSorted[(dfSorted['Most_likely'] == 'Cluster_2')].Class.mode()
        if clusterB[0] in existing_IDs:
            clusterB[0] = 'Natural stand II'
            existing_IDs.append(clusterB[0])
        else:
            existing_IDs.append(clusterB[0])
        clusterC = dfSorted[(dfSorted['Most_likely'] == 'Cluster_3')].Class.mode()
        if clusterC[0] in existing_IDs:
            clusterC[0] = 'Natural stand II'
            existing_IDs.append(clusterC[0])
        else:
            existing_IDs.append(clusterC[0])
        for cluster in (clusterA, clusterB, clusterC):
            if cluster[0] == 'Breeding line':
                cluster[0] = 'Cultivated material'
        return clusterA, clusterB, clusterC

def makePlot(K):
    colorsAll = ['red', 'lime', 'blue', 'yellow', 'fuchsia', 'cyan']
    if K == 2:
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([]) # hide x-axis tick marks
        assignClusterMembership(K)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_2'], color = colorsAll[0], width = 1)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_1'], bottom = dfSorted['Cluster_2'], color = colorsAll[1], width = 1)
        plt.ylabel('Population membership probability')
        x1 = len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_1') & (dfSorted['Likelihood'] > 0.6)])/2
        x2 = x1*2 + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2') & (dfSorted['Likelihood'] > 0.6)])/2
        y = -0.1 # only a single, constant value for y is needed
        plt.text(x1, y, s = clusterA[0], fontsize = 12, ha = 'center')
        plt.text(x2, y, s = clusterB[0], fontsize = 12, ha = 'center')
        plt.savefig(sys.argv[2])
    elif K == 3:
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([])
        assignClusterMembership(K)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_2'], color = colorsAll[0], width = 1)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_1'], bottom = dfSorted['Cluster_2'], color = colorsAll[1], width = 1)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_3'], bottom = dfSorted['Cluster_2'] + dfSorted['Cluster_1'], color = colorsAll[2], width = 1)
        plt.ylabel('Population membership probability')
        x1 = len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_1')])/2
        x2 = x1*2 + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2')])/2
        x3 = x1*2 + + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2')]) + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_3')])/2
        y = -0.1 # constant--different y values are not necessary for plotting text
        plt.text(x1, y, s = clusterA[0], fontsize = 12, ha = 'center')
        plt.text(x2, y, s = clusterB[0], fontsize = 12, ha = 'center')
        plt.text(x3, y, s = clusterC[0], fontsize = 12, ha = 'center')
        plt.savefig(sys.argv[2])
    elif K == 4:
        cluster1_ID = dfSorted[(dfSorted['Most_likely'] == 'Cluster_1') & (dfSorted['Likelihood'] > 0.6)].Class.mode()
        existing_IDs.append(cluster1_ID[0])
        cluster2_ID = dfSorted[(dfSorted['Most_likely'] == 'Cluster_2')].Sample_identity.mode()
        print('The length of Z aquatica is:' + str(len(dfSorted[dfSorted['Sample_identity'] == 'Zizania aquatica'])))
        print('The total length of Cluster 2 is:' + str(len(dfSorted[dfSorted['Most_likely'] == 'Cluster_2'])))
        if cluster2_ID[0] in existing_IDs:
            print('So far so good.')
            fractionZaquatica = int(len(dfSorted[(dfSorted['Sample_identity'] == 'Zizania aquatica')])) / int(len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2')]))
            print(fractionZaquatica)
            if fractionZaquatica > 0.7:
                print('You are in the right spot.')
                cluster2_ID[0] = 'Zizania aquatica'
                existing_IDs.append(cluster2_ID[0])
        else:
            print('How did I end up here??')
            existing_IDs.append(cluster2_ID[0])
        cluster3_ID = dfSorted[(dfSorted['Most_likely'] == 'Cluster_3') & (dfSorted['Likelihood'] > 0.6)].Class.mode()
        existing_IDs.append(cluster3_ID[0])
        cluster4_ID = dfSorted[(dfSorted['Most_likely'] == 'Cluster_4') & (dfSorted['Likelihood'] > 0.6)].Class.mode()
        if cluster4_ID[0] in existing_IDs:
            cluster4_ID[0] = 'Natural stand II'
            existing_IDs.append(cluster4_ID[0])
        else:
            existing_IDs.append(cluster4_ID[0])
        # This for loop is to add a roman numeral to the first Natural stand cluster to be consistent with the second
        # The other part is to change the name of the breeding lines cluster to be 'Cultivated material'
        for cluster in [cluster1_ID, cluster2_ID, cluster3_ID, cluster4_ID]:
            if cluster[0] == 'Natural stand':
                cluster[0] = 'Natural stand I'
            elif cluster [0] == 'Breeding line':
                cluster[0] = 'Cultivated material'
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([])
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_2'], color = colorsAll[0], width = 1)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_1'], bottom = dfSorted['Cluster_2'], color = colorsAll[1], width = 1)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_3'], bottom = dfSorted['Cluster_2'] + dfSorted['Cluster_1'], color = colorsAll[2], width = 1)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_4'], bottom = dfSorted['Cluster_3'] + dfSorted['Cluster_2'] + dfSorted['Cluster_1'], color = colorsAll[3], width = 1)
        plt.ylabel('Population membership probability')
        x1 = len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_1')])/2
        x2 = x1*2 + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2')])/2
        x3 = x1*2 + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2')]) + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_3')])/2
        x4 = x1*2 + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2')]) + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_3')]) + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_4')])/2
        y = -0.1
        plt.text(x1, y, s = cluster1_ID[0], fontsize = 12, ha = 'center')
        plt.text(x2, y, s = cluster2_ID[0], fontsize = 12, ha = 'center')
        plt.text(x3, y, s = cluster3_ID[0], fontsize = 12, ha = 'center')
        plt.text(x4, y, s = cluster4_ID[0], fontsize = 12, ha = 'center')
        plt.savefig(sys.argv[2])
    elif K == 5:
        print('K=5')
    elif K == 6:
        print('K=6')
    else:
        print('Not an acceptable value of K!')

def emulateStructure(df):
    if len(df.columns) == 9:
        makePlot(K = 2)
        print('Analysis completed assuming K=2 populations.')
    elif len(df.columns) == 10:
        makePlot(K = 3)
        print('Analysis completed assuming K=3 populations.')
    elif len(df.columns == 11):
        makePlot(K = 4)
        print('Analysis completed assuming K=4 populations.')
    elif len(df.columns == 12):
        makePlot(K = 5)
        print('Analysis completed assuming K=5 populations.')
    elif len(df.columns == 13):
        makePlot(K = 6)
        print('Analysis completed assuming K=6 populations.')
    elif len(df.columns > 13):
        print('You might have more than K = 6 populations in your input file.')
    else:
        print('Something is wrong with your input file.')

df = pd.read_csv(sys.argv[1])
dfSorted = df.sort_values(by = ['Most_likely', 'Likelihood'], ascending = (True, False))
emulateStructure(df)
