
library(tidycensus)
library(tidyverse)
source("source.R")


#census_api_key("your_census_api_key_here", install = TRUE)


# Tables to Explore 
table_vec <- c("B01001", "B02001", "B03002", 
               "B11001", "B11003", "B11010", "B17001", "B19001", "B19013", "B19057","B19101", "B19113", "B19127",
                "B23001", "B25002", "B25003") 

boros <- c("Queens", "New York", "Richmond", "Kings", "Bronx")


#### ACTUAL DOWNLOAD ####

years <- 2010:2019

acs_list <- years %>% map(~get_acs_multi(state = "NY",
                                    counties = boros,
                                    tables = table_vec,
                                    output = "wide",
                                    geography = "tract",
                                    year = .x
))



for(i in 1:length(acs_list)){
  
  csv_name <- paste0("data/acs", years[i], ".csv")
  write.csv(acs_list[[i]], csv_name, row.names = FALSE, na = ".")
}



#### TEST ####

# test <- get_acs_multi(state = "NY",
#                             counties = "New York" ,
#                             tables = c("B01001", "B02001", "B03002"),
#                             output = "wide",
#                             geography = "tract",
#                             year = 2010
# )
# 
# acs_list[[1]] %>%  head %>%  View
# 
# 
# test <- get_acs_multi(state = "NY",
#                       counties = "New York" ,
#                       tables = c("B01001"),
#                       output = "wide",
#                       geography = "tract",
#                       year = 2010) 
# test %>%  View
# 
# names(test)
# 
# 
# View(test)
# class(test)
# 
# 
# nyc_tracts <- get_acs_multi(state = "NY", 
#               counties = boros, 
#               tables = table_vec,
#               output = "wide",
#               geography = "tract",
#               year = 2010
# )
# 
# names(nyc_tracts)
# class(nyc_tracts)
# 
# colSums(is.na(nyc_tracts))[colSums(is.na(nyc_tracts)) > 0]


  

# Note: can download data in wide format
# Note: can name variables 
# Other packages
## censusapi 
# prettyNum(object.size(nyc_tracts), big.mark= ",")
# 
# write.csv(nyc_tracts, "acs2010.csv", row.names = FALSE) # Write to CSv

#### Notes 
# length(unique(nyc_tracts$GEOID)) # 2168 census tracts
# nrow(nyc_tracts) - 2

#  length(unique(nyc_tracts$variable))  
#49 variables (long form)

#rm(test)




# Needs error for unknowne argument (e.g. "counties" instead of "county")

#### Old Code ####

# test <- get_acs(geography = 'tract',
#         table = "B01001",
#         survey = "acs5",
#         state = "NY",
#         counties = "New York",
#         year = 2010)

# Note: Can also subset
# Note: cache_tabe refers to output of data query, not table argument
# acs2010 <- table_vec %>% lapply(function(x) get_acs(geography = 'tract',
#                                          table = x,
#                                          state = "NY",
#                                          county = "New York",
#                                          year = 2010))

#table_vec %>% lapply(check_acs_years )




#### WHS NOTES: 11/02/2021 ####

# To-do:  11/03/2021

#### Note: Find out how table argument works in get_acs, may be what I was trying to do 
#### Note: If not, can find all variables in each table, or find specific variables needed 

# for (i in 1:length(years)){
#   var_list[[i]] <- get_acs(geograph = "tract", variables = c())
#   var_list[[i]]$year <- years[i]
# 
# }






#### Table: Race/Ethnicity (B02001) #### 
#### Table: Race/Ethnicity (B03002) ####

#SHR1AD       
#Total population for race/ethnicity
#Table B02001:1

#MINNHW1AN
#Non-Hispanic/Latino White alone population
#ACS 06-10 source: Table B03002:3

# MINNHB1AN     
# Black/African American alone population (Non-Hispanic/Latino)
# Table B03002:4

# MINNHI1AN     
# Non-Hispanic/Latino
# American Indian/Alaska Native alone population 
# Table B03002:5

#MINNHR1AN 
# Asian alone population (Non-Hispanic/Latino )
# Table B03002:6

# MINNHH1AN 
# Native Hawaiian and other Pacific Islander alone population (Non-Hispanic/Latino)
# Table B03002:7

