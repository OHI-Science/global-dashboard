source("global.R")

###Setting up the dashboard page
dashboardPage(
  dashboardHeader(
    title = "Global Ocean Health Index",
    titleWidth = 375),
  
### Dashboard sidebar  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Index", tabName = "dashboard", icon = icon("dashboard"), badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Livelihoods & Economies", tabName = "liveco", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Tourism & Recreation", tabName = "tr", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Biodiversity", tabName = "bio", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Sense of Place", tabName = "sop", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Local Fishing & Resource Access Opportunities ", tabName = "ao", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Mariculture", tabName = "mar", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Coastal Protection & Carbon Storage", tabName = "cpcs", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Pressures", tabName = "pressures", badgeLabel = "draft", badgeColor = "orange")
  ),
  width = 350),
  
  
### Dashboard Body
  dashboardBody(
    #adding this tag to make header longer, from here:https://rstudio.github.io/shinydashboard/appearance.html#long-titles
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
      ),
    
### Side bar tabs

  tabItems(
    
    ## Overall index scores ##
    
    tabItem(tabName = "dashboard",
            h2("Index scores")
            
            ),
    
    ## Livelihood and economies ## 
    
    tabItem(tabName = "liveco",
            
            ## Livelihoods & Economies tab title ##
            tab_title_ui(goal_text = "LIVELIHOODS & ECONOMIES",
                         commitment_text = "a high quantity and quality of ocean-dependent jobs and local revenue")
            
            ),

            
    ## Tourism & recreation ##
    
    tabItem(tabName = "tr",
            
            ## Tourism & Recreation tab title ##
            tab_title_ui(goal_text = "TOURISM & RECREATION",
                         commitment_text = "opportunities for people to enjoy coastal areas through tourism and recreation")
            
            ),
    
    ## Biodiversity ##
    
    tabItem(tabName = "bio",
            
            ## Biodiversity tab title ##
            tab_title_ui(goal_text = "BIODIVERSITY",
                         commitment_text = "a diversity of healthy marine species, habitats, and landscapes")
            
            ),
    
    ## Sense of Place ##
    
    tabItem(tabName = "sop",
            
            ## Sense of Place tab title ##
            tab_title_ui(goal_text = "SENSE OF PLACE",
                         commitment_text = "a deep sense of identity and belonging provided through connections with our marine communities")
            
            ),
    
    ## Local Fishing & Resource Access Opportunities  ##
    
    tabItem(tabName = "ao",
            
            ## Local Fishing & Resource Access Opportunities tab title ##
            tab_title_ui(goal_text = "LOCAL FISHING & RESOURCE ACCESS OPPORTUNITIES",
                         commitment_text = "opportunities for Native Americans and local community members to access local natural resources")
            
            ),
    
    ## Mariculture ##
    
    tabItem(tabName = "mar",
            
            ## Food Provision tab title ##
            tab_title_ui(goal_text = "MARICULTURE",
                         commitment_text = "sustainably harvested seafood from mariculture"),
    
    
            ## Annual Production ##
            card_ui(id = "mar_prod",
                    title_text = "Production",
                    sub_title_text = "",
                    select_type = "drop_down",
                    select_location = "above",
                    select_choices = unique(mar_harvest$country),
                    select_label = "Select Country",
                    source_text = "Source: FAO")
            
            ),
    
    
    
    
    ## Coastal Protection & Carbon Storage ##
    
    tabItem(tabName = "cpcs",
            
            ## Coastal Protection & Carbon Storage tab title ##
            tab_title_ui(goal_text = "COASTAL PROTECTION & CARBON STORAGE",
                         commitment_text = "storage of carbon and protection of our coasts from storm damage by living natural habitats")
            
            ),
    
    ## Pressures ##
    
    tabItem(tabName = "pressures",
            
            ## Pressures tab title ##
            tab_title_ui(goal_text = "Pressures",
                         commitment_text = "pressures"),
    
            ##map for trash layer ##
            map_ui(id = "trash_map",
                   title_text = "Trash pressure layer")
            
            )
  )
    )
  )

