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

data_path <- "data/alwood_data/"
source(paste(scripts_path, "Alwood.R", sep = ""))  # creates 'alwood' dataset

# NOTE: Modified Ko dataset to fix column off by one error in final row
data_path <- "data/ko_data/"
source(paste(scripts_path, "Ko.R", sep = ""))  # creates 'ko' dataset variable

# creates 'turner' and 'glds' datasets
data_path <- "data/turner_data/"
source(paste(scripts_path, "Tuner histo.R", sep = ""))
source(paste(scripts_path, "Turner GLDS.R", sep = ""))


### CREATE SUBSETS OF DATA ###
# limit the ko data to only the 4 week duration
ko_4wk <- subset(ko, dur == 28)  # 28 is mapped to "4wk"
ko_4wk <- subset(ko_4wk, select = -dur)  # remove fixed variable
# limit the ko data to only the 0%, 60% and 80% unloaded animals
ko_4wk <- subset(ko_4wk, unload %in% c(0, 60, 80))

# create metaphysis and epiphysis subsets of the turner data
glds_meta <- subset(glds, select = c(mass, mass_meta, trab_meta, expose))
glds_epi <- subset(glds, select = c(mass, mass_epiph, trab_epiph, expose))


### RUN ALGORITHMS ###
# Generate bayesian network skeleton with MMPC algorithm
alwood_bn <- mmpc(alwood)
ko_bn <- mmpc(ko)
turner_bn <- mmpc(turner)
glds_bn <- mmpc(glds)

ko_4wk_bn <- mmpc(ko_4wk)  # FLOATING POINT ERROR: fixed correlation coeff > 1
glds_meta_bn <- mmpc(glds_meta)
glds_epi_bn <- mmpc(glds_epi)

# Generate bayesian network with MMHC algorithm
alwood_dag <- mmhc(alwood)
ko_dag <- mmhc(subset(ko, select = -c(resorp, form)))  # remove NA variables
turner_dag <- mmhc(turner)
glds_dag <- mmhc(glds)

ko_4wk_dag <- mmhc(subset(ko_4wk, select = -c(resorp, form)))  # remove NA again
glds_meta_dag <- mmhc(glds_meta)
glds_epi_dag <- mmhc(glds_epi)


### PLOT RESULTS ###
# plot and visualize Bayesian network skeletons
graphviz.plot(alwood_bn, main = "Alwood BN")
graphviz.plot(ko_bn, main = "Ko BN")
graphviz.plot(turner_bn, main = "Turner BN")
graphviz.plot(glds_bn, main = "GLDS BN")

graphviz.plot(ko_4wk_bn, main = "Ko, 4 week data BN")
graphviz.plot(glds_meta_bn, main = "GLDS metaphysis BN")
graphviz.plot(glds_epi_bn, main = "GLDS epiphysis BN")

# plot and visualize Dags
graphviz.plot(alwood_dag, main = "Alwood DAG")
graphviz.plot(ko_dag, main = "Ko DAG")
graphviz.plot(turner_dag, main = "Turner DAG")
graphviz.plot(glds_dag, main = "GLDS DAG")

graphviz.plot(ko_4wk_dag, main = "Ko, 4 week data DAG")
graphviz.plot(glds_meta_dag, main = "GLDS metaphysis DAG")
graphviz.plot(glds_epi_dag, main = "GLDS epiphysis DAG")



