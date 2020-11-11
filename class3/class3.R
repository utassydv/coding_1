### Class 3
## Data wrangling:
#cleaning the hotels dataset

rm(list=ls())
library(tidyverse)

# Import raw data
data_in <- "/Users/utassydv/Documents/workspaces/CEU/my_repos/coding_1/class3/data/"
b_data <- read_csv(paste0(data_in, "raw/hotelbookingdata.csv"))

# Have glimpse on data
glimpse(b_data)

# Create a new variable
b_data <- mutate(b_data, nnights = 1 )

# Clean accommodation type column
b_data <- separate( b_data, accommodationtype, "@",  into = c("garbage", "accomodation_type"))
                                                                          
# Remove the variable called garbage
b_data <- select( b_data, -garbage )

# Correct guestreviewrating iinto simple numeric variable
b_data <- separate( b_data, guestreviewsrating, "/", into = c( "ratings" ) )

# Convert ratiings to numeric values
typeof(b_data$ratings)
b_data$ratings <- as.numeric(b_data$ratings)
typeof(b_data$ratings)

# How to deal with distance measure
eg1 <- "Coding is 123 fun!"

# Find numeric valuest ni a vector and replace it
gsub("12", "extra fun", eg1)

# Find any numeric value
gsub("[0-9\\.]", "extra fun", eg1)
gsub("[^0-9\\.]", "", eg1)

# Mutate all the distance measures
b_data <-  mutate( b_data, 
                   distance = as.numeric(gsub("[^0-9\\.]", "", center1distance ) ),
                   distance_alter = as.numeric(gsub("[^0-9\\.]", "", center2distance ) ) )

# Rename some variables
b_data <- rename(b_data,
                 rating_count = rating_reviewcount,
                 ratingta = rating2_ta,
                 ratingta_count = rating2_ta_reviewcount,
                 country = addresscountryname )

# Replacing missing values
b_data <- rename (b_data, stars = starrating)
table(b_data$stars)


b_data <- mutate(b_data, stars = na_if(stars, 0))
table(b_data$stars)

#Filter out observation which do not have id
b_data <- filter(b_data, !is.na(hotel_id) )


# Filter out duplicates
sum(duplicated(b_data))
# Remove duplicates
b_data <- filter( b_data , !duplicated(b_data))

# Remove duplicates to specific variables
sub_data <- subset(b_data, select = c(country, hotel_id))
b_data <-  filter(b_data, !duplicated(
                  subset(b_data, select = c(country, hotel_id, distance, 
                                            stars, ratings, price, year, month,
                                            weekend, holiday))))
## Finally hotels Vienna
b_data <- rename( b_data, city = s_city )
hotel_vienna <- filter(b_data, city == "Vienna")

# Filter multiple conditions
hotel_vienna <- filter( hotel_vienna ,
                        year == 2017 & month == 11 & weekend == 0,
                        accomodation_type == "Hotel",
                        stars >=3 & stars <= 4,
                        price < 1000 )


write_csv( hotel_vienna , paste0( data_in,
                                  "clean/hotel_vienna.csv"))

# Create a descriptive table
vienna_sum_stat <- summarise( hotel_vienna , 
                              mean = mean( price ),
                              median = median( price ),
                              std = sd( price ),
                              min = min( price ),
                              max = max( price ) )

vienna_sum_stat                      
