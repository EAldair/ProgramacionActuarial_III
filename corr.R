corr <- function(directorio, horizonte=0){
 
  correlacion <- vector("numeric",0)
  k <- 1
  for (i in 1:332){
    
    id2<-formatC(i,width = 3 ,flag = "0")
    
    readen <- read.csv(paste(id2, ".csv",sep=""),header = T)
    
    mydata <- data.frame(readen$sulfate,readen$nitrate)
    
    completos <- mydata[complete.cases(mydata),]
    
    n <- nrow(completos)
    
    if (n>horizonte){
      
      length(correlacion) <- length(correlacion)+1
      
      correlacion[k] <- cor(completos[,1],completos[,2])
      
      k <- k+1
    }
  }
  correlacion
}