## global variables


## SET UP ENVIRONMENT ##

## libraries
library(ohicore)
library(sf)
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)
library(plotly)
library(sunburstR)
library(viridis)

## Color Palettes
ygb <- colorRampPalette(brewer.pal(5,'YlGnBu'))(200); cols <- ygb[19:200] # blue shades
# cols <- rev(colorRampPalette(brewer.pal(11, 'Spectral'))(255)) # rainbow 

## Define Annually Changing Variables
prep_repo <- "ohiprep_v2018"
present_yr <- 2018
assess_yr <- "v2018"
data_yr <- 2016


## source OHI script
source(paste0("https://raw.githubusercontent.com/OHI-Science/", prep_repo, "/master/src/R/common.R"))
source(paste0("https://raw.githubusercontent.com/OHI-Science/", prep_repo, "/master/src/R/fao_fxn.R"))
source(paste0("https://raw.githubusercontent.com/OHI-Science/", prep_repo, "/master/globalprep/mar/", assess_yr, "/mar_fxs.R"))

## source modules
source("modules/chart_card.R")
source("modules/map_card.R")
source("modules/baseline_metrics_card.R")

## source functions
source("functions/tab_title.R")
source("functions/front_page.R")

## no scientific notation and round to 2 decimals
options(scipen = 999,
        digits = 5)



## GLOBAL OHI REGION DATA SOURCES ##

## OHI Region ID and Names
regions <- georegion_labels %>% 
  select(rgn_id, region=r2_label, country=rgn_label)

## OHI Region Shapefile - is there a way to read in the shapefile with the github url?
ohi_regions <-  sf::st_read('../ohiprep/globalprep/spatial/downres', "rgn_all_gcs_low_res")
rgns_leaflet <- ohi_regions %>%
  filter(rgn_typ == "eez")



## MAR DATA SOURCES ##

## Mariculture Production
# Prepare time-series data for graphing annual production per country
mar_out <- read.csv(paste0("https://rawgit.com/OHI-Science/", prep_repo, "/master/globalprep/mar/", assess_yr, "/output/MAR_FP_data.csv"))

# Get marine harvest amount & tidy
mar_harvest <- mar_out %>% 
  left_join(regions, by="rgn_id") %>% 
  select(rgn_id, country, species, Taxon_code, year, value) %>% 
  rename(tonnes = value) %>% 
  arrange(country) %>%  # Sort country alphabetically
  mutate(Taxon = case_when(
    Taxon_code == "F" ~ "Fish", 
    Taxon_code == "SH" ~ "Crustacean",
    Taxon_code == "BI" ~ "Bivalve and Molluscs",
    Taxon_code == "INV" ~ "Invertebrate",
    Taxon_code == "CRUST" ~ "Crustacean",
    Taxon_code == "MOLL" ~ "Bivalve and Molluscs",
    Taxon_code == "AL" ~ "Seaweed",
    Taxon_code == "NS-INV" ~ "Invertebrate",
    Taxon_code == "URCH" ~ "Invertebrate",
    Taxon_code == "CEPH" ~ "Bivalve and Molluscs",
    Taxon_code == "TUN" ~ "Invertebrate"))
mar_harvest$Taxon <- as.factor(mar_harvest$Taxon)
                 
# Save harvest (tonnes) data with country names
write.csv(mar_harvest, "int/harvest_countries.csv", row.names = FALSE)




## GLOBAL MAP SUMMARY DATA ##

## Top Producing Countries (Seafood/Capita)
mar_pop <- read.csv(paste0("https://rawgit.com/OHI-Science/", prep_repo,"/master/globalprep/mar_prs_population/", assess_yr, "/output/mar_pop_25mi.csv")) %>% 
  na.omit()

## Join coastal population and mariculture production tables
food_pop <- mar_harvest %>% 
  mutate(pounds = tonnes*2204.62) %>% 
  left_join(mar_pop, by=c("rgn_id","year")) %>% 
  na.omit()

## Summarize all production per country-year, production/capita for each country-year, and per capita for each taxon-country-year
mar_global_map <- food_pop %>%
  group_by(country,year) %>%
  mutate(prodTonnesAll = sum(tonnes, na.rm=TRUE)) %>% # Total production per year and country in tonnes
  mutate(prodPerCap = sum(pounds, na.rm=TRUE)/popsum) %>% # 
  ungroup() %>% 
  gather(type,map_data,c(prodTonnesAll, prodPerCap),na.rm=TRUE) %>% 
  mutate(units = case_when(
    type == "prodTonnesAll" ~ "tonnes",
    type == "prodPerCap" ~ "lb/person"
  )) %>%
  filter(year == data_yr) %>% # plotting only 2016 data
  select(rgn_id, country, type, map_data,units) %>% 
  distinct() %>% 
  mutate(map_data = as.numeric(format(round(map_data, 2), nsmall=2))) %>%   # round to two decimal places
  mutate(map_data = ifelse(map_data == 0, NA, map_data)) # so visually values < 0.1 are greyed out



## Trujillo sustainability data -- incorporate into global map!
# sust <- read.csv("https://rawgit.com/OHI-Science/ohiprep_v2018/master/globalprep/mar/v2018/output/mar_sustainability.csv")
# # Remove numeric code in species name
# sust <- sust %>%
#   mutate(species = str_replace(sust$taxa_code, "_[0-9]+", "")) %>%
#   select(-taxa_code) %>% 
#   left_join(regions[,1:2], by="rgn_id")
# # Save tidied sustainability data
# write.csv(sust, "int/sust.csv", row.names=FALSE)
# sust <- read.csv("int/sust.csv")



