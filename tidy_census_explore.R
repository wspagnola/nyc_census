

library(tidycensus)
library(tidyverse)

# x <- tidycensus::get_decennial(geography = "state",
#                            variables = "P004004",
#                            year = 2010,
#                            key = census_api_key)


#### 2000 long-form Decennial Census ####
var_list2000 <- tidycensus::load_variables(year = 2000,
                            dataset = "sf3")
#var_list2000 %>% filter(grepl("^P\\d", name)) %>%  View


#### 206-2010 ACS ####
var_list2010 <- tidycensus::load_variables(year = 2010,
                                           dataset = "acs5")
#var_list2010 %>% View


#### Adult0N ####

#ADULT0N 2000 Table P8:21-40, 60-79

# Number of Adults older than 18 
# Data: Summary File 3 (Long Form: 2000 Census)
#21-40 = Male 18 or older 
#60-79 = Female 18 or older
var_list %>%
  filter(grepl("^P0080([2-3]|40|[6-7])", name))  %>% View


#### CHILD0N ####

#Table P8:3-20,42-59
# P8:3-20 = Males under 18
# P8:42-59 = females under 18
var_list2000 %>%
  filter(grepl("^P0080(0[3-9]|1|20|4[2-9]|5)", name))  %>%  View
  
#### Favinc??? ####

#Aggregate family income ($)

# FAVINC0N 2000 Table P78:1

#Total families

# FAVINC0D

# Average income per family ($)

# FAVINC0 2000 FAVINC0N/FAVINC0D

# FAVINC0

#### Female Population #### 

## Note: ending "0" means 2000 (super confusing !!!!)

#Females 0-4 years old
#Table P8:42-46
# FEM40

#Females 5-9 years old
# Table P8:47-51
# FEM90

#Females 10-14 years old
#  Table P8:52-56
# FEM140

# Females 15-17 years old
# Table P8:57-59
# FEM170A

#### Female-Headed Families #### 

#Female-headed families without own children under 18 years old
# Table P12:13,28
# FHNKID0

#Female-headed families with own children under 18 years old
# Table P12:13,28
# FHWKID0

#### Children Under 5 years Old ####

#  Table P8:3-7,42-46
# Children under 5 years old
# KIDS0N


#### Married-Couple Families ####

# Married-couple families without own children under 18 years old
# MCNKID0

# Married-couple families with own children under 18 years old
# MCWKID0


#### Median Income #### 

# Median family income last year ($)
# Table P77:1
# MDFAMY0

# Median household income last year ($)
# Table P53:1
# MDHHY0

# Household vs family ????


#### Males  ####

# Males 0-4 years old
# Table P8:3-7
# MEN40

# Males 5-9 years old
# Table P8:8-12
# MEN90

# Males 10-14 years old
# Table P8:13-17
# MEN140

# Males 15-17 years old
# Table P8:18-20
# MEN170A

#### Male-headed Families #### 

# Male-headed families without own children under 18 years old
# Table P12:10,25
# MHNKID0

# Male-headed families with own children under 18 years old
# Table P12:9,24
# MHWKID0


#### Race / Ethnicity #### 

# Non-Hispanic/Latino 
# Asian, Native Hawaiian and other Pacific Islander alone population
# MINNHA0N = MINNHR0N + MINNHH0N
# MINNHA0N

# Non-Hispanic/Latino Black/African American alone population
# Table P7:4
# MINNHB0N

# Non-Hispanic/Latino 
# Native Hawaiian and other Pacific Islander alone population
# Table P7:7
# MINNHH0N

# Non-Hispanic/Latino 
# American Indian/Alaska Native alone population
# Table P7:5
# MINNHI0N

# Non-Hispanic/Latino 
# Other race alone population
# Table P7:8
# MINNHO0N

# Non-Hispanic/Latino 
# Asian alone population
# Table P7:6
# MINNHR0N

# Non-Hispanic/Latino 
# White alone population
# Table P7:3
# MINNHW0N

# Non-Hispanic/Latino 
# Multiracial population
# Table P7:9
# MRANHS0N

# Total Hispanic/Latino population
# Table P7:10
# SHRHSP0N

#### Poverty / Employment / Welfare ####

# Total population with poverty status determined
# Table P87:1
# POVRAT0D

# Total persons below the poverty level last year
# Table P87:2
# POVRAT0N

# Persons 16+ years old in the civilian labor force
# Table P43:5,12
# UNEMPT0D

# Persons 16+ years old in the civilian labor force and unemployed
# Table P43:7,14
# UNEMPT0N

# WELFAR0D
# Total Households
#WELFAR0D 2000 Table P64:1
var_list2000 %>% 
  filter(str_detect(name, "^P064")) %>%  View

# Households with public assistance income (incl. SSI) last year 
# Table P63:2 + Table P64:2
# WELFAR0N

# NOTE: Assuming these are mutually exclusive 
var_list2000 %>% 
  filter(str_detect(name, "^P063002|^P064002")) %>%  View

#### Housing ####

# Total occupied housing units
# Table H6:2
# OCCHU0

# Total owner-occupied housing units 
# Table H7:2
# OWNOCC0

# Total renter-occupied housing units
# Table H7:3
# RNTOCC0

# Total vacant housing units
# Table H6:3
# VACHU0

# Total housing units
# Table H1:1
# TOTHSUN0

#### Other Variables #### 

# Total population for race/ethnicity
# Table P6:1
# SHR0D

# Non-family households
# Table P12:14,29
# NONFAM0

# Total households
# Table P14:1
# NUMHHS0

# Persons 65+ years old
#Table P8:35-40,74-79
# OLD0N

# Total population
# Table P1:1
# TRCTPOP0


#### Table Concepts ####

# https://www.census.gov/data/datasets/2010/dec/summary-file-1.html

# There are 177 population tables (identified with a ‘‘P’’) and 
# 58 housing tables (identified with an ‘‘H’’) shown down to the block level;
# 82 population tables (identified with a ‘‘PCT’’) and 4 housing tables
# (identified with an “HCT”) shown down to the census tract level; 
# and 10 population tables (identified with a “PCO”) shown down to
# the county level, for a total of 331 tables.
# The SF 1 Urban/Rural Update added 2 PCT tables, increasing
# the total number to 333 tables. There are 14 population tables and
# 4 housing tables shown down to the block level and 5 population 
# tables shown down to the census tract level that 
# are repeated by the major race and Hispanic or Latino groups.

table_concepts <- var_list2000 %>%
  mutate(unit= str_extract(name, "[A-Z]+"),
         table = str_extract(name, "\\d\\d\\d")) %>% 
  distinct(unit, table, concept) %>% 
  select(unit, table, concept)
table_concepts %>%  View

table_concepts %>%  count(unit)

# H   = Housing
# P   = Population
# HCT = Housing (Census Tract)
# PCT = Population (Census Tract)




