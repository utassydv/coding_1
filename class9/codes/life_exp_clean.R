#######################
## Analysis of       ##
##  Life expectancy  ##
##    and            ##
##  GPD/capita       ##
##                   ##
##      NO. 2        ##
##                   ##
## Cleaning the data ##
##                   ##
#######################



# Clear memory
rm(list=ls())

library(tidyverse)

# Call the data from github
my_path <- "/Users/utassydv/Documents/workspaces/CEU/my_repos/coding_1/class9/"
df <- read_csv( paste0(my_path,'data/raw/WDI_GDP_CO2_raw.csv') )

## Check the observations:
#   Lot of grouping observations
#     usually contains a number
d1 <- df %>% filter(grepl("[[:digit:]]", df$iso2c))
d1
# Filter these out
df <- df %>% filter( !grepl("[[:digit:]]", df$iso2c) )

# Some grouping observations are still there, check each of them
#   HK - Hong Kong, China
#   OE - OECD members
#   all with starting X, except XK which is Kosovo
#   all with starting Z, except ZA-South Africa, ZM-Zambia and ZW-Zimbabwe

# 1st drop specific values
drop_id <- c("EU","HK","OE")
# Check for filtering
df %>% filter( grepl( paste( drop_id , collapse="|"), df$iso2c ) ) 
# Save the opposite
df <- df %>% filter( !grepl( paste( drop_id , collapse="|"), df$iso2c ) ) 

# 2nd drop values with certain starting char
# Get the first letter from iso2c
fl_iso2c <- substr(df$iso2c, 1, 1)
retain_id <- c("XK","ZA","ZM","ZW")
# Check
d1 <- df %>% filter( grepl( "X", fl_iso2c ) | grepl( "Z", fl_iso2c ) & 
                       !grepl( paste( retain_id , collapse="|"), df$iso2c ) ) 
# Save observations which are the opposite (use of !)
df <- df %>% filter( !( grepl( "X", fl_iso2c ) | grepl( "Z", fl_iso2c ) & 
                        !grepl( paste( retain_id , collapse="|"), df$iso2c ) ) ) 

# Clear non-needed variables
rm( d1 , drop_id, fl_iso2c , retain_id )
  
### 
# Check for missing observations
m <- df %>% filter( !complete.cases( df ) )
# Drop if life-expectancy, gdp or total population missing -> if not complete case except iso2c
df <- df %>% filter( complete.cases( df ) | is.na( df$iso2c ) )

###
# CLEAN VARIABLES
#
# Recreate table:
#   Rename variables and scale them
#   Drop all the others !! in this case write into readme it is referring to year 2018!!
df <-df %>% transmute( country = country,
                        population=SP.POP.TOTL/1000000,
                        gdppc=NY.GDP.PCAP.PP.KD/1000,
                        co2_emission=EN.ATM.CO2E.PC )

###
# Check for extreme values
# all HISTOGRAMS
df %>%
  keep(is.numeric) %>% 
  gather() %>% 
  ggplot(aes(value)) +
  facet_wrap(~key, scales = "free") +
  geom_histogram()

# It seems we have a large value(s) for population:
df %>% filter( population > 500 )
df %>% filter( gdppc > 80 )
df %>% filter( co2_emission > 30 )
# These are real countries... not an extreme value

# Check for summary as well
summary( df )

# Save the raw data file
write_csv( df, paste0(my_path,'data/clean/WDI_GDP_CO2_clean.csv'))

# I have pushed it into github as well!



