# Test leaflet plot of global map

## Setup
library(rgdal)
library(dplyr)
library(leaflet)

ygb <- colorRampPalette(brewer.pal(5,'YlGnBu'))(200); cols <- ygb[19:200]

source("global.R")


## OHI Region Shapefile - is there a way to read in the shapefile with the github url?
ohi_regions <-  sf::st_read('../ohiprep/globalprep/spatial/downres', "rgn_all_gcs_low_res")
rgns_leaflet <- ohi_regions %>%
  filter(rgn_typ == "eez")

## Identify arguments for map_card
data = mar_global_map
filter_field = data$type
display_field = "map_data"
color_palette = ygb
legend_title = "Legend"
popup_title = "Seafood Production: "
popup_units = "pounds/person"
popup_add_field = "rgn_nam"
popup_add_field_title = "EEZ: "

## Attach data to rgn shapefile - select for just production per capita to test
data_shp <- rgns_leaflet %>%
  full_join(data, by = "rgn_id") %>% 
  filter(type == "prodPerCap")



# Get color pal
pal <- colorQuantile(palette = color_palette,
                     domain = data_shp$map_data,
                     na.color = "#00000000",
                     alpha = 0.4)


## Popup attributes
popup_title = "Seafood Production: "
popup_add_field_title = "Country EEZ: "

popup_text <- paste("<h5><strong>", popup_title, "</strong>", as.character(signif(data_shp$map_data,3)), "lb/person", "</h5>",
                    "<h5><strong>", popup_add_field_title, "</strong>", data_shp$rgn_nam, "</h5>", sep=" ")

## Plot with leaflet!
leaflet(data_shp,
        options = leafletOptions(zoomControl = FALSE)) %>%
  addPolygons(color = "#A9A9A9", 
              weight = 0.5, 
              smoothFactor = 0.5,
              opacity = 1.0, 
              fillOpacity = 0.7,
              fillColor = ~pal(map_data),
              popup = popup_text, 
              highlightOptions = highlightOptions(color = "white", 
                                                  weight = 2,
                                                  bringToFront = TRUE)) %>% 
  addLegend("bottomright",
            pal = pal,
            values = ~map_data,
            title = legend_title,
            opacity = 1,
            layerId = "colorLegend") %>%
  addProviderTiles(providers$CartoDB.Positron)


## Prepare data for map: total produced per population
## Subset seaweed production for ohi-science article
# seaweed <- mar_harvest %>% 
#   filter(Taxon_code == "AL")
# 
# top <- seaweed %>% 
#   filter(year %in% c(2011:2015)) %>%
#   group_by(country) %>% 
#   rename(tonnes = value) %>% 
#   dplyr::summarise(tot_edible_sw = sum(tonnes))%>% 
#   dplyr::arrange(desc(tot_edible_sw)) %>% 
#   ungroup()