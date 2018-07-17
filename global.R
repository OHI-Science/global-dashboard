#global


source(file.path('~/github/ne-prep/src/R/common.R'))  ### an OHI-NE specific version of common.R

dir_anx <- file.path(dir_M, 'git-annex/neprep')

## source modules
source("modules/chart_card.R")
source("modules/map_card.R")

## source functions
source("functions/tab_title.R")

## no scientific notation and round to 2 decimals
options(scipen = 999,
        digits = 2)

##libraries

library(tidyverse)
library(shinydashboard)

## Data sources (change this to be organized by goal and then alphabetically?)

# NOEP data for livelihoods & economies, tourism & recreation
noep_data <- readxl::read_excel(file.path(dir_anx, '_raw_data/NOEP/New_England_ocean_series.xlsx'), sheet = "ENOW") %>%
  mutate(Employment = as.integer(Employment),
         Wages_2012 = as.integer(Wages_2012)/Employment) %>%
  filter(str_detect(County, "All"),
         !is.na(Employment),
         !is.na(Wages_2012),
         !is.na(GDP_2012))

# Trash pressure layer

trash <- read_csv("~/github/ne-prep/prep/cw/scores/trash.csv")
