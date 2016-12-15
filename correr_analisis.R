#Establecemos el directorio de trabajo:
  
setwd("~/GitHub/ProgramacionActuarial_III/UCI HAR Dataset")

#Y abrimos cada archivo necesario de test y train:
  
  xtrain <- read.table("./train/X_train.txt") 
  ytrain <- read.table("./train/Y_train.txt")
  strain <- read.table("./train/subject_train.txt")

xtest <- read.table("./test/X_test.txt") 
ytest <- read.table("./test/y_test.txt") 
stest <- read.table("./test/subject_test.txt")

#Combinamos los archivos apropiadamente:
  
  dataX <- rbind(xtrain, xtest) 
  dataY <- rbind(ytrain, ytest)
  dataS <- rbind(strain, stest)

#Removemos lo que ya no serán útiles:
  
  rm(xtrain)
  rm(ytrain)
  rm(strain)
  rm(xtest)
  rm(ytest)
  rm(stest)

#Extraemos las medidas de media y desviación estándar de cada medición del archivo features.txt (y quitamos lo que no es útil):
  
  caract <- read.table("./features.txt")
  
  promedioStdIndex <- grep("mean\\(\\)|std\\(\\)", caract[, 2])
  
  dataX <- dataX[, promedioStdIndex]
  names(dataX) <- gsub("\\(\\)", "", caract[promedioStdIndex, 2])
  names(dataX) <- gsub("mean", "Mean", names(dataX)) 
  names(dataX) <- gsub("std", "Std", names(dataX)) 
  names(dataX) <- gsub("-", "", names(dataX)) 
 
#Removemos lo que ya no será útil:
  
  rm(caract)
  rm(promedioStdIndex)

#Mandamos a llamar las actividades en la nueva base de datos, utilizando el archivo activity_labels.txt:
  
  activity <- read.table("./activity_labels.txt") 
  activity[, 2] <- tolower(gsub("_", "", activity[, 2])) 
  substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
  substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
  dataY[, 1] <- activity[dataY[, 1], 2] 
  names(dataY) <- "actividad"

#Damos a las etiquetas un nombre apropiado para la nueva base de datos (combinando las etiquetas de cada dirección):
  
  names(dataS) <- "sujeto"
  cleandata <- cbind(dataS, dataY, dataX)
  
  rm(dataX)
  rm(dataY)

#Creamos otra base de datos con lo que se ha recopilado, con el promedio de cada medición para reducir los datos y completar la base de datos que requerimos: 
  SLen <- length(table(dataS)) 
  activityLen <- dim(activity)[1]
  colLen <- dim(cleandata)[2]
  op <- as.data.frame(matrix(NA, nrow=SLen*activityLen, ncol=colLen))
  colnames(op) <- colnames(cleandata)
  f <- 1
  for(i in 1:SLen) {
    for(j in 1:activityLen) {
      op[f, 1] <- sort(unique(dataS)[, 1])[i]
      op[f, 2] <- activity[j, 2]
      die1 <- i == cleandata$sujeto
      die2 <- activity[j, 2] == cleandata$actividad
      op[f, 3:colLen] <- colMeans(cleandata[die1&die2, 3:colLen])
      f <- f + 1
    }
  }
  
#Por último, colocamos la base de datos ordenada en un archivo de texto, con los 30 sujetos y los promedios de cada una de las 66 mediciones, en cada una de las seis actividades:
  
  write.table(op, "BaseCompleta.txt", row.name=FALSE)
  