# Load required modules
import numpy as np
import pandas as pd

# Read in data
reads1 = pd.read_csv('190730_A00223_0174_BHCN5GDRXX_metrics.csv')
reads2 = pd.read_csv('190819_A00223_0191_AHF3V3DRXX_metrics.csv')

# Filter out pilot project data
reads1filt = reads1[reads1['general-samplename'].str.contains('18') | reads1['general-samplename'].str.contains('Mean')]
reads2filt = reads2[reads2['general-samplename'].str.contains('18') | reads2['general-samplename'].str.contains('Mean')]

# Subset data, keeping only identifying columns and column with total sequence information
reads1subset = reads1filt[['general-projectname', 'general-runname', 'general-samplename', 'fastqc-totalsequences']]
reads2subset = reads2filt[['general-projectname', 'general-runname', 'general-samplename', 'fastqc-totalsequences']]

# Concatenate the two sets of read counts and sum the  fastqc-totalsequences column
mergedReadData = pd.concat([reads1subset, reads2subset]).groupby(['general-samplename']).sum().reset_index()

# Save data to file
mergedReadData.to_csv("merged_fastq_sequence_counts.csv", header = True)
