## global

## Set up environment ##

## libraries
library(ohicore)
library(sf)
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)

## Color Palette
ygb <- colorRampPalette(brewer.pal(5,'YlGnBu'))(200)
cols <- ygb[19:200]

## source OHI common script
source("https://raw.githubusercontent.com/OHI-Science/ohiprep_v2018/master/src/R/common.R")

## source modules
source("modules/chart_card.R")
source("modules/map_card.R")
source("modules/baseline_metrics_card.R")

## source functions
source("functions/tab_title.R")

## no scientific notation and round to 2 decimals
options(scipen = 999,
        digits = 2)
## variables
present_yr <- 2018



## GLOBAL OHI DATA SOURCES ##

## OHI Region ID and Names
regions <- georegion_labels %>% 
  select(rgn_id, region=r2_label, country=rgn_label)

## OHI Region Shapefile
ohi_regions <- sf::st_read(file.path(dir_M,"git-annex/globalprep/spatial/v2017"), "regions_2017_update", quiet = T) %>%
  sf::st_transform(crs = '+proj=longlat +datum=WGS84')  # rgn_id, rgn_name

rgns_leaflet <- ohi_regions %>%
  filter(rgn_type == "land", rgn_name != "Antarctica")



## Empty Baseline Metrics Data Frame
# baseline <- setNames(data.frame(matrix(ncol = 4, nrow = 0)),
#                      c("country","goal","metric","description"))

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
mar_all <- read.csv("https://raw.githubusercontent.com/OHI-Science/ohiprep_v2018/master/globalprep/mar/v2018/output/MAR_FP_data.csv")
mar_harvest <- mar_all %>% 
  left_join(regions, by="rgn_id") %>% 
  select(rgn_id, country, species, Taxon_code, year, value) %>% 
  arrange(country) # Sort country alphabetically
# Save harvest (tonnes) data with country names
write.csv(mar_harvest, "int/harvest_countries.csv", row.names = FALSE)

## Prepare data for map: total produced per population
## Subset seaweed production for ohi-science article
seaweed <- mar_harvest %>% 
  filter(Taxon_code == "AL")

top <- seaweed %>% 
  filter(year %in% c(2011:2015)) %>%
  group_by(country) %>% 
  rename(tonnes = value) %>% 
  dplyr::summarise(tot_edible_sw = sum(tonnes))%>% 
  dplyr::arrange(desc(tot_edible_sw)) %>% 
  ungroup()




## Baseline Metrics: Statistics
## MAR Global Score
# mar_statistics <- data.frame("Global","MAR",MAR,"Global Mariculture Score")
# baseline <- rbind(mar_statistics,baseline)

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

# mar_metric1 <- list(
#   mar_perc <- paste(round(top_cntry$rel_contrib[1]*100),"%",sep=""),
#   cntry <- as.character(top_cntry$country[1])
# )


# Combine all metrics into baseline.csv
# mar_statistics <- data.frame(
#   country = c("Global",
#                as.character(top_cntry$country[1]),
#               "Chile"),
#   goal = c("MAR",
#            "MAR",
#            "MAR"),
#   metric = c(paste0(MAR,"%"),
#               paste(round(top_cntry$rel_contrib[1]*100),"%",sep=""),
#              "78 tonnes"),
#   subtitle = c("Global Mariculture Score",
#                    "Largest Share of Production",
#                   "Seafood per Capita"),
#   description = c("Healthy oceans maximize the marine cultivation potential and minimize impacts to the ecosystem.",
#                   "contributes the largest historic share by tonnes of mariculture produced for human consumption",
#                   "produces the most seafood per capita"))
# 
# baseline <- rbind(mar_statistics,baseline)
# write.csv(baseline, "int/baseline.csv", row.names=FALSE)
baseline <- read.csv("int/baseline.csv")

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
