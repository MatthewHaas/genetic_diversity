# 3 July 2019
# The R package "poppr" was difficult to install. It seems that one of its dependencies ("sf") needed some options specified. This code will get it running.
# All of these modules need to be loaded when using poppr. The installation of the packages should not need to be done each time.

module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1

module load R/3.6.0

R

install.packages("units", configure.args = c(units = "--with-udunits2-lib=/panfs/roc/msisoft/udunits/2.2.26_gcc8.1.0/lib --with-udunits2-include=/panfs/roc/msisoft/udunits/2.2.26_gcc8.1.0/include"))
install.packages('sf',configure.args='--with-gdal-config=/panfs/roc/msisoft/gdal/2.3.2/bin/gdal-config --with-proj-include=/panfs/roc/msisoft/proj/4.9.3/include --with-proj-lib=/panfs/roc/msisoft/proj/4.9.3/lib --with-proj-share=/panfs/roc/msisoft/proj/4.9.3/share/proj')
install.packages('adegenet')
install.packages('poppr')

library(poppr)
