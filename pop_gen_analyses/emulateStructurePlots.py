import sys
import os
#import argparse
import pandas as pd
import matplotlib.pyplot as plt

#parser = argparse.ArgumentParser()

#parser.add_argument('--pops', '-k', help = 'How many K populations do you expect?', type = str)

#args = parser.parse_args()

#print(parser.format_help())

def makePlot(K = NULL):
    if K == 2:
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([]) # hide x-axis tick marks
        dfSorted = df.sort_values(by = ['Most_likely', 'Likelihood'], ascending = (True, False))
        cluster1_ID = dfSorted[(dfSorted['Most_likely'] == 'Cluster_1') & (dfSorted['Likelihood'] > 0.6)].Class.mode()
        cluster2_ID = dfSorted[(dfSorted['Most_likely'] == 'Cluster_2') & (dfSorted['Likelihood'] > 0.6)].Class.mode()
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_2'], color = colorsAll[0], width = 1)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_1'], bottom = dfSorted['Cluster_2'], color = colorsAll[1], width = 1)
        plt.ylabel('Population membership probability')
        x1 = len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_1') & (dfSorted['Likelihood'] > 0.6)])/2
        x2 = x1*2 + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2') & (dfSorted['Likelihood'] > 0.6)])/2
        y = -0.1
        plt.text(x1, y, s = cluster1_ID[0], fontsize = 12, ha = 'center')
        plt.text(x2, y, s = cluster2_ID[0], fontsize = 12, ha = 'center')
        plt.savefig(sys.argv[2])
    elif K == 3:
        existing_IDs = [] # empty list to store existing IDs. Main purpose is to have a mechanism to recogize of 'Natural stand' has already been used and 'Natural stand II' should be used instead
        cluster1_ID = dfSorted[(dfSorted['Most_likely'] == 'Cluster_1') & (dfSorted['Likelihood'] > 0.6)].Class.mode()
        existing_IDs.append(cluster1_ID[0])
        cluster2_ID = dfSorted[(dfSorted['Most_likely'] == 'Cluster_2') & (dfSorted['Likelihood'] > 0.6)].Class.mode()
        existing_IDs.append(cluster2_ID[0])
        cluster3_ID = dfSorted[(dfSorted['Most_likely'] == 'Cluster_3') & (dfSorted['Likelihood'] > 0.6)].Class.mode()
        if cluster3_ID[0] in existing_IDs:
            cluster3_ID[0] = 'Natural stand II'
            existing_IDs.append(cluster3_ID[0])
        else:
            existing_IDs.append(cluster3_ID[0])
        plt.figure(figsize = (20, 4.8)) # supposedly this is in inches...
        plt.xticks([])
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_2'], color = colorsAll[0], width = 1)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_1'], bottom = dfSorted['Cluster_2'], color = colorsAll[1], width = 1)
        plt.bar(dfSorted['Sample_name'], dfSorted['Cluster_3'], bottom = dfSorted['Cluster_2'] + dfSorted['Cluster_1'], color = colorsAll[2], width = 1)
        plt.ylabel('Population membership probability')
        x1 = len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_1') & (dfSorted['Likelihood'] > 0.6)])/2
        x2 = x1*2 + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2') & (dfSorted['Likelihood'] > 0.6)])/2
        x3 = x1*2 + + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2') & (dfSorted['Likelihood'] > 0.6)]) + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_3') & (dfSorted['Likelihood'] > 0.6)])/2
        y = -0.1 # constant--different y values are not necessary for plotting text
        plt.text(x1, y, s = cluster1_ID[0], fontsize = 12, ha = 'center')
        plt.text(x2, y, s = cluster2_ID[0], fontsize = 12, ha = 'center')
        plt.text(x3, y, s = cluster3_ID[0], fontsize = 12, ha = 'center')
        plt.savefig(sys.argv[2])
    elif K == 4:
    elif K == 5:
    elif K == 6:
    else:
        print('Not an acceptable value of K!')

def emulateStructure(data):
    df = pd.read_csv(data)
    colorsAll = ['red', 'lime', 'blue', 'yellow', 'fuchsia', 'cyan']
    if len(df.columns) == 9:
        colors = colorsAll[:2]
        makePlot(K = 2)
        print('Analysis completed assuming K=2 populations.')
    elif len(df.columns) == 10:
        colors = colorsAll[:3]
        makePlot(K = 3)
        print('Analysis completed assuming K=3 populations.')
    elif len(df.columns == 11):
        colors = colorsAll[:4]
        makePlot(K = 4)
        print('Analysis completed assuming K=4 populations.')
    elif len(df.columns == 12):
        colors = colorsAll[:5]
        makePlot(K = 5)
        print('Analysis completed assuming K=5 populations.')
    elif len(df.columns == 13):
        colors = colorsAll[:6]
        makePlot(K = 6)
        print('Analysis completed assuming K=6 populations.')
    elif len(df.columns > 13):
        print('You might have more than K = 6 populations in your input file.')
    else:
        print('Something is wrong with your input file.')

df = pd.read_csv(sys.argv[1])
dfSorted = df.sort_values(by = ['Most_likely', 'Likelihood'], ascending = (True, False))
emulateStructure(df)
