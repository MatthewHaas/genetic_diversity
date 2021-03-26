# README for unrooted_trees

The script [gl2gi.R](gl2gi.R) script is here because I coud not get the [dartR](https://rdrr.io/cran/dartR/src/R/gl2gi.r) package installed and I needed the function. Fortunately, I was able to find the source code, so I saved the function as its own file and call it using ```source()``` in my scripts to make the unrooted trees. The script is important because it converts the genlight object (which I have) to a genind object (which I need).

[natural_stands_unrooted_UPGMA_tree.R](natural_stands_unrooted_UPGMA_tree.R) will make the unrooted tree for the natural stands.
[temporal_samples_unrooted_UPGMA_tree.R](temporal_samples_unrooted_UPGMA_tree.R) will make the unrooted tree for the temporal samples.

Have not yet made the script for the breeding lines, mostly because I had some issues with the minimum spanning network.

There are plenty of options for the method to joining the trees (Nei, Rogers, Edwards, Reynolds, Prevosti), but only Prevosti seems to work. The rest complain about missing data. Bruvo is another, but it is only suitable for microsatellite data.
