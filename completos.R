completos <- function(directorio, id = 1:332){
  
  nobs <- vector("numeric", length(id))
  a<-1
  for (i in id){
    
    id2<-formatC(i,width = 3 ,flag = "0")
    
    readen <- read.csv(paste(id2, ".csv",sep=""), header=T)
    
    x <- (readen$sulfate)
    y <- (readen$nitrate)
    mydata <- data.frame(x, y)
    
    nobs[a] <- nrow(mydata[complete.cases(mydata),])
    
    a<-a+1
  }
  data.frame(id=id,nobs=nobs)
}
