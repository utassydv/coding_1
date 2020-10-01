2+2

#Variable assignment
myString <- "Hello world!"
print(myString)

#this is a comment
#We can define numbers as well
a <- 2
b <- 3

a+b-(a*b)^a

c <- a + b
d <- a*c/b*c

# Use of logical operators


a == b
2 == 3
( a + 1 ) == b

a != b 

# other logical operators
2 == 2 & 3 == 2
2 == 2 & 3 == 3
2 == 2 | 3 == 2

# Remove variable from workspace
rm(d)


##
# Create vectors
v <- c(2,5,10)

# Operations with vectors
z <- c(3,4,7)

v+z

v*z #element
a+v

# Number of elements
num_v <- length(v)
num_v

# Create vector from vectors
w <- c(v,z)
length(w)

# Note: be careful with operation
q <- c(2,3)
v+q

## Extra:
null_vector <- c()

# NaN value
nan_vec <- c(NaN, 1,2,3,4)
nan_vec + 3
# Inf values
inf_val <- Inf
5/0
sqrt(2)^2 == 2

# Convention to name your variables
my_fav_var <- "bla"
myFavVar <- "bla"
my_favourite_variable <- "bla"

# Difference between double and integers
int_val <- as.integer(1)
doub_val <- as.double(1)
int_val <- as.integer(2000000000)

typeof(int_val)

##
# INDEXING - goes w []
v[1]
v[2:3]
v[c(1,3)]

#Fix the addition of v+q
v[1:2] + q

###
# Lists
my_list <- list("a",2,0==1)
my_list2 <- list(c("a", "b"), c(1,2,3),c("d"), sqrt(2)^2==2)

my_list2[1][1]


my_list2[[1]][1]
my_list2[[2]][3]

## Practice and read R for DataScience Chapter 16

