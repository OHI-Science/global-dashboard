
function(input, output, session) {
  
  
  ## Mariculture Production ##
  callModule(card_plot, "mar_prod",
             df = mar_harvest,
             x = "year",
             y = "tonnes",
             color_group = "species",
             filter_field = "country",
             colors = cols,
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Tonnes:", tonnes,
                                   "<br>Species:", species, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Annual Production (tonnes)")
  
  
  ## Mariculture Baseline Metrics ##
  callModule(baseline_metrics, "mar_baseline",
             goal_name = "MAR",
             first = "Global Mariculture Score",
             second = "Largest Share of Production",
             third = "Seafood per Capita",
             icon = "fish",
             color = "light-blue") # see ?validColors
  

  ## Mariculture Global Map ##
  callModule(card_map, "mar_global_map",
             data = mar_global_map,
             field = "input",
             filter_field = type, # type of data to plot
             display_field = "map_data",
             color_palette = ygb,
             legend_title = "Legend",
             popup_title = "rgn_nam")

  


  }
