#Crear Vectores
x <- vector(mode=
               "numeric", length = 5L)
x

#Crear vectores con la funcióon C

x <- c(0.5,0.6)
x
class(x)

x <- c(TRUE,FALSE)
x
class(x)

x <- 5:10
x
class(x)

x <- 10:0
x
Class(x)

x <- c(1+2i,5,3+9i,-4-5i)
x
class(x)

x <- c("a","b", "c","d")
x
Class(x)

#Mezcla de objetos en un vector 
y <- c(1.7,"a") #caracter
y
Class(y)
y <- c(TRUE,2)#Numerico
y
class(y)
y <- c("a",TRUE) #caracter
y
class(y)

#Orden de Coacción Explícita
#1 Character
#2 Complex
#3 numeric
#4 integer
#5 logical

# Coercion Explicita
z <- 0:6
class(z)

as.numeric(z)
as.logical(z)
as.character(z)

z <- c(1+2i,4 + 4i,0+3i)
as.logical(z)

#Listas

x <- list(1,"a",T,1+9i)
x
class(x)

#Listas (es como un vector... pero de vectores y c/u tiene su propia clase)

#Matrices
m <- matrix(nrow = 2,ncol = 3)
m
dim(m)
attributes(m)
#Cambio de Dimensiones de 2x3 a 3x2
dim (m) <- c(3,2)
m

#Crear Una Matriz Con Datos
m<- matrix(1:6,3,2)
m

m<- matrix(1:6,3,2, T)
m

m<- matrix(1:6,3,3, T)
m

class(m)
str(m)

dim(m) <- (2,5) #Esto Produce Error

x<- c(1,2,3)
y <- c("a","b","c")
z <- c(x,y)
z
m1 <- rbind(m,x)
m1

m2 <- cbind(m,x)
m2

m3 <- rbind(m1,y)
m3

m4 <- cbind(m2,y)
m4
