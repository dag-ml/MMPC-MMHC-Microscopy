setwd("/Users/camwolff/Development/local/R/dag_validation")

## GLDS
file <- paste(data_path, "GLDS-351.csv", sep='')

glds <- read.csv(file, header=T, stringsAsFactors=F)
  glds$expose <- ifelse(glds$Teatment=="Ground Control",0,1)
glds<- glds[7:30,c(5:7,11,13,16:19,22:25)]  

# Make component variables
mass      <- pca(r=glds[,c("DXA_BMC_mg","DXA_BMD_mg_per_mmsq")],nfactors=1,scores = T)
trab_meta <- pca(r=glds[,c("metaphysis_canc_Tb_Sp_micrometer","metaphysis_canc_Tb_N_1per_mm")],nfactors=1,scores = T)
trab_epiph <- pca(r=glds[,c("epiphysis_canc_Tb_Sp_micrometer","epiphysis_canc_Tb_N_1per_mm")],nfactors=1,scores = T)

glds$mass <- as.vector(mass$scores)
glds$trab_meta <- as.vector(trab_meta$scores)
glds$trab_epiph <- as.vector(trab_epiph$scores)

# Standardize site-specific/single variable mass measures
names(glds)[5] <- "mass_meta"
glds$mass_meta <- scale(glds$mass_meta)

names(glds)[9] <- "mass_epiph"
glds$mass_epiph <- scale(glds$mass_epiph)

# Final dataset
glds <- glds[,c("expose","mass","mass_meta","mass_epiph","trab_meta","trab_epiph")]

rm(list=c("mass","trab_epiph","trab_meta"))