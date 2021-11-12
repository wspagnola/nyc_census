#tidycensus::get_acs()

check_acs_years <- function(tablename, dta = var_df ){
  
  # Only want to load these if tidyverse not loaded
  # Can use baseR to reduce dependencies
  require(dplyr)
  library(magrittr) #note: use require or library? 
  
  
  dta %>%  
    filter(table == tablename) %>% 
    is.na() %>% 
    colSums()

}



get_acs_multi <- function(counties, tables, geography, state,
                          output = "tidy", survey = "acs5", 
                          year = 2019, sleep = 10){
  
  table_list <- list()
  
  for (i in 1:length(tables)){
    
    county_list <- list()
    
    for(j in 1:length(counties)){
      
      county_list[[j]] <- get_acs(geography = geography,
                                  table = tables[[i]],
                                  survey = survey,
                                  output = output,
                                  state = state,
                                  county = counties[[j]],
                                  year = year)
      
    }
    
    county_df <- do.call(rbind, county_list)

    if(output == "tidy"){
      county_df$table <- tables[[i]]
      
    }
    
    table_list[[i]] <- county_df
    
    #Sleep between queries 
    #cat("Sleeping for", sleep, "second(s)...")
    #Sys.sleep(sleep)
  }
  
  if(output == "tidy"){
    
    # Simply bind rows for data in tidy format
    table_df <- do.call(rbind, table_list)

  } else if(output == "wide"){

    # Merge data if data in wide format
    # cbind() would duplicate key variables
    # Note: Think GEOID is key name regardless of geography
    table_df <- base::Reduce(function(x,y)
                       merge(x, y, by = c("GEOID", "NAME"), all = TRUE),
                       table_list)

  }
  
  # Do I even want year here?
  table_df$YEAR <- year
  table_df <- table_df %>% select(GEOID, NAME, YEAR, everything()) # OCD
  return(table_df)
}


#### Functions to Create #####

# load multi-year: load multiple years of data as list, Sys.Sleep to avoid overloading server 
# check_var_year: check if variable is available in all years
# load _tables:   create table variable along with load_variables
# extract_tables: -extract table (unique concepts) from acs data
#                 -pass table code to main dataset to get unique columns from that table 

