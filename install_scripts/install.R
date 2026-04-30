#! /usr/bin/env Rscript
install.packages(c('tidyverse', 'plinkFile', 'BiocManager'),
                 repos='http://cran.r-project.org')
BiocManager::install('GENESIS')
