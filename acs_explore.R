
library(tidycensus)
library(tidyverse)
source("source.R")


get_acs(geography = "tract",
        table = "B25003",
        survey = "acs5",
        output = "wide",
        state = "NY",
        county = "005",
        year = 2010)

#### ACS 2010 ####

#GEO0610       2010 Census Tract Identifier (ssccctttttt)
#TRCTPOP1A    
#06-10 Total population
#Table B01001:1


#### Check to Make Sure 
vars_acs10 <- tidycensus::load_variables(year = 2010, dataset = "acs5")
var_list <- list()

years <- 2010:2019
for(i in 1:length(years)){
  print(paste("year: ",years[i]))
  var_list[[i]] <-  load_variables(year = years[i], dataset = "acs5")
  
  var_list[[i]][, paste0("yr", years[i])] <- 1 
  
  Sys.sleep(5)
}

# Remove Extra colon in 2015-2019 ACS dataset 
var_list[[length(var_list)]] <- var_list[[length(var_list)]] %>% 
                                        mutate(label = str_remove_all(label, ":"))

# Join list of datasets into one master dataset
var_df <- reduce(var_list, full_join, by = c("name", "label", "concept"))

# Create a table variable 
var_df$table <- str_sub(var_df$name, 1, 6)


