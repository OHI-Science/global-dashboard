frontp = function() 
  div(class = "frontp",
      
      # Create homepage title banner and image
      div(class = "front-banner",
          div(class = "imgcon"), # not working!!
          div(class = "intro-title", "Global Ocean Health Index")
      ),
      
      
      # Home page text
      tags$p(h4("The Ocean Health Index Global Data Explorer is a tool created by an OHI Global Fellow to help ocean-enthusiasts interact with the data behind the most recent assessment.")),
      
      div(class = "intro-divider"), 
      
      # Additional information
      tags$p("Currently, we only have data exploration available for our Mariculture sub-goal, but the remaining 10 goals will be available in the near future. Other goals include Tourism & Recreation, Clean Waters, Biodiversity, Artisanal Opportunities, Carbon Storage, and Natural Products.")
      
      # Two hyperlink boxes: more info

  )