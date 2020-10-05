#####################################################
## Descriptive stat of hotel-vienna dateset
##
## 2020-101-05

#A command to clear R environment, delete all global variables
rm(list=ls())
library(tidyverse)

##Import data
# /Users/utassydv/Documents/workspaces/CEU/official_repos/ECBS-5208-Coding-1-Business-Analytics/Class_2/data/clean

# library(readr)
# hotels_vienna <- read_csv()
# View(hotels_vienna)

#Documents/workspaces/CEU/official_repos/ECBS-5208-Coding-1-Business-Analytics/Class_2/data/clean/hotels_vienna.csv
data_in <- "/Documents/workspaces/CEU/official_repos/ECBS-5208-Coding-1-Business-Analytics/Class_2/data/"

hotels_vienna <- read_csv(paste0(data_in, "clean/hotels_vianna.csv"))

getwd()
setwd()

#glmipse on data
glimpse(hotels_vienna)

# Have a summary
summary(hotels_vienna)

# Select favourite vars
hotels_vienna$price

#Average of prices
mean(hotels_vienna$price)

#Number of observaton
length(hotels_vienna$price)


### 
# Visualization
ggplot( data = hotels_vienna , aes(x = price)) + geom_histogram()

#with labels
ggplot( data = hotels_vienna , aes(x = price)) + 
  geom_histogram( fill = "navyblue" )+
  labs(x = "Hotel prices ($)", y = "Absolute Frequeny")

ggplot( data = hotels_vienna, aes(x = price))+
  geom_histogram(binwidth = 15)

#Relative freq
ggplot( data = hotels_vienna , aes(x = price)) + 
  geom_histogram( aes(y= ..density..),fill = "navyblue" )+
  labs(x = "Hotel prices ($)", y = "Absolute Frequeny")

#Kernel density estimator
ggplot( data = hotels_vienna , aes(x = price)) + 
  geom_density( aes(y= ..density..),color = "red", fill = "navyblue", bw=15, alpha = 0.5)+
  labs(x = "Hotel prices ($)", y = "Absolute Frequeny")
  

#Kernel density and histogram
ggplot( data = hotels_vienna , aes(x = price)) + 
  geom_histogram( aes(y= ..density..),fill = "navyblue", binwidth = 20 )+
  geom_density( aes(y= ..density..),color = "red", fill = "navyblue", bw=15, alpha = 0.5)+
  
  labs(x = "Hotel prices ($)", y = "Absolute Frequeny")

  labs(x = "Hotel prices ($)", y = "Absolute Frequeny")
