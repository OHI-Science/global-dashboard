## CONSIDER USING ST_SIMPLIFY TO INCREASE SPEED OF PLOTTING
# ohi_regions <- sf::st_read(file.path(dir_M,"git-annex/globalprep/spatial/v2017"), "regions_2017_update", quiet = T) %>%
#   sf::st_transform(crs = '+proj=longlat +datum=WGS84') %>% # rgn_id, rgn_name
#   sf::st_simplify()
# save(ohi_regions, file = "tmp/global_map.RData")

# library(rgdal)
# library(dplyr)
# library(leaflet)

## May want to save it onto mazu or global-dashboard in the future so people can easily access it
# ohi_regions <-  sf::st_read('../ohiprep/globalprep/spatial/downres', "rgn_all_gcs_low_res")
# 
# ohi_regions <- ohi_regions %>%
#   filter(rgn_typ == "eez")
# 
# plot(ohi_regions)

# data <- mar_global_map

# data_shp <- ohi_regions %>%
#   left_join(data, by = "rgn_id") %>% 
#   filter(type == "prodPerCap")

# pal <- colorNumeric(palette = ygb,
#                     domain = data_shp$map_data,
#                     na.color = "#00000000",
#                     alpha = 0.4)

# legend_title = "Map Stuff"
# 
#  popup_title = "Seafood Production: "
#  popup_add_field_title = "Country EEZ: "
#  
#  popup_text <- paste("<h5><strong>", popup_title, "</strong>", as.character(signif(data_shp$map_data,3)), "lb/person", "</h5>",
#                      "<h5><strong>", popup_add_field_title, "</strong>", data_shp$rgn_nam, "</h5>", sep=" ")

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