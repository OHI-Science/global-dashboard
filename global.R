## global

## Set up environment ##

## libraries
library(ohicore)
library(tidyverse)
library(shinydashboard)
## source OHI common script
source("https://raw.githubusercontent.com/OHI-Science/ohiprep_v2018/master/src/R/common.R")
## source modules
source("modules/chart_card.R")
source("modules/map_card.R")
## source functions
source("functions/tab_title.R")
source("functions/baseline_metrics.R")
## file paths
dir_M <- file.path(dir_M, 'git-annex/')
## no scientific notation and round to 2 decimals
options(scipen = 999,
        digits = 2)
## variables
present_yr <- 2018



## OHI DATA SOURCES ##

## OHI Region ID and Names
regions <- georegion_labels %>% 
  select(rgn_id, region=r2_label, country=rgn_label)

## OHI Global scores
scores <- read.csv("https://rawgit.com/OHI-Science/ohi-global/draft/eez/scores.csv")
scores <- scores %>%
 rename(rgn_id = "region_id") %>%
 left_join(regions, by="rgn_id")


## MAR DATA SOURCES ##
## Mariculture Production
# Country-specific mariculture description
countryInfo <- read_csv("int/country_desc.csv")
# Prepare time-series data for graphing annual production per country
mar_harvest <- read.csv("https://rawgit.com/OHI-Science/ohiprep_v2018/master/globalprep/mar/v2018/output/mar_harvest_tonnes.csv")
# Get marine harvest amount & tidy
mar_harvest <- mar_harvest %>% 
  left_join(regions, by="rgn_id") %>% 
  mutate(species = str_replace(mar_harvest$taxa_code, "_[0-9]+", "")) %>% 
  select(-taxa_code, -region, -rgn_id)
# Save harvest (tonnes) data with country names
write.csv(mar_harvest, "int/harvest_countries.csv")

## Trujillo sustainability data
sust <- read.csv("https://rawgit.com/OHI-Science/ohiprep_v2018/master/globalprep/mar/v2018/output/mar_sustainability.csv") 
# Remove numeric code in species name
sust <- sust %>% 
  mutate(species = str_replace(sust$taxa_code, "_[0-9]+", "")) %>% 
  select(-taxa_code)
# Save tidied sustainability data
write.csv(sust, "int/sust.csv")


## BASELINE METRICS DATA SOURCES ##


# List of all unique goal or sub-goals
goal_names <- unique(scores$goal)
# Save the global score for each goal/sub-goal
for(name in goal_names){

  name <- scores %>%
    filter(goal == name,
           dimension == "score",
           rgn_id == 0,
           year == present_yr) %>%
    select(score) %>%
    .$score

}
