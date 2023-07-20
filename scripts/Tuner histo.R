setwd("/Users/camwolff/Development/local/R/dag_validation")

## Turner histo
file <- paste(data_path, "LSDS-30_histomorphometry_turnerTRANSFORMED.csv", sep='')

turner <- read.csv(file, header=T, stringsAsFactors=F)
turner <- turner[,c(1,3:9)] 
  turner$expose <- ifelse(turner$Spaceflight=="Space Flight",1,0)
  names(turner)[3:8] <- c("mass","labellength","cont_bf","ceased_bf","MAR","osteoc_per") 
  
# Create measures
resorp <- pca(r=turner[,c("labellength","osteoc_per")],nfactors=1,scores=T)
form   <- pca(r=turner[,c("ceased_bf","MAR")],nfactors=1,scores=T)
  
turner$resorp <- as.vector(resorp$scores)
turner$form   <- as.vector(form$scores)*-1  ## form loads "backwards"; multiply by -1 to fix
turner$mass   <- scale(turner$mass)
  
turner <- turner[,c(9,3,10:11)]
rm(list=c("form","resorp"))
