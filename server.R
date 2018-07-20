
function(input, output, session) {
  
  
  ## Mariculture Production ##
  callModule(card_plot, "mar_prod",
             df = mar_harvest,
             x = "year",
             y = "tonnes",
             color_group = "species",
             filter_field = "country",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Tonnes:", tonnes,
                                   "<br>Species:", species, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Annual Production (tonnes)")

  
  

  
  }
