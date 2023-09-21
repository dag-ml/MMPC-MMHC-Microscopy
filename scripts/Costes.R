setwd("/home/cam/Development/Git/mmpc")

## Costes
file <- file.path(data_path, 'GLDS-366_GWAS_processed_associations.csv')
costes <- read.csv(file, header=T, stringsAsFactors=T)

costes <- costes[, c(1:28, 31:34)]  # Omit repeated data entry columns
costes <- costes[complete.cases(costes[,3:ncol(costes)]), ]  # clean NA data

# one-hot encode chromosone data
costes$chromosome <- as.factor(costes$chromosome)
costes <- one_hot(as.data.table(costes), cols = "chromosome", sparsifyNAs = TRUE,
                  naCols = FALSE, dropCols = TRUE, dropUnusedLevels = TRUE)

costes <- costes %>% mutate_all(as.numeric)  # transform all data to numeric

costes <- costes[!duplicated(costes)]  # remove duplicate rows

#TODO elimiate repeated positions within the same chromosome 