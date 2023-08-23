setwd("/Users/camwolff/Development/local/R/dag_validation")

### LOAD LIBRARIES###
# install packages
# source("install.R")

library(bnlearn)
library(Rgraphviz)
library(psych)

### LOAD AND PREPARE DATA ###
graphs_path <- "graphs/"
scripts_path <- "scripts/"

data_path <- "data/costes_data"
source(paste(scripts_path, "Costes.R", sep = ""))

### RUN ALGORITHMS ###
cotes_bn <- mmpc(cotes)  # Generate bayesian network skeleton with MMPC algorithm
cotes_dag <-mmhc(cotes)  # Generate directed acyclic graph with MMHC algorithm

### PLOT RESULTS ###
graphviz.plot(costes_bn, main = "Costes BN") # plot and visualize Bayesian network skeleton
graphviz.plot(costes_dag, main = "Costes BN") # plot and visualize Dags
