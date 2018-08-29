
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
             number_boxes = 3,
             statistic = list("53%", "68%", "51%"),
             text = list("of global seafood comes from aquaculture. Mariculture, which excludes inland production, contributes 19% to all seafood provision.",
                         "of mariculture produced in 2016 for human consumption came from China. They are followed by South Korea at only 4%!",
                         "of mariculture is comprised of shellfish production by weight. The remaining 33% is from seaweed and 15% from fish."))
  

  ## Mariculture Global Map ##
  callModule(card_map, "mar_global_map",
             data = mar_global_map,
             field = "input",
             filter_field = type, # type of data to plot
             display_field = "map_data",
             display_units = "units",
             color_palette = ygb,
             legend_title = "Legend",
             popup_title = "rgn_nam")

  


  }
