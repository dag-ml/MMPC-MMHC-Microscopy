setwd("/home/cam/Development/Git/mmpc")

## LOAD LIBRARIES ###
# install packages
# source("src/install.R")

library(bnlearn)
library(Rgraphviz)
library(psych)
library(tidyr)
library(mltools)
library(data.table)
library(dplyr)

### LOAD AND PREPARE DATA ###
scripts_path <- "scripts"
data_path <- "data/costes_data"
source(file.path(scripts_path, "Costes.R"))

### RUN ALGORITHMS AND PLOT RESULTS ###
costes_bn <- mmpc(costes, debug = T)  # Generate bayesian network skeleton with MMPC algorithm
graphviz.plot(costes_bn, main = "Costes BN") # plot and visualize Bayesian network skeleton

costes_dag <-mmhc(costes, debug = T)  # Generate directed acyclic graph with MMHC algorithm
graphviz.plot(costes_dag, main = "Costes BN") # plot and visualize Dags

