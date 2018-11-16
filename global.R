## global variables
## sources goal data for map and chart modules
## defines global variables, source code, etc


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
library(stringr)

## Color Palettes
ygb <- colorRampPalette(brewer.pal(5,'YlGnBu'))(200); cols <- ygb[19:200] # blue shades



## DEFINE ANNUALLY CHANGING VARIABLES ##

## Current global prep repository
prep_repo <- "ohiprep_v2018"

## Current assessment year
present_yr <- 2018
assess_yr <- "v2018"



## SOURCE EXTERNAL SCRIPTS ##

## source OHI scripts
source(paste0("http://ohi-science.org/", prep_repo, "/src/R/fao_fxn.R"))
source(paste0("http://ohi-science.org/", prep_repo, "/globalprep/mar/", assess_yr, "/mar_fxs.R"))

## source modules
source("modules/chart_card.R")
source("modules/map_card.R")
source("modules/summary_stats_card.R")

## source functions
source("functions/tab_title.R")

## source front page css/html customization
source("front_page.R")

## set: no scientific notation and round to 2 decimals
options(scipen = 999,
        digits = 5)



## GLOBAL OHI REGION DATA SOURCES ##

## OHI Region ID and Names
regions <- georegion_labels %>% 
  select(rgn_id, region=r2_label, country=rgn_label)

## OHI Region Shapefile - is there a way to read in the shapefile with the github url?
ohi_regions <-  sf::st_read("int/spatial", "rgn_all_gcs_low_res")
rgns_leaflet <- ohi_regions %>%
  filter(rgn_typ == "eez", rgn_id != 213, rgn_id <= 250) %>% # remove Antarctica 
  select(-are_km2, -ant_typ, -ant_id, -rgn_key)



## GLOBAL MARICULTURE DATA SOURCES ##
source("dataprep/mar.R")