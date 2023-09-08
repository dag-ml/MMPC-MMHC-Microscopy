setwd("/home/cam/Development/Git/mmpc")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Rgraphviz")
install.packages("bnlearn")
install.packages("psych")
install.packages("tidyr")
install.packages("mltools")
install.packages("data.table")
install.packages("dplyr")