# MINNHA1AN    
# Asian, Native Hawaiian and other (Non-Hispanic/LatinoS)
# Table ???? Equation ????

# Pacific Islander alone population 
# Table B03002:6,7

# MINNHO1AN 
# Non-Hispanic/Latino other race alone population
# Table B03002:8

# MRANHS1AN 
# Multiracial population (Non-Hispanic/Latino)
# Table B03002:9

# SHRHSP1AN   
# Total Hispanic/Latino population
# Table B03002:12

#### Table: Age Category (B01001) ####


# ADULT1AN    
# Adults 18+ years old
# Table B01001:7-25,31-49

#CHILD1AN 
#Children under 18 years old
# Table B01001:3-6,27-30

# OLD1AN       
# Persons 65+ years old
# Table B01001:20-25,44-49

# KIDS1A       
# Proportion of persons who are children under 5 years old

#### Table Households (B11001)  #### 

#NUMHHS1A      
# Total households
# Table B11001:1

#### Table Head of Households (B11003) ####

# MCWKID1A      
# Married-couple families with own children under 18 years  old 
# Table B11003:3

#MCNKID1A      
# Married-couple families without own children under 18 years old 
# Table B11003:7

#MHWKID1A     
# Male-headed families with own children under 18 years old
# Table B11003:10

#MHNKID1A   
# Male-headed families without own children under 18 years  old 
# Table B11003:14

# FHWKID1A      
# Female-headed families with own children under 18 years old
# Table B11003:16

# FHNKID1A    
#Female-headed families without own children under 18 years old 
# Table B11003:20


#### Table Non-Family Households (B11010) ####

# NONFAM1A   
# Nonfamily households
# Table B11010:1

#### Table Unemployed (B23001) ####

#UNEMPT1AN
#Persons 16+ years old in the civilian labor force and unemployed 
# Table B23001:8,15,22,29,36,43,50,57,64,71,76,81,86,94,
#101,108,115,122,129,136,143,150,157,162,167,172

# UNEMPT1AD   
#Persons 16+ years old in the civilian labor force
# Table B23001:6,13,20,27,34,41,48,55,62,69,92,99,106,113,120,127,134,141,148,155

#### Table Poverty (B17001) #####

# POVRAT1AN    
# Total persons below the poverty level in past 12 months
# Table B17001:2

# POVRAT1AD   
# Total population with poverty status determined
# Table B17001:1

#### Table Welfare (19057) ####
# WELFAR1ARN    
# Households with public assistance income (not incl. SSI) in past 12 months 
# Table B19057:2

#### Table Total Households (B19001) ####
# WELFAR1AD 
# Total households
# Table B19001:1

# WELFAR1AR
# Proportion of households with public assistance income (incl. SSI) in past 12 months 

#### Table Family Income (B19127) ####

# FAVINC1AN 
# Aggregate family income ($)
# Table B19127:1

#### Table Total Families (B19101) #### 
# FAVINC1AD 
# Total families
# Table B19101:1

# FAVINC1A 
# Average income per family ($)
# Table? 


#### Table B19113 ####

# MDFAMY1A
# Median family income in the past 12 months ($)
# Table B19113:1


#### Table  B19013 ####

# MDHHY1A
# Median household income in the past 12 months ($)
# Table B19013:1



#### Table B010001 ####

# FEM41A
# Females 0-4 years old
# Table B01001:27

# FEM91A
# Females 5-9 years old
# Table B01001:28

# FEM141A
# Females 10-14 years old
# Table B01001:29

# FEM171AA
# Females 15-17 years old
# Table B01001:30

# MEN41A
# Males 0-4 years old
# Table B01001:3

# MEN91A      
# 06-10 Males 5-9 years old
# Table B01001:4

# MEN141A
# Males 10-14 years old
# Table B01001:5

#MEN171AA     
# 06-10 Males 15-17 years old
# Table B01001:6



#### Table B25002 ####

# TOTHSUN1A     
# Total housing units
# Table B25002:1

# OCCHU1A
# Total occupied housing units
# Table B25002:2

# VACHU1A   
# Total vacant housing units
# Table B25002:3

# RNTOCC1A    
#Total renter-occupied housing units
# Table B25003:3

# OWNOCC1A     
# Total owner-occupied housing units
#: Table B25003:2


