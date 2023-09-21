setwd("/home/cam/Development/Git/mmpc")

## Ko
nastring <- c("           *","epiphysis broken")  # things we want R to read as NA

# Read raw files
file1 <- paste(data_path, "LSDS-40_Bone_Biomechanical_LDSD-40_biomechanical_KoTRANSFORMED.csv", sep='')
file2 <- paste(data_path, "LSDS-40_histomorphometry_LSDS-40_histomorphometry_KoTRANSFORMED.csv", sep='')
file3 <- paste(data_path, "LSDS-40_microCT_LSDS-40_microCT_KoTRANSFORMED.csv", sep='')
file4 <- paste(data_path, "LSDS-41_peripheral_quantitative_computed_tomography_pQCT_LSDS-41_pQCT_KoTRANSFORMED.csv", sep='')

ko1 <- read.csv(file1, header=T, stringsAsFactors=F) 
ko2 <- read.csv(file2, header=T, stringsAsFactors=F, na.strings=nastring)
ko3 <- read.csv(file3, header=T, stringsAsFactors=F, na.strings=nastring)
ko4 <- read.csv(file4, header=T, stringsAsFactors=F)

# Subest to needed columns/rows
ko1 <- ko1[,c(1,3:4,8:10)]
ko2 <- ko2[!(is.na(ko2$Source.Name)),c(1,7:11)]
ko3 <- ko3[,c(1,10,13:17)]
ko4 <- ko4[,c(1,4:7)]


# Rename columns
names(ko1) <- c("ID","PWB","duration","stiffness","load.max","load.fail")
names(ko2) <- c("ID","OBSBS","OCSBS",'MSBS',"MAR","BFRBS")
names(ko3) <- c("ID","BVTV","trab.num","trab.thick","trab.sep","BMD","cort.thick")
names(ko4) <- c("ID","BMD0","BMD1","BMD2","BMD4")

# create indicators of source file
ko1$k1 <- 1
ko2$k2 <- 1
ko3$k3 <- 1
ko4$k4 <- 1

# Merge files
ko12   <- merge(ko1,ko2,by="ID",all.x=T,all.y=T)
ko123  <- merge(ko12,ko3,by="ID",all=T)
ko1234 <- merge(ko123,ko4,by="ID",all=T) 

# Fill in missing indicators with 0
ko1234$k1[is.na(ko12$k1)] <-0
ko1234$k2[is.na(ko12$k2)] <-0
ko1234$k3[is.na(ko12$k3)] <-0
ko1234$k4[is.na(ko12$k4)] <-0

# Keep only needed rows
ko <- ko1234[!(is.na(ko1234$stiffness)),]
ko$unload <- 0*(ko$PWB=='PWB100')+30*(ko$PWB=="PWB70")+60*(ko$PWB=="PWB40")+80*(ko$PWB =="PWB20")
ko$dur <- 7*(ko$duration=='1wk')+14*(ko$duration=='2wk')+28*(ko$duration=='4wk')
ko <- ko[,c('BVTV','BMD','trab.sep','trab.num','MSBS','OCSBS','BFRBS','load.max','load.fail','unload','dur')]

# explicitly cast to numeric to convert character literal numbers to numeric
ko <- as.data.frame(sapply(ko, as.numeric))

mass <- pca(r=ko[,c("BVTV","BMD")], nfactors = 1, scores = T)
trab <- pca(r=ko[,c("trab.sep","trab.num")], nfactors = 1, scores = T)
form   <- pca(r=ko[,c("MSBS","BFRBS")], nfactors = 1, scores = T)
stren <- pca(r=ko[,c("load.max","load.fail")], nfactors = 1, scores = T)

ko$mass <- as.vector(mass$scores[,1])
ko$trab <- as.vector(trab$scores[,1])
ko$stren <- as.vector(stren$scores[,1])
ko$expose <- ((ko$unload*ko$dur)-mean(ko$unload*ko$dur))/(sd(ko$unload*ko$dur))
ko$resorp <- scale(ko$OCSBS)
ko$form   <- as.vector(form$scores)


ko <- ko[,c("unload","dur","expose","mass","trab","stren","resorp","form")]

rm(list=c("mass","trab","form","stren"))


