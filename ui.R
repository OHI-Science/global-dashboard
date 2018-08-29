source("global.R")

###Setting up the dashboard page
dashboardPage(
  dashboardHeader(
    title = "OHI Global Data Explorer",
    titleWidth = 300),
  
### Dashboard sidebar  
  dashboardSidebar(
    
    sidebarMenu(
      menuItem("The OHI Story", tabName = "dashboard", icon = icon("globe", lib="glyphicon")),
      # menuItem("Livelihoods & Economies", tabName = "liveco", badgeLabel = "draft", badgeColor = "orange"),
      # menuItem("Tourism & Recreation", tabName = "tr", badgeLabel = "draft", badgeColor = "orange"),
      # menuItem("Biodiversity", tabName = "bio", badgeLabel = "draft", badgeColor = "orange"),
      # menuItem("Sense of Place", tabName = "sop", badgeLabel = "draft", badgeColor = "orange"),
      # menuItem("Artisanal Opportunities", tabName = "ao", badgeLabel = "draft", badgeColor = "orange"),
      # menuItem("Food Provision", tabName = "fp", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Mariculture", tabName = "mar")
      #,
      # menuItem("Fisheries", tabName = "fis", badgeLabel = "draft", badgeColor = "orange"),
      # menuItem("Coastal Protection", tabName = "cp", badgeLabel = "draft", badgeColor = "orange"),
      # menuItem("Carbon Storage", tabName = "cs", badgeLabel = "draft", badgeColor = "orange")
  ),
  width = 200),
  
  
### Dashboard Body
  dashboardBody(
    #adding this tag to make header longer, from here:https://rstudio.github.io/shinydashboard/appearance.html#long-titles
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
      ),
    
### Side bar tabs

  tabItems(
    
    ## The OHI Story ##
    
    tabItem(tabName = "dashboard",
          
            frontp() # content is in functions/front_page.R
            
            ),
    
    # ## Livelihood and economies ## 
    # 
    # tabItem(tabName = "liveco",
    #         
    #         ## Livelihoods & Economies tab title ##
    #         tab_title_ui(goal_text = "LIVELIHOODS & ECONOMIES",
    #                      definition = "coastal and ocean-dependent livelihoods (job quantity and quality) and economies (revenues) produced by marine sectors",
    #                      commitment_text = "a high quantity and quality of ocean-dependent jobs and local revenue")
    #         
    #         ),
    # 
    #         
    # ## Tourism & recreation ##
    # 
    # tabItem(tabName = "tr",
    #         
    #         ## Tourism & Recreation tab title ##
    #         tab_title_ui(goal_text = "TOURISM & RECREATION",
    #                      definition = "the value people have for experiencing and enjoying coastal areas through activities such as sailing, recreational fishing, beach-going, and bird watching",
    #                      commitment_text = "opportunities for people to enjoy coastal areas through tourism and recreation")
    #         
    #         ),
    # 
    # ## Biodiversity ##
    # 
    # tabItem(tabName = "bio",
    #         
    #         ## Biodiversity tab title ##
    #         tab_title_ui(goal_text = "BIODIVERSITY",
    #                      definition = "the conservation status of native marine species and key habitats that serve as a proxy for the suite of species that depend upon them",
    #                      commitment_text = "a diversity of healthy marine species, habitats, and landscapes")
    #         
    #         ),
    # 
    # ## Sense of Place ##
    # 
    # tabItem(tabName = "sop",
    #         
    #         ## Sense of Place tab title ##
    #         tab_title_ui(goal_text = "SENSE OF PLACE",
    #                      definition = "the conservation status of iconic species (e.g., salmon, whales) and geographic locations that contribute to cultural identity",
    #                      commitment_text = "a deep sense of identity and belonging provided through connections with our marine communities")
    #         
    #         ),
    # 
    # ## Local Fishing & Resource Access Opportunities  ##
    # 
    # tabItem(tabName = "ao",
    #         
    #         ## Local Fishing & Resource Access Opportunities tab title ##
    #         tab_title_ui(goal_text = "ARTISANAL FISHING OPPORTUNITY",
    #                      definition = "the opportunity for small-scale fishers to supply catch for their families, members of their local communities, or sell in local markets",
    #                      commitment_text = "opportunities for Native Americans and local community members to access local natural resources")
    #         
    #         ),
    # 
    # ## Food Provision ##
    # 
    # tabItem(tabName = "fp",
    #         
    #         ## Food Provision tab title ##
    #         tab_title_ui(goal_text = "FOOD PROVISION",
    #                      definition = "the sustainable harvest of seafood from wild-caught fisheries and mariculture",
    #                      commitment_text = "sustainably harvested and wild-caught seafood from fisheries and mariculture")
    #         
    # ),
    
    
    ## Mariculture ##
    
    tabItem(tabName = "mar",
            
          ## Mariculture Tab Title ##
          tab_title_ui(goal_text = "MARICULTURE",
                       definition = "the sustainable harvest of seafood from mariculture practices.",
                       commitment_text = "Global mariculture production has been rising since the 1980s while wild-caught fisheries growth has stagnated."),
        
            
          ## Mariculture Baseline Metrics ##
           baseline_metrics_ui(id = "mar_baseline",
                               number_boxes = 3),
                
          ## Mariculture Global Map
          map_ui(id = "mar_global_map",
                 title_text = "Mariculture Global Production per Capita in 2016",
                 sub_title_text = "",
                 select_type = "drop_down",
                 select_location = "above",
                 select_choices = c("All Production" = "prodTonnesAll",
                                    "Production per Capita" = "prodPerCap"),
                 select_label = "Select data to view & click on EEZ regions to see more information."),
          
          ## Annual Mariculture Production ##
           card_ui(id = "mar_prod",
                    title_text = "Mariculture Production",
                    sub_title_text = "Select or search for a country. Click on names of species you want to hide. Hover over the lines to view tonnes and species harvested",
                    select_type = "search",
                    select_location = "above",
                    select_choices = unique(mar_harvest$country),
                    select_label = NULL,
                    source_text = "Source: Food and Agriculture Organization, Global Aquaculture Production Quantity 1950 - 2016 dataset (released March 2018)")

            )
    #,
    
    
    
    
    
    
    # ## Fisheries ##
    # 
    # tabItem(tabName = "fis",
    #         
    #         ## Fisheries tab title ##
    #         tab_title_ui(goal_text = "FISHERIES",
    #                      definition = "the sustainable harvest of seafood from wild-caught fisheries",
    #                      commitment_text = "sustainably wild-caught seafood from fisheries")
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
    #                      commitment_text = "storage of carbon and protection of our coasts from storm damage by living natural habitats")
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
    #                      commitment_text = "storage of carbon and protection of our coasts from storm damage by living natural habitats")
    #         
    # )
    
  )
    )
  )

