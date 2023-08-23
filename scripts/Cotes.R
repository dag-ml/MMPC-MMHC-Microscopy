setwd("/Users/camwolff/Development/local/R/dag_validation")

## Cotes
file <- paste(data_path, 'OSD-366-samples.csv', sep='')
cotes <- read.csv(file, header=T, stringsAsFactors=F)
cotes <- na.omit(cotes)  # remove na data