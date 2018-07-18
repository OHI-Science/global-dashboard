##global

## Set up environment ##

## source common.R
source("https://raw.githubusercontent.com/OHI-Science/ohiprep_v2018/master/src/R/common.R")

## source modules
source("modules/chart_card.R")
source("modules/map_card.R")

## source functions
source("functions/tab_title.R")

## no scientific notation and round to 2 decimals
options(scipen = 999,
        digits = 2)

##libraries
library(ohicore)
library(tidyverse)
library(shinydashboard)
dir_M <- file.path(dir_M, 'git-annex/')



## Data sources ##

## FAO data for mariculture production
## Prepare time-series data for graphing annual production per country
mar_harvest <- read.csv("https://rawgit.com/OHI-Science/ohiprep_v2018/master/globalprep/mar/v2018/output/mar_harvest_tonnes.csv")

## Get country names and their region id
regions <- georegion_labels %>% 
  select(rgn_id, region=r2_label, country=rgn_label)

## Get marine harvest amount & tidy
mar_harvest <- mar_harvest %>% 
  left_join(regions, by="rgn_id") %>% 
  mutate(species = str_replace(mar_harvest$taxa_code, "_[0-9]+", "")) %>% 
  select(-taxa_code, -region, -rgn_id)

## Save harvest (tonnes) data with country names
write.csv(mar_harvest, "int/harvest_countries.csv")



## Coastal population data


## Trujillo sustainability data
sust <- read.csv("https://rawgit.com/OHI-Science/ohiprep_v2018/master/globalprep/mar/v2018/output/mar_sustainability.csv") 

sust <- sust %>% 
  mutate(species = str_replace(sust$taxa_code, "_[0-9]+", "")) %>% 
  select(-taxa_code)

## Save tidied sustainability data
write.csv(sust, "int/sust.csv")
