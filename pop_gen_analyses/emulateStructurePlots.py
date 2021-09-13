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
        y1 = -0.1
        x2 = x1*2 + len(dfSorted[(dfSorted['Most_likely'] == 'Cluster_2') & (dfSorted['Likelihood'] > 0.6)])/2
        y2 = -0.1
        text(x1, y1, s = cluster1_ID[0], fontsize = 12, ha = 'center')
        text(x2, y2, s = cluster2_ID[0], fontsize = 12, ha = 'center')
    elif K == 3:
    elif K == 4:
    elif K == 5:
    elif K == 6:
    else:
        print('Not an acceptable value of K!')

def emulateStructure(data):
    df = pd.read_csv(data)
    colorsAll = ['red', 'lime', 'blue', 'yellow', 'fuchsia', 'cyan']
    if len(df.columns) == 8:
        colors = colorsAll[:2]
        makePlot(K = 2)
        print('this assumes there are K = 2 populations')
    elif len(df.columns) == 9:
        colors = colorsAll[:3]
        makePlot(K = 3)
        print('this assumes there are K = 3 populations')
    elif len(df.columns == 10):
        colors = colorsAll[:4]
        makePlot(K = 4)
        print('this assumes there are K = 4 populations')
    elif len(df.columns == 11):
        colors = colorsAll[:5]
        makePlot(K = 5)
        print('this assumes there are K = 5 populations')
    elif len(df.columns == 12):
        colors = colorsAll[:6]
        makePlot(K = 6)
        print('this assumes there are K = 6 populations')
    elif len(df.columns > 12):
        print('You might have more than K = 6 populations in your input file.')
    else:
        print('Something is wrong with your input file.')

emulateStructure(data = sys.argv[1])
