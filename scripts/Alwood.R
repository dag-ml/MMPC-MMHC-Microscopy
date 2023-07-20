setwd("/Users/camwolff/Development/local/R/dag_validation")

## Alwood
file <- paste(data_path, "LSDS-15_microCT_alwoodTRANSFORMED.csv", sep='')
alwood <- read.csv(file, header=T, stringsAsFactors=F)
alwood <- alwood[11:37,c(3:6,9)]
  alwood$expose <- ifelse(alwood$Factor.Value=="Flight",1,0)
  names(alwood)[2:5] <- c("thick","sep","num","bvtv")

trab <- pca(r=alwood[,c("sep","num")],nfactors=1,scores = T)
mass <- pca(r=alwood[,c("thick","bvtv")],nfactors=1,scores=T)

alwood$trab <- as.vector(trab$scores)
alwood$mass <- as.vector(mass$scores)

alwood <- alwood[,c("expose","trab","mass")]

rm(list=c("trab","mass"))