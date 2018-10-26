## Fisheries sub-goal data prep
## The two data tables produced in this script are `fis_harvest` and `fis_global_map`
## Comment out wrangling to save time when loading app. Read data tables directly from int folder
## When there is new data, change year and re-wrangle and process to create new data tables.



## DEFINE GLOBAL FIS VARIABLES ##
data_yr <- 2015 # most recent year of data for fis




## FISHERIES HARVEST TIME SERIES ##

# # Prepare time-series data for graphing annual production per country; read in gapfilled and tidied mariculture production data set
fis_out <- read.csv(paste0("https://rawgit.com/OHI-Science/", prep_repo, "/master/globalprep/fis/", assess_yr, "/output/fis_bbmsy.csv"))

fis <- fis_out %>% 
  filter(year == data_yr, rgn_id == 24)

fis_rgn <- georegion_labels %>% 
  select(rgn_id, country = rgn_label)

fis_harvest <- fis_out %>% 
  left_join(fis_rgn, by = "rgn_id")

# write.csv(fis_harvest, "int/fis_bbmsy.csv", row.names=FALSE)




## GLOBAL MAP SUMMARY DATA ##
fis_global_map <- read.csv(paste0("https://raw.githubusercontent.com/OHI-Science/", prep_repo, "/master/globalprep/fis/", assess_yr, "/output/mean_catch.csv"))

## Total Mean Catch (tonnes)
fis_global_map <- fis_global_map %>% 
  filter(year == data_yr) %>% 
  group_by(rgn_id) %>%
  summarize(total_catch = sum(mean_catch)) %>% 
  ungroup()

write.csv(fis_global_map, "int/fis_global_map.csv", row.names=FALSE)

# ## Top Producing Countries (Seafood/Capita)
# mar_pop <- read.csv(paste0("https://rawgit.com/OHI-Science/", prep_repo,"/master/globalprep/mar_prs_population/", assess_yr, "/output/mar_pop_25mi.csv")) %>%
#   na.omit()
# 
# ## Join coastal population and mariculture production tables
# mar_harvest$tonnes <- as.numeric(mar_harvest$tonnes) # turn it back to numeric
# food_pop <- mar_harvest %>%
#   mutate(pounds = tonnes*2204.62) %>%
#   left_join(mar_pop, by=c("rgn_id","year")) %>%
#   na.omit()
# 
# ## Summarize all production per country-year, production/capita for each country-year
# summary_food <- food_pop %>%
#   group_by(country,year) %>%
#   mutate(prodTonnesAll = sum(tonnes, na.rm=TRUE)) %>% # Total production per year and country in tonnes
#   mutate(prodPerCap = sum(pounds, na.rm=TRUE)/popsum) %>% # NAs may cuase issues in calc
#   ungroup()
# 
# 
# ## Add missing regions back into food production data frame
# temp_rgns <- rgns_leaflet %>%
#   select(rgn_id, rgn_nam)
# st_geometry(temp_rgns) <- NULL # remove geometry so it is just a data frame
# 
# food_all_countries <- summary_food %>%
#   full_join(temp_rgns, by = "rgn_id") %>% # add in all regions from temp
#   mutate(rgn_nam = as.character(rgn_nam)) %>%
#   mutate(country = as.character(country)) %>% 
#   mutate(country = ifelse(is.na(country), rgn_nam, country)) %>%
#   select(-rgn_nam)
# 
# ## Tidy data into long format so it's ready for plotting
# yr_range <- min(food_all_countries$year,na.rm=T):max(food_all_countries$year,na.rm=T)
# 
# mar_global_map <- food_all_countries %>%
#   complete(year = yr_range, nesting(country, rgn_id)) %>% # add in all years even if no value reported
#   gather(type,map_data,c(prodTonnesAll, prodPerCap)) %>%
#   mutate(units = case_when(
#     type == "prodTonnesAll" ~ "tonnes",
#     type == "prodPerCap" ~ "lb/person"
#   )) %>%
#   filter(year == data_yr) %>% # plotting only 2016 data
#   select(rgn_id, country, type, map_data, units, Taxon) %>%
#   distinct() %>%
#   mutate(map_data = as.numeric(format(round(map_data, 2), nsmall=2))) %>%   # round to two decimal places
#   mutate(map_data = ifelse(map_data == 0, NA, map_data)) # so visually values < 0.1 are greyed out
# 
# write.csv(mar_global_map, "int/mar_global_map.csv", row.names=FALSE)

