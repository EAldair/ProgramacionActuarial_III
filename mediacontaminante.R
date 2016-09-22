> setwd("~/GitHub/ProgramacionActuarial_III/specdata")
mediacontaminante <- function(directorio, contaminante, id = 1:332){
  suma <- numeric()
  for (i in id){
    
    id2 <- formatC(i,width = 3 ,flag = "0")
    readen <- read.csv(paste(id2, ".csv",sep=""),header = T)
    
    if (contaminante == "sulfate"){
      
      
      suma <- c(suma,readen$sulfate)
    } else if (contaminante == "nitrate"){
      
      
      suma <- c(suma,readen$nitrate)
    } 
    
  }
  promedio <- mean(suma, na.rm = T)
  promedio
}
mediacontaminante("specdata","sulfate",1:332)
mediacontaminante("specdata","nitrate",1:332)

