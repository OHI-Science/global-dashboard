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



## GLOBAL OHI DATA SOURCES ##

## OHI Region ID and Names
regions <- georegion_labels %>% 
  select(rgn_id, region=r2_label, country=rgn_label)





## BASELINE METRICS DATA SOURCES ##

## OHI Global scores
scores <- read.csv("https://rawgit.com/OHI-Science/ohi-global/draft/eez/scores.csv")
scores <- scores %>%
  rename(rgn_id = "region_id") %>%
  left_join(regions, by="rgn_id")
# List of all unique goal or sub-goals
goal_names <- as.character(unique(scores$goal))
# Save the global score for each goal/sub-goal
for(i in 1:length(goal_names)){
  
  score_val <- scores %>%
    filter(goal == goal_names[i],
           dimension == "score",
           rgn_id == 0,
           year == present_yr) %>%
    select(score) %>%
    .$score
  
  assign(goal_names[i],score_val)

}





## MAR DATA SOURCES ##

## Mariculture Production
# Prepare time-series data for graphing annual production per country
mar_harvest <- read.csv("https://rawgit.com/OHI-Science/ohiprep_v2018/master/globalprep/mar/v2018/output/mar_harvest_tonnes.csv")
# Get marine harvest amount & tidy
mar_harvest <- mar_harvest %>% 
  left_join(regions, by="rgn_id") %>% 
  mutate(species = str_replace(mar_harvest$taxa_code, "_[0-9]+", "")) %>% 
  select(-taxa_code, -region, -rgn_id)
mar_harvest$country <- sort(mar_harvest$country) # Sort country alphabetically
# Save harvest (tonnes) data with country names
write.csv(mar_harvest, "int/harvest_countries.csv")

## Largest Share of Production
# Determine which country produced the most mariculture regardless of species
historic <- mar_harvest %>%
  filter(year == 2016) %>% 
  summarize(total = sum(tonnes))

top_cntry <- mar_harvest %>% 
  filter(year == 2016) %>% 
  group_by(country) %>% 
  summarize(cntry_tot = sum(tonnes)) %>%
  ungroup() %>% 
  mutate(rel_contrib = cntry_tot/historic$total) %>% 
  arrange(desc(rel_contrib))

mar_metric1 <- list(
  mar_perc <- paste(round(top_cntry$rel_contrib[1]*100),"%",sep=""),
  cntry <- as.character(top_cntry$country[1])
)



## Trujillo sustainability data
sust <- read.csv("https://rawgit.com/OHI-Science/ohiprep_v2018/master/globalprep/mar/v2018/output/mar_sustainability.csv")
# Remove numeric code in species name
sust <- sust %>%
  mutate(species = str_replace(sust$taxa_code, "_[0-9]+", "")) %>%
  select(-taxa_code) %>% 
  left_join(regions[,1:2], by="rgn_id")
# Save tidied sustainability data
write.csv(sust, "int/sust.csv", row.names=FALSE)
sust <- read.csv("int/sust.csv")
