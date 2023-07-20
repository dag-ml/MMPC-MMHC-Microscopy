setwd("/Users/camwolff/Development/local/R/dag_validation")

# install packages
# source("install.R")

# load libraries
library(bnlearn)
library(Rgraphviz)
library(psych)

# load and prepare data
graphs_path <- "graphs/"
scripts_path <- "scripts/"

data_path <- "data/alwood_data/"
source(paste(scripts_path, "Alwood.R", sep = ""))  # creates 'alwood' dataset

data_path <- "data/ko_data/"
source(paste(scripts_path, "Ko.R", sep = ""))  # creates 'ko' dataset variable

# creates 'turner' and 'glds' datasets
data_path <- "data/turner_data/"
source(paste(scripts_path, "Tuner histo.R", sep = ""))
source(paste(scripts_path, "Turner GLDS.R", sep = ""))

# Generate bayesian networks with MMPC algorithm
alwood_bn <- mmpc(alwood)
ko_bn <- mmpc(ko)
turner_bn <- mmpc(turner)
glds_bn <- mmpc(glds)

# plot and visualize bayesian networks
graph_alwood <- graphviz.plot(alwood_bn, main = "Alwood")
graph_ko <- graphviz.plot(ko_bn, main = "Ko")
graph_turner <- graphviz.plot(turner_bn, main = "Turner")
graph_glds <- graphviz.plot(glds_bn, main = "GLDS")
