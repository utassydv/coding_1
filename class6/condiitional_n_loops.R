
rm(list=ls())

########
#Conditional execution


x <- 5 
y <- 0

#if...
if (x > 0){
  print("Positive number")
}

#if, else
if (x > 0){
  print("Positive number")
} else {
  print("Negative numbber")
}

#else if
if ( y > 0){
  print("Positive number")
} else if (y < 0){
  print("Negative numbber")
} else{
  print("Zero")
}


if ( y >= 0 && x >= 0 ){
  z <- y + x
}else if (y > 0 && x < 0){
  z <- y - x
}else if (y < 0 && x > 0){
  z <- x - y
}else if (y < 0 && x > 0){
  print("SMALLLEEEER")
}

if (y == 0) print("hello") # dont use this!!!!!

#######################
#loops

#for
for (i in 1 : 5) {
  print(i)
}

for (i in seq(2,5)) {
  print(i)
}

for (i in c(2,8,9,-10)) {
  print(i)
}

for (i in list(2,TRUE,'a',9,-10)) {
  print(i)
}

for (i in list(2,TRUE,'a',9,-10)) {
  print(i)
}

#useful tool: seq_along()
my_v <- c(1,2,53,1,56,2)
seq_along(my_v)

for (i in seq_along(my_v)) {
  print(my_v[i])
}

#Create a cummulative som loop
v <- seq(1,10)
result <- 0

for (i in v) {
  result = result + i
}

cumsum(v)

#Create a vector with for loop
v2 <- double(length= length(v))
for (i in seq_along(v)){
  if ( i>1 ){
    v2[i] = v2[i-1] + v[i]
  }else {
    v2[i] = v[i]
  }
}

if (all(cumsum(v) == v2)){
  print("good")
}else{
  print("not")
}

##
#Measure cpu time
##Install some developer package
#install.packages("devtools")
library(devtools)

devtools::install_github("jabiru/tictoc")
library(tictoc)

iter_num <- 1000000
# Sloppy way
tic("Sloppy way")
cs_v3 <- c()

for (i in 1 : iter_num){
  cs_v3 <- c(cs_v3, i)
}
toc()

# Proper way
tic("Proper way")
cs_v4 <- double ( lenght = iter_num )
iter_num <- 10000
for (i in 1 : iter_num){
  cs_v4[i] <- i
}
toc()

print("what")


#while
while ( x < 10){
  x <- x + 1
}

#for with condition
maxiter <- 5
x <- 0
flag <- FALSE
for( i in 1 :maxiter){
  if (x < 10){
    x <- x + 1
  }else{
    flag <- TRUE
    break
  }
}
if (!flag){
  warning('For loop diid not converged, reached max iter')
}


