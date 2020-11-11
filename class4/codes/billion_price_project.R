###########################
## CLASS 4 - Coding in R ##
##                       ##
## Billion-Price-Project ##
###########################


## Start script
# Remove variables from the memory
rm(list=ls())
# Call packages
library(tidyverse)
library(moments)
# new package we use
#install.packages("readxl")
library(readxl)
library(dplyr) #for glimpse



## Import data
#/Users/utassydv/Documents/workspaces/CEU/my_repos/coding_1/class4
data_in <- "/Users/utassydv/Documents/workspaces/CEU/my_repos/coding_1/class4/data/"
# Reading with excel and telling that the parsing should check the first 40000 observations
bpp_orig <- read_excel( paste0( data_in , "raw/online_offline_ALL_clean.xls" ), guess_max = 40000 )
# Check the variables
glimpse(bpp_orig)

## Create our key variable
bpp_orig <- mutate( bpp_orig , p_diff = price_online - price )


## Check some of the key variables -> introducing the %>% 
# cmd+shift+m
# Note: we will learn how to do this without writing this part down 3 times...
# 1) Online and offline prices
p1_sum <- bpp_orig %>% summarise(
  mean     = mean(price),
  median   = median(price),
  std      = sd(price),
  iq_range = IQR(price), 
  min      = min(price),
  max      = max(price),
  skew     = skewness(price),
  numObs   = sum( !is.na( price ) ) )

p2_sum <- bpp_orig %>% summarise(
  mean     = mean(price_online),
  median   = median(price_online),
  std      = sd(price_online),
  iq_range = IQR(price_online), 
  min      = min(price_online),
  max      = max(price_online),
  skew     = skewness(price_online),
  numObs   = sum( !is.na( price_online ) ) )

p3_sum <- bpp_orig %>% summarise(
  mean     = mean(p_diff),
  median   = median(p_diff),
  std      = sd(p_diff),
  iq_range = IQR(p_diff), 
  min      = min(p_diff),
  max      = max(p_diff),
  skew     = skewness(p_diff),
  numObs   = sum( !is.na( p_diff ) ) )

# Join the to table
price_summary <- p1_sum %>% add_row( p2_sum ) %>% add_row( p3_sum )
price_summary
rm( p1_sum , p2_sum , p3_sum )

# Check for extreme values
# Histogram
ggplot( data = bpp_orig ) +
  geom_histogram( aes( x = price ) , color = 'blue'  , alpha = 0.1 ) +
  labs(x = "Price",
       y = "Count" )

# Need to filter out some data
# FILTER DATA -> filter for "PRICETYPE" is a large restriction!
#     may check without that filter!
bpp <- bpp_orig %>% 
  filter(is.na(sale_online)) %>% 
  filter(!is.na(price)) %>%
  filter(!is.na(price_online)) %>% 
  filter(PRICETYPE == "Regular Price")

# Drop obvious errors
bpp <- bpp %>% 
  filter( price < 1000 )

# Check the summary stat
p1_sum <- bpp %>% summarise(
  mean     = mean(price),
  median   = median(price),
  std      = sd(price),
  iq_range = IQR(price), 
  min      = min(price),
  max      = max(price),
  skew     = skewness(price),
  numObs   = sum( !is.na( price ) ) )
p2_sum <- bpp %>% summarise(
  mean     = mean(price_online),
  median   = median(price_online),
  std      = sd(price_online),
  iq_range = IQR(price_online), 
  min      = min(price_online),
  max      = max(price_online),
  skew     = skewness(price_online),
  numObs   = sum( !is.na( price_online ) ) )
p3_sum <- bpp %>% summarise(
  mean     = mean(p_diff),
  median   = median(p_diff),
  std      = sd(p_diff),
  iq_range = IQR(p_diff), 
  min      = min(p_diff),
  max      = max(p_diff),
  skew     = skewness(p_diff),
  numObs   = sum( !is.na( p_diff ) ) )



# Join the to table
price_summary <- p1_sum %>% add_row( p2_sum ) %>% add_row( p3_sum )
price_summary
rm( p1_sum , p2_sum , p3_sum )


# Histogram
ggplot( data = bpp ) +
  geom_density( aes( x = price ) , color = 'blue'  , alpha = 0.1 ) +
  geom_density( aes( x = price_online )  , color = 'red' , alpha = 0.1 ) +
  labs(x = "Price",
       y = "Relative Frequency" )

# Check the price differences
ggplot( data = bpp ) +
  geom_density( aes( x = p_diff ) , color = 'blue'  , alpha = 0.1 ) +
  labs(x = "Price differences",
       y = "Relative Frequency" ) +
  xlim(-4,4)

# Check for price differences
chck <- bpp %>% filter( p_diff > 500 | p_diff < -500 )
# Drop them
bpp <- bpp %>% filter( p_diff < 500 & p_diff > -500 )
rm( chck )

# factors
## Creating factors in R
bpp$country <- factor(bpp$COUNTRY)

