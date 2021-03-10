import os
import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d

infile = open('plink_20percent_NA_pca_breeding_lines.eigenvec', 'r') # this is the eigenvector file
sampleKey = pd.read_csv('~/main_GBS/191021_main_GBS_sample_key.csv') # read in sample key

eigenvectors = pd.read_table(infile, sep = ' ', header = None) # separated by white space, not tabs

eigenvectors = eigenvectors.drop(labels = 0, axis = 1) # drop one of the columns with sample names (they are duplicated). either labels = 0 or labels = 1 will do the trick

eigenvectors.replace('/.+$', '', regex = True, inplace = True) # strip excess characters from sample names

breedingLines = ['Itasca-C12', 'PM3E', 'PM3/7*K2EF', 'PM3/3*PBM-C3', '14S-PS', '14S*PS', '14S*PM3/PBM-C3',
				 '14PD-C10', 'K2EF-C16', 'K2EFBP-C1', 'K2B-C16', 'VN/3*K2EF', 'VE/2*14WS/*4K2EF',
				 'GPB/K2B-C2', 'GPP-1.20', 'GPN-1.20', 'FY-C20', 'Barron', 'PBML-C20', 'PLaR-C20',
				 'KPVN-C4', 'KSVN-C4']

sampleNames = eigenvectors[1].values.tolist()

# Make a list of tuples with each tuple containing PC1, PC2, PC3
tupleList = []
for i in range(0,len(sampleNames)):
	tupleList.append((eigenvectors.loc[i,2], eigenvectors.loc[i,3], eigenvectors.loc[i,4]))
	
colors = ['mediumorchid', 'navy', 'gold', 'mediumorchid', 'gold', 'mediumorchid', 'navy', 'gold', 			'mediumorchid', 'mediumorchid', 'navy', 'gold', 'mediumorchid', 'navy', 'green', 'gold', 			'mediumorchid', 'navy', 'green', 'mediumorchid', 'firebrick', 'gold', 'gold', 'wheat', 'firebrick', 			'firebrick', 'hotpink', 'orange', 'firebrick', 'gold', 'wheat', 'gold', 'navy', 'firebrick', 			'lightgreen', 'hotpink', 'orange', 'wheat', 'firebrick', 'gold', 'navy', 'firebrick', 'hotpink', 			'hotpink', 'orange', 'gold', 'navy', 'firebrick', 'hotpink', 'hotpink', 'gold', 'firebrick', 			'gold', 'firebrick', 'firebrick', 'wheat', 'navy', 'firebrick', 'lightgreen', 'hotpink', 'orange', 			'gold', 'firebrick', 'gold', 'firebrick', 'wheat', 'firebrick', 'lightgreen', 'hotpink', 'gold', 			'firebrick', 'lightgreen', 'hotpink', 'gold', 'firebrick', 'firebrick', 'lightgreen', 'hotpink', 			'wheat', 'wheat', 'gold', 'wheat', 'wheat', 'lightpink', 'gold', 'lightgreen', 'hotpink', 'hotpink', 			'wheat', 'gold', 'firebrick', 'hotpink', 'hotpink', 'wheat', 'wheat', 'wheat', 'firebrick', 			'hotpink', 'hotpink', 'orange', 'navy', 'wheat', 'wheat', 'orange', 'wheat', 'wheat', 			'lightpink', 'lightpink', 'hotpink', 'orange', 'wheat', 'lightpink', 'lightpink', 'lightgreen', 			'hotpink', 'orange', 'orange', 'lightpink', 'gold', 'lightgreen', 'lightgreen', 'hotpink', 'hotpink', 			'navy', 'navy', 'navy', 'navy', 'navy', 'navy', 'navy', 'navy', 'navy', 'navy', 'navy', 'navy']

# Create plot
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax = fig.gca(projection='3d')

for tupleList, color, in zip(tupleList, colors):
    x, y, z = tupleList
    ax.scatter(x, y, z, alpha=0.8, c=color, edgecolors='none', s=30)

plt.title('Matplot 3d scatter plot')
plt.legend(loc=2)
plt.savefig('breeding_lines_3d_pca.png')
