source("global.R")

###Setting up the dashboard page
dashboardPage(
  dashboardHeader(
    title = "OHI Global Data Explorer",
    titleWidth = 300),
  
### Dashboard Sidebar  
  dashboardSidebar(
    
    sidebarMenu(
      menuItem("The OHI Story", tabName = "dashboard", icon = icon("globe", lib="glyphicon")),
      # menuItem("Livelihoods & Economies", tabName = "liveco"),
      # menuItem("Tourism & Recreation", tabName = "tr"),
      # menuItem("Biodiversity", tabName = "bio"),
      # menuItem("Sense of Place", tabName = "sop"),
      # menuItem("Artisanal Opportunities", tabName = "ao"),
      # menuItem("Food Provision", tabName = "fp"),
      menuItem("Mariculture", tabName = "mar")
      #,
      # menuItem("Fisheries", tabName = "fis"),
      # menuItem("Coastal Protection", tabName = "cp"),
      # menuItem("Carbon Storage", tabName = "cs")
  ),
  
  # Footer tag, include hyperlink
  tags$a(href="http://ohi-science.org/globalfellows/fellows.html", 
  tags$footer("\u00a9 Iwen Su, OHI Global Fellow", align = "right", style = "
              position:absolute;
              bottom:0;
              width:100%;
              height:50px;   /* Height of the footer */
              color: white;
              padding: 10px;
              z-index: 1000;")
  ),
  
  width = 200),
  
  
### Dashboard Body
  dashboardBody(
    #adding this tag to make header longer, from here:https://rstudio.github.io/shinydashboard/appearance.html#long-titles
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
      ),
    
### Side Bar Tabs
  tabItems(
    
    ## The OHI Story ##
    
    tabItem(tabName = "dashboard",
          
            frontp() # content is in front_page.R
            
            ),
    
    ## FOR BUILDING OUT FUTURE GOALS ##
    # ## Livelihood and economies ## 
    # 
    # tabItem(tabName = "liveco",
    #         
    #         ## Livelihoods & Economies tab title ##
    #         tab_title_ui(goal_text = "LIVELIHOODS & ECONOMIES",
    #                      definition = "",
    #                      goal_description = "")
    #         ),
    # 
    #         
    # ## Tourism & recreation ##
    # 
    # tabItem(tabName = "tr",
    #         
    #         ## Tourism & Recreation tab title ##
    #         tab_title_ui(goal_text = "TOURISM & RECREATION",
    #                      definition = "",
    #                      goal_description = "")
    #         
    #         ),
    # 
    # ## Biodiversity ##
    # 
    # tabItem(tabName = "bio",
    #         
    #         ## Biodiversity tab title ##
    #         tab_title_ui(goal_text = "BIODIVERSITY",
    #                      definition = "",
    #                      goal_description = "")
    #         
    #         ),
    # 
    # ## Sense of Place ##
    # 
    # tabItem(tabName = "sop",
    #         
    #         ## Sense of Place tab title ##
    #         tab_title_ui(goal_text = "SENSE OF PLACE",
    #                      definition = "",
    #                      goal_description = "")
    #         
    #         ),
    # 
    # ## Local Fishing & Resource Access Opportunities  ##
    # 
    # tabItem(tabName = "ao",
    #         
    #         ## Local Fishing & Resource Access Opportunities tab title ##
    #         tab_title_ui(goal_text = "ARTISANAL FISHING OPPORTUNITY",
    #                      definition = "",
    #                      goal_description = "")
    #         
    #         ),
    # 
    # ## Food Provision ##
    # 
    # tabItem(tabName = "fp",
    #         
    #         ## Food Provision tab title ##
    #         tab_title_ui(goal_text = "FOOD PROVISION",
    #                      definition = "",
    #                      goal_description = "")
    #         
    # ),
    
    
    ## Mariculture ##
    
    tabItem(tabName = "mar",
            
          ## Mariculture Tab Title ##
          tab_title_ui(goal_text = "MARICULTURE",
                       goal_description = "Global mariculture has been growing impressively since the 1980s, while wild-caught fishery production has remained relatively static.",
                       definition = list("Mariculture measures the ability to reach the highest levels of seafood gained from farm-raised facilities without damaging the ocean’s ability to provide fish sustainably now and in the future. The status of each country is calculated by taking tonnes of seafood produced, weighting it for sustainability and dividing it by the country's coastal population to scale it across the global. Since OHI also defines higher mariculture statuses as those that are maximizing sustainable harvest from the oceans, we compare the production per coastal population to the highest global historic production capacity. The mariculture and fisheries status both contribute equally to measuring the OHI Food Provisions goal.")),
          
          ## Mariculture Baseline Metrics ##
           baseline_metrics_ui(id = "mar_baseline",
                               number_boxes = 3),
                
          ## Mariculture Global Map
          map_ui(id = "mar_global_map",
                 title_text = paste0("Global Map of Mariculture Production in ", data_yr),
                 sub_title_text = "Start exploring! Select different data to view on the map & click on EEZ regions to see country and values (may take a few seconds to load).",
                 select_type = "radio",
                 select_location = "above",
                 select_choices = c("All Production" = "prodTonnesAll",
                                    "Production per Capita" = "prodPerCap"),
                 select_label = "",
                 source_text = list(
                   p("Sources:"),
                   p(tags$sup("1."), tags$a(href="http://www.fao.org/fishery/statistics/software/fishstatj/en", "Food and Agriculture Organization"), ", Global Aquaculture Production Quantity (March 2018)"),
                   p(tags$sup("2."), tags$a(href="http://sedac.ciesin.columbia.edu/data/collection/gpw-v4/documentation","Center for International Earth Science Information Network"), ", Gridded Population of the World, V4 (2016).")
                   )
                 ),
          
          ## Annual Mariculture Production ##
           card_ui(id = "mar_prod",
                    title_text = "Tonnes of Species Harvested by Country",
                    sub_title_text = "Start exploring! Select or type in a country of interest. Click on names of species you want to remove from the plot. Hover over the points to view tonnes and species harvested.",
                    select_type = "search",
                    select_location = "above",
                    select_choices = unique(mar_harvest$country),
                    select_label = NULL,
                    source_text = list(
                      p("Sources:"),
                      p(tags$sup("1."), tags$a(href="http://www.fao.org/fishery/statistics/software/fishstatj/en", "Food and Agriculture Organization"), ", Global Aquaculture Production Quantity (March 2018)"))
                      
                     )

            )
    #,
    
    
    
    
    
    
    # ## Fisheries ##
    # 
    # tabItem(tabName = "fis",
    #         
    #         ## Fisheries tab title ##
    #         tab_title_ui(goal_text = "FISHERIES",
    #                      definition = "the sustainable harvest of seafood from wild-caught fisheries",
    #                      goal_description = "sustainably wild-caught seafood from fisheries")
    #         
    # ),
    # 
    # ## Coastal Protection ##
    # 
    # tabItem(tabName = "cp",
    #         
    #         ## Coastal Protection tab title ##
    #         tab_title_ui(goal_text = "COASTAL PROTECTION",
    #                      definition = "the amount of protection provided by marine and coastal habitats serving as natural buffers against incoming waves",
    #                      goal_description = "storage of carbon and protection of our coasts from storm damage by living natural habitats")
    #         
    #         ),
    # 
    # ## Carbon Storage ##
    # 
    # tabItem(tabName = "cs",
    #         
    #         ## Carbon Storage tab title ##
    #         tab_title_ui(goal_text = "CARBON STORAGE",
    #                      definition = "the condition of coastal habitats that store and sequester atmospheric carbon",
    #                      goal_description = "storage of carbon and protection of our coasts from storm damage by living natural habitats")
    #         
    # )
    
  )
    )
  )

