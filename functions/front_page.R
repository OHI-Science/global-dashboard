frontp = function() 
  div(class = "frontp",
      
      # Create homepage title banner and image
      div(class = "front-banner-test",
          tags$img(src = "img/home-banner-crop.jpg", style="width:100%"),
          div(class = "content", ("Explore the Data Behind the Global Ocean Health Index"))
        ),
      
      
      # Home page text
      tags$p(h4("The Ocean Health Index Global Data Explorer is a tool for interacting with the data behind the most recent assessment.")),
      
      div(class = "intro-divider"), 
      
      # Additional information
      tags$p("The Ocean Health Index is a tailorable marine assessment framework to comprehensively and quantitatively evaluate ocean health. Originally developed by an interdisciplinary team of scientists, global assessments have been repeated every year since 2012."),
      
      tags$p("Currently, we only have data exploration available for our Mariculture sub-goal, but the remaining 10 goals will be available in the near future. Other goals include Tourism & Recreation, Clean Waters, Biodiversity, Artisanal Opportunities, Carbon Storage, and Natural Products."),
      
      # Two hyperlink boxes: more info
      div(class = "box-con",
          
          tags$a(target = "_blank",
                 href = "http://ohi-science.org/about/#what-is-the-ocean-health-index",
                 div(class = "float box box-more",
                     tags$p(class = "intro-text", "Overview"),
                     tags$p("What is the Ocean Health Index?")
                     )),
          
          tags$a(target = "_blank",
                 href = "http://ohi-science.org/ohi-global/",
                 div(class = "float box box-rear",
                     tags$p(class = "intro-text", "Deep Dive"),
                     tags$p("The Ocean Health Index Global Assessment is produced from a collaborative team of scientists based in Santa Barbara. Click here for documentation of methods, data, and publications.") 
                     ))
          )
      )
