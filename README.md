Instrucciones
El propósito de este proyecto es demostrar tu habilidad para recolectar, trabajar y limpiar base de
datos. El objetivo es preparar un conjunto ordenado de información que pueda ser trabajado en
análisis posteriores.
Considera incluir:
  1) La base de datos ordenada
2) Dirección de GitHub para el repositorio
3) Un libro de códigos para describir las variables, la base de datos y las transformaciones que
realices llamado "CodeBook.md".
4) Un archivo "README.md" en el repositorio con tus códigos. Este archivo explica el
funcionamiento de tus scripts y como se conectan entre ellos.
Deberás crear un código en R llamado "correr_analisis.R" que haga lo siguiente:
  1) Une los datos de test con los de training, para crear un solo conjunto de datos.
2) Extrae únicamente las medidas de media y desviación estándar de cada medición. 
3) Usa nombres de actividad para describir los nombres de las actividades en la base de
datos.
4) Coloca etiquetas apropiadas en la base de datos con nombres de variables que las
describan.
5) Con los datos del paso 4, crea una segunda base de datos independiente con el promedio
de cada variable para cada actividad y cada sujeto. 


FUNCIONAMIENTO DEL CÓDIGO

El código contenido en correr_análisis.R realiza lo siguiente:
  
  Une los datos de los archivos test con los de los archivos training, para crear un solo conjunto de datos.

Establecemos el directorio de trabajo:
  
  setwd("~/Universidad/Cuarto Semestre/Programación Actuarial III/Caso 3/UCI HAR Dataset")

Y abrimos cada archivo necesario de test y train:
  
  xtrain <-read.table("./train/X_train.txt") ytrain <-read.table("./train/Y_train.txt") strain <-read.table("./train/subject_train.txt")

xtest <- read.table("./test/X_test.txt") ytest <- read.table("./test/y_test.txt") stest <- read.table("./test/subject_test.txt")

Después combinamos los archivos apropiadamente:
  
  dataX <- rbind(xtrain, xtest) dataY <- rbind(ytrain, ytest) dataS <- rbind(strain, stest)

Y removemos lo que ya no serán útiles:
  
  rm(xtrain) rm(ytrain) rm(strain) rm(xtest) rm(ytest) rm(stest)

Extraemos las medidas de media y desviación estándar de cada medición del archivo features.txt (y quitamos lo que no es útil):
  
  caract <- read.table("./features.txt") promedioStdIndex <- grep("mean\(\)|std\(\)", caract[, 2]) dataX <- dataX[, promedioStdIndex] names(dataX) <- gsub("\(\)", "", caract[promedioStdIndex, 2]) names(dataX) <- gsub("mean", "Mean", names(dataX)) names(dataX) <- gsub("std", "Std", names(dataX)) names(dataX) <- gsub("-", "", names(dataX))

Removemos lo que ya no será útil:
  
  rm(caract) rm(promedioStdIndex)

Mandamos a llamar las actividades en la nueva base de datos, utilizando el archivo activity_labels.txt:
  
  activity <- read.table("./activity_labels.txt") activity[, 2] <- tolower(gsub("_", "", activity[, 2])) substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) dataY[, 1] <- activity[dataY[, 1], 2] names(dataY) <- "actividad"

Damos a las etiquetas un nombre apropiado para la nueva base de datos (combinando las etiquetas de cada dirección):
  
  names(dataS) <- "sujeto" cleandata <- cbind(dataS, dataY, dataX)

y, nuevamente, removemos lo que ya no es útil:
  
  rm(dataX) rm(dataY)

Creamos otra base de datos con lo que se ha recopilado, con el promedio de cada medición para reducir los datos y completar la base de datos que requerimos: SLen <- length(table(dataS)) activityLen <- dim(activity)[1] colLen <- dim(cleandata)[2] op <- as.data.frame(matrix(NA, nrow=SLen*activityLen, ncol=colLen)) colnames(op) <- colnames(cleandata) f <- 1 for(i in 1:SLen) { for(j in 1:activityLen) { resultado[f, 1] <- sort(unique(dataS)[, 1])[i] resultado[f, 2] <- activity[j, 2] die1 <- i == cleandata$sujeto die2 <- activity[j, 2] == cleandata$actividad resultado[f, 3:colLen] <- colMeans(cleandata[die1&die2, 3:colLen]) f <- f + 1 } }

Y por último, colocamos la base de datos ordenada en un archivo de texto, con los 30 sujetos y los promedios de cada una de las 66 mediciones, en cada una de las seis actividades:
  
  write.table(op, "BaseCompleta.txt", row.name=FALSE)