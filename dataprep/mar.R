## Mariculture sub-goal data prep

## DEFINE GLOBAL MAR VARIABLES ##
data_yr <- 2016

## MAR DATA SOURCES ##

## Mariculture Production
# Prepare time-series data for graphing annual production per country; read in gapfilled and tidied mariculture production data set
mar_out <- read.csv(paste0("https://rawgit.com/OHI-Science/", prep_repo, "/master/globalprep/mar/", assess_yr, "/output/MAR_FP_data.csv"))

# Get marine harvest amount & tidy
mar_harvest <- mar_out %>% 
  left_join(regions, by="rgn_id") %>% 
  mutate(country = as.character(country)) %>% # convert factor to character to do next step
  mutate(country = ifelse(country == "R_union", "Reunion", country)) %>% 
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

## Summarize all production per country-year, production/capita for each country-year
summary_food <- food_pop %>%
  group_by(country,year) %>%
  mutate(prodTonnesAll = sum(tonnes, na.rm=TRUE)) %>% # Total production per year and country in tonnes
  mutate(prodPerCap = sum(pounds, na.rm=TRUE)/popsum) %>% # NAs may cuase issues in calc
  ungroup()


## Add missing regions back into food production data frame
temp_rgns <- rgns_leaflet %>% 
  select(rgn_id, rgn_nam)
st_geometry(temp_rgns) <- NULL # remove geometry so it is just a data frame

food_all_countries <- summary_food %>% 
  full_join(temp_rgns, by = "rgn_id") %>% # add in all regions from temp
  mutate(rgn_nam = as.character(rgn_nam)) %>% 
  mutate(country = ifelse(is.na(country), rgn_nam, country)) %>% 
  select(-rgn_nam)

## Tidy data into long format so it's ready for plotting
yr_range <- min(food_all_countries$year,na.rm=T):max(food_all_countries$year,na.rm=T)

mar_global_map <- food_all_countries %>% 
  complete(year = yr_range, nesting(country, rgn_id)) %>% # add in all years even if no value reported
  gather(type,map_data,c(prodTonnesAll, prodPerCap)) %>% 
  mutate(units = case_when(
    type == "prodTonnesAll" ~ "tonnes",
    type == "prodPerCap" ~ "lb/person"
  )) %>%
  filter(year == data_yr) %>% # plotting only 2016 data
  select(rgn_id, country, type, map_data, units, Taxon) %>% 
  distinct() %>% 
  mutate(map_data = as.numeric(format(round(map_data, 2), nsmall=2))) %>%   # round to two decimal places
  mutate(map_data = ifelse(map_data == 0, NA, map_data)) # so visually values < 0.1 are greyed out

## Top Seaweed Producers
# seaweed <- mar_global_map %>%
#   filter(Taxon == "Seaweed")
# 
# top_seaweed <- seaweed %>%
#   filter(type == "prodPerCap")%>%
#   dplyr::arrange(desc(map_data))


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
