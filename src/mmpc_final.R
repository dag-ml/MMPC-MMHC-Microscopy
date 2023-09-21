setwd("/home/cam/Development/Git/mmpc")

library(bnlearn)
library(Rgraphviz)
library(psych)
library(dplyr)

### LOAD AND PREPARE DATA ###
graphs_path <- "graphs/"
scripts_path <- "scripts/"

# NOTE: Modified Ko dataset to fix column off by one error in final row
data_path <- "data/ko_data/"
source(paste(scripts_path, "Ko2.R", sep = ""))  # creates 'ko' dataset variable

au_naturel <- dag.data[,c("unload", "BVTV", "BMD", "TbSp", "TbN", "MaxLoad", "FailLoad")]
PCA_synthetic <- dag.data[,c("unload", "mass", "trab", "strength")]

### RUN ALGORITHMS AND PLOT RESULTS ###
au_naturel_bn <- mmpc(au_naturel, debug = T)  # Generate bayesian network skeleton with MMPC algorithm
graphviz.plot(au_naturel_bn, main = "Au Naturel BN") # plot and visualize Bayesian network skeleton

au_naturel_dag <-mmhc(au_naturel, debug = T)  # Generate directed acyclic graph with MMHC algorithm
graphviz.plot(au_naturel_dag, main = "Au Naturel DAG") # plot and visualize Dags

PCA_synthetic_bn <- mmpc(PCA_synthetic, debug = T)  # Generate bayesian network skeleton with MMPC algorithm
graphviz.plot(PCA_synthetic_bn, main = "PCA-Synthetic BN") # plot and visualize Bayesian network skeleton

PCA_synthetic_dag <-mmhc(PCA_synthetic, debug = T)  # Generate directed acyclic graph with MMHC algorithm
graphviz.plot(PCA_synthetic_dag, main = "PCA-Synthetic DAG") # plot and visualize Dags
