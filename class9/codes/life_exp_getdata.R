#######################
## Analysis of       ##
##  Life expectancy  ##
##    and            ##
##  GPD/capita       ##
##                   ##
##      NO. 1        ##
##                   ##
##  Getting the data ##
##                   ##
#######################


# Clear memory
rm(list=ls())

# Call packages
install.packages('WDI')
library(WDI)


# How WDI works - it is an API
# Search for variables which contains GDP
#a <- WDIsearch('co2')
# Narrow down the serach for: GDP + something + capita + something + constant
#a <- WDIsearch('gdp.*capita.*constant')

# Get data
gdp_data <- WDI(indicator='NY.GDP.PCAP.PP.KD', country="all", start=2015, end=2015)


#a <- WDIsearch('population, total')
#b <- WDIsearch('life expectancy at birth')

# Get all the data - 2018 is the latest available data for life expectancy

data_raw <- WDI(indicator=c('NY.GDP.PCAP.PP.KD','EN.ATM.CO2E.PC','SP.POP.TOTL'), 
                country="all", start=2015, end=2015)


# Save the raw data file
my_path <- "/Users/utassydv/Documents/workspaces/CEU/my_repos/coding_1/class9/"
write_csv(data_raw, paste0(my_path,'data/raw/WDI_GDP_CO2_raw.csv'))

# I have pushed it to Github, we will use that!
# Note this is only the raw files! I am cleaning them in a separate file and save the results to the clean folder!


