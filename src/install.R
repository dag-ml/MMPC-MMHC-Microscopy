setwd("/Users/camwolff/Development/local/R/dag_validation")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Rgraphviz")
install.packages("bnlearn")
install.packages("psych")