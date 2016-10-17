rankingcompleto <- function(resultado, num = "mejor") {
  data <- read.csv("outcome-of-care-measures.csv")
  v <- c("infarto", "falla", "neumonia")
  if (resultado == "infarto") col <- 11
  else if (resultado == "falla") col <- 17
  else if (resultado == "neumonia") col <- 23
  else if (resultado %in% v == F){
    stop("resultado inválido")
  }
  data[, col] <- suppressWarnings(as.numeric(levels(data[, col])[data[, col]]))
  data[, 2] <- as.character(data[, 2])
  
  output <- vector() # Vector a llenar (por filas) mediante el ciclo
  estados <- levels(data[, 7])
  for(i in 1:length(estados)) {
    databystate <- data[grep(estados[i], data[,7]), ]
    ordered <- databystate[order(databystate[, col], databystate[, 2], na.last = NA), ]
    
    if(num == "mejor") hospital <- ordered[1, 2]
    else if(num == "peor") hospital <- ordered[nrow(ordered), 2]
    else hospital <- ordered[num, 2]
    
    output <- append(output, c(hospital, estados[i]))
  }
  output <- as.data.frame(matrix(output, length(estados), 2, byrow = TRUE))
  colnames(output) <- c("hospital", "state")
  rownames(output) <- estados
  output
}
tail(rankingcompleto("falla"),10)