table(bpp$country)

#Mean for each country
bpp %>% select(country, p_diff) %>%
  group_by(country) %>% 
  summarize( mean = mean(p_diff), 
             sd = sd(p_diff),
             numObs = n())

#Historgram for each country

ggplot( data = bpp, aes(x = p_diff, fill = country)) + 
  geom_histogram( aes( y= ..density.. ), alpha = 0.4) +
  labs( x= "Price", y = 'Rel Freq', fill = 'Country') +
  facet_wrap(~country) +
  xlim(-4,4)
#Homework
#Do the same with impute variable:
# 1)recode it as a string
#     a) if NA ->Yes
#     b) if 1 ->'no'
# 2)Call factor variiable as 'same_day'
# 3)Create summary by countries and by same_day
bpp$IMPUTE <- factor(bpp$imputed)
# ...

#######################################################

# Hypothesis testing

# Test: 
# HO the price difference between price_online -price = 0
# HA the price difference is not 0
t.test(bpp$p_diff, mu = 0)

#Test2 the online prices are smaller or equal then offline prices
#HO pdiff * <= 0
#HA pdiff > price
t.test(bpp$p_diff, mu = 0, alternative = 'less')
t.test(bpp$p_diff, mu = 0, alternative = 'greater')
#HW2 filter to USA and price smaller than 1000
#two-sided t-test

#Multiple hypothesis testing

testing <- bpp %>% 
        select(country, p_diff) %>% 
        group_by(country) %>% 
        summarize(meand_pdiff = mean(p_diff),
                  se_p_diff = 1/sqrt(n())*sd(p_diff),
                  num_obs = n(),
                  )
testing <- mutate(testing, t_stat = meand_pdiff/se_p_diff)
testing
testing <- mutate(testing, p_val = pt(-abs(t_stat), df = num_obs-1 ) ) #for one sided, neglect abs, and decide which side
testing <- mutate (testing, p_val = round( p_val, digit = 4))
testing

####
###Scatter plot
#
ggplot( bpp, aes( x = price_online, y = price )) +
  geom_point(color = 'red') +
  labs(x = 'Price online', y = 'Price offline') +
  geom_smooth(method = 'lm', formula = y ~ x )

#bin scatter
# 1) 'easy way' with equal distances
ggplot( bpp, aes( x = price_online, y = price )) +
  stat_summary_bin( fun = 'mean', binwidth = 50, geom = 'point')

# 1.1) 'group by countries
ggplot( bpp, aes( x = price_online, y = price, color = country )) +
  stat_summary_bin( fun = 'mean', binwidth = 50, geom = 'point') +
  facet_wrap(~country, scales ="free", ncol = 2) + #by countr, free up scales, defiine column number
  theme(legend.position = "none") + #get rid of the legend
  geom_smooth(method = 'lm', formula = y~x) #line acording to all data

# 2) Using percantiles instead of equally sized bins
#catagorizing all prices into intervals
bpp$price_online_10b <-  bpp$price_online %>%  cut_number(10)

bs_summary <- bpp %>% 
  select(price, price_online_10b) %>% 
  group_by(price_online_10b) %>%
  summarise_all(lst(p_min=min,p_max=max, p_mean=mean, p_median=median, p_sd =sd, p_num_obs = length))
bs_summary


bs_summary$price_online_10b <- gsub("[^0-9\\.]",',',bs_summary$min, bs_summary$max)

bs_summary <-  bs_summary %>% 
  separate(price_online_10b , into = c("trash", "lower_b", "upper_b"), sep ="[^0-9\\.]" )
  
bs_summary <-  bs_summary %>% 
  mutate( lower_b = as.numeric(lower_b)) %>% 
  mutate( upper_b = as.numeric(upper_b)) %>% 
  select( -trash)


bs_summary <- mutate( bs_summary , bin_mid = ( as.numeric(upper_b) + as.numeric(lower_b))/2 )
# bs_summary <- bs_summary %>% mutate( bs_summary , bin_mid = ( as.numeric(upper_b) + as.numeric(lower_b))/2 )

ggplot( bs_summary, aes( x = bin_mid, y = p_mean)) +
 geom_point(size =2, color = 'red')

ggplot( bs_summary, aes( x = bin_mid, y = p_mean)) +
  geom_point(size =2, color = 'red') + xlim(0,100)+ylim(0,100)

#HOMEWORK, do the same but for each country

######
# Correlation and plots with factors
# Covariiance (symmetric)
cov(bpp$price,bpp$price_online)
# Correlation
cor(bpp$price,bpp$price_online)

# Make a correlation table for each country
correlation_table <- bpp %>% 
  select(country, price ,price_online) %>% 
  group_by(country) %>%
  summarise(correlation = cor(price,price_online))

ggplot(correlation_table, aes(x= correlation, y=fct_reorder(country,-correlation))) +
  geom_point(color = 'red', size =2)+
  labs(y='Countries', x='Correlation')
  


