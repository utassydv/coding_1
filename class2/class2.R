
# How to install a package
install.packages("moments")
#install.packages("tidyverse")

# dataframes
# date tables n a tidy format
library(tidyverse)
df <- data_frame(id=c(1,2,3,4,5,6), 
                 age=c(25,30,33,22,26,38),
                 grade=c("A", "A+", "B", "B-", "A", "C"))

View(df)

# Indexing n data-frame
df[ 1 ]
df[ 2 ]
df[2,2]
df[[1]] #numeric vector
df[[2,2]]
# dr$var_name == df[[var_column]]
df$id

#Lets find age of 3rd obbservaton or id ==3
df$age[3]
df[[3,2]]
df$age[df$id==3]
df$age[df$grade=="A"]
#indexing with logicals
df$id==3


## Functions
age2 <- df$age[1:3]
# sum of age
age2[1]+age2[2]+age2[3]

sum(age2)
?sum
sum(c(age2,NaN),na.rm=TRUE)
mean(age2)
sd(age2)


